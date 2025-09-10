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
<title>재고 변동 추이 분석</title>
<style>
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
</style>
</head>
<body>
	<h2>재고 변동 추이 분석</h2>

	<form id="stockAnalysisForm">
		<div class="search-container">
			<div class="search-header">조회조건</div>

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
					<input type="text" id="warehouseId" name="warehouseId"
						placeholder="창고 코드 또는 이름" />
					<span class="search-icon" onclick="openWarehouseSearchPopup()">
						<svg xmlns="http://www.w3.org/2000/svg" fill="none"
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
					<select id="itemSmallCategory" name="itemSmallCategory">
						<option value="">전체</option>
						<c:forEach var="category" items="${itemSmallCategories.rows}">
							<option value="${category.small_category}">${category.small_category}</option>
						</c:forEach>
					</select> <span class="search-icon" onclick="openSmallCategorySearchPopup()">
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
				<label for="currentMonth">현재월</label> <input type="month"
					id="currentMonth" name="currentMonth" readonly>
			</div>
			<div class="search-item">
				<label for="periodRange">기간간격:</label> <input type="number"
					id="periodRange" name="periodRange" value="3"> 개월
			</div>
			<div class="search-item">
				<label for="compareCount">비교횟수:</label> <input type="number"
					id="compareCount" name="compareCount" value="4"> 회
			</div>
			<div class="search-item">
				<label for="analysisItem">분석항목:</label> <select id="analysisItem"
					name="analysisItem">
					<option value="총출고량">총출고량</option>
					<option value="총입고량">총입고량</option>
					<option value="재고금액">재고금액</option>
				</select>
			</div>
			<button type="button" id="searchButton">조회</button>
		</div>
	</form>

	<div id="resultTableContainer"></div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<script>
$(document).ready(function () {
    // 현재 시스템 날짜를 yyyy-MM 형태로 변환
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const currentMonth = `${year}-${month}`;

    // readonly input에 기본값 세팅
    $('#currentMonth').val(currentMonth);

    // 조회 버튼 클릭 이벤트
    $('#searchButton').on('click', function () {
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
    // 필요에 따라 창고 이름도 다른 곳에 표시할 수 있습니다.
    // 예: $('#warehouseName').val(name);
}

// 품목소분류 검색 팝업 함수
function openSmallCategorySearchPopup() {
    const url = '/stockAnalysis/itemSubCategorySearchPopup';
    const name = 'smallCategoryPopup';
    const specs = 'width=800,height=600,scrollbars=yes,resizable=yes';
    window.open(url, name, specs);
}

// 팝업에서 선택된 데이터를 받는 함수
function setSmallCategoryData(data) {
    if (data && data.smallCategory) {
        // 품목소분류 드롭다운에 값을 설정합니다.
        let $select = $('#itemSmallCategory');
        if ($select.find(`option[value='${data.smallCategory}']`).length) {
            $select.val(data.smallCategory);
        } else {
            $select.append(`<option value="${data.smallCategory}">${data.smallCategory}</option>`);
            $select.val(data.smallCategory);
        }
    }
}
</script>

</body>
</html>