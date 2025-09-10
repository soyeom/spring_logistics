<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521:xe"
    user="system" password="1234" />

<%-- business_unit 테이블에서 bu_id와 bu_name을 조회 --%>
<sql:query var="businessUnits" dataSource="${dataSource}">
    SELECT bu_id, bu_name FROM business_unit ORDER BY bu_id
</sql:query>

<%-- item_master 테이블에서 category를 조회 --%>
<sql:query var="itemBigCategories" dataSource="${dataSource}">
    SELECT DISTINCT big_category FROM item_master WHERE big_category IS NOT NULL
</sql:query>
<sql:query var="itemMidCategories" dataSource="${dataSource}">
    SELECT DISTINCT mid_category FROM item_master WHERE mid_category IS NOT NULL
</sql:query>
<sql:query var="itemSmallCategories" dataSource="${dataSource}">
    SELECT DISTINCT small_category FROM item_master WHERE small_category IS NOT NULL
</sql:query>
<sql:query var="importanceLevels" dataSource="${dataSource}">
    SELECT DISTINCT importance_level FROM item_master WHERE importance_level IS NOT NULL
</sql:query>
<sql:query var="units" dataSource="${dataSource}">
    SELECT DISTINCT base_unit FROM item_master WHERE base_unit IS NOT NULL
</sql:query>

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
    </style>
</head>
<body>
    <h2>재고 변동 추이 분석</h2>
    <form id="stockAnalysisForm">
    <div class="search-container">
        <div class="search-item">
            <label for="buId">사업단위:</label>
            <select id="buId" name="buId">
                <option value="">전체</option>
                <c:forEach var="bu" items="${businessUnits.rows}">
                    <option value="${bu.bu_id}">${bu.bu_name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="search-item">
            <label for="warehouseId">창고:</label>
            <input type="text" id="warehouseId" name="warehouseId" placeholder="창고 코드 또는 이름">
        </div>
        
        <div class="search-item">
            <label for="stockStandard">재고기준:</label>
            <select id="stockStandard" name="stockStandard">
                <option value="">전체</option>
                <option value="수량">수량</option>
                <option value="금액">금액</option>
            </select>
        </div>
        
        <div class="search-item">
            <label for="importanceLevel">중요도:</label>
            <select id="importanceLevel" name="importanceLevel">
                <option value="">전체</option>
                <c:forEach var="level" items="${importanceLevels.rows}">
                    <option value="${level.importance_level}">${level.importance_level}</option>
                </c:forEach>
            </select>
        </div>

        <div class="search-item">
            <label for="itemAssetClass">품목자산분류:</label>
            <input type="text" id="itemAssetClass" name="itemAssetClass" placeholder="품목자산분류">
        </div>

        <div class="search-item">
            <label for="itemSmallCategory">품목소분류:</label>
            <select id="itemSmallCategory" name="itemSmallCategory">
                <option value="">전체</option>
                <c:forEach var="category" items="${itemSmallCategories.rows}">
                    <option value="${category.small_category}">${category.small_category}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="search-item">
            <label for="itemName">품명:</label>
            <input type="text" id="itemName" name="itemName" placeholder="품명">
        </div>
        
        <div class="search-item">
            <label for="itemInternalCode">품번:</label>
            <input type="text" id="itemInternalCode" name="itemInternalCode" placeholder="품번">
        </div>
        
        <div class="search-item">
            <label for="spec">규격:</label>
            <input type="text" id="spec" name="spec" placeholder="규격">
        </div>
        
        <div class="search-item">
            <label for="unit">단위:</label>
            <select id="unit" name="unit">
                <option value="">전체</option>
                <c:forEach var="unit" items="${units.rows}">
                    <option value="${unit.base_unit}">${unit.base_unit}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <button type="button" id="searchButton">조회</button>
    </form>

    <div id="resultTableContainer">
    </div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#searchButton').on('click', function() {
                // 폼 데이터를 JSON 객체로 변환
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
                    unit: $('#unit').val()
                };

                // AJAX를 사용하여 POST 요청 보내기
                $.ajax({
                    url: '/stockAnalysis/analysis',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        console.log('데이터 조회 성공:', response);
                        displayDataInTable(response);
                    },
                    error: function(error) {
                        console.error('데이터 조회 실패:', error);
                        alert('데이터를 가져오는 데 실패했습니다.');
                    }
                });
            });

            function displayDataInTable(data) {
                const container = $('#resultTableContainer');
                container.empty(); // 이전 결과 삭제

                if (data && data.length > 0) {
                    let tableHtml = '<table border="1"><thead><tr>';
                    // 테이블 헤더 생성
                    for (const key in data[0]) {
                        tableHtml += '<th>' + key + '</th>';
                    }
                    tableHtml += '</tr></thead><tbody>';

                    // 테이블 본문 데이터 채우기
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
    </script>
</body>
</html>
