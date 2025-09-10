<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	user="system"
	password="1234" />

<%-- 검색 키워드 변수 설정 --%>
<c:set var="keyword" value="${param.keyword}" />

<%-- 품목 데이터 조회 쿼리 (수정) --%>
<c:choose>
    <c:when test="${not empty keyword}">
        <sql:query var="items" dataSource="${dataSource}">
            SELECT item_id, item_name, small_category, big_category, item_internal_code
            FROM item_master
            WHERE item_name LIKE '%' || ? || '%'
                OR small_category LIKE '%' || ? || '%'
                OR big_category LIKE '%' || ? || '%'
            ORDER BY item_name
            <sql:param value="${keyword}" />
            <sql:param value="${keyword}" />
            <sql:param value="${keyword}" />
        </sql:query>
    </c:when>
    <c:otherwise>
        <sql:query var="items" dataSource="${dataSource}">
            SELECT item_id, item_name, small_category, big_category, item_internal_code
            FROM item_master
            ORDER BY item_name
        </sql:query>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>품목자재소분류</title>
	<style>
		body { font-family: sans-serif; }
		.search-form { margin-bottom: 20px; }
		table { width: 100%; border-collapse: collapse; font-size: 14px; }
		th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
		th { background-color: #f2f2f2; }
		tr:hover { background-color: #f5f5f5; cursor: pointer; }
		.button-container { text-align: center; margin-top: 20px; }
		.search-input-container { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
		.search-input { display: flex; align-items: center; }
		.search-input input { border: 1px solid #ccc; padding: 6px; border-radius: 4px; }
		.search-button { margin-left: 8px; }
	</style>
</head>
<body>
<h2>품목자재소분류</h2>

<form action="itemSubCategorySearchPopup.jsp" method="get" class="search-form">
	<div class="search-input-container">
		<div class="search-input">
			<label for="keyword">품목소분류</label>
			<input type="text" id="keyword" name="keyword" placeholder="품목명 또는 소분류 검색" value="${keyword}" size="30" />
			<button type="submit" class="search-button">검색</button>
		</div>
		<button type="button" onclick="window.close()">닫기</button>
	</div>
</form>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>품목소분류</th>
			<th>품목소분류코드</th>
			<th>품목대분류</th>
			<th>품목명</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${not empty items.rows}">
				<c:forEach var="item" items="${items.rows}" varStatus="status">
					<tr onclick="selectItem('${item.small_category}', '${item.item_internal_code}', '${item.big_category}', '${item.item_internal_code}', '${item.item_name}')">
						<td>${status.count}</td>
						<td>${item.small_category}</td>
						<td>${item.item_internal_code}</td>
						<td>${item.big_category}</td>
						<td>${item.item_name}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">조회된 품목이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>

<script>
//수정된 JavaScript 코드
function selectItem(smallCategory, smallCategoryCode, bigCategory, bigCategoryCode, itemName) {
    if (window.opener && window.opener.setSmallCategoryData) {
        // 부모 페이지의 setSmallCategoryData 함수 호출
        window.opener.setSmallCategoryData({
            // 품목소분류의 이름과 코드를 함께 전달
            smallCategoryName: smallCategory,
            smallCategoryCode: smallCategoryCode
        });
    }
    window.close();
}
</script>

</body>
</html>