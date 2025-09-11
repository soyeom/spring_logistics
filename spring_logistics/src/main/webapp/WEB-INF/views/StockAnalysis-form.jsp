<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe" user="system" password="1234" />

<%-- business_unit 테이블에서 bu_id와 bu_name을 조회 --%>
<sql:query var="businessUnits" dataSource="${dataSource}">SELECT bu_id, bu_name FROM business_unit ORDER BY bu_id</sql:query>

<%-- item_master 테이블에서 category를 조회 --%>
<sql:query var="itemBigCategories" dataSource="${dataSource}">SELECT DISTINCT big_category FROM item_master WHERE big_category IS NOT NULL</sql:query>
<sql:query var="itemMidCategories" dataSource="${dataSource}">SELECT DISTINCT mid_category FROM item_master WHERE mid_category IS NOT NULL</sql:query>
<sql:query var="itemSmallCategories" dataSource="${dataSource}">SELECT DISTINCT small_category FROM item_master WHERE small_category IS NOT NULL</sql:query>
<sql:query var="importanceLevels" dataSource="${dataSource}">SELECT DISTINCT importance_level FROM item_master WHERE importance_level IS NOT NULL</sql:query>
<sql:query var="units" dataSource="${dataSource}">SELECT DISTINCT base_unit FROM item_master WHERE base_unit IS NOT NULL</sql:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고변동추이분석</title>
<style>
.search-header {
	display: flex;
	justify-content: space-between; /* 양쪽 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	padding: 10px;
	border-bottom: 1px solid #ccc;
	font-weight: bold;
}

#searchButton {
	padding: 6px 12px;
	font-size: 14px;
}

.search-container {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 15px;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 8px;
}

.search-item {
	display: flex;
	flex-direction: column;
}

.search-header {
	grid-column: 1/-1; /* 전체 너비 차지 */
	background-color: #f5f5f5; /* 회색 배경 */
	border-bottom: 1px solid #ccc; /* 구분선 */
	padding: 8px 12px;
	font-weight: bold;
	font-size: 14px;
}

/* 추가된 CSS */
.search-group {
	display: flex;
	align-items: center;
}

.search-group input[type="text"], .search-group select {
	flex-grow: 1;
}

.search-icon {
	cursor: pointer;
	margin-left: -25px;
	z-index: 10;
}

.search-icon svg {
	width: 20px;
	height: 20px;
}

.result-container {
	margin-top: 15px;
	border: 1px solid #ccc;
	border-radius: 6px;
	padding: 10px;
	background: #fff;
}

.result-container table th {
	background-color: #f5f5f5;
	padding: 8px;
}

