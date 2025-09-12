<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>재고변동추이분석</title>
<style>
/* 전체 페이지 기본 스타일 */
body {
    font-family: 'Noto Sans KR', 'Malgun Gothic', '맑은 고딕', sans-serif;
    font-size: 14px;
    color: #444;
    background-color: #f7f9fc;
    margin: 20px;
}

h2 {
    font-size: 24px;
    font-weight: normal;
    color: #1a5276;
    border-bottom: 2px solid #a8c1de;
    padding-bottom: 8px;
    margin-bottom: 20px;
}

/* --- 요청된 CSS 시작 --- */
.search-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 15px;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #fff;
    margin-bottom: 20px;
}

.search-header {
    grid-column: 1/-1; /* 전체 너비 차지 */
    display: flex;
    justify-content: space-between; /* 양쪽 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    padding: 10px;
    border-bottom: 1px solid #ccc;
    font-weight: bold;
    font-size: 14px;
    background-color: #f5f5f5; /* 회색 배경 */
}

#searchButton {
    padding: 6px 12px;
    font-size: 14px;
    background-color: #1a5276;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

#searchButton:hover {
    background-color: #154261;
}

.search-item {
    display: flex;
    flex-direction: column;
}

.search-item label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #555;
    font-size: 13px;
}

.search-item input[type="text"],
.search-item select,
.search-item input[type="number"],
.search-item input[type="month"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #c8d3e1;
    border-radius: 4px;
    box-sizing: border-box;
}

.search-item input[type="text"]:focus,
.search-item select:focus,
.search-item input[type="number"]:focus,
.search-item input[type="month"]:focus {
    outline: none;
    border-color: #4c8bf5;
}

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
    background: transparent;
    border: none;
}

.search-icon svg {
    width: 20px;
    height: 20px;
    fill: #888;
}

.result-container {
    margin-top: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 10px;
    background: #fff;
    overflow-x: auto;
}

.result-container table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}

.result-container table th {
    background-color: #f5f5f5;
    padding: 8px;
    border-bottom: 1px solid #ccc;
    text-align: center;
}

.result-container table td {
    padding: 6px;
    border-bottom: 1px solid #e0e6ed;
    text-align: center;
}
/* --- 요청된 CSS 끝 --- */

</style>
</head>
<body>
    <h2>재고변동추이분석</h2>

    <form id="stockAnalysisForm">
        <div class="search-container">
            <div class="search-header">
                <span>조회조건</span>
                <button type="button" id="searchButton">조회</button>
            </div>

            <div class="search-item">
    <label for="buId">사업단위:</label>
    <select id="buId" name="buId" onchange="fetchDataForBusinessUnit()">
        <option value="">전체</option>
        <%-- 백엔드에서 동적으로 로드 필요 --%>
    </select>
