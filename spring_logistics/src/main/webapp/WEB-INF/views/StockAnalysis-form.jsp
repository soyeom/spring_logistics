<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    // 현재 날짜를 yyyy-MM 형식으로 포맷팅
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    String currentDate = sdf.format(new Date());
    request.setAttribute("currentDate", currentDate);

    // 검색 조건 변수 설정
    String startDate = request.getParameter("startDate");
    if (startDate == null) {
        startDate = currentDate;
    }

    String period = request.getParameter("period");
    if (period == null || period.isEmpty()) {
        period = "3";
    }

    String buId = request.getParameter("buId");
    String warehouseCode = request.getParameter("warehouseCode");
    String importanceLevel = request.getParameter("importanceLevel");
    String itemAssetClass = request.getParameter("itemAssetClass");
    String bigCategory = request.getParameter("bigCategory");
    String midCategory = request.getParameter("midCategory");
    String smallCategory = request.getParameter("smallCategory");
    String spec = request.getParameter("spec");
    String itemName = request.getParameter("itemName");
    String itemInternalCode = request.getParameter("itemInternalCode");

    // 시작 날짜 계산
    Calendar cal = Calendar.getInstance();
    Date d = sdf.parse(startDate);
    cal.setTime(d);
    cal.add(Calendar.MONTH, -Integer.parseInt(period) + 1);
    String calculatedStartDate = sdf.format(cal.getTime());

    // SQL 쿼리 생성
    String sqlQuery = "SELECT "
            + "    im.big_category, "
            + "    im.mid_category, "
            + "    im.small_category, "
            + "    im.spec, "
            + "    im.item_name, "
            + "    im.item_internal_code, "
            + "    wd.warehouse_name, "
            + "    wm.warehouse_internal_code AS warehouse_code, "
            + "    im.asset_class, "
            + "    im.importance_level, "
            + "    im.base_unit, "
            + "    im.sales_unit, "
            + "    im.currency, "
            + "    NVL(ibd_sub.inbound_qty, 0) AS inbound_qty, "
            + "    NVL(outd_sub.outbound_qty, 0) AS outbound_qty "
            + "FROM "
            + "    item_master im "
            + "LEFT JOIN ( "
            + "    SELECT "
            + "        item_id, warehouse_id, SUM(qty) AS inbound_qty "
            + "    FROM "
            + "        inbound_detail "
            + "    WHERE "
            + "        inbound_date >= TO_DATE(?, 'YYYY-MM-DD') AND inbound_date < TO_DATE(?, 'YYYY-MM-DD') + 1 "
            + "    GROUP BY "
            + "        item_id, warehouse_id "
            + ") ibd_sub ON im.item_id = ibd_sub.item_id "
            + "LEFT JOIN ( "
            + "    SELECT "
            + "        item_id, warehouse_id, SUM(qty) AS outbound_qty "
            + "    FROM "
            + "        out_detail "
            + "    WHERE "
            + "        out_date >= TO_DATE(?, 'YYYY-MM-DD') AND out_date < TO_DATE(?, 'YYYY-MM-DD') + 1 "
            + "    GROUP BY "
            + "        item_id, warehouse_id "
            + ") outd_sub ON im.item_id = outd_sub.item_id AND ibd_sub.warehouse_id = outd_sub.warehouse_id "
            + "LEFT JOIN "
            + "    warehouse_detail wd ON ibd_sub.warehouse_id = wd.warehouse_id OR outd_sub.warehouse_id = wd.warehouse_id "
            + "LEFT JOIN "
            + "    warehouse_master wm ON wd.warehouse_master_id = wm.warehouse_master_id "
            + "WHERE 1=1 ";

    if (buId != null && !buId.isEmpty() && !buId.equals("전체")) {
        sqlQuery += "AND im.bu_id = ? ";
    }
    if (warehouseCode != null && !warehouseCode.isEmpty()) {
        sqlQuery += "AND wm.warehouse_internal_code = ? ";
    }
    if (importanceLevel != null && !importanceLevel.isEmpty()) {
        sqlQuery += "AND im.importance_level = ? ";
    }
    if (itemAssetClass != null && !itemAssetClass.isEmpty()) {
        sqlQuery += "AND im.asset_class = ? ";
    }
    if (bigCategory != null && !bigCategory.isEmpty()) {
        sqlQuery += "AND im.big_category = ? ";
    }
    if (midCategory != null && !midCategory.isEmpty()) {
        sqlQuery += "AND im.mid_category = ? ";
    }
    if (smallCategory != null && !smallCategory.isEmpty()) {
        sqlQuery += "AND im.small_category = ? ";
    }
    if (spec != null && !spec.isEmpty()) {
        sqlQuery += "AND im.spec LIKE ? ";
    }
    if (itemName != null && !itemName.isEmpty()) {
        sqlQuery += "AND im.item_name LIKE ? ";
    }
    if (itemInternalCode != null && !itemInternalCode.isEmpty()) {
        sqlQuery += "AND im.item_internal_code LIKE ? ";
    }

    sqlQuery += "ORDER BY im.item_name";

    request.setAttribute("sqlQuery", sqlQuery);
    request.setAttribute("calculatedStartDate", calculatedStartDate);

