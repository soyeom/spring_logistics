<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사업단위별 수불집계 조회</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { padding: 20px; }
        .search-area, .result-area { margin-bottom: 20px; }
        .search-area div { margin-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 조회 버튼 클릭 이벤트
            $('#searchBtn').click(function() {
                const searchData = {
                    businessBuName: $('#businessUnit').val(),
                    searchPeriodStart: $('#startDate').val(),
                    searchPeriodEnd: $('#endDate').val(),
                    stockStandard: $('#stockStandard').val(),
                    itemAssetClass: $('#itemAssetClass').val(),
                    itemBigCategory: $('#itemBigCategory').val(),
                    itemBigCategoryCode: $('#itemBigCategoryCode').val(),
                    itemMidCategory: $('#itemMidCategory').val(),
                    itemMidCategoryCode: $('#itemMidCategoryCode').val(),
                    itemSmallCategory: $('#itemSmallCategory').val(),
                    itemSmallCategoryCode: $('#itemSmallCategoryCode').val(),
                    itemName: $('#itemName').val(),
                    itemInternalCode: $('#itemInternalCode').val(),
                    itemSpec: $('#itemSpec').val(),
                    itemStatus: $('#itemStatus').val(),
                    unitStandard: $('#unitStandard').val(),
                    includeZeroQty: $('#includeZeroQty').is(':checked')
                };

                $.ajax({
                    url: '/stock/summary/search',
                    type: 'GET',
                    data: searchData,
                    success: function(response) {
                        renderTable(response);
                    },
                    error: function(error) {
                        alert('Error: ' + error.statusText);
                    }
                });
            });

            // 테이블 렌더링 함수
            function renderTable(data) {
                const $tbody = $('#resultTable tbody');
                $tbody.empty(); // 기존 내용 삭제

                if (data.length === 0) {
                    $tbody.append('<tr><td colspan="19" style="text-align: center;">조회된 데이터가 없습니다.</td></tr>');
                    return;
                }

                $.each(data, function(index, item) {
                    const row = `
                        <tr>
                            <td>${item.itemNumber}</td>
                            <td>${item.itemAssetClass}</td>
                            <td>${item.itemBigCategory}</td>
                            <td>${item.itemMidCategory}</td>
                            <td>${item.itemName}</td>
                            <td>${item.inboundQty}</td>
                            <td>${item.itemUnit}</td>
                            <td>${item.itemUnitInternalCode}</td>
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
                });
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>사업단위별 수불집계 조회</h2>

        <!-- 조회 조건 영역 -->
        <div class="search-area">
            <h3>조회 조건</h3>
            <div>사업단위: <input type="text" id="businessUnit"></div>
            <div>조회기간: <input type="date" id="startDate"> ~ <input type="date" id="endDate"></div>
            <div>재고기준: <input type="text" id="stockStandard"></div>
            <div>
                품목자산분류: <input type="text" id="itemAssetClass">
                <input type="hidden" id="itemAssetClassCode">
            </div>
            <div>
                품목대분류: <input type="text" id="itemBigCategory">
                <input type="hidden" id="itemBigCategoryCode">
                <button onclick="openPopup('big')">검색</button>
            </div>
            <div>
                품목중분류: <input type="text" id="itemMidCategory">
                <input type="hidden" id="itemMidCategoryCode">
                <button onclick="openPopup('mid')">검색</button>
            </div>
            <div>
                품목소분류: <input type="text" id="itemSmallCategory">
                <input type="hidden" id="itemSmallCategoryCode">
                <button onclick="openPopup('small')">검색</button>
            </div>
            <div>품명: <input type="text" id="itemName"></div>
            <div>품번: <input type="text" id="itemInternalCode"></div>
            <div>규격: <input type="text" id="itemSpec"></div>
            <div>
                추가조회조건:
                품목상태: <input type="text" id="itemStatus">
                단위조회기준: <input type="text" id="unitStandard">
                0수량 조회여부: <input type="checkbox" id="includeZeroQty">
            </div>
            <button id="searchBtn">조회</button>
        </div>

        <!-- 결과 테이블 영역 -->
        <div class="result-area">
            <h3>조회 결과</h3>
            <table id="resultTable">
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
                        <th>외주입고</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 데이터가 여기에 동적으로 삽입됩니다. -->
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // 팝업창을 열기 위한 더미 함수. 실제 팝업 로직은 별도로 구현해야 합니다.
        function openPopup(type) {
            alert(type + " 품목 분류 팝업창을 엽니다.");
        }
    </script>
</body>
</html>
