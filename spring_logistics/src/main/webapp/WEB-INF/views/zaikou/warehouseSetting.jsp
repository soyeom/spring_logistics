<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고구분별 재고조회설정</title>
<link rel="stylesheet" href="/resources/css/logistics.css"
	type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class="layout">
		<div class="home-bar">
			<span> <a href="/"><img
					src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png"
					alt="홈화면" class="home-icon"></a>
			</span>
		</div>
		<aside class="sidebar">
			<div class="sidebar-header">
				<div class="profile">
					<img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png"
						alt="프로필">
					<p>홍길동님, 안녕하세요 👋</p>
					<div class="auth-btns">
						<button class="btn btn-secondary">로그인</button>
						<button class="btn btn-secondary">회원가입</button>
					</div>
				</div>
			</div>
			<nav class="menu">
				<div class="menu-item">
					<div class="title">
						<a href="#">입고 및 출고</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">입고 내역</a>
						</div>
						<div>
							<a href="#">출고 내역</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">재고 출하통제</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">출하 계획</a>
						</div>
						<div>
							<a href="#">출하 내역</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">재고 관리</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">재고 현황</a>
						</div>
						<div>
							<a href="#">재고 이동</a>
						</div>
						<div>
							<a href="#">재고 조회</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">사업단위별 수불집계</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">사업장별 집계</a>
						</div>
						<div>
							<a href="#">월별 추이</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">재고 변동 추이 분석</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">그래프 보기</a>
						</div>
					</div>
				</div>
			</nav>
		</aside>

		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>倉庫区分別在庫照会設定</h1>
				</div>
				<div>
					<button class="btn btn-secondary" onclick="location.href='/warehouse/setting'">照会</button>
					<button type="button" id="saveBtn" class="btn btn-secondary">保存</button>
				</div>
			</div>
			
			<div class="table-container" style="height : 300px;">
			<form id="warehouseForm">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 150px">番号</th>
							<th style="width: 150px">倉庫区分</th>
							<th style="width: 150px">資産在庫</th>
							<th style="width: 150px">有効在庫</th>
							<th style="width: 150px">実在庫</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="warehouse" items="${warehouseList}"
							varStatus="status">
							<tr>
								<td class="text-center">${status.index + 1}</td>
								<td class="text-center">${warehouse.warehouseInternalCode}<input type="hidden"
									class="warehouse-code"
									value="${warehouse.warehouseInternalCode}" />
								</td>
								<td><input type="checkbox"
									class="asset-flag" value="Y"
									<c:if test="${warehouse.assetStockFlag eq 'Y'}">checked</c:if> />
								</td>
								<td><input type="checkbox"
									class="available-flag" value="Y"
									<c:if test="${warehouse.availableStockFlag eq 'Y'}">checked</c:if> />
								</td>
								<td><input type="checkbox"
									class="actual-flag" value="Y"
									<c:if test="${warehouse.actualStockFlag eq 'Y'}">checked</c:if> />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
			</div>
			
			<script>
			$(document).ready(function(){
				$('#saveBtn').on('click', function(e){
					e.preventDefault();
					
					const warehouses = [];
					
					$('tbody tr').each(function(){
						const row = $(this);
						const wh = {
								warehouseInternalCode : row.find('.warehouse-code').val(),
								assetStockFlag : row.find('.asset-flag').is(':checked') ? 'Y' : 'N',
								availableStockFlag : row.find('.available-flag').is(':checked') ? 'Y' : 'N',
								actualStockFlag : row.find('.actual-flag').is(':checked') ? 'Y' : 'N'
								};
						warehouses.push(wh);
					});
					
					$.ajax({
						url : '/warehouse/update',
						type : 'POST',
						contentType : 'application/json',
						data : JSON.stringify(warehouses),
						success : function(response){
							if(response === 'success'){
								alert('保存されました。');
								window.location.href = '/warehouse/setting';
							} else {
								alert('保存中にエラーが発生しました。');
							}
						},
						error : function(){
							alert('サーバー通信エラーが発生しました。');
						}
					});
				});
			});
			</script>
</body>
</html>
