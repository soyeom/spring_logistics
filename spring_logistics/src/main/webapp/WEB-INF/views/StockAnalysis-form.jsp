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

/* 모달 배경 */
.modal {
    display: none; /* 기본적으로 숨겨져 있음 */
    position: fixed; /* 고정 위치 */
    z-index: 1000; /* 다른 요소 위에 표시 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto; /* 내용이 넘칠 경우 스크롤 허용 */
    background-color: rgba(0,0,0,0.4); /* 반투명 검은 배경 */
}

/* 모달 내용 상자 */
.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 상단에서 15% 위치, 중앙 정렬 */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* 원하는 너비 설정 */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

/* 닫기 버튼 */
.close-button {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close-button:hover,
.close-button:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
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
			        <button type="button" class="search-icon" id="warehouseSearchBtn">
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
			        <button type="button" class="search-icon" id="smallCategorySearchBtn">
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
	
	<div id="warehouseModal" class="modal">
	       <div class="modal-content">
	           <span class="close-button">&times;</span>
	           <h4>창고 검색</h4>
	           <p>창고 검색 컨텐츠가 들어갈 자리입니다.</p>
	       </div>
	   </div>

	   <div id="smallCategoryModal" class="modal">
	       <div class="modal-content">
	           <span class="close-button">&times;</span>
	           <h4>품목소분류 검색</h4>
	           <p>품목소분류 검색 컨텐츠가 들어갈 자리입니다.</p>
	       </div>
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
	        }
			
			// --- 모달 관련 이벤트 처리 ---
			       // 창고 검색 모달 열기
				   $('#warehouseSearchBtn').on('click', function() {
				       $('#warehouseModal').show();
				   });

				   $('#smallCategorySearchBtn').on('click', function() {
				       $('#smallCategoryModal').show();
				   });

			       // 모달 닫기 버튼 이벤트
			       $('.modal .close-button').on('click', function() {
			           $(this).closest('.modal').hide();
			       });
			       
			       // 모달 외부 클릭 시 닫기
			       $(window).on('click', function(event) {
			           if ($(event.target).hasClass('modal')) {
			               $(event.target).hide();
			           }
			       });

	        // 조회 버튼 클릭 이벤트
	        $('#searchButton').on('click', function (event) {
	                event.preventDefault();
	            }
	            
	            // DTO에 맞게 데이터 수집
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
	                currentMonth: $('#currentMonth').val(), // YYYY-MM 형식 그대로 전송
	                analysisPeriod: parseInt($('#analysisPeriod').val(), 10),
	                analysisCount: parseInt($('#analysisCount').val(), 10),
	                analysisItem: $('#analysisItem').val()
	            };

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
	                    $('#resultTableContainer').html('<p style="text-align: center; color: #888;">데이터 조회 중 오류가 발생했습니다.</p>');
	                }
	            });
	        });

	        // 결과 테이블 출력 함수 (개선)
	        function displayDataInTable(data) {
	            const container = $('#resultTableContainer');
	            container.empty();

	            if (!Array.isArray(data) || data.length === 0) {
	                container.html('<p style="text-align: center; color: #888; padding: 20px;">조회된 데이터가 없습니다.</p>');
	                return;
	            }

	            const analysisItemName = $('#analysisItem option:selected').text();
	            
	            // 고정된 품목 정보 헤더
	            const fixedHeaders = [
	                '품목자산분류', '품목대분류', '품목중분류', 
	                '품목소분류', '품명', '규격', '단위', '사업단위', '창고'
	            ];
	            
	            let tableHtml = '<table><thead><tr>';
	            
	            // 고정 헤더 생성
	            fixedHeaders.forEach(header => {
	                tableHtml += `<th>${header}</th>`;
	            });

	            // 동적 기간별 헤더 생성
	            const analysisCount = parseInt($('#analysisCount').val(), 10);
	            for (let i = 1; i <= analysisCount; i++) {
	                tableHtml += `<th>${i}회차 ${analysisItemName}</th>`;
	            }

	            tableHtml += '</tr></thead><tbody>';

	            // 테이블 바디 생성
	            data.forEach(item => {
	                tableHtml += '<tr>';
	                // 고정된 품목 정보 셀
	                tableHtml += `<td>${item.itemAssetClass || ''}</td>`;
	                tableHtml += `<td>${item.itemBigCategory || ''}</td>`;
	                tableHtml += `<td>${item.itemMidCategory || ''}</td>`;
	                tableHtml += `<td>${item.itemSmallCategory || ''}</td>`;
	                tableHtml += `<td>${item.itemName || ''}</td>`;
	                tableHtml += `<td>${item.spec || ''}</td>`;
	                tableHtml += `<td>${item.baseUnit || ''}</td>`;
	                tableHtml += `<td>${item.buName || ''}</td>`;
	                tableHtml += `<td>${item.warehouseName || ''}</td>`;
	                
	                // 동적 기간별 데이터 셀
	                if (item.periodDataList && item.periodDataList.length > 0) {
	                    item.periodDataList.forEach(periodData => {
	                        // 선택된 분석 항목에 따라 값을 가져옴
	                        let value;
	                        switch ($('#analysisItem').val()) {
	                            case 'averageStock':
	                                value = periodData.averageStock;
	                                break;
	                            case 'turnoverRate':
	                                value = periodData.turnoverRate;
	                                break;
	                            case 'totalInbound':
	                                value = periodData.totalInbound;
	                                break;
	                            case 'totalOutbound':
	                                value = periodData.totalOutbound;
	                                break;
	                            default:
	                                value = '';
	                                break;
	                        }
	                        tableHtml += `<td>${value !== null && value !== undefined ? value.toLocaleString() : ''}</td>`;
	                    });
	                }
	                tableHtml += '</tr>';
	            });
	            
	            tableHtml += '</tbody></table>';
	            container.html(tableHtml);
	        }
	    });
	</script>

</body>
</html>