%>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver" url="jdbc:oracle:thin:@localhost:1521:xe" user="system" password="1234" />

<sql:query var="inventoryData" dataSource="${dataSource}">
    ${sqlQuery}
    <sql:param value="<%= calculatedStartDate %>-01" />
    <sql:param value="<%= startDate %>-01" />
    <sql:param value="<%= calculatedStartDate %>-01" />
    <sql:param value="<%= startDate %>-01" />
    <c:if test="${not empty param.buId and param.buId != '전체'}">
        <sql:param value="${param.buId}" />
    </c:if>
    <c:if test="${not empty param.warehouseCode}">
        <sql:param value="${param.warehouseCode}" />
    </c:if>
    <c:if test="${not empty param.importanceLevel}">
        <sql:param value="${param.importanceLevel}" />
    </c:if>
    <c:if test="${not empty param.itemAssetClass}">
        <sql:param value="${param.itemAssetClass}" />
    </c:if>
    <c:if test="${not empty param.bigCategory}">
        <sql:param value="${param.bigCategory}" />
    </c:if>
    <c:if test="${not empty param.midCategory}">
        <sql:param value="${param.midCategory}" />
    </c:if>
    <c:if test="${not empty param.smallCategory}">
        <sql:param value="${param.smallCategory}" />
    </c:if>
    <c:if test="${not empty param.spec}">
        <sql:param value="%${param.spec}%" />
    </c:if>
    <c:if test="${not empty param.itemName}">
        <sql:param value="%${param.itemName}%" />
    </c:if>
    <c:if test="${not empty param.itemInternalCode}">
        <sql:param value="%${param.itemInternalCode}%" />
    </c:if>
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 변동 추이 분석</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* 스타일 부분은 그대로 유지 */
    </style>
</head>
<body>

