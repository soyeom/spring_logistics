<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 분석</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
}

h2 {
    margin-bottom: 20px;
}

.container {
    max-width: 1200px;
    margin: auto;
}

/* 📌 조회조건 박스 */
.search-container {
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 20px;
    background-color: #f9f9f9;
}

.search-grid {
    display: grid;
    grid-template-columns: 150px 1fr 150px 1fr;
    gap: 12px 16px;
    align-items: center;
}

.search-grid label {
    font-weight: bold;
    text-align: right;
    white-space: nowrap;
}

.search-grid input,
.search-grid select,
.search-grid button {
    padding: 6px;
    height: 32px;
    width: 100%;
    box-sizing: border-box;
}

/* 📌 조회 버튼 */
.btn-search {
    grid-column: span 4;     /* ✅ 버튼을 한 줄 전부 차지 */
    justify-self: end;       /* ✅ 오른쪽 끝으로 정렬 */
    padding: 6px 14px;
    height: 32px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: auto;             /* 버튼 크기 = 내용 크기 */
}

.btn-search:hover {
    background-color: #45a049;
}

/* 📌 결과 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 14px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    vertical-align: middle;
}

th {
    background-color: #f2f2f2;
}

</style>
</head>
<body>
<div class="container">

    <h2>재고 분석</h2>

    <!-- ✅ 조회조건 컨테이너 -->
  <div class="search-container">
    <label>사업단위</label>
    <select id="buId">
        <option value="">-- 선택 --</option>
        <option value="1">본사</option>
    </select>

    <label>창고</label>
    <input type="hidden" id="warehouseId" name="warehouseId" />
    <button type="button" id="btnWarehouse">창고 선택</button>

    <label>재고기준</label>
    <select id="stockStandard">
        <option value="REAL">실재고</option>
        <option value="ASSET">자산재고</option>
    </select>

    <label>중요도</label>
    <select id="importanceLevel">
        <option value="">-- 선택 --</option>
        <option value="A">A등급</option>
        <option value="B">B등급</option>
        <option value="C">C등급</option>
    </select>

    <label>품목자산분류</label>
    <select id="itemAssetClass">
        <option value="">-- 선택 --</option>
        <option value="제품">제품</option>
        <option value="반제품">반제품</option>
        <option value="상품">상품</option>
        <option value="원자재">원자재</option>
        <option value="부자재">부자재</option>
        <option value="재공품">재공품</option>
        <option value="저장품">저장품</option>
    </select>

    <label>품목소분류</label>
    <input type="hidden" id="itemSmallCategory" name="itemSmallCategory" />
    <button type="button" id="btnItemSmallCategory">소분류 선택</button>

    <label>품명</label>
    <input type="text" id="itemName" />

    <label>품번</label>
    <input type="text" id="itemCode" />

    <label>규격</label>
    <input type="text" id="spec" />

    <!-- ✅ 조회 버튼은 맨 끝 -->
    <button class="btn-search" id="btnSearch">조회</button>
</div>

    <!-- ✅ 결과 테이블 -->
    <table>
        <thead>
        <tr>
            <th>품목자산분류</th>
            <th>품목대분류</th>
            <th>품목중분류</th>
            <th>품목소분류</th>
            <th>품번</th>
            <th>품명</th>
            <th>규격</th>
            <th>기초재고</th>
            <th>입고수량</th>
            <th>출고수량</th>
            <th>기말재고</th>
        </tr>
        </thead>
        <tbody id="resultBody">
            <!-- Ajax로 데이터 채움 -->
        </tbody>
    </table>

</div>
</body>

	

		<script>
$(document).ready(function () {
    $("#btnSearch").click(function () {
        let requestData = {
            buId: $("#buId").val(),
            itemName: $("#itemName").val(),
            spec: $("#spec").val(),
            itemAssetClass: $("#itemAssetClass").val(),
            importanceLevel: $("#importanceLevel").val(),
            stockStandard: $("#stockStandard").val()   // ✅ 추가됨
        };

        $.ajax({
            url: "${pageContext.request.contextPath}/stock-analysis/analysis",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestData),
            success: function (data) {
                let tbody = $("#resultBody");
                tbody.empty();

                if (data.length === 0) {
                    tbody.append("<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>");
                    return;
                }

                $.each(data, function (index, item) {
                    let row = "<tr>" +
                        "<td>" + (item.itemAssetClass || '') + "</td>" +
                        "<td>" + (item.itemBigCategory || '') + "</td>" +
                        "<td>" + (item.itemMidCategory || '') + "</td>" +
                        "<td>" + (item.itemSmallCategory || '') + "</td>" +
                        "<td>" + (item.itemId || '') + "</td>" +
                        "<td>" + (item.itemName || '') + "</td>" +
                        "<td>" + (item.spec || '') + "</td>" +
                        "<td>" + (item.beginningStock || 0) + "</td>" +
                        "<td>" + (item.inboundQty || 0) + "</td>" +
                        "<td>" + (item.outQty || 0) + "</td>" +
                        "<td>" + (item.endingStock || 0) + "</td>" +
                        "</tr>";
                    tbody.append(row);
                });
            },
            error: function (xhr, status, error) {
                alert("데이터 조회 중 오류 발생: " + error);
            }
        });
    });
});

//📌 창고 선택 팝업 열기
$("#btnWarehouse").click(function () {
    window.open(
        "${pageContext.request.contextPath}/stock-analysis/warehouse-popup",
        "warehousePopup",
        "width=600,height=400,scrollbars=yes,resizable=no"
    );
});

$(document).on("click", "#warehouseTable tr", function () {
    let id = $(this).data("id");
    let name = $(this).data("name");

    // 부모창의 input/select 에 값 넣기
    window.opener.document.getElementById("warehouseId").value = id;
    window.opener.document.getElementById("btnWarehouse").innerText = name;

    window.close();
});


//📌 소분류 선택 팝업 열기
$("#btnItemSmallCategory").click(function () {
    window.open(
        "${pageContext.request.contextPath}/stock-analysis/item-small-category-popup",
        "itemSmallCategoryPopup",
        "width=700,height=500,scrollbars=yes,resizable=no"
    );
});

// 📌 소분류 선택 이벤트 (팝업 내 테이블 행 클릭 시)
$(document).on("click", "#smallCategoryTable tr", function () {
    let id = $(this).data("id");     // 소분류 ID (코드)
    let name = $(this).data("name"); // 소분류명

    // 부모창의 input/select에 값 넣기
    window.opener.document.getElementById("itemSmallCategory").value = id;
    window.opener.document.getElementById("btnItemSmallCategory").innerText = name;

    window.close();
});


</script>
</body>
</html>
