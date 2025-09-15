<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 분석</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body { font-family: Arial, sans-serif; }
    h2 { margin-bottom: 20px; }
    .container { max-width: 1200px; margin: auto; }

    /* 📌 조회조건 박스 */
    .search-container {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        background-color: #f9f9f9;
    }
    .search-container h3 {
        margin-bottom: 15px;
        font-size: 18px;
        font-weight: bold;
    }
    .search-grid {
        display: grid;
        grid-template-columns: 180px 1fr 180px 1fr;
        gap: 12px 20px;
        align-items: center;
    }
    .search-grid label {
        font-weight: bold;
        text-align: right;
    }
    .search-grid input, 
    .search-grid select, 
    .search-grid button {
        padding: 6px;
        width: 100%;
        box-sizing: border-box;
    }
    .btn-search {
        margin-top: 15px;
        padding: 8px 16px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }
    .btn-search:hover {
        background-color: #45a049;
    }

    /* 📌 결과 테이블 */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
<div class="container">

<h2>재고 분석</h2>

<!-- ✅ 조회조건 컨테이너 -->
<div class="search-container">
    <h3>조회조건</h3>
    <div class="search-grid">
        <label>사업단위</label>
        <select id="buId">
            <option value="">-- 선택 --</option>
            <option value="1">본사</option>
        </select>

        <label>창고</label>
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
        <button type="button" id="btnCategory">소분류 선택</button>

        <label>품명</label>
        <input type="text" id="itemName" />

        <label>품번</label>
        <input type="text" id="itemCode" />

        <label>규격</label>
        <input type="text" id="spec" />
    </div>

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
            <th>품명</th>
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

<script>
$(document).ready(function () {
    $("#btnSearch").click(function () {
    	let requestData = {
    		    buId: $("#buId").val(),
    		    itemName: $("#itemName").val(),
    		    itemId: $("#itemCode").val(),   // 품번
    		    spec: $("#spec").val()
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
                    "<td>" + (item.itemId || '') + "</td>" +          // 품번
                    "<td>" + (item.itemName || '') + "</td>" +
                    "<td>" + (item.spec || '') + "</td>" +            // 규격
                    "<td>" + (item.baseUnit || '') + "</td>" +        // 단위
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
</script>

</body>
</html>
