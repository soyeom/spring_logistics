<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        table {
            border-collapse: collapse;
            font-size: 0.9rem;
        }
        th, td {
            border: 1px solid #e5e7eb;
            padding: 0.75rem;
            text-align: left;
        }
        thead th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #1f2937;
        }
        tbody tr:nth-child(odd) {
            background-color: #f9fafb;
        }
        tbody tr:hover {
            background-color: #e5e7eb;
        }
        .search-area input[type="text"],
        .search-area input[type="date"] {
            border: 1px solid #d1d5db;
            padding: 0.5rem;
            border-radius: 0.5rem;
            width: 100%;
            transition: all 0.2s;
        }
        .search-area button {
            background-color: #4f46e5;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.2s;
            cursor: pointer;
        }
        .search-area button:hover {
            background-color: #4338ca;
        }
        .btn-group {
            display: flex;
            gap: 0.5rem;
        }
        .full-width {
            grid-column: span 2 / span 2;
        }
    </style>
</head>
<body class="bg-gray-100 p-8">

    <div class="container">
        <h2 class="text-2xl font-bold mb-6 text-center text-indigo-700">사업단위별 수불집계 조회</h2>

        <!-- 조회 조건 영역 -->
        <div class="search-area p-6 mb-8 bg-gray-50 rounded-lg border border-gray-200">
            <h3 class="text-xl font-semibold mb-4 text-gray-700">조회 조건</h3>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">사업단위:</span>
                    <input type="text" id="businessUnit" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">조회기간:</span>
                    <input type="date" id="startDate" class="flex-1">
                    <span class="mx-1 text-gray-500">~</span>
                    <input type="date" id="endDate" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">재고기준:</span>
                    <input type="text" id="stockStandard" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품목자산분류:</span>
                    <input type="text" id="itemAssetClass" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품목대분류:</span>
                    <input type="text" id="itemBigCategory" class="flex-1">
                    <button onclick="openPopup('big')" class="flex-shrink-0">검색</button>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품목중분류:</span>
                    <input type="text" id="itemMidCategory" class="flex-1">
                    <button onclick="openPopup('mid')" class="flex-shrink-0">검색</button>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품목소분류:</span>
                    <input type="text" id="itemSmallCategory" class="flex-1">
                    <button onclick="openPopup('small')" class="flex-shrink-0">검색</button>
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품명:</span>
                    <input type="text" id="itemName" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">품번:</span>
                    <input type="text" id="itemInternalCode" class="flex-1">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600 w-24">규격:</span>
                    <input type="text" id="itemSpec" class="flex-1">
                </div>
            </div>
            <div class="mt-4 flex items-center space-x-4">
                <span class="text-gray-600 font-semibold">추가조회조건:</span>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600">품목상태:</span>
                    <input type="text" id="itemStatus" class="flex-1 w-28">
                </div>
                <div class="flex items-center space-x-2">
                    <span class="text-gray-600">단위조회기준:</span>
                    <input type="text" id="unitStandard" class="flex-1 w-28">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="checkbox" id="includeZeroQty" class="rounded text-indigo-600">
                    <span class="text-gray-600">0수량 조회여부</span>
                </div>
            </div>
            <div class="mt-6 text-center">
                <button id="searchBtn">조회</button>
            </div>
        </div>

        <!-- 결과 테이블 영역 -->
        <div class="result-area overflow-x-auto">
            <h3 class="text-xl font-semibold mb-4 text-gray-700">조회 결과</h3>
            <table id="resultTable" class="w-full rounded-lg shadow-sm">
                <thead>
                    <tr>
                        <th rowspan="2">품번</th>
                        <th rowspan="2">품목자산분류</th>
                        <th rowspan="2">품목대분류</th>
                        <th rowspan="2">품목중분류</th>
                        <th rowspan="2">품명</th>
                        <th rowspan="2">이월수량</th>
                        <th colspan="4">입고</th>
                        <th rowspan="2">총입고수량</th>
                        <th colspan="5">출고</th>
                        <th rowspan="2">총출고수량</th>
                        <th rowspan="2">재고수량</th>
                        <th rowspan="2">단위</th>
                        <th rowspan="2">단위내부코드</th>
                        <th rowspan="2">품목상태</th>
                    </tr>
                    <tr>
                        <th>생산입고</th>
                        <th>외주입고</th>
                        <th>구매입고</th>
                        <th>수입입고</th>
                        <th>거래명세표</th>
                        <th>기타출고</th>
                        <th>판매보관품출고</th>
                        <th>작업실적</th>
                        <th>외주출고</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 데이터가 여기에 동적으로 삽입됩니다. -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // 가상의 데이터
        const MOCK_DATA = [
            {
                itemNumber: "A123-01",
                itemAssetClass: "자산",
                itemBigCategory: "전자기기",
                itemMidCategory: "노트북",
                itemName: "초경량 노트북 13인치",
                carriedOverQty: 100,
                productionInbound: 50,
                outsourcingInbound: 20,
                purchaseInbound: 30,
                importInbound: 10,
                inboundQty: 110,
                deliverySlipOutbound: 15,
                otherOutbound: 5,
                salesConsignmentOutbound: 10,
                workPerformanceOutbound: 8,
                outsourcingOutbound: 2,
                outboundQty: 40,
                stockQty: 170,
                itemUnit: "EA",
                itemUnitInternalCode: "EA-01",
                itemStatus: "정상",
            },
            {
                itemNumber: "B456-02",
                itemAssetClass: "소모품",
                itemBigCategory: "사무용품",
                itemMidCategory: "토너",
                itemName: "흑백 레이저 토너",
                carriedOverQty: 50,
                productionInbound: 0,
                outsourcingInbound: 0,
                purchaseInbound: 25,
                importInbound: 0,
                inboundQty: 25,
                deliverySlipOutbound: 0,
                otherOutbound: 10,
                salesConsignmentOutbound: 0,
                workPerformanceOutbound: 0,
                outsourcingOutbound: 0,
                outboundQty: 10,
                stockQty: 65,
                itemUnit: "EA",
                itemUnitInternalCode: "EA-01",
                itemStatus: "정상",
            },
            {
                itemNumber: "C789-03",
                itemAssetClass: "자산",
                itemBigCategory: "전자기기",
                itemMidCategory: "모니터",
                itemName: "27인치 4K 모니터",
                carriedOverQty: 200,
                productionInbound: 0,
                outsourcingInbound: 0,
                purchaseInbound: 50,
                importInbound: 0,
                inboundQty: 50,
                deliverySlipOutbound: 30,
                otherOutbound: 0,
                salesConsignmentOutbound: 0,
                workPerformanceOutbound: 0,
                outsourcingOutbound: 0,
                outboundQty: 30,
                stockQty: 220,
                itemUnit: "EA",
                itemUnitInternalCode: "EA-01",
                itemStatus: "정상",
            },
        ];

        // 페이지 로드 시 또는 '조회' 버튼 클릭 시 데이터를 가져오는 함수
        function performSearch() {
            const $tbody = document.getElementById('resultTable').querySelector('tbody');
            $tbody.innerHTML = '<tr><td colspan="21" class="text-center p-4">데이터를 불러오는 중입니다...</td></tr>';

            // 가상의 API 호출 시뮬레이션
            setTimeout(() => {
                // 사용자가 입력한 조회 조건을 가져옵니다.
                const searchData = {
                    itemAssetClass: document.getElementById('itemAssetClass').value.trim().toLowerCase(),
                    itemBigCategory: document.getElementById('itemBigCategory').value.trim().toLowerCase(),
                    itemMidCategory: document.getElementById('itemMidCategory').value.trim().toLowerCase(),
                    itemName: document.getElementById('itemName').value.trim().toLowerCase(),
                    itemInternalCode: document.getElementById('itemInternalCode').value.trim().toLowerCase(),
                    itemSpec: document.getElementById('itemSpec').value.trim().toLowerCase(),
                    itemStatus: document.getElementById('itemStatus').value.trim().toLowerCase(),
                    unitStandard: document.getElementById('unitStandard').value.trim().toLowerCase(),
                    includeZeroQty: document.getElementById('includeZeroQty').checked,
                };
                
                // MOCK_DATA를 필터링하여 조건에 맞는 데이터만 남깁니다.
                const filteredData = MOCK_DATA.filter(item => {
                    const assetClassMatch = item.itemAssetClass.toLowerCase().includes(searchData.itemAssetClass);
                    const bigCategoryMatch = item.itemBigCategory.toLowerCase().includes(searchData.itemBigCategory);
                    const midCategoryMatch = item.itemMidCategory.toLowerCase().includes(searchData.itemMidCategory);
                    const nameMatch = item.itemName.toLowerCase().includes(searchData.itemName);
                    const internalCodeMatch = item.itemNumber.toLowerCase().includes(searchData.itemInternalCode);
                    const specMatch = item.itemSpec ? item.itemSpec.toLowerCase().includes(searchData.itemSpec) : !searchData.itemSpec;
                    const statusMatch = item.itemStatus.toLowerCase().includes(searchData.itemStatus);
                    const unitMatch = item.itemUnitInternalCode.toLowerCase().includes(searchData.unitStandard);
                    
                    // 0수량 포함 여부에 따라 필터링합니다.
                    const zeroQtyMatch = searchData.includeZeroQty ? true : item.stockQty > 0;

                    return assetClassMatch && bigCategoryMatch && midCategoryMatch && nameMatch && internalCodeMatch && specMatch && statusMatch && unitMatch && zeroQtyMatch;
                });
                
                // 필터링된 데이터를 테이블에 렌더링합니다.
                renderTable(filteredData);
            }, 500); // 0.5초 지연
        }

        // 테이블 렌더링 함수
        function renderTable(data) {
            const $tbody = document.getElementById('resultTable').querySelector('tbody');
            $tbody.innerHTML = '';

            if (data.length === 0) {
                $tbody.innerHTML = '<tr><td colspan="21" class="text-center p-4">조회된 데이터가 없습니다.</td></tr>';
                return;
            }

            data.forEach(item => {
                const row = `
                    <tr>
                        <td>${item.itemNumber}</td>
                        <td>${item.itemAssetClass}</td>
                        <td>${item.itemBigCategory}</td>
                        <td>${item.itemMidCategory}</td>
                        <td>${item.itemName}</td>
                        <td>${item.carriedOverQty}</td>
                        <td>${item.productionInbound}</td>
                        <td>${item.outsourcingInbound}</td>
                        <td>${item.purchaseInbound}</td>
                        <td>${item.importInbound}</td>
                        <td>${item.inboundQty}</td>
                        <td>${item.deliverySlipOutbound}</td>
                        <td>${item.otherOutbound}</td>
                        <td>${item.salesConsignmentOutbound}</td>
                        <td>${item.workPerformanceOutbound}</td>
                        <td>${item.outsourcingOutbound}</td>
                        <td>${item.outboundQty}</td>
                        <td>${item.stockQty}</td>
                        <td>${item.itemUnit}</td>
                        <td>${item.itemUnitInternalCode}</td>
                        <td>${item.itemStatus}</td>
                    </tr>
                `;
                $tbody.innerHTML += row;
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            performSearch();

            document.getElementById('searchBtn').addEventListener('click', performSearch);
        });

        function openPopup(type) {
            console.log(type + " 품목 분류 팝업창을 엽니다.");
        }
    </script>
</body>
</html>
