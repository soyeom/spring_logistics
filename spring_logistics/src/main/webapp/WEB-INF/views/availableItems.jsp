<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가용재고 조회</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="container mt-5">

	<h2 class="text-center mb-4">가용재고 조회</h2>

	<table class="table table-bordered">
		<thead>
			<tr>
				<th>창고</th>
				<th>창고코드</th>
				<th>품목자산분류</th>
				<th>품명</th>
				<th>규격</th>
				<th>품번</th>
				<th>단위</th>
				<th>입고예정</th>
				<th>안전재고</th>
				<th>생산의뢰</th>
				<th>구매발주</th>
				<th>적송요청</th>
				<th>기타입고요청</th>
				<th>입고예정계</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${items}">
				<tr>
					<td>${item.warehouseName}</td>
					<td>${item.warehouseId}</td>
					<td>${item.assetClass}</td>
					<td>${item.itemName}</td>
					<td>${item.spec}</td>
					<td>${item.itemId}</td>
					<td>${item.baseUnit}</td>
					<td>${item.expectedQty}</td>
					<td>${item.safetyQty}</td>
					<td>${item.requestQty}</td>
					<td>${item.orderQty}</td>
					<td>${item.transferQty}</td>
					<td>${item.inboundQty}</td>
					<td>${item.expectedQty}</td>
				</tr>
			</c:forEach>
		</tbody>

	</table>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
