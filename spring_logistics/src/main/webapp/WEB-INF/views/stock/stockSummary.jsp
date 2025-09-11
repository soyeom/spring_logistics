<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사업단위별 수불집계 조회</title>
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
        .table-container {
            overflow-x: auto;
            position: relative;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
            white-space: nowrap;
        }
        th, td {
            border: 1px solid #e5e7eb;
            padding: 0.75rem;
            text-align: left;
        }
        thead th {
            background-color: #f9fafb;
            font-weight: 600;
        }
        .sticky-col {
            position: sticky;
            left: 0;
            background-color: #fff;
            z-index: 10;
        }
    </style>
</head>
<body>
    <div class="container">
    	<!-- 헤더 영역 -->
    	<div>
	        <h1 class="text-2xl font-bold mb-6">사업단위별 수불집계 조회</h1>
    	</div>
    	<!-- end of 헤더 영역 -->
    	
    	<!-- 검색 영역 -->
    	<form id="search-form">
    		<div class="space-x-2">
				<button id="reset-btn" type="button" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
					초기화
				</button>
				<button id="search-btn" type="button" class="px-4 py-2 bg-indigo-600 text-white rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none">
					조회
				</button>
			</div>
			<div class="space-y-4">
				<!-- 조회조건 -->
				<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
					<!-- 사업단위 -->
					<div>
						<label for="businessBuName" class="block text-sm font-medium text-gray-700">사업단위</label>
						<select id="businessBuName" name="businessBuName" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
	                    	<option value="">전체</option>
	                    	<option value="서울사업단">서울사업단</option>
	                    	<option value="부산사업단">부산사업단</option>
	                    </select>
					</div>
					<!-- 조회기간 -->
					<div>
						<label for="searchPeriodStart" class="block text-sm font-medium text-gray-700">조회기간</label>
						<div class="flex items-center space-x-2 mt-1">
							<input type="date" id="searchPeriodStart" name="searchPeriodStart" class="rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 w-full">
							<span>~</span>
							<input type="date" id="searchPeriodEnd" name="searchPeriodEnd" class="rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 w-full">
						</div>
					</div>
					<!-- 재고기준 -->
					<div>
						<label for="stockStandard" class="block text-sm font-medium text-gray-700">재고기준</label>
						<select id="stockStandard" name="stockStandard" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
							<option value="">전체</option>
							<option value="실재고">실재고</option>
							<option value="자산재고">자산재고</option>
						</select>
					</div>
					<!-- 품목자산분류 -->
					<div>
						<label for="itemAssetClass" class="block text-sm font-medium text-gray-700">품목자산분류</label>
						<select id="itemAssetClass" name="itemAssetClass" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
							<option value="">전체</option>
							<option value="자산">자산</option>
							<option value="반제품">반제품</option>
							<option value="상품">상품</option>
							<option value="원자재">원자재</option>
							<option value="부자재">부자재</option>
							<option value="재공품">재공품</option>
							<option value="저장품">저장품</option>
						</select>
					</div>
					<!-- 품목대분류 -->
					<div>
	    				<label for="itemBigCategory" class="block text-sm font-medium text-gray-700">품목대분류</label>
	    				<div class="flex items-center space-x-2 mt-1">
	        				<input type="text" id="itemBigCategory" name="itemBigCategory" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
	        				<button id="open-big-category-modal-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
	            				🔍
	        				</button>
	    				</div>
					</div>
					<!-- 품목중분류 -->
					<div>
					    <label for="itemMidCategory" class="block text-sm font-medium text-gray-700">품목중분류</label>
					    <div class="flex items-center space-x-2 mt-1">
					        <input type="text" id="itemMidCategory" name="itemMidCategory" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
					        <button id="open-mid-category-modal-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
					        	🔍
					        </button>
					    </div>
					</div>				
					<!-- 품목소분류 -->
					<div>
					    <label for="itemSmallCategory" class="block text-sm font-medium text-gray-700">품목소분류</label>
					    <div class="flex items-center space-x-2 mt-1">
					        <input type="text" id="itemSmallCategory" name="itemSmallCategory" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
					        <button id="open-small-category-modal-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
								🔍
					        </button>
					    </div>
					</div>
					<!-- 품명 -->
					<div>
						<label for="itemName" class="block text-sm font-medium text-gray-700">품명</label>
						<input type="text" id="itemName" name="itemName" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
					<!-- 품번 -->
					<div>
						<label for="itemInternalCode" class="block text-sm font-medium text-gray-700">품번</label>
						<input type="text" id="itemInternalCode" name="itemInternalCode" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
					<!-- 규격 -->
					<div>
						<label for="itemSpec" class="block text-sm font-medium text-gray-700">규격</label>
						<input type="text" id="itemSpec" name="itemSpec" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
				</div>
				<!-- end of 조회조건 -->
				
				<!-- 추가조회조건 -->
				<div id="additional-criteria" class="hidden grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mt-4 p-4 border rounded-md">
					<!-- 품목상태 -->
					<div>
						<label for="itemStatus" class="block text-sm font-medium text-gray-700">품목상태</label>
						<input type="text" id="itemStatus" name="itemStatus" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
					<!-- 단위조회기준 -->
					<div>
						<label for="unitStandard" class="block text-sm font-medium text-gray-700">단위조회기준</label>
						<select id="unitStandard" name="unitStandard" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
							<option value="">선택</option>
							<option value="기준단위">기준단위</option>
							<option value="수불단위">수불단위</option>
							<option value="환산단위">환산단위</option>
						</select>
					</div>
					<!-- 0수량 조회여부 -->
					<div class="flex items-center">
						<input id="includeZeroQty" name="includeZeroQty" type="checkbox" class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded">
						<label for="includeZeroQty" class="ml-2 block text-sm text-gray-900">0수량 조회여부</label>
					</div>
				</div>
				<!-- end of 추가조회조건 -->
				<!-- 버튼 -->
				<div class="flex items-center justify-between mt-6">
					<button id="toggle-criteria-btn" type="button" class="text-sm text-indigo-600 hover:text-indigo-800 focus:outline-none">
						추가 조회 조건 ▼
					</button>
				</div>
				<!-- end of 버튼 -->
			</div>
		</form>
		<!-- end of 검색 영역 -->
		
		<hr class="my-6">
		
        <!-- 결과 영역 -->
        <div class="table-container">
            <table class="w-full text-left">
                <thead>
                    <tr>
                        <th class="sticky-col" rowspan="2">품번</th>
                        <th rowspan="2">품목자산분류</th>
                        <th rowspan="2">품목대분류</th>
                        <th rowspan="2">품목중분류</th>
                        <th rowspan="2">품명</th>
                        <th rowspan="2">입고수량</th>
                        <th rowspan="2">단위</th>
                        <th rowspan="2">품목상태</th>
                        <th rowspan="2">재고수량</th>
                        <th rowspan="2">이월수량</th>
                        <th rowspan="2">출고수량</th>
                        <th colspan="4" class="p-3 text-center">입고</th>
                        <th colspan="5" class="p-3 text-center">출고</th>
                    </tr>
                    <tr>
                        <th class="p-3">생산입고</th>
                        <th class="p-3">외주입고</th>
                        <th class="p-3">구매입고</th>
                        <th class="p-3">수입입고</th>
                        <th class="p-3">거래명세표</th>
                        <th class="p-3">기타출고</th>
                        <th class="p-3">판매보관품출고</th>
                        <th class="p-3">작업실적</th>
                        <th class="p-3">외주입고</th>
                    </tr>
                </thead>
                <tbody id="stockSummaryTableBody">
                    <!-- 데이터가 여기에 동적으로 삽입됩니다. -->
                </tbody>
            </table>
            <div id="noDataMessage" class="hidden text-center text-gray-500 mt-4">
                	조회된 데이터가 없습니다.
            </div>
        </div>
        <!-- end of 결과 영역 -->
    </div>
    <!-- end of container -->

	<div id="item-search-modal" class="fixed inset-0 z-50 overflow-y-auto bg-gray-600 bg-opacity-50 hidden">
    	<div class="flex items-center justify-center min-h-screen p-4">
        	<div class="relative bg-white w-full max-w-2xl mx-auto rounded-lg shadow-lg p-6">
            	<div class="flex justify-between items-center pb-3 border-b border-gray-200">
                	<h3 class="text-xl font-semibold text-gray-900">품목 조회</h3>
                	<button type="button" class="text-gray-400 hover:text-gray-600" onclick="closeModal()">
                    	<span class="sr-only">Close modal</span>
                    	<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                	</button>
            	</div>
            	<div class="py-4">
                	<div class="flex space-x-2 mb-4">
                    	<input type="text" id="modal-search-input" placeholder="품목 검색..." class="flex-grow rounded-md border-gray-300 shadow-sm">
                    	<button id="modal-search-btn" class="px-4 py-2 bg-indigo-600 text-white rounded-md shadow-sm">
                        	검색
                    	</button>
                	</div>
                	<div class="border rounded-md overflow-hidden">
                    	<table class="w-full">
                        	<thead>
                            	<tr class="bg-gray-50 text-left text-xs font-semibold uppercase tracking-wider text-gray-500">
                                	<th class="px-4 py-2">품번</th>
                                	<th class="px-4 py-2">품명</th>
                                	<th class="px-4 py-2">규격</th>
                                	<th class="px-4 py-2">대분류</th>
                                	<th class="px-4 py-2">중분류</th>
                                	<th class="px-4 py-2">소분류</th>
                            	</tr>
                        	</thead>
                        	<tbody id="modal-result-table-body" class="divide-y divide-gray-200">
                            	</tbody>
                    	</table>
                	</div>
            	</div>
        	</div>
    	</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    // 문서가 로딩되면 실행
    $(document).ready(function() {

        // 어떤 카테고리의 모달이 열려 있는지 상태를 저장하는 변수
        let currentCategoryModal = '';

        // 추가 조회 조건 토글
        $('#toggle-criteria-btn').on('click', function() {
            const additionalCriteria = $('#additional-criteria');
            additionalCriteria.toggleClass('hidden');
            const btnText = $(this).text();
            $(this).text(btnText.includes('▼') ? '추가 조회 조건 ▲' : '추가 조회 조건 ▼');
        });

        // 조회 버튼 클릭 이벤트
        $('#search-btn').on('click', function() {
        	event.preventDefault(); // 폼의 기본 제출 동작 방지
            searchStockSummary();
        });

     	// 초기화 버튼 클릭 이벤트
        $('#reset-btn').on('click', function() {
            $('#search-form')[0].reset(); // 폼 태그의 reset() 함수 사용
            
            // 추가 조회 조건 섹션 숨김 및 버튼 텍스트 변경
            $('#additional-criteria').addClass('hidden');
            $('#toggle-criteria-btn').text('추가 조회 조건 ▼');
            
            // 초기화된 검색 조건을 반영하기 위해 다시 조회
            searchStockSummary(); 
        });
     	
     	// 초기 로드 시 조회 함수 호출
        searchStockSummary();

        // 모달 닫기
        function closeModal() {
            $('#item-search-modal').addClass('hidden');
            $('#modal-search-input').val('');
            $('#modal-result-table-head').empty();
            $('#modal-result-table-body').empty();
        }

        // 모달 열기
        function openModal(categoryType) {
            currentCategoryModal = categoryType;
            const modalTitle = $('#item-search-modal .font-semibold');
            const modalTableHead = $('#modal-result-table-head');
            
            // 모달 제목과 테이블 헤더를 동적으로 설정
            if (categoryType === 'big') {
                modalTitle.text('품목대분류 조회');
                modalTableHead.html('<tr class="bg-gray-50 text-left text-xs font-semibold uppercase tracking-wider text-gray-500"><th class="px-4 py-2">품목대분류</th></tr>');
            } else if (categoryType === 'mid') {
                modalTitle.text('품목중분류 조회');
                modalTableHead.html('<tr class="bg-gray-50 text-left text-xs font-semibold uppercase tracking-wider text-gray-500"><th class="px-4 py-2">품목대분류</th><th class="px-4 py-2">품목중분류</th></tr>');
            } else if (categoryType === 'small') {
                modalTitle.text('품목소분류 조회');
                modalTableHead.html('<tr class="bg-gray-50 text-left text-xs font-semibold uppercase tracking-wider text-gray-500"><th class="px-4 py-2">품목대분류</th><th class="px-4 py-2">품목중분류</th><th class="px-4 py-2">품목소분류</th></tr>');
            }

            // 모달 표시
            $('#item-search-modal').removeClass('hidden');

            // 모달을 열 때 전체 목록을 불러옴
            fetchAndDisplayCategories(categoryType);
        }

        // 모달 검색 버튼 클릭 이벤트
        $('#modal-search-btn').on('click', function() {
            const searchTerm = $('#modal-search-input').val();
            fetchAndDisplayCategories(currentCategoryModal, searchTerm);
        });

        // 모달 닫기 버튼 이벤트
        // X 버튼과 모달 외부 클릭 시 닫기
        $('#item-search-modal .text-gray-400, #item-search-modal').on('click', function(event) {
            if ($(event.target).is('#item-search-modal') || $(event.target).closest('.text-gray-400').length > 0) {
                closeModal();
            }
        });

        // 항목 선택 이벤트
        $('#modal-result-table-body').on('click', 'tr', function() {
            if (currentCategoryModal === 'big') {
                const bigCategory = $(this).find('td:nth-child(1)').text();
                $('#itemBigCategory').val(bigCategory);
                $('#itemMidCategory').val('');
                $('#itemSmallCategory').val('');
            } else if (currentCategoryModal === 'mid') {
                const bigCategory = $(this).find('td:nth-child(1)').text();
                const midCategory = $(this).find('td:nth-child(2)').text();
                $('#itemBigCategory').val(bigCategory);
                $('#itemMidCategory').val(midCategory);
                $('#itemSmallCategory').val('');
            } else if (currentCategoryModal === 'small') {
                const bigCategory = $(this).find('td:nth-child(1)').text();
                const midCategory = $(this).find('td:nth-child(2)').text();
                const smallCategory = $(this).find('td:nth-child(3)').text();
                $('#itemBigCategory').val(bigCategory);
                $('#itemMidCategory').val(midCategory);
                $('#itemSmallCategory').val(smallCategory);
            }
            closeModal();
        });

        // 각 버튼에 모달 열기 이벤트 리스너 연결
        $('#open-big-category-modal-btn').on('click', function() {
            openModal('big');
        });
        $('#open-mid-category-modal-btn').on('click', function() {
            openModal('mid');
        });
        $('#open-small-category-modal-btn').on('click', function() {
            openModal('small');
        });

        // 카테고리 데이터를 불러와 모달에 표시하는 함수
        function fetchAndDisplayCategories(categoryType, searchTerm = '') {
            const $listBody = $('#modal-result-table-body');
            const $noDataMessage = $('#noDataMessage');

            $noDataMessage.addClass('hidden');
            $listBody.empty();

            $.ajax({
                url: `/stock/categories/${categoryType}`,
                type: 'GET',
                data: {
                    searchTerm: searchTerm
                },
                dataType: 'json',
                success: function(response) {
                    if (response && response.length > 0) {
                        $.each(response, function(i, item) {
                            const row = $('<tr></tr>').addClass('cursor-pointer hover:bg-gray-100');
                            if (item.bigCategory) {
                                row.append(`<td class="border px-4 py-2">${item.bigCategory}</td>`);
                            }
                            if (item.midCategory) {
                                row.append(`<td class="border px-4 py-2">${item.midCategory}</td>`);
                            }
                            if (item.smallCategory) {
                                row.append(`<td class="border px-4 py-2">${item.smallCategory}</td>`);
                            }
                            $listBody.append(row);
                        });
                    } else {
                        $noDataMessage.removeClass('hidden');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터를 불러오는 중 오류 발생:', status, error);
                    $noDataMessage.removeClass('hidden').text('데이터를 불러오는 중 오류가 발생했습니다.');
                }
            });
        }

        // 조회 함수 시작
        function searchStockSummary() {
            const criteria = {
                businessBuName: $('#businessBuName').val(), // 사업단위
                searchPeriodStart: $('#searchPeriodStart').val(), // 조회기간 시작일
                searchPeriodEnd: $('#searchPeriodEnd').val(), // 조회기간 종료일
                stockStandard: $('#stockStandard').val(), // 재고기준
                itemAssetClass: $('#itemAssetClass').val(), // 품목자산분류
                itemBigCategory: $('#itemBigCategory').val(), // 품목대분류
                itemMidCategory: $('#itemMidCategory').val(), // 품목중분류
                itemSmallCategory: $('#itemSmallCategory').val(), // 품목소분류
                itemName: $('#itemName').val(), // 품명
                itemInternalCode: $('#itemInternalCode').val(), // 품번
                itemSpec: $('#itemSpec').val(), // 규격
                itemStatus: $('#itemStatus').val(), // 품목상태
                unitStandard: $('#unitStandard').val(), // 단위조회기준
                includeZeroQty: $('#includeZeroQty').is(':checked') // 0수량 조회여부
            };

            $.ajax({
                url: '/stock/summary/search',
                type: 'GET',
                data: criteria,
                dataType: 'json',
                success: function(response) {
                    console.log('Server response:', response);
                    const $tbody = $('#stockSummaryTableBody');
                    const $noDataMessage = $('#noDataMessage');
                    $tbody.empty();

                    if (response && response.length > 0) {
                        $noDataMessage.addClass('hidden');
                        $.each(response, function(index, item) {
                            if (item) {
                                const row = `
                                    <tr>
                                        <td class="sticky-col">${item.itemInternalCode}</td>
                                        <td>${item.itemAssetClass}</td>
                                        <td>${item.itemBigCategory}</td>
                                        <td>${item.itemMidCategory}</td>
                                        <td>${item.itemName}</td>
                                        <td>${item.inboundQty}</td>
                                        <td>${item.itemUnit}</td>
                                        <td>${item.itemStatus}</td>
                                        <td>${item.stockQty}</td>
                                        <td>${item.carriedOverQty}</td>
                                        <td>${item.outboundQty}</td>
                                        <td>${item.productionInbound}</td>
                                        <td>${item.outsourcingInbound}</td>
                                        <td>${item.purchaseInbound}</td>
                                        <td>${item.importInbound}</td>
                                        <td>${item.deliverySlipOutbound}</td>
                                        <td>${item.otherOutbound}</td>
                                        <td>${item.salesConsignmentOutbound}</td>
                                        <td>${item.workPerformanceOutbound}</td>
                                        <td>${item.outsourcingOutbound}</td>
                                    </tr>
                                `;
                                $tbody.append(row);
                            }
                        });
                    } else {
                        $noDataMessage.removeClass('hidden');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('An error occurred:', status, error);
                    $('#noDataMessage').removeClass('hidden').text('데이터를 불러오는 중 오류가 발생했습니다.');
                }
            });
        }
    });
</script>
</body>
</html>
