<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>창고구분별 재고조회설정</title>
<style>
table {
	border-collapse: collapse;
	width: 700px;
	margin: 0 auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

h2 {
	text-align: center;
}

.title-bar {
	width: 700px;
	margin: 20px auto;
}

.title-bar h2 {
	display: inline;
}

.title-bar div {
	float: right;
}
</style>
</head>
<body>
	<!-- ✅ 제목 + 버튼 영역 -->
	<div class="title-bar">
		<h2>창고구분별 재고조회설정</h2>
		<div>
			<!-- 저장 버튼: form 안에 포함 -->
			<button type="submit" form="warehouseForm">저장</button>
			<!-- 조회 버튼: 단순히 /list GET -->
			<button type="button" onclick="location.href='/list'">조회</button>
		</div>
	</div>

	<!-- ✅ 목록 테이블 -->
	<form id="warehouseForm" method="post" action="/update">
		<table>
			<thead>
				<tr>
					<th>순번</th>
					<th>창고구분</th>
					<th>자산재고</th>
					<th>가용재고</th>
					<th>실재고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="warehouse" items="${warehouseList}"
					varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${warehouse.warehouseInternalCode} <input type="hidden"
							name="warehouses[${status.index}].warehouseInternalCode"
							value="${warehouse.warehouseInternalCode}" />
						</td>
						<td><input type="checkbox"
							name="warehouses[${status.index}].assetStockFlag" value="Y"
							<c:if test="${warehouse.assetStockFlag eq 'Y'}">checked</c:if> />
						</td>
						<td><input type="checkbox"
							name="warehouses[${status.index}].availableStockFlag" value="Y"
							<c:if test="${warehouse.availableStockFlag eq 'Y'}">checked</c:if> />
						</td>
						<td><input type="checkbox"
							name="warehouses[${status.index}].actualStockFlag" value="Y"
							<c:if test="${warehouse.actualStockFlag eq 'Y'}">checked</c:if> />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</body>
</html>
