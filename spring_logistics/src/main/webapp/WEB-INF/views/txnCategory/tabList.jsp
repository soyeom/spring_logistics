<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입출고구분설정</title>
	<link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<style>
/* ✅ 테이블 가로 스크롤 문제 해결 / テーブル横スクロール対応 */
.table-container {
  overflow-x: auto; /* 가로 스크롤 허용 / 横スクロールを許可 */
  overflow-y: auto; /* 세로 스크롤도 유지 / 縦スクロールも維持 */
}

.table-container table {
  width: max-content; /* 내용에 따라 폭 자동 조정 / 内容に応じて幅を自動調整 */
  min-width: 100%;    /* 최소한 컨테이너 폭은 유지 / コンテナ幅を最低限維持 */
  table-layout: auto; /* 자동 폭 계산 / 自動レイアウト */
}
</style>
</head>
<body>
	<div class = "layout">
					<%@ include file="/WEB-INF/views/logistics.jsp" %>
<!-- ✅ メイン画面 / 메인 화면 -->
<div class="main">
  <div class="main-header">
    <!-- ≡ ボタン (サイドバー開閉) / ≡ 버튼 (사이드바 열기/닫기) -->
    <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>

    <!-- タイトル: 入出庫区分設定 / 제목: 입출고 구분 설정 -->
    <div><h1>入出庫区分設定</h1></div>

    <!-- ボタン群 / 버튼 영역 -->
    <div>
      <!-- 照会ボタン / 조회 버튼 -->
      <button class="btn btn-secondary search-btn" onclick="loadData()">照会</button>
      <!-- 保存ボタン / 저장 버튼 -->
      <button class="btn btn-secondary search-btn" onclick="saveAll()">保存</button>
      <!-- 削除ボタン / 삭제 버튼 -->
      <button class="btn btn-secondary search-btn" onclick="deleteSelected()">削除</button>
    </div>
  </div>

  <!-- ✅ タブ選択 / 탭 선택 -->
  <div class="filters">
    <div class="filters-main">
      <div class="title">タブ選択</div> <!-- 탭 선택 -->
      <div class="line"></div>
    </div>
    <div class="filters-row">
      <div class="filters-value">
        <!-- 出庫 (출고) 탭 -->
        <button class="btn btn-secondary tab-btn active" onclick="showTab('outTab', this)">出庫</button>
        <!-- 入庫 (입고) 탭 -->
        <button class="btn btn-secondary tab-btn" onclick="showTab('inTab', this)">入庫</button>
        <!-- 移動 (이동) 탭 -->
        <button class="btn btn-secondary tab-btn" onclick="showTab('moveTab', this)">移動</button>
      </div>
    </div>
  </div>

  <!-- 📦 出庫タブ / 출고 탭 -->
  <div id="outTab" class="tab-content active" style="height:100%">
    <div class="table-container" >
      <table class="table-single-select">
        <thead>
          <tr>
            <th style="width:50px;">番号</th> <!-- 번호 -->
            <th style="width:140px;">出庫区分</th> <!-- 출고 구분 -->
            <th style="width:80px;">並び順</th> <!-- 정렬 순서 -->
            <th style="width:80px;">使用可否</th> <!-- 사용 여부 -->
            <th style="width:120px;">勘定科目</th> <!-- 회계 과목 -->
            <th style="width:100px;">費用区分</th> <!-- 비용 구분 -->
            <th style="width:90px;">製品</th> <!-- 제품 -->
            <th style="width:90px;">材料</th> <!-- 자재 -->
            <th style="width:90px;">営業使用</th> <!-- 영업 사용 -->
            <th style="width:110px;">在庫実調整(出庫)</th> <!-- 재고 실조정(출고) -->
            <th style="width:110px;">在庫実調整(入庫)</th> <!-- 재고 실조정(입고) -->
            <th style="width:100px;">付加税対象</th> <!-- 부가세 대상 -->
            <th style="width:110px;">付加税処理区分</th> <!-- 부가세 처리 구분 -->
            <th style="width:80px;">AS</th>
            <th style="width:130px;">品目別伝票処理可否</th> <!-- 품목별 전표 처리 여부 -->
            <th style="width:90px;">項目選択</th> <!-- 항목 선택 -->
          </tr>
        </thead>
        <tbody id="tbody-out"></tbody>
      </table>
    </div>
  </div>

  <!-- 📦 入庫タブ / 입고 탭 -->
  <div id="inTab" class="tab-content" style="display:none; height:100%">
    <div class="table-container" >
      <table class="table-single-select">
        <thead>
          <tr>
            <th style="width:50px;">番号</th> <!-- 번호 -->
            <th style="width:140px;">入庫区分</th> <!-- 입고 구분 -->
            <th style="width:80px;">並び順</th> <!-- 정렬 순서 -->
            <th style="width:80px;">使用可否</th> <!-- 사용 여부 -->
            <th style="width:120px;">勘定科目</th> <!-- 회계 과목 -->
            <th style="width:100px;">費用区分</th> <!-- 비용 구분 -->
            <th style="width:90px;">製品</th> <!-- 제품 -->
            <th style="width:90px;">材料</th> <!-- 자재 -->
            <th style="width:110px;">副産物入庫</th> <!-- 부산물 입고 -->
            <th style="width:150px;">品目別反入処理可否</th> <!-- 품목별 반입 처리 여부 -->
            <th style="width:90px;">項目選択</th> <!-- 항목 선택 -->
          </tr>
        </thead>
        <tbody id="tbody-in"></tbody>
      </table>
    </div>
  </div>

  <!-- 📦 移動タブ / 이동 탭 -->
  <div id="moveTab" class="tab-content" style="display:none; height:100%">
    <div class="table-container">
      <table class="table-single-select">
        <thead>
          <tr>
            <th style="width:50px;">番号</th> <!-- 번호 -->
            <th style="width:140px;">移動区分</th> <!-- 이동 구분 -->
            <th style="width:80px;">並び順</th> <!-- 정렬 순서 -->
            <th style="width:80px;">使用可否</th> <!-- 사용 여부 -->
            <th style="width:90px;">移動</th> <!-- 이동 -->
            <th style="width:90px;">積送</th> <!-- 적송 -->
            <th style="width:90px;">AS出庫</th> <!-- AS 출고 -->
            <th style="width:90px;">AS返納</th> <!-- AS 반납 -->
            <th style="width:100px;">無償支給</th> <!-- 무상 지급 -->
            <th style="width:100px;">配車対象</th> <!-- 배차 대상 -->
            <th style="width:90px;">項目選択</th> <!-- 항목 선택 -->
          </tr>
        </thead>
        <tbody id="tbody-move"></tbody>
      </table>
    </div>
  </div>
