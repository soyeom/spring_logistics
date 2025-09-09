<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521:xe"
    user="your_username" password="your_password" />

<%-- business_unit 테이블에서 bu_id와 bu_name을 조회 --%>
<sql:query var="businessUnits" dataSource="${dataSource}">
    SELECT bu_id, bu_name FROM business_unit ORDER BY bu_id
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 변동 추이 분석</title>
</head>
<body>
    <h2>재고 변동 추이 분석</h2>
    
    <div class="search-form">
        <label for="buId">사업단위:</label>
        <select id="buId" name="buId">
            <option value="">전체</option>
            <%-- 조회된 데이터를 드롭다운 목록으로 표시 --%>
            <c:forEach var="bu" items="${businessUnits.rows}">
                <option value="${bu.bu_id}">${bu.bu_name}</option>
            </c:forEach>
        </select>
    </div>
</body>
</html>