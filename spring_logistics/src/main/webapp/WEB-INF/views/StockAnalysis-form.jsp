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
    grid-column: 1/-1;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ccc;
    font-weight: bold;
    font-size: 14px;
    background-color: #f5f5f5;
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
                <select id="buId" name="buId">
                    <option value="">전체</option>
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
                    <option value="">선택</option>
                    <option value="수량">수량</option>
                    <option value="금액">금액</option>
                </select>
            </div>

            <div class="search-item">
                <label for="importanceLevel">중요도:</label>
                <select id="importanceLevel" name="importanceLevel">
                    <option value="">전체</option>
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
                    <input type="number" id="analysisPeriod" name="analysisPeriod" min="1" value="3" style="width: 70px;">
                    <span>개월</span>
                    <input type="number" id="analysisCount" name="analysisCount" min="1" value="4" style="width: 70px;">
                    <span>회</span>
                </div>
            </div>

            <div class="search-item">
                <label for="analysisItem">분석항목:</label>
                <select id="analysisItem" name="analysisItem">
                    <option value="">선택</option>
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
    // 팝업에서 선택된 창고 데이터를 받는 함수
    function setWarehouse(id, name) {
        $('#warehouseId').val(id);
        $('#warehouseName').val(name);
    }
    
    // 팝업에서 선택된 품목소분류 데이터를 받는 함수
    function setSmallCategoryData(data) {
        if (data && data.smallCategoryCode) {
            $('#itemSmallCategory').val(data.smallCategoryCode);
            $('#itemSmallCategoryName').val(data.smallCategoryName);
        }
    }

    $(document).ready(function () {
        // 페이지 로딩 시 현재 월 설정
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0');
        $('#currentMonth').val(`${year}-${month}`);

        // 동적으로 드롭다운 옵션을 로드하는 함수 (실제 API 엔드포인트에 맞게 수정 필요)
        function loadOptions(selectId, endpoint) {
            // 이 부분은 실제 API가 존재할 때 작동합니다.
            // 예: loadOptions('#buId', '/api/business-units');
        }

        // 페이지 로딩 시 필요한 드롭다운 옵션 로드
        // loadOptions('#buId', '/api/business-units'); 
        // loadOptions('#importanceLevel', '/api/importance-levels');
        // loadOptions('#baseUnit', '/api/base-units');

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
                analysisPeriod: $('#analysisPeriod').val(),
                analysisCount: $('#analysisCount').val(),
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
                // 재고기준에 따라 동적으로 테이블 헤더와 데이터를 구성
                const stockStandard = $('#stockStandard').val();
                
                let quantityColumns = ['beginningStock', 'inboundQty', 'outQty', 'endingStock'];
                let amountColumns = ['beginningAmount', 'inboundAmount', 'outAmount', 'endingAmount'];
                
                let tableHeaderNames = {
                    'itemBigCategory': '품목대분류',
                    'itemMidCategory': '품목중분류',
                    'itemAssetClass': '품목자산분류',
                    'itemSmallCategory': '품목소분류',
                    'itemName': '품명'
                };
                
                let selectedColumns;
                if (stockStandard === '금액') {
                    selectedColumns = ['itemBigCategory', 'itemMidCategory', 'itemAssetClass', 'itemSmallCategory', 'itemName'].concat(amountColumns);
                    tableHeaderNames['beginningAmount'] = '기초금액';
                    tableHeaderNames['inboundAmount'] = '입고금액';
                    tableHeaderNames['outAmount'] = '출고금액';
                    tableHeaderNames['endingAmount'] = '기말금액';
                } else { // 기본값: 수량
                    selectedColumns = ['itemBigCategory', 'itemMidCategory', 'itemAssetClass', 'itemSmallCategory', 'itemName'].concat(quantityColumns);
                    tableHeaderNames['beginningStock'] = '기초재고';
                    tableHeaderNames['inboundQty'] = '입고량';
                    tableHeaderNames['outQty'] = '출고량';
                    tableHeaderNames['endingStock'] = '기말재고';
                }

                let tableHtml = '<table><thead><tr>';
                selectedColumns.forEach(key => {
                    tableHtml += '<th>' + (tableHeaderNames[key] || key) + '</th>';
                });
                tableHtml += '</tr></thead><tbody>';
                
                data.forEach(item => {
                    tableHtml += '<tr>';
                    selectedColumns.forEach(key => {
                        const value = item[key] !== null ? item[key] : '';
                        tableHtml += '<td>' + value + '</td>';
                    });
                    tableHtml += '</tr>';
                });
                
                tableHtml += '</tbody></table>';
                container.html(tableHtml);
            } else {
                container.html('<p style="text-align: center; color: #888; padding: 20px;">조회된 데이터가 없습니다.</p>');
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
    
    // 품목소분류 검색 팝업 함수
    function openSmallCategorySearchPopup() {
        const url = 'item-sub-category-search-popup';
        const name = 'smallCategoryPopup';
        const specs = 'width=800,height=600,scrollbars=yes,resizable=yes';
        window.open(url, name, specs);
    }
    </script>
</body>
</html>