</div>
</div>
</body>
</html>

<script type="text/javascript" src="../resources/js/logistics.js"></script>

<script>
/* ✅ タブ切り替え関数 / 탭 전환 함수 */
function showTab(id, btn){
	$(".tab-content").hide();
	$("#"+id).show();
	$(".tab-btn").removeClass("active");
	$(btn).addClass("active");
}

/* ✅ Ajax照会 / Ajax 조회 */
function loadData(){
	loadTabData("OUT", "#tbody-out");
	loadTabData("IN", "#tbody-in");
	loadTabData("MOVE", "#tbody-move");
}
/* ✅ タブごとのデータロード / 탭별 데이터 로드 */
function loadTabData(type, tbodySelector) {
  $.ajax({
    url: '/txnCategory/api/list/' + type,
    type: 'GET',
    dataType: 'json',
    success: function (result) {
      const tbody = $(tbodySelector);
      tbody.empty();

      result.forEach((r, i) => {
        let html = `
          <tr data-txncode="\${r.txnCode}">
            <td class="text-center">\${i + 1}</td>
        `;

        /* ✅ 出庫タブ (출고) */
        if (type === "OUT") {
          html += `
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="판촉" \${r.categoryName === "판촉" ? "selected" : ""}>販促</option>
                <option value="폐기" \${r.categoryName === "폐기" ? "selected" : ""}>廃棄</option>
                <option value="반품" \${r.categoryName === "반품" ? "selected" : ""}>返品</option>
              </select>
            </td>

            <td contenteditable="true">\${r.sortOrder || ''}</td>
            <td class="text-center"><input type="checkbox" \${r.useYn?.toUpperCase() === 'Y' ? "checked" : ""}></td>

            <!-- ✅ 勘定科目 -->
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="외화현금" \${r.accountSubject === "외화현금" ? "selected" : ""}>外貨現金</option>
                <option value="보통예금" \${r.accountSubject === "보통예금" ? "selected" : ""}>普通預金</option>
                <option value="외화보통예금" \${r.accountSubject === "외화보통예금" ? "selected" : ""}>外貨普通預金</option>
                <option value="당좌예금" \${r.accountSubject === "당좌예금" ? "selected" : ""}>当座預金</option>
              </select>
            </td>

            <!-- ✅ 費用区分 -->
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="제조" \${r.costType === "제조" ? "selected" : ""}>製造</option>
                <option value="판관" \${r.costType === "판관" ? "selected" : ""}>販売管理</option>
              </select>
            </td>

            <td class="text-center"><input type="checkbox" \${r.isFinishedProduct?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isMaterial?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isSalesUse?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.adjustOut?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.adjustIn?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isVatTarget?.toUpperCase() === 'Y' ? "checked" : ""}></td>

            <!-- ✅ 付加税処理区分 -->
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="판매기준단가+수량(차액처리포함)" \${r.vatProcessType === "판매기준단가+수량(차액처리포함)" ? "selected" : ""}>販売基準単価＋数量(差額処理含む)</option>
                <option value="판매기준단가+수량(차액처리안함)" \${r.vatProcessType === "판매기준단가+수량(차액처리안함)" ? "selected" : ""}>販売基準単価＋数量(差額処理なし)</option>
              </select>
            </td>

            <td class="text-center"><input type="checkbox" \${r.isAs?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isItemJournal?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" class="chk-delete"></td>
          `;
        }

        /* ✅ 入庫タブ (입고) */
        else if (type === "IN") {
          html += `
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="샘플입고" \${r.categoryName === "샘플입고" ? "selected" : ""}>サンプル入庫</option>
                <option value="불량입고" \${r.categoryName === "불량입고" ? "selected" : ""}>不良入庫</option>
                <option value="정상입고" \${r.categoryName === "정상입고" ? "selected" : ""}>正常入庫</option>
              </select>
            </td>

            <td contenteditable="true">\${r.sortOrder || ''}</td>
            <td class="text-center"><input type="checkbox" \${r.useYn?.toUpperCase() === 'Y' ? "checked" : ""}></td>

            <!-- ✅ 勘定科目 -->
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="외화현금" \${r.accountSubject === "외화현금" ? "selected" : ""}>外貨現金</option>
                <option value="보통예금" \${r.accountSubject === "보통예금" ? "selected" : ""}>普通預金</option>
                <option value="외화보통예금" \${r.accountSubject === "외화보통예금" ? "selected" : ""}>外貨普通預金</option>
                <option value="당좌예금" \${r.accountSubject === "당좌예금" ? "selected" : ""}>当座預金</option>
              </select>
            </td>

            <!-- ✅ 費用区分 -->
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="제조" \${r.costType === "제조" ? "selected" : ""}>製造</option>
                <option value="판관" \${r.costType === "판관" ? "selected" : ""}>販売管理</option>
              </select>
            </td>

            <td class="text-center"><input type="checkbox" \${r.isFinishedProduct?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isMaterial?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isByproductIn?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isReturnIn?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" class="chk-delete"></td>
          `;
        }

        /* ✅ 移動タブ (이동) */
        else if (type === "MOVE") {
          html += `
            <td>
              <select class="form-select">
                <option value="">選択</option>
                <option value="위탁처리" \${r.categoryName === "위탁처리" ? "selected" : ""}>委託処理</option>
                <option value="이동처리" \${r.categoryName === "이동처리" ? "selected" : ""}>移動処理</option>
                <option value="자재불출" \${r.categoryName === "자재불출" ? "selected" : ""}>資材払出</option>
                <option value="외주불출" \${r.categoryName === "외주불출" ? "selected" : ""}>外注払出</option>
                <option value="불량처리" \${r.categoryName === "불량처리" ? "selected" : ""}>不良処理</option>
                <option value="양품처리" \${r.categoryName === "양품처리" ? "selected" : ""}>良品処理</option>
              </select>
            </td>
            <td contenteditable="true">\${r.sortOrder || ''}</td>
            <td class="text-center"><input type="checkbox" \${r.useYn?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isMove?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isTransfer?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isAsOut?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isAsReturn?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isFreeSupply?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" \${r.isDispatchTarget?.toUpperCase() === 'Y' ? "checked" : ""}></td>
            <td class="text-center"><input type="checkbox" class="chk-delete"></td>
          `;
        }

        html += `</tr>`;
        tbody.append(html);
      });
 
      // ✅ 新規追加行 / 신규 입력 행 추가
		let emptyRow = `<tr data-txncode="">
		  <td class="text-center">\${result.length + 1}</td>`;

		if (type === "OUT") {
		  emptyRow += `
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="판촉">販促</option>
		        <option value="폐기">廃棄</option>
		        <option value="반품">返品</option>
		      </select>
		    </td>
		    <td contenteditable="true"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="외화현금">外貨現金</option>
		        <option value="보통예금">普通預金</option>
		        <option value="외화보통예금">外貨普通預金</option>
		        <option value="당좌예금">当座預金</option>
		      </select>
		    </td>
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="제조">製造</option>
		        <option value="판관">販売管理</option>
		      </select>
		    </td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="판매기준단가+수량(차액처리포함)">販売基準単価＋数量(差額処理含む)</option>
		        <option value="판매기준단가+수량(차액처리안함)">販売基準単価＋数量(差額処理なし)</option>
		      </select>
		    </td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
		}

		else if (type === "IN") {
		  emptyRow += `
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="샘플입고">サンプル入庫</option>
		        <option value="불량입고">不良入庫</option>
		        <option value="정상입고">正常入庫</option>
		      </select>
		    </td>
		    <td contenteditable="true"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="외화현금">外貨現金</option>
		        <option value="보통예금">普通預金</option>
		        <option value="외화보통예금">外貨普通預金</option>
		        <option value="당좌예금">当座預金</option>
		      </select>
		    </td>
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="제조">製造</option>
		        <option value="판관">販売管理</option>
		      </select>
		    </td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
		}

		else if (type === "MOVE") {
		  emptyRow += `
		    <td>
		      <select class="form-select">
		        <option value="">選択</option>
		        <option value="위탁처리">委託処理</option>
		        <option value="이동처리">移動処理</option>
		        <option value="자재불출">資材払出</option>
		        <option value="외주불출">外注払出</option>
		        <option value="불량처리">不良処理</option>
		        <option value="양품처리">良品処理</option>
		      </select>
		    </td>
		    <td contenteditable="true"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox"></td>
		    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
		}

		emptyRow += `</tr>`;
		tbody.append(emptyRow);
	}
});
}

/* ✅ 編集検知イベント / 수정 감지 이벤트 */
$(document).on("change input", "tbody input, tbody select, tbody [contenteditable=true]", function() {
  $(this).closest("tr").addClass("modified");
});

/* ✅ 保存処理 / 저장 처리 */
function saveAll() {
	  const active = $(".tab-btn.active").text().trim();
	  let type = active === "出庫" ? "OUT" : (active === "入庫" ? "IN" : "MOVE");
	  let tbody = type === "OUT" ? "#tbody-out" : type === "IN" ? "#tbody-in" : "#tbody-move";
	  let data = [];

	  $(tbody + " tr").each(function () {
	    const tr = $(this);
	    const txnCode = tr.data("txncode");
	    const tds = tr.find("td");

	    let obj = {
	      txnCode: txnCode && txnCode !== "" ? txnCode : null,
	      categoryName: $(tds[1]).find("select").val(),
	      sortOrder: $(tds[2]).text().trim(),
	      useYn: $(tds[3]).find("input").prop("checked") ? "Y" : "N",
	      txnType: type,
	      buId: 10
	    };

	    if (type === "OUT") {
	      obj.accountSubject = $(tds[4]).find("select").val();
	      obj.costType = $(tds[5]).find("select").val();
	      obj.isFinishedProduct = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
	      obj.isMaterial = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
	      obj.isSalesUse = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
	      obj.adjustOut = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
	      obj.adjustIn = $(tds[10]).find("input").prop("checked") ? "Y" : "N";
	      obj.isVatTarget = $(tds[11]).find("input").prop("checked") ? "Y" : "N";
	      obj.vatProcessType = $(tds[12]).find("select").val();
	      obj.isAs = $(tds[13]).find("input").prop("checked") ? "Y" : "N";
	      obj.isItemJournal = $(tds[14]).find("input").prop("checked") ? "Y" : "N";
	    }

	    if (type === "IN") {
	      obj.accountSubject = $(tds[4]).find("select").val();
	      obj.costType = $(tds[5]).find("select").val();
	      obj.isFinishedProduct = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
	      obj.isMaterial = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
	      obj.isByproductIn = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
	      obj.isReturnIn = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
	    }

	    if (type === "MOVE") {
	      obj.isMove = $(tds[4]).find("input").prop("checked") ? "Y" : "N";
	      obj.isTransfer = $(tds[5]).find("input").prop("checked") ? "Y" : "N";
	      obj.isAsOut = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
	      obj.isAsReturn = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
	      obj.isFreeSupply = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
	      obj.isDispatchTarget = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
	    }

	    if (!obj.categoryName || obj.categoryName === "選択") return;

	    if (!txnCode || tr.hasClass("modified")) {
	      data.push(obj);
	    }
	  });

	  if (data.length === 0) {
	    alert("保存する項目がありません。");
	    return;
	  }

	  let successCount = 0;
	  data.forEach((row) => {
	    $.ajax({
	      url: '/txnCategory/api/save',
	      type: 'POST',
	      contentType: 'application/json',
	      data: JSON.stringify(row),
	      success: () => {
	        successCount++;
	        if (successCount === data.length) {
	          alert("保存が完了しました ✅");
	          loadData();
	        }
	      },
	      error: (err) => console.error("保存失敗:", err)
	    });
	  });
	}




/* ✅ 削除処理 / 삭제 처리 */
function deleteSelected() {
  const active = $(".tab-btn.active").text().trim();
  let tbody = active === "出庫" ? "#tbody-out" : active === "入庫" ? "#tbody-in" : "#tbody-move";
  let checked = $(tbody + " .chk-delete:checked");

  if (checked.length === 0) {
    alert("削除する項目を選択してください。"); // 삭제할 항목을 선택하세요.
    return;
  }
  if (!confirm("選択した項目を削除しますか？")) return; // 선택 항목 삭제 확인

  const buId = 1;
  let successCount = 0;
  const total = checked.length;

  checked.each(function () {
    const tr = $(this).closest("tr");
    const txnCode = tr.data("txncode");

    if (txnCode) {
      $.ajax({
        url: "/txnCategory/api/delete",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ txnCode: txnCode, buId: buId }),
        success: function () {
          tr.remove();
          successCount++;
          if (successCount === total) {
            reorderRowNumbers(tbody);
            alert("削除が完了しました。"); // 삭제 완료
          }
        },
        error: function (xhr) {
          console.error("削除失敗:", xhr);
          alert("削除中にエラーが発生しました。"); // 삭제 중 오류 발생
        }
      });
    } else {
      tr.remove();
    }
  });
  reorderRowNumbers(tbody);
}


	/* ✅ 番号再整理関数 / 번호 재정렬 함수 */
	function reorderRowNumbers(tbodySelector) {
	  $(tbodySelector + " tr").each(function (index) {
	    $(this).find("td:first").text(index + 1);
	  });
	}





/* ✅ ページロード時自動照会 / 페이지 로드시 자동 조회 */
$(document).ready(loadData);
</script>
