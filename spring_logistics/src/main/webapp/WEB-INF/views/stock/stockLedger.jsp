<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고원장 조회</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            color: #333;
        }
        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }
        th, td {
            border: 1px solid #e5e7eb;
            padding: 0.75rem;
            text-align: center;
        }
        th {
            background-color: #f9fafb;
            font-weight: 600;
        }
        .no-data {
            text-align: center;
            font-weight: 500;
            color: #6b7280;
            padding: 2rem;
        }
        .input-with-button {
            display: flex;
            align-items: center;
        }
        .input-with-button input {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            flex-grow: 1;
        }
        .input-with-button button {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            background-color: #e5e7eb;
            border: 1px solid #e5e7eb;
            padding: 0.5rem 0.75rem;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-2xl font-bold mb-6 text-center">재고원장 조회</h1>

        <form id="searchForm" class="mb-8 p-6 bg-gray-50 rounded-lg shadow-inner">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                
                <div>
                    <label for="buName" class="block text-sm font-medium text-gray-700">사업단위</label>
                    <select id="buName" name="businessBuName" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <option value="">전체</option>
                        <option value="본사">본사</option>
                        <option value="부산지사">부산지사</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">조회기간</label>
                    <div class="flex space-x-2 mt-1">
                        <input type="date" id="searchPeriodStart" name="searchPeriodStart" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <span>~</span>
                        <input type="date" id="searchPeriodEnd" name="searchPeriodEnd" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                    </div>
                </div>

                <div>
                    <label for="stockStandard" class="block text-sm font-medium text-gray-700">재고기준</label>
                    <select id="stockStandard" name="stockStandard" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <option value="">전체</option>
                        <option value="실재고">실재고</option>
                        <option value="자산재고">자산재고</option>
                    </select>
                </div>
                <!-- 품명 -->
                <div>
                    <label for="itemName" class="block text-sm font-medium text-gray-700">품명</label>
                    <div class="input-with-button">
                        <input type="text" id="itemName" name="itemName" readonly class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <button id="search-item-name-btn" type="button" class="mt-1">
                            ...
                        </button>
                    </div>
                </div>
				<!-- 품번 -->
                <div>
                    <label for="itemId" class="block text-sm font-medium text-gray-700">품번</label>
                    <div class="input-with-button">
                        <input type="text" id="itemId" name="itemId" readonly class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <button id="search-item-id-btn" type="button" class="mt-1">
                            ...
                        </button>
                    </div>
                </div>
                
                <div>
                    <label for="unitStandard" class="block text-sm font-medium text-gray-700">단위조회기준</label>
                    <select id="unitStandard" name="unitStandard" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                        <option value="">전체</option>
                        <option value="KG">KG</option>
                        <option value="EA">EA</option>
                        <option value="SET">SET</option>
                    </select>
                </div>
                
            </div>
            <div class="mt-6 flex justify-center space-x-4">
                <button type="submit" class="px-6 py-2 bg-blue-600 text-white font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    	검색
                </button>
                <button type="button" id="resetBtn" class="px-6 py-2 bg-blue-600 text-white font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    	검색 조건 초기화
                </button>
            </div>
        </form>

        <div class="overflow-x-auto">
            <table id="stockLedgerTable" class="min-w-full">
                <thead>
                    <tr>
                        <th>일자</th>
                        <th>구분</th>
                        <th>입출고구분</th>
                        <th>입출고유형</th>
                        <th>단위</th>
                        <th>입고수량</th>
                        <th>출고수량</th>
                        <th>재고수량</th>
                        <th>관리번호</th>
                        <th>사업단위</th>
                        <th>입고창고</th>
                        <th>출고창고</th>
                        <th>거래처</th>
                        <th>처리부서</th>
                        <th>처리자</th>
                    </tr>
                </thead>
                <tbody id="resultTableBody">
                    </tbody>
            </table>
            <div id="noDataMessage" class="hidden no-data">
                데이터가 없습니다.
            </div>
        </div>
    </div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    
	    // ==========================================================
	    // 1. 팝업 함수 (window.opener를 위해 전역 함수로 정의)
	    // ==========================================================
    
    	// 팝업 종류를 저장할 전역 변수
    	let currentCategoryType = '';
    	
    	// 팝업 함수
    	function openPopup(url, windowName) {
    		currentCategoryType = windowName; // 팝업 종류를 전역 변수에 저장
    		
    		var popupWidth = 900;
    		var popupHeight = 600;
    		
    		var left = (screen.width - popupWidth) / 2;
    		var top = (screen.height - popupHeight) / 2;
    		
    		window.open
    		(
    			url,
    			windowName,
    			"width=" + popupWidth +
    			",height=" + popupHeight +
    			",left=" + left +
    			",top=" + top +
    			",scrollbars=yes,resizable=yes"
    		);
    	}
    	
    	// 통일된 콜백 함수 (팝업에서 window.opener.item_RowData(data)로 호출)
        // 품명, 품번 팝업에서 받은 배열 데이터를 처리합니다.
        function item_RowData(data) {
        	
        	let itemId = ''; // 품번
        	let itemName = ''; // 품명

        	// 팝업 종류(currentCategoryType)에 따라 값의 인덱스와 타겟 필드 ID를 설정
         	if (data && data.length > 2) {
    	 		// 품번은 data[0]
    	 		itemId = data[0];
    	 		// 품명은 data[2]
    	 		itemName = data[2];
            } else {
            	console.error("팝업에서 유효한 데이터를 받지 못했습니다.");
            	return;
            }
        
        	// 품명 (itemName) 필드에 값 적용
        	const itemNameElement = document.getElementById('itemName');
        	if (itemNameElement) {
        		itemNameElement.value = itemName;
        	}
        
        	// 품번 (itemId) 필드에 값 적용
        	const itemIdElement = document.getElementById('itemId');
        	if (itemIdElement) {
        		itemIdElement.value = itemId;
        	}
        	
        	console.log(`[콜백] 품명 적용 완료: ${itemName}, 품번 적용 완료: ${itemId}`);
        	
        	// 데이터 처리 후 currentCategoryType 초기화.
        	currentCategoryType = '';
        }
    	
     	// ==========================================================
        // 2. jQuery 로직
        // ==========================================================
        // 문서가 로딩되면 실행
        $(document).ready(function() {
            const $searchForm = $('#searchForm');
            const $resultTableBody = $('#resultTableBody');
            const $noDataMessage = $('#noDataMessage');
            
            // 초기화 버튼 클릭 이벤트
            $('#resetBtn').on('click', function() {
            	$searchForm[0].reset(); // 폼의 모든 필드를 기본값으로 리셋
            	
            	// 특정 필드를 수동으로 비워야 하는 경우 (readonly 등)
            	$('#itemName').val('');
            	$('#itemId').val('');
            });
            
         	// ==========================================================
            // 3. 팝업 버튼 이벤트 리스너
            // ==========================================================

            // 품명 버튼 이벤트 리스너
            $('#search-item-name-btn').on('click', function() {
                openPopup('/popup/item_name_popup', 'item_name');
            });
         	
            // 품번 버튼 이벤트 리스너
            $('#search-item-id-btn').on('click', function() {
                openPopup('/popup/item_popup', 'item');
            });
         	
            $searchForm.on('submit', function(event) {
                event.preventDefault(); // 폼의 기본 제출 동작 방지

                const formData = $(this).serialize(); // 폼 데이터를 직렬화

                $.ajax({
                    url: '/stock/ledger/search',
                    type: 'GET',
                    data: formData,
                    success: function(data) {
                        $resultTableBody.empty();
                        $noDataMessage.addClass('hidden');

                        if (data && data.length > 0) {
                            data.forEach(function(item) {
                                // transactionDate를 JavaScript로 변환
                                const transactionDate = item.transactionDate ? new Date(item.transactionDate) : null;
                                const formattedDate = transactionDate ? transactionDate.toISOString().split('T')[0] : '';
                                
                                const row = `
                                    <tr>
                                        <td>${formattedDate}</td>
                                        <td>${item.type || ''}</td>
                                        <td>${item.inOutboundType || ''}</td>
                                        <td>${item.inOutboundCategory || ''}</td>
                                        <td>${item.unit || ''}</td>
                                        <td>${item.inboundQty !== null ? item.inboundQty : ''}</td>
                                        <td>${item.outboundQty !== null ? item.outboundQty : ''}</td>
                                        <td>${item.stockQty !== null ? item.stockQty : ''}</td>
                                        <td>${item.managementId || ''}</td>
                                        <td>${item.buName || ''}</td>
                                        <td>${item.inboundWarehouse || ''}</td>
                                        <td>${item.outboundWarehouse || ''}</td>
                                        <td>${item.customer || ''}</td>
                                        <td>${item.processingDepartment || ''}</td>
                                        <td>${item.processor || ''}</td>
                                    </tr>
                                `;
                                $resultTableBody.append(row);
                            });
                        } else {
                            $noDataMessage.removeClass('hidden');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('An error occurred:', status, error);
                        $noDataMessage.removeClass('hidden').text('데이터를 불러오는 중 오류가 발생했습니다.');
                    }
                });
            });
            
         	// 페이지 로드 시 자동 조회
            $searchForm.submit();
        });
    </script>
</body>
</html>