.result-container table td {
	padding: 6px;
}
</style>
</head>
<body>
	<h2>재고변동추이분석</h2>

	<form id="stockAnalysisForm">
		<div class="search-container">
			<div class="search-header">
				<span class="title">조회조건</span>
				<button type="button" id="searchButton">조회</button>
			</div>

			<div class="search-item">
				<label for="buId">사업단위:</label> <select id="buId" name="buId">
					<option value="">전체</option>
					<c:forEach var="bu" items="${businessUnits.rows}">
						<option value="${bu.bu_id}">${bu.bu_name}</option>
					</c:forEach>
				</select>
			</div>

			<%-- 창고 검색 기능 추가 --%>
			<div class="search-item">
				<label for="warehouseId">창고:</label>
				<div class="search-group">
					<input type="hidden" id="warehouseId" name="warehouseId" /> <input
						type="text" id="warehouseName" name="warehouseName"
						placeholder="창고 코드 또는 이름" readonly /> <span class="search-icon"
						onclick="openWarehouseSearchPopup()"> <svg
							xmlns="http://www.w3.org/2000/svg" fill="none"
							viewBox="0 0 24 24" stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
			</svg>
					</span>
				</div>
			</div>

			<div class="search-item">
				<label for="stockStandard">재고기준:</label> <select id="stockStandard"
					name="stockStandard">
					<option value="">전체</option>
					<option value="수량">수량</option>
					<option value="금액">금액</option>
				</select>
			</div>

			<div class="search-item">
				<label for="importanceLevel">중요도:</label> <select
					id="importanceLevel" name="importanceLevel">
					<option value="">전체</option>
					<c:forEach var="level" items="${importanceLevels.rows}">
						<option value="${level.importance_level}">${level.importance_level}</option>
					</c:forEach>
				</select>
			</div>

			<%-- 품목자산분류 드롭다운 목록으로 변경 --%>
			<div class="search-item">
				<label for="itemAssetClass">품목자산분류:</label> <select
					id="itemAssetClass" name="itemAssetClass">
					<option value="">전체</option>
					<option value="제품">제품</option>
					<option value="반제품">반제품</option>
					<option value="상품">상품</option>
					<option value="부자재">부자재</option>
					<option value="원자재">원자재</option>
					<option value="재공품">재공품</option>
				</select>
			</div>

			<%-- 품목소분류 검색 기능 추가 --%>
			<div class="search-item">
				<label for="itemSmallCategory">품목소분류:</label>
				<div class="search-group">
					<input type="hidden" id="itemSmallCategory"
						name="itemSmallCategory" /> <input type="text"
						id="itemSmallCategoryName" name="itemSmallCategoryName"
						placeholder="품목소분류 코드 또는 이름" readonly /> <span
						class="search-icon" onclick="openSmallCategorySearchPopup()">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none"
							viewBox="0 0 24 24" stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
			</svg>
					</span>
				</div>
			</div>

			<div class="search-item">
				<label for="itemName">품명:</label> <input type="text" id="itemName"
					name="itemName" placeholder="품명">
			</div>

			<div class="search-item">
				<label for="itemInternalCode">품번:</label> <input type="text"
					id="itemInternalCode" name="itemInternalCode" placeholder="품번">
			</div>

			<div class="search-item">
				<label for="spec">규격:</label> <input type="text" id="spec"
					name="spec" placeholder="규격">
			</div>

			<div class="search-item">
				<label for="unit">단위:</label> <select id="unit" name="unit">
					<option value="">전체</option>
					<c:forEach var="unit" items="${units.rows}">
						<option value="${unit.base_unit}">${unit.base_unit}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="search-container">
			<div class="search-header">비교대상 기간설정</div>
			<div class="search-item">
				<label for="currentMonth">현재월</label>
				<%
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM");
					String currentMonth = sdf.format(new java.util.Date());
				%>
				<input type="month" id="currentMonth" name="currentMonth"
					value="<%=currentMonth%>">
			</div>
			<div class="search-item">
				<label for="periodRange">기간간격:</label>
				<div style="display: flex; align-items: center; gap: 8px;">
					<input type="number" id="periodRange" name="periodRange" min="1"
						value="3" style="width: 70px;"> <span>개월</span> <input
						type="number" id="compareCount" name="compareCount" min="1"
						value="4" style="width: 70px;"> <span>회</span>
				</div>
			</div>

			<select id="analysisItem" name="analysisItem">
				<option value="averageStock">평균재고량</option>
				<option value="turnoverRate">재고회전율(%)</option>
				<option value="totalInbound">총입고량</option>
				<option value="totalOutbound">총출고량</option>
			</select>


		</div>

	</form>

	<div id="resultTableContainer">
		<table id="resultTable" border="1"
			style="width: 100%; border-collapse: collapse; text-align: center;">
			<thead>
				<tr>
					<th>품목대분류</th>
					<th>품목중분류</th>
					<th>품목자산분류</th>
					<th>품목소분류</th>
					<th>품명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5">조회 결과가 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<script>

	$(document).ready(function (){
    // 조회 버튼 클릭 이벤트
    $('#searchButton').on('click', function () {
	
		if(!$('#stockStandard').val()){
			alert('재고기준을 선택하세요.');
			$('#stockStandard').focus();
			return;
		}
		if(!$('#analysisItem').val()){
			alert('분석항목을 선택하세요.');
			$('#analysisItem').focus();
			return;
		}
		
        const formData = {
            buId: $('#buId').val(),
            warehouseId: $('#warehouseId').val(),
            stockStandard: $('#stockStandard').val(),
            importanceLevel: $('#importanceLevel').val(),
            itemAssetClass: $('#itemAssetClass').val(),
            itemSmallCategory: $('#itemSmallCategory').val(),
            itemName: $('#itemName').val(),
            itemInternalCode: $('#itemInternalCode').val(),
            spec: $('#spec').val(),
            unit: $('#unit').val(),
            currentMonth: $('#currentMonth').val(),
            periodRange: $('#periodRange').val(),
            compareCount: $('#compareCount').val(),
            analysisItem: $('#analysisItem').val()
        };

        $.ajax({
            url: '/stockAnalysis/analysis',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function (response) {
                console.log('데이터 조회 성공:', response);
                displayDataInTable(response);
            },
            error: function (error) {
                console.error('데이터 조회 실패:', error);
                alert('데이터를 가져오는 데 실패했습니다.');
            }
        });
    });

    // 결과 테이블 출력 함수
    function displayDataInTable(data) {
        const container = $('#resultTableContainer');
        container.empty();

        if (data && data.length > 0) {
            let tableHtml = '<table border="1"><thead><tr>';
            for (const key in data[0]) {
                tableHtml += '<th>' + key + '</th>';
            }
            tableHtml += '</tr></thead><tbody>';

            data.forEach(item => {
                tableHtml += '<tr>';
                for (const key in item) {
                    tableHtml += '<td>' + (item[key] !== null ? item[key] : '') + '</td>';
                }
                tableHtml += '</tr>';
            });
            tableHtml += '</tbody></table>';
            container.append(tableHtml);
        } else {
            container.append('<p>조회된 데이터가 없습니다.</p>');
        }
    }
});

// 창고 검색 팝업 함수
function openWarehouseSearchPopup() {
    const url = '/stockAnalysis/warehouseSearchPopup';
    const name = 'warehousePopup';
    const specs = 'width=600,height=500,scrollbars=yes,resizable=yes';
    window.open(url, name, specs);
}

// 팝업에서 선택된 창고 데이터를 받는 함수
function setWarehouse(code, name) {
	$('#warehouseId').val(code);
	$('#warehouseName').val(name);
}

// 품목소분류 검색 팝업 함수
function openSmallCategorySearchPopup() {
    const url = '/stockAnalysis/itemSubCategorySearchPopup';
    const name = 'smallCategoryPopup';
    const specs = 'width=800,height=600,scrollbars=yes,resizable=yes';
    window.open(url, name, specs);
}

// 팝업에서 선택된 데이터를 받는 함수
// 팝업에서 선택된 데이터를 받는 함수 (수정)
function setSmallCategoryData(data) {
    if (data && data.smallCategoryCode && data.smallCategoryName) {
        // 품목소분류 코드와 이름을 각각의 input에 설정
        $('#itemSmallCategory').val(data.smallCategoryCode);
        $('#itemSmallCategoryName').val(data.smallCategoryName);
    }
}
</script>

</body>
</html>