</div>

            <div class="search-item">
                <label for="warehouseId">창고:</label>
                <div class="search-group">
                    <input type="text" id="warehouseName" name="warehouseName" placeholder="창고 코드 또는 이름" readonly />
                    <input type="hidden" id="warehouseId" name="warehouseId" />
                    <button type="button" class="search-icon" onclick="openWarehouseSearchPopup()">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </button>
                </div>
            </div>

            <div class="search-item">
                <label for="stockStandard">재고기준:</label>
                <select id="stockStandard" name="stockStandard">
                    <option value=""></option>
                    <option value="수량">수량</option>
                    <option value="금액">금액</option>
                </select>
            </div>

            <div class="search-item">
                <label for="importanceLevel">중요도:</label>
                <select id="importanceLevel" name="importanceLevel">
                    <option value="">전체</option>
                    <%-- 백엔드에서 동적으로 로드 필요 --%>
                </select>
            </div>

            <div class="search-item">
                <label for="itemAssetClass">품목자산분류:</label>
                <select id="itemAssetClass" name="itemAssetClass">
                    <option value="">전체</option>
                    <option value="제품">제품</option>
                    <option value="반제품">반제품</option>
                    <option value="상품">상품</option>
                    <option value="부자재">부자재</option>
                    <option value="원자재">원자재</option>
                    <option value="재공품">재공품</option>
                </select>
            </div>

            <div class="search-item">
                <label for="itemSmallCategory">품목소분류:</label>
                <div class="search-group">
                    <input type="text" id="itemSmallCategoryName" name="itemSmallCategoryName" placeholder="품목소분류 코드 또는 이름" readonly />
                    <input type="hidden" id="itemSmallCategory" name="itemSmallCategory" />
                    <button type="button" class="search-icon" onclick="openSmallCategorySearchPopup()">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </button>
                </div>
            </div>

            <div class="search-item">
                <label for="itemName">품명:</label>
                <input type="text" id="itemName" name="itemName" placeholder="품명">
            </div>

            <div class="search-item">
                <label for="spec">규격:</label>
                <input type="text" id="spec" name="spec" placeholder="규격">
            </div>

            <div class="search-item">
                <label for="baseUnit">단위:</label>
                <select id="baseUnit" name="baseUnit">
                    <option value="">전체</option>
                    <%-- 백엔드에서 동적으로 로드 필요 --%>
                </select>
            </div>
        </div>

        <div class="search-container">
            <div class="search-header">비교대상 기간설정</div>
            <div class="search-item">
                <label for="currentMonth">현재월</label>
                <input type="month" id="currentMonth" name="currentMonth">
            </div>
            <div class="search-item">
                <label for="periodRange">기간간격:</label>
                <div style="display: flex; align-items: center; gap: 8px;">
                    <input type="number" id="periodRange" name="periodRange" min="1" value="3" style="width: 70px;">
                    <span>개월</span>
                    <input type="number" id="compareCount" name="compareCount" min="1" value="4" style="width: 70px;">
                    <span>회</span>
                </div>
            </div>

            <div class="search-item">
                <label for="analysisItem">분석항목:</label>
                <select id="analysisItem" name="analysisItem">
                    <option value="averageStock">평균재고량</option>
                    <option value="turnoverRate">재고회전율(%)</option>
                    <option value="totalInbound">총입고량</option>
                    <option value="totalOutbound">총출고량</option>
                </select>
            </div>
        </div>
    </form>

    <div id="resultTableContainer" class="result-container">
        <table id="resultTable">
            <thead>
                <tr>
                    <th>품목대분류</th>
                    <th>품목중분류</th>
                    <th>품목자산분류</th>
                    <th>품목소분류</th>
                    <th>품명</th>
                    <th>기초재고</th>
                    <th>입고량</th>
                    <th>출고량</th>
                    <th>기말재고</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="9">조회 결과가 없습니다.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // 현재 월을 설정
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            $('#currentMonth').val(`${year}-${month}`);

            // 조회 버튼 클릭 이벤트
            $('#searchButton').on('click', function () {
                if (!$('#stockStandard').val()) {
                    alert('재고기준을 선택하세요.');
                    $('#stockStandard').focus();
                    return;
                }
                if (!$('#analysisItem').val()) {
                    alert('분석항목을 선택하세요.');
                    $('#analysisItem').focus();
                    return;
                }
                
                const requestData = {
                    buId: $('#buId').val(),
                    warehouseId: $('#warehouseId').val(),
                    stockStandard: $('#stockStandard').val(),
                    importanceLevel: $('#importanceLevel').val(),
                    itemAssetClass: $('#itemAssetClass').val(),
                    itemSmallCategory: $('#itemSmallCategory').val(),
                    itemName: $('#itemName').val(),
                    spec: $('#spec').val(),
                    baseUnit: $('#baseUnit').val(),
                    periodRange: $('#periodRange').val(),
                    compareCount: $('#compareCount').val(),
                    analysisItem: $('#analysisItem').val()
                };

                const currentMonth = $('#currentMonth').val();
                if (currentMonth) {
                    const dateParts = currentMonth.split('-');
                    const year = parseInt(dateParts[0]);
                    const month = parseInt(dateParts[1]);
                    const firstDayOfMonth = new Date(year, month - 1, 1);
                    const lastDayOfMonth = new Date(year, month, 0);

                    requestData.startDate = firstDayOfMonth.toISOString().slice(0, 10);
                    requestData.endDate = lastDayOfMonth.toISOString().slice(0, 10);
                }

                $.ajax({
                    url: '/stock-analysis/analysis',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(requestData),
                    success: function (response) {
                        console.log("AJAX 성공. 받은 데이터:", response);
                        displayDataInTable(response);
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX 오류:", status, error);
                        console.log("XHR:", xhr.responseText);
                        $('#resultTableContainer').html('<p style="text-align: center; color: #888;">데이터 조회 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.</p>');
                    }
                });
            });

            // 결과 테이블 출력 함수
            function displayDataInTable(data) {
                const container = $('#resultTableContainer');
                container.empty();

                if (Array.isArray(data) && data.length > 0) {
                    const desiredColumns = [
                        'itemBigCategory',
                        'itemMidCategory',
                        'itemAssetClass',
                        'itemSmallCategory',
                        'itemName',
                        'beginningStock',
                        'inboundQty',
                        'outQty',
                        'endingStock'
                    ];
                    let tableHtml = '<table><thead><tr>';
                    
                    const headerNames = {
                        itemBigCategory: '품목대분류',
                        itemMidCategory: '품목중분류',
                        itemAssetClass: '품목자산분류',
                        itemSmallCategory: '품목소분류',
                        itemName: '품명',
                        beginningStock: '기초재고',
                        inboundQty: '입고량',
                        outQty: '출고량',
                        endingStock: '기말재고'
                    };
                    desiredColumns.forEach(key => {
                        tableHtml += '<th>' + (headerNames[key] || key) + '</th>';
                    });
                    tableHtml += '</tr></thead><tbody>';
                    data.forEach(item => {
                        tableHtml += '<tr>';
                        desiredColumns.forEach(key => {
                            const value = item[key] !== null ? item[key] : '';
                            tableHtml += '<td>' + value + '</td>';
                        });
                        tableHtml += '</tr>';
                    });
                    
                    tableHtml += '</tbody></table>';
                    container.append(tableHtml);
                } else {
                    container.append('<p style="text-align: center; color: #888; padding: 20px;">조회된 데이터가 없습니다.</p>');
                }
            }
        });

        // 창고 검색 팝업 함수
        function openWarehouseSearchPopup() {
            const url = 'warehouse-search-popup';
            const name = 'warehousePopup';
            const specs = 'width=600,height=500,scrollbars=yes,resizable=yes';
            window.open(url, name, specs);
        }
        
        // 팝업에서 선택된 창고 데이터를 받는 함수
        function setWarehouse(id, name) {
            $('#warehouseId').val(id);
            $('#warehouseName').val(name);
        }
        
        // 품목소분류 검색 팝업 함수
        function openSmallCategorySearchPopup() {
            const url = 'item-sub-category-search-popup';
            const name = 'smallCategoryPopup';
            const specs = 'width=800,height=600,scrollbars=yes,resizable=yes';
            window.open(url, name, specs);
        }
        
        // 팝업에서 선택된 데이터를 받는 함수
        function setSmallCategoryData(data) {
            if (data && data.smallCategoryCode) {
                $('#itemSmallCategory').val(data.smallCategoryCode);
                $('#itemSmallCategoryName').val(data.smallCategoryName);
            }
        }
        
        // 사업단위 변경 시 데이터를 조회하는 함수
        function fetchDataForBusinessUnit() {
            const buId = $('#buId').val();
            
            // '전체'를 선택했거나 값이 없으면 모든 데이터를 조회
            if (!buId) {
                // 이 경우, 모든 사업단위에 대한 데이터를 조회하는 로직을 추가
                // 예를 들어, 조회 버튼을 클릭하는 것과 동일한 동작을 수행
                // $('#searchButton').click();
                // 또는 AJAX 요청에 buId 값을 빈 값으로 보냅니다.
                requestData.buId = '';
            }

            // 모든 조회 조건을 포함하는 요청 데이터 객체를 생성합니다.
            const requestData = {
                buId: buId,
                warehouseId: $('#warehouseId').val(),
                stockStandard: $('#stockStandard').val(),
                importanceLevel: $('#importanceLevel').val(),
                itemAssetClass: $('#itemAssetClass').val(),
                itemSmallCategory: $('#itemSmallCategory').val(),
                itemName: $('#itemName').val(),
                spec: $('#spec').val(),
                baseUnit: $('#baseUnit').val(),
                periodRange: $('#periodRange').val(),
                compareCount: $('#compareCount').val(),
                analysisItem: $('#analysisItem').val()
            };

            // 재고기준과 분석항목이 필수값이므로, 값이 없을 때는 요청을 보내지 않거나 알림을 줍니다.
            if (!$('#stockStandard').val() || !$('#analysisItem').val()) {
                // 필수값이 없으면 함수 실행을 중단
                return;
            }

            // 현재 월을 YYYY-MM-DD 형식으로 변환하여 요청에 추가
            const currentMonth = $('#currentMonth').val();
            if (currentMonth) {
                const dateParts = currentMonth.split('-');
                const year = parseInt(dateParts[0]);
                const month = parseInt(dateParts[1]);
                const firstDayOfMonth = new Date(year, month - 1, 1);
                const lastDayOfMonth = new Date(year, month, 0);

                requestData.startDate = firstDayOfMonth.toISOString().slice(0, 10);
                requestData.endDate = lastDayOfMonth.toISOString().slice(0, 10);
            }

            // Ajax 호출
            $.ajax({
                url: '/stock-analysis/analysis',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(requestData),
                success: function (response) {
                    console.log("AJAX 성공. 받은 데이터:", response);
                    displayDataInTable(response);
                },
                error: function (xhr, status, error) {
                    console.error("AJAX 오류:", status, error);
                    console.log("XHR:", xhr.responseText);
                    $('#resultTableContainer').html('<p style="text-align: center; color: #888;">데이터 조회 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.</p>');
                }
            });
        }
    </script>
</body>
</html>