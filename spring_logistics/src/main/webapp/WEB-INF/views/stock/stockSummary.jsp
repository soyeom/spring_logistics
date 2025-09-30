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
    	/* 웹페이지 전체에 대한 기본 스타일 정의 */
        body {
            font-family: 'Inter', sans-serif; /* 글꼴: Inter, 없을 시 sans-serif */
            background-color: #f3f4f6; /* 배경 색상: 연한 회색 */
            color: #333; /* 텍스트 색상: 어두운 회색 */
        }
        /* 웹페이지 주요 콘텐츠 영역 */
        .container {
            max-width: 1400px; /* 최대 너비: 1400px */
            margin: 2rem auto; /* 요소 내부 여백: 상하 여백 2rem 좌우 여백 자동(컨테이너를 페이지 중앙에 배치) */
            padding: 2rem; /* 요소 외부 여백: 2rem(셀 내부의 콘텐츠와 테두리 사이 여백) */
            background-color: #fff; /* 배경 색상: 흰색 */
            border-radius: 1rem; /* 테두리 모서리: 1rem(모서리를 둥글게 만듬) */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 컨테이너 아래에 그림자 추가 */
        }
        /* 테이블을 감싸서 스크롤 기능을 추가 */
        .table-container {
            overflow-x: auto; /* 가로 스크롤바 추가 */
            position: relative; /* 이 요소를 기준으로 자식 요소의 위치(예: stick-col)를 상대적으로 지정 (스크롤 바를 움직여도 고정되어있는 요소를 지정하기 위함) */
        }
        /* 웹페이지 내 모든 <table> 태그에 적용 */
        table {
            width: 100%; /* 테이블 너비를 부모 요소(table-container)의 100%로 채움 */
            border-collapse: collapse; /* 테이블 셀의 테두리를 하나로 합쳐 이중선 방지 */
            font-size: 0.875rem; /* 글꼴 크기를 0.875rem으로 설정 */
            white-space: nowrap; /* 셀 내부 텍스트 줄바꿈 방지(한 줄로 표시) */
        }
        /* 헤더 셀(<th>) 데이터 셀(<td>)에 공통적으로 적용 */
        th, td {
            border: 1px solid #e5e7eb; /* 모든 셀에 1픽셀 두께의 연한 회색 테두리 추가 */
            padding: 0.75rem; /* 요소 외부 여백: 0.75rem(셀 내부의 콘텐츠와 테두리 사이 여백) */
            text-align: left; /* 셀 내부 텍스트 왼쪽 정렬 */
        }
        /* 테이블 헤더 영역(<thread>)안의 헤더 셀(<hr>)에만 적용 */
        thead th {
            background-color: #f9fafb; /* 헤더 셀의 배경색을 아주 연한 회색으로 만듬 */
            font-weight: 600; /* 헤더 셀의 글씨를 굵게 만듬 */
        }
        /* 클래스 이름이 sticky-col인 열에 적용(테이블의 첫 번째 열을 고정시키기 위해 사용) */
        .sticky-col {
            position: sticky; /* 스크롤 시 해당 요소 고정 */
            left: 0; /* 요소가 부모 요소의 왼쪽 가장자리에 고정되도록 함 */
            background-color: #fff; /* 고정된 열의 배경색을 흰색으로 설정 */
            z-index: 10; /* 다른 요소들(예: 스크롤되는 다른 열들)의 가장 위에 위치하도록 만듬 */
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
    		<!-- 버튼을 담고있는 컨테이너 -->
    		<div class="flex justify-end space-x-2">
    		<!-- flex: 내부 요소들을 가로로 나란히 배치하기 위해 Flexbox 레이아웃 사용 -->
    		<!-- justify-end: 버튼들을 컨테이너의 오른쪽 끝에 정렬 -->
    		<!-- space-x-2: 버튼들 사이에 가로로 작은 간격(space)을 둠 -->
    			<!-- 버튼 스타일 정의 -->
			    <button id="reset-btn" type="button" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
				<!-- px/py(수평/수직 패딩), 배경색, 텍스트 색상, 둥근 모서리, 그림자, hover(마우스를 올렸을 때)색상변화 -->
			        초기화
			    </button>
			    <button id="search-btn" type="button" class="px-4 py-2 bg-indigo-600 text-white rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none">
			        조회
			    </button>
			</div>
			<!-- 조회 조건 영역 전체 컨테이너="내부 요소들 사이에 세로로 간격을 둠" -->
			<div class="space-y-4">
				<!-- 조회조건 -->
				<!-- 반응형 그리드 레이아웃 -->
				<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
				<!-- grid-cols-1: 기본적으로 한 줄에 한 개의 컬럼만 표시, sm:grid-cols-2: 화면이 작아지면(sm) 한 줄에 두개의 컬럼 표시 -->
				<!-- md:grid-cols-3: 중간 화면(md)에서는 세 개의 컬럼, lg:grid-cols-4: 큰 화면(lg)에서는 네 개의 컬럼 표시 -->
					<!-- 사업단위 -->
					<div>
						<label for="businessBuName" class="block text-sm font-medium text-gray-700">사업단위</label>
						<select id="businessBuName" name="businessBuName" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
	                    	<option value="">전체</option>
	                    	<option value="본사">본사</option>
	                    	<option value="부산지사">부산지사</option>
	                    </select>
					</div>
					<!-- 조회기간 -->
					<div>
						<label for="searchPeriodStart" class="block text-sm font-medium text-gray-700">조회기간</label>
						<div class="flex items-center space-x-2 mt-1">
							<input type="date" id="searchPeriodStart" name="searchPeriodStart" class="rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 w-full">
							<span>~</span>
							<input type="date" id="searchPeriodEnd" name="searchPeriodEnd" class="rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 w-full">
						</div>
						<!-- 시작일과 종료일 입력 필드를 가로로 배치하고, <input>과 <span>~</span>을 같은 줄에 정렬 -->
					</div>
					
					<!-- 재고기준 -->
					<div>
						<label for="stockStandard" class="block text-sm font-medium text-gray-700">재고기준</label>
						<select id="stockStandard" name="stockStandard" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
							<option value="">전체</option>
							<option value="실재고">실재고</option>
							<option value="자산재고">자산재고</option>
						</select>
					</div>
					<!-- 품목자산분류 -->
					<div>
						<label for="itemAssetClass" class="block text-sm font-medium text-gray-700">품목자산분류</label>
						<select id="itemAssetClass" name="itemAssetClass" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
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
	        				<input type="text" id="itemBigCategory" name="itemBigCategory" class="block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
	        		        <button id="search-big-category-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
					            🔍
					        </button>
	    				</div>
	    				<!-- 입력 필드에 readonly 속성을 추가하여 사용자가 직접 타이핑할 수 없게 만듬 -->
					</div>
					<!-- 품목중분류 -->
					<div>
					    <label for="itemMidCategory" class="block text-sm font-medium text-gray-700">품목중분류</label>
					    <div class="flex items-center space-x-2 mt-1">
					        <input type="text" id="itemMidCategory" name="itemMidCategory" class="block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
					        <button id="search-mid-category-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
					            🔍
					        </button>
					    </div>
					    <!-- 입력 필드에 readonly 속성을 추가하여 사용자가 직접 타이핑할 수 없게 만듬 -->
					</div>				
					<!-- 품목소분류 -->
					<div>
					    <label for="itemSmallCategory" class="block text-sm font-medium text-gray-700">품목소분류</label>
					    <div class="flex items-center space-x-2 mt-1">
					        <input type="text" id="itemSmallCategory" name="itemSmallCategory" class="block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500" readonly>
					        <button id="search-small-category-btn" type="button" class="px-3 py-2 bg-gray-200 text-gray-800 rounded-md shadow-sm hover:bg-gray-300 focus:outline-none">
					            🔍
					        </button>
					    </div>
					    <!-- 입력 필드에 readonly 속성을 추가하여 사용자가 직접 타이핑할 수 없게 만듬 -->
					</div>
					<!-- 품명 -->
					<div>
						<label for="itemName" class="block text-sm font-medium text-gray-700">품명</label>
						<input type="text" id="itemName" name="itemName" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
					<!-- 품번 -->
					<div>
						<label for="itemInternalCode" class="block text-sm font-medium text-gray-700">품번</label>
						<input type="text" id="itemInternalCode" name="itemInternalCode" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
					<!-- 규격 -->
					<div>
						<label for="itemSpec" class="block text-sm font-medium text-gray-700">규격</label>
						<input type="text" id="itemSpec" name="itemSpec" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
					</div>
				</div>
				<!-- end of 조회조건 -->
				
				<!-- 추가조회조건 -->
				<div id="additional-criteria" class="hidden grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mt-4 p-4 border rounded-md">
				<!-- hidden 클래스로 숨기고 추가 조회 조건 버튼을 누를 때 나타나게 함 -->
					<!-- 품목상태 -->
					<div>
						<label for="itemStatus" class="block text-sm font-medium text-gray-700">품목상태</label>
						<select id="itemStatus" name="itemStatus" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
							<option value="">선택</option>
							<option value="임시">임시</option>
							<option value="사용">사용</option>
							<option value="생산중지">생산중지</option>
							<option value="거래중지">거래중지</option>
							<option value="폐기">폐기</option>
						</select>
						</select>
					</div>
					<!-- 단위조회기준 -->
					<div>
						<label for="unitStandard" class="block text-sm font-medium text-gray-700">단위조회기준</label>
						<select id="unitStandard" name="unitStandard" class="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
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
				<!-- justify-between을 사용하여 한쪽에 버튼을 배치 -->
					<button id="toggle-criteria-btn" type="button" class="text-sm text-indigo-600 hover:text-indigo-800 focus:outline-none">
						추가 조회 조건 ▼
					</button>
				</div>
				<!-- end of 버튼 -->
			</div>
		</form>
		<!-- end of 검색 영역 -->
		
		<!-- 수평선 -->
		<hr class="my-6">
		
        <!-- 결과 영역 -->
        <div class="table-container">
            <table class="w-full text-left">
            <!-- w-full: 테이블의 너비를 부모 요소의 100%로 설정, text-left: 테이블 내부 텍스트 왼쪽 정렬 -->
            	
            	<!-- 테이블 헤더 -->
                <thead>
                	<!-- 테이블 헤더의 첫 번째 행(row) -->
                    <tr>
                    	<!-- 테이블 헤더 셀(th) -->
                        <th class="sticky-col" rowspan="2">품번</th>
                    	<!-- 테이블을 가로로 스크롤 할 때 품번 열을 고정 -->
                    	
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
                        
                        <!-- '생산입고', '외주입고', '구매입고', '수입입고'를 하나의 그룹으로 묶음 -->
                        <th colspan="4" class="p-3 text-center">입고</th>
                        <!-- th colspan="4": 네 개의 열을 합침 -->
                        <!-- class="p-3 text-center": 셀 내부에 패딩을 주고 텍스트 중앙 정렬 -->
                       
                        <!-- 출고 관련 항목들을 그룹으로 묶음 -->
                        <th colspan="5" class="p-3 text-center">출고</th>
                    </tr>
                    
                    <!-- 테이블 헤더의 두 번째 행(첫 번째 행의 하위 항목) -->
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
                    <!-- 여기에 데이터가 동적으로 삽입 됨 -->
                </tbody>
            </table>
            <!-- 데이터가 없을 시 표시 될 메시지 -->
            <div id="noDataMessage" class="hidden text-center text-gray-500 mt-4">
                	조회된 데이터가 없습니다.
            </div>
            
        </div>
        <!-- end of 결과 영역 -->
    </div>
    <!-- end of container -->
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    // ==========================================================
    // 1. 팝업 함수 (window.opener를 위해 전역 함수로 정의)
    // ==========================================================
    
    // 팝업 종류를 저장할 전역 변수
    let currentCategoryType = '';
    
 	// 통일된 팝업 오픈 함수 (화면 중앙 정렬 로직)
    function openPopup(url, windowName) {
    	currentCategoryType = windowName; // 팝업 종류를 전역 변수에 저장
    	
        var popupWidth = 900;
        var popupHeight = 600;
        
        // 화면 중앙 좌표 계산
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
    // 품목 대/중/소 분류 팝업에서 받은 배열 데이터를 처리합니다.
    function item_RowData(data) {
    	
    	let categoryName = '';
    	let targetElementId = '';

    	// 팝업 종류(currentCategoryType)에 따라 값의 인덱스와 타겟 필드 ID를 설정
     	if (currentCategoryType === 'big') {
	 		categoryName = data[1];
	 		targetElementId = 'itemBigCategory';
        } else if (currentCategoryType === 'mid') {
        	categoryName = data[2];
        	targetElementId = 'itemMidCategory';
        } else if (currentCategoryType === 'small') {
        	categoryName = data[3];
        	targetElementId = 'itemSmallCategory';
        } else {
        	console.error("알 수 없는 팝업 유형입니다:", currentCategoryType);
        	return;
        }
    
    	// 해당 필드에 값 적용
    	if (targetElementId && categoryName !== undefined) {
    		document.getElementById(targetElementId).value = categoryName;
    	}
    
    	// 데이터 처리 후 currentCategoryType 초기화
    	currentCategoryType = '';
    	
    	console.log(`[콜백] ${targetElementId} 필드에 명칭 적용 완료: ${categoryName}`);
    }
    
    // ==========================================================
    // 2. jQuery 로직
    // ==========================================================
    // 문서가 로딩되면 실행
    $(document).ready(function() {
        
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


        // ==========================================================
        // 3. 팝업 버튼 이벤트 리스너
        // ==========================================================

        // 품목대분류 버튼 이벤트 리스너
        $('#search-big-category-btn').on('click', function() {
            openPopup('/popup/category_popup_big', 'big');
        });
     	
        // 품목중분류 버튼 이벤트 리스너
        $('#search-mid-category-btn').on('click', function() {
            openPopup('/popup/category_popup_mid', 'mid');
        });
     	
        // 품목소분류 버튼 이벤트 리스너
        $('#search-small-category-btn').on('click', function() {
            openPopup('/popup/category_popup_small', 'small');
        });

         
        // 조회 함수
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

            // ... (기존 AJAX 통신 로직) ...
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
                                        <td class="sticky-col">${item.itemId}</td> // 품번
                                        <td>${item.itemAssetClass}</td> // 품목자산분류
                                        <td>${item.itemBigCategory}</td> // 품목대분류
                                        <td>${item.itemMidCategory}</td> // 품목중분류
                                        <td>${item.itemName}</td> // 품명
                                        <td>${item.inboundQty}</td> // 입고수량
                                        <td>${item.itemUnit}</td> // 단위
                                        <td>${item.itemStatus}</td> // 품목상태
                                        <td>${item.stockQty}</td> // 재고수량
                                        <td>${item.carriedOverQty}</td> // 이월수량
                                        <td>${item.outboundQty}</td> // 출고수량
                                        <td>${item.productionInbound}</td> // 입고(생산입고)
                                        <td>${item.outsourcingInbound}</td> // 입고(외주입고)
                                        <td>${item.purchaseInbound}</td> // 입고(구매입고)
                                        <td>${item.importInbound}</td> // 입고(수입입고)
                                        <td>${item.deliverySlipOutbound}</td> // 출고(거래명세표)
                                        <td>${item.otherOutbound}</td> // 출고(기타출고)
                                        <td>${item.salesConsignmentOutbound}</td> // 출고(판매보관품출고)
                                        <td>${item.workPerformanceOutbound}</td> // 출고(작업실적)
                                        <td>${item.outsourcingOutbound}</td> // 출고(외주입고)
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