<div class="full-screen-container">
    <div class="header">
        재고 변동 추이 분석
    </div>
    <div class="main-content">
        <form id="analysisForm" class="search-form-container" method="get">
            <h4 class="text-lg font-bold text-gray-800 mb-4">조회 조건</h4>
            <div class="search-grid">
                <div class="grid-item">
                    <label for="buId">사업단위</label>
                    <input type="text" id="buId" name="buId" value="<c:out value='${param.buId}' default='전체'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="warehouseCode">창고</label>
                    <div class="search-group">
                        <input type="text" id="warehouseCode" name="warehouseCode" class="rounded-l-md" placeholder="창고 코드 또는 이름" value="<c:out value='${param.warehouseCode}'/>" />
                        <span class="search-icon" onclick="openWarehouseSearchPopup()">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                        </span>
                    </div>
                </div>
                <div class="grid-item">
                    <label for="itemAssetClass">품목자산분류</label>
                    <input type="text" id="itemAssetClass" name="itemAssetClass" value="<c:out value='${param.itemAssetClass}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="bigCategory">품목대분류</label>
                    <input type="text" id="bigCategory" name="bigCategory" value="<c:out value='${param.bigCategory}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="midCategory">품목중분류</label>
                    <input type="text" id="midCategory" name="midCategory" value="<c:out value='${param.midCategory}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="smallCategory">품목소분류</label>
                    <input type="text" id="smallCategory" name="smallCategory" value="<c:out value='${param.smallCategory}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="spec">규격</label>
                    <input type="text" id="spec" name="spec" value="<c:out value='${param.spec}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="itemName">품명</label>
                    <input type="text" id="itemName" name="itemName" value="<c:out value='${param.itemName}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="itemInternalCode">품번</label>
                    <input type="text" id="itemInternalCode" name="itemInternalCode" value="<c:out value='${param.itemInternalCode}'/>" class="rounded-md" />
                </div>
                <div class="grid-item">
                    <label for="importanceLevel">중요도</label>
                    <input type="text" id="importanceLevel" name="importanceLevel" value="<c:out value='${param.importanceLevel}'/>" class="rounded-md" />
                </div>
            </div>

            <hr class="my-6 border-gray-200">

            <h4 class="text-lg font-bold text-gray-800 mb-4">비교 대상 기간 설정</h4>
            <div class="date-setting-container">
                <div class="date-group">
                    <label for="startDate">현재일</label>
                    <input type="month" id="startDate" name="startDate" value="${currentDate}" class="rounded-md" />
                    <label for="period">기간</label>
                    <select id="period" name="period" class="rounded-md">
                        <option value="3" <c:if test="${param.period == '3'}">selected</c:if>>3개월</option>
                        <option value="6" <c:if test="${param.period == '6'}">selected</c:if>>6개월</option>
                        <option value="12" <c:if test="${param.period == '12'}">selected</c:if>>12개월</option>
                    </select>
                </div>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn-search">조회</button>
            </div>
        </form>

        <c:if test="${not empty inventoryData.rows}">
            <div class="table-container">
                <h4 class="text-lg font-bold text-gray-800 mb-4">분석 결과</h4>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>품목 대분류</th>
                            <th>품목 중분류</th>
                            <th>품목 소분류</th>
                            <th>규격</th>
                            <th>품명</th>
                            <th>품번</th>
                            <th>창고명</th>
                            <th>창고코드</th>
                            <th>품목자산분류</th>
                            <th>중요도</th>
                            <th>입고량</th>
                            <th>출고량</th>
                            <th>순 변동량</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="data" items="${inventoryData.rows}">
                            <c:set var="inboundQty" value="${data.inbound_qty}" />
                            <c:set var="outboundQty" value="${data.outbound_qty}" />
                            <c:set var="netChange" value="${inboundQty - outboundQty}" />
                            <tr>
                                <td>${data.big_category}</td>
                                <td>${data.mid_category}</td>
                                <td>${data.small_category}</td>
                                <td>${data.spec}</td>
                                <td>${data.item_name}</td>
                                <td>${data.item_internal_code}</td>
                                <td>${data.warehouse_name}</td>
                                <td>${data.warehouse_code}</td>
                                <td>${data.asset_class}</td>
                                <td>${data.importance_level}</td>
                                <td><fmt:formatNumber value="${inboundQty}" pattern="#,##0.00" /></td>
                                <td><fmt:formatNumber value="${outboundQty}" pattern="#,##0.00" /></td>
                                <td><fmt:formatNumber value="${netChange}" pattern="#,##0.00" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

    </div>
</div>

<script>
    function openWarehouseSearchPopup() {
        window.open('warehouseSearchPopup.jsp', 'warehouseSearch', 'width=600,height=400,scrollbars=yes');
    }

    function setWarehouse(code, name) {
        document.getElementById('warehouseCode').value = code;
    }
</script>

</body>
</html>
