<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>입출고구분설정</title>
    <!-- Handsontable -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.css">
    <script src="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.js"></script>

  <style>
    body { font-family: "맑은 고딕", Arial, sans-serif; margin: 20px; }
    h2 { margin-bottom: 15px; }

    /* ✅ 탭 + 버튼 영역 .*/
    .tab-menu { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
    .tab-left button, .tab-right button {
        padding: 8px 15px;
        margin-right: 5px;
        cursor: pointer;
        border: 1px solid #ccc;
        border-radius: 4px;
        background: #f5f5f5;
    }
    .tab-left button.active { background: #e0e0e0; font-weight: bold; }
    .tab-right button.remove { color: black; }

    .tab-content { display: none; }
    .tab-content.active { display: block; }
    .grid { width: 100%; height: 400px; }

    /* ✅ 셀 공통 높이 */
    .handsontable td {
        vertical-align: middle !important;
        line-height: normal !important;
        height: 34px !important;
        padding: 2px !important;
    }
  </style>
</head>
<body>
    <h2>입출고구분설정</h2>

    <!-- ✅ 탭 + 버튼 -->
    <div class="tab-menu">
        <div class="tab-left">
            <button type="button" class="active" onclick="showTab('outTab', this)">출고</button>
            <button type="button" onclick="showTab('inTab', this)">입고</button>
            <button type="button" onclick="showTab('moveTab', this)">이동</button>
        </div>
        <div class="tab-right">
            <button onclick="loadData()">조회</button>
            <button onclick="saveAll()">저장</button>
            <button class="remove" onclick="deleteSelected()">삭제</button>
        </div>
    </div>

    <!-- 📌 출고 -->
    <div id="outTab" class="tab-content active"><div id="gridOut" class="grid"></div></div>
    <!-- 📌 입고 -->
    <div id="inTab" class="tab-content"><div id="gridIn" class="grid"></div></div>
    <!-- 📌 이동 -->
    <div id="moveTab" class="tab-content"><div id="gridMove" class="grid"></div></div>

<script>
/* ✅ 탭 전환 */
function showTab(tabId, btn) {
    document.querySelectorAll(".tab-content").forEach(c => c.classList.remove("active"));
    document.querySelectorAll(".tab-menu button").forEach(b => b.classList.remove("active"));
    document.getElementById(tabId).classList.add("active");
    btn.classList.add("active");
}

/* ✅ 공통 옵션 */
const commonOpts = {
    stretchH: "all",
    rowHeaders: false,
    filters: true,
    dropdownMenu: true,
    licenseKey: "non-commercial-and-evaluation",
    minSpareRows: 3,
    rowHeights: 32
};

/* ✅ 번호 자동 증가 */
function numbering(instance, td, row, col, prop, value, cellProperties) {
    if (col === 0) {
        const category = instance.getDataAtCell(row, 1);
        td.textContent = (category && category.trim() !== "") ? (row + 1) : "";
        td.style.textAlign = "center";
        return td;
    }
}

/* ✅ Excel 스타일 체크박스 Renderer */
function excelCheckboxRenderer(instance, td, row, col, prop, value, cellProperties) {
    td.style.textAlign = "center";
    td.style.verticalAlign = "middle";
    td.innerHTML = "";

    const checkbox = document.createElement("div");
    checkbox.style.width = "18px";
    checkbox.style.height = "18px";
    checkbox.style.border = "2px solid #666";
    checkbox.style.borderRadius = "3px";
    checkbox.style.margin = "0 auto";
    checkbox.style.cursor = "pointer";
    checkbox.style.backgroundColor = "#fff";
    checkbox.style.position = "relative";

    if (value === true) {
        const checkMark = document.createElement("div");
        checkMark.innerHTML = "✔";
        checkMark.style.position = "absolute";
        checkMark.style.top = "-3px";
        checkMark.style.left = "2px";
        checkMark.style.fontSize = "14px";
        checkMark.style.color = "#000";
        checkbox.appendChild(checkMark);
    }

    checkbox.addEventListener("click", () => {
        const newValue = !value;
        instance.setDataAtCell(row, col, newValue);
    });

    td.appendChild(checkbox);
}

/* ✅ Boolean 컬럼 목록 */
const booleanCols = [
  "useYn","isFinishedProduct","isMaterial","isSalesUse","adjustOut",
  "adjustIn","isVatTarget","isAs","isItemJournal","isByproductIn",
  "isReturnIn","isMove","isTransfer","isAsOut","isAsReturn",
  "isFreeSupply","isDispatchTarget","_remove"
];

/* ✅ 데이터 정규화 */
function normalizeData(data) {
    return data.map(row => {
        booleanCols.forEach(col => {
            if (row[col] === "Y") row[col] = true;
            else if (row[col] === "N" || row[col] === null) row[col] = false;
        });
        row._remove = false;
        if (row.txnCode === undefined) row.txnCode = null;
        if (row.buId === undefined) row.buId = 1;
        return row;
    });
}

/* ✅ 저장용 데이터 변환 */
function denormalizeData(rowData, txnType) {
  const payload = { ...rowData, txnType, buId: 1 };
  booleanCols.forEach(col => {
    if (typeof payload[col] === "boolean") payload[col] = payload[col] ? "Y" : "N";
  });
  if (!payload.txnCode || payload.txnCode.trim() === "") payload.txnCode = null;
  return payload;
}

/* ✅ 저장 (단일 행) */
function saveChange(txnType, rowData) {
  const payload = denormalizeData(rowData, txnType);
  fetch("/txnCategory/api/save", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  }).catch(err => console.error("저장 실패:", err));
}

/* ✅ 전체 저장 */
function saveAll() {
  const activeTab = document.querySelector(".tab-content.active .grid");
  let hot, txnType;
  if (activeTab.id === "gridOut") { hot = hotOut; txnType = "OUT"; }
  else if (activeTab.id === "gridIn") { hot = hotIn; txnType = "IN"; }
  else if (activeTab.id === "gridMove") { hot = hotMove; txnType = "MOVE"; }

  const allData = hot.getSourceData();
  allData.forEach(row => { if (row.categoryName) saveChange(txnType, row); });
  alert("저장 완료");
}

/* ✅ 삭제 */
function deleteSelected() {
  const activeTab = document.querySelector(".tab-content.active .grid");
  let hot;
  if (activeTab.id === "gridOut") hot = hotOut;
  else if (activeTab.id === "gridIn") hot = hotIn;
  else if (activeTab.id === "gridMove") hot = hotMove;

  const rowsToRemove = hot.getSourceData().filter(r => r._remove === true);
  if (rowsToRemove.length === 0) { alert("삭제할 항목을 선택하세요."); return; }

  Promise.all(rowsToRemove.map(row => {
    if (!row.txnCode || !row.buId) return Promise.resolve();
    const url = "/txnCategory/api/delete/" + encodeURIComponent(row.txnCode) + "/" + encodeURIComponent(row.buId);
    return fetch(url, { method: "DELETE" });
  }))
  .then(() => { alert("선택 항목 삭제 완료"); location.reload(); })
  .catch(err => console.error("삭제 실패:", err));
}

/* ✅ 조회 (DB에서 다시 불러오기) */
function loadData() {
  fetch("/txnCategory/api/list/OUT")
    .then(res => res.json()).then(data => hotOut.loadData(normalizeData(data)));
  fetch("/txnCategory/api/list/IN")
    .then(res => res.json()).then(data => hotIn.loadData(normalizeData(data)));
  fetch("/txnCategory/api/list/MOVE")
    .then(res => res.json()).then(data => hotMove.loadData(normalizeData(data)));
}

/* ✅ 출고 Grid */
/* ✅ 출고 Grid */
const hotOut = new Handsontable(document.getElementById("gridOut"), {
    data: [],
    colHeaders: ["번호","출고구분","정렬순서","사용여부","계정과목","비용구분",
                 "제상품","자재","영업사용","재고실사조정(출고)","재고실사조정(입고)",
                 "부가세대상여부","부가세처리구분","AS","품목별전표처리여부","항목선택"],
    columns: [
        { readOnly: true, renderer: numbering },
        { 
            data:"categoryName", 
            type:"dropdown", 
            source: ["불량폐기","판촉","연구개발","실사기타출고","불량재고정리","샘플출고","사업상증여"]
        },
        { data:"sortOrder", type:"numeric" },
        { data:"useYn", type:"checkbox", renderer: excelCheckboxRenderer },
        { 
            data:"accountSubject", 
            type:"dropdown", 
            source: ["현금","외화현금","당좌예금","외화당좌예금","보통예금","외화보통예금",
                     "정기예금","외화정기예금","정기적금","외화정기적금",
                     "단기금융상품","단기매매증권","단기매매증권평가충당금",
                     "매도가능증권(유동)","매도가능증권(유동)평가충당금",
                     "만기보유증권(유동)","만기보유증권(유동)평가충당금",
                     "유가증권","유가증권평가충당금",
                     "외상매출금","외상매출금대손충당금",
                     "외화외상매출금","외화외상매출금대손충당금",
                     "받을어음","받을어음대손충당금"]
        },
        { data:"costType", type:"dropdown", source:["제조","판관"] },
        { data:"isFinishedProduct", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isMaterial", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isSalesUse", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"adjustOut", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"adjustIn", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isVatTarget", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"vatProcessType", type:"dropdown", source:["기타출고금액","판매기준단가*수량(차액처리안함)","판매기준단가*수량(차액처리포함)"] },
        { data:"isAs", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isItemJournal", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"_remove", type:"checkbox", renderer: excelCheckboxRenderer }
    ],
    ...commonOpts
});

/* ✅ 입고 Grid */
const hotIn = new Handsontable(document.getElementById("gridIn"), {
    data: [],
    colHeaders: ["번호","입고구분","정렬순서","사용여부","계정과목","비용구분",
                 "제상품","자재","부상품입고","품목별반입처리여부","항목선택"],
    columns: [
        { readOnly: true, renderer: numbering },
        { data:"categoryName", type:"dropdown", source:["샘플입고","불량입고","자체상품"] },
        { data:"sortOrder", type:"numeric" },
        { data:"useYn", type:"checkbox", renderer: excelCheckboxRenderer },
        { 
            data:"accountSubject", 
            type:"dropdown", 
            source:["현금","외화현금","당좌예금","외화당좌예금","보통예금","외화보통예금",
                    "정기예금","외화정기예금","정기적금","외화정기적금",
                    "단기금융상품","단기매매증권","단기매매증권평가충당금",
                    "매도가능증권(유동)","매도가능증권(유동)평가충당금",
                    "만기보유증권(유동)","만기보유증권(유동)평가충당금",
                    "유가증권","유가증권평가충당금",
                    "외상매출금","외상매출금대손충당금",
                    "외화외상매출금","외화외상매출금대손충당금",
                    "받을어음","받을어음대손충당금"]
        },
        { data:"costType", type:"dropdown", source:["제조","판관"] },
        { data:"isFinishedProduct", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isMaterial", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isByproductIn", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isReturnIn", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"_remove", type:"checkbox", renderer: excelCheckboxRenderer }
    ],
    ...commonOpts
});

/* ✅ 이동 Grid */
const hotMove = new Handsontable(document.getElementById("gridMove"), {
    data: [],
    colHeaders: ["번호","이동구분","정렬순서","사용여부","이동","적송",
                 "AS출고","AS반납","무상사급","배차대상","항목선택"],
    columns: [
        { readOnly: true, renderer: numbering },
        { data:"categoryName", type:"dropdown", source:["위탁처리","이동처리","자재불출","외주불출","불량처리","양품처리"] },
        { data:"sortOrder", type:"numeric" },
        { data:"useYn", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isMove", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isTransfer", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isAsOut", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isAsReturn", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isFreeSupply", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"isDispatchTarget", type:"checkbox", renderer: excelCheckboxRenderer },
        { data:"_remove", type:"checkbox", renderer: excelCheckboxRenderer }
    ],
    ...commonOpts
});


/* ✅ 페이지 로드시 데이터 조회 */
loadData();
</script>
</body>
</html>
