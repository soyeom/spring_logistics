<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe" user="system" password="1234" />

<%-- 검색 키워드 변수 설정 --%>
<c:set var="keyword" value="${param.keyword}" />

<%-- 품목 데이터 조회 쿼리 (수정) --%>
<c:choose>
    <c:when test="${not empty keyword}">
        <sql:query var="warehouses" dataSource="${dataSource}">
            SELECT warehouse_id, warehouse_name
            FROM warehouse_detail
            WHERE warehouse_id LIKE '%' || ? || '%'
                OR warehouse_name LIKE '%' || ? || '%'
            ORDER BY warehouse_name
            <sql:param value="${keyword}" />
            <sql:param value="${keyword}" />
        </sql:query>
    </c:when>
    <c:otherwise>
        <sql:query var="warehouses" dataSource="${dataSource}">
            SELECT warehouse_id, warehouse_name
            FROM warehouse_detail
            ORDER BY warehouse_name
        </sql:query>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 검색</title>
<style>
body { font-family: Arial, sans-serif; padding: 20px; }
#search-form { display: flex; gap: 10px; margin-bottom: 20px; }
#search-input { flex-grow: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
#search-button { padding: 8px 12px; border: none; background-color: #4CAF50; color: white; border-radius: 4px; cursor: pointer; }
#warehouse-list { width: 100%; border-collapse: collapse; }
#warehouse-list th, #warehouse-list td { border: 1px solid #ddd; padding: 8px; text-align: left; }
#warehouse-list th { background-color: #f2f2f2; }
#warehouse-list tr:hover { background-color: #f5f5f5; cursor: pointer; }
</style>
</head>
<body>

	<h3>창고 검색</h3>
	<form id="search-form" action="warehouseSearchPopup.jsp" method="get">
		<input type="text" id="search-input" name="keyword" placeholder="창고 코드 또는 이름 검색" value="${keyword}">
		<button type="submit" id="search-button">검색</button>
	</form>

	<table id="warehouse-list">
		<thead>
			<tr>
				<th>창고 코드</th>
				<th>창고 이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="wh" items="${warehouses.rows}">
				<tr onclick="selectWarehouse('${wh.warehouse_id}', '${wh.warehouse_name}')">
					<td>${wh.warehouse_id}</td>
					<td>${wh.warehouse_name}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script>
		function selectWarehouse(code, name) {
			if (window.opener && !window.opener.closed && window.opener.setWarehouse) {
				window.opener.setWarehouse(code, name);
				window.close();
			} else {
				alert('부모 창이 열려 있지 않거나 창고를 설정하는 함수가 없습니다.');
			}
		}
	</script>

</body>
</html>