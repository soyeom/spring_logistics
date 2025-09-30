<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가용재고조회</title>
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
		<!-- 홈 아이콘 세로 바 -->
		<div class="home-bar">
			<span> <a href="/"><img
					src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png"
					alt="홈화면" class="home-icon"></a>
			</span>
		</div>
		<!-- 사이드바 -->
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
		<!-- ✅ 메인 -->
		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>가용재고조회</h1>
				</div>
				<div>
					<button class="btn btn-secondary" onclick="search()">조회</button>
				</div>
			</div>
			<!-- ✅ 조회 조건 -->
			<div class="filters">
				<div class="filters-main">
					<div class="title">조회 조건</div>
					<div class="line"></div>
				</div>
				<div class="filters-row">
					<!-- 사업단위 -->
					<div class="filters-count">
						<div class="filters-text">사업단위</div>
						<div class="filters-value">
							<select id="buId" name="buId">
								<option value=""></option>
								<c:forEach items="${buList}" var="buItem">
									<option value="${buItem.BU_ID}">${buItem.BU_NAME}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 창고명 -->
					<div class="filters-count">
						<div class="filters-text">창고명</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 🔑 직접 입력 가능 -->
							<input type="text" id="warehouseName" name="warehouseName"
								placeholder="창고명을 입력하세요">
							<!-- 🔍 팝업 버튼 -->
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openWarehousePopup()">
						</div>
					</div>
					<!-- 자산구분 -->
					<div class="filters-count">
						<div class="filters-text">자산분류</div>
						<div class="filters-value">
							<select id="assetClass" name="assetClass">
								<option value=""></option>
								<c:forEach items="${assetClassList}" var="assetItem">
									<option value="${assetItem.ASSET_CLASS}">${assetItem.ASSET_CLASS}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 대분류 -->
					<div class="filters-count">
						<div class="filters-text">품목대분류</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 🔑 직접 입력 가능 -->
							<input type="text" id="bigCategory" name="bigCategory"
								placeholder="대분류 유형을 입력하세요"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openBigCategoryPopup()">
						</div>
					</div>
					<!-- 중분류 -->
					<div class="filters-count">
						<div class="filters-text">품목중분류</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 🔑 직접 입력 가능 -->
							<input type="text" id="midCategory" name="midCategory"
								placeholder="중분류 유형을 입력하세요"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openMidCategoryPopup()">
							<!-- 🔍 팝업 버튼 -->
						</div>
					</div>
					<!-- 소분류 -->
					<div class="filters-count">
						<div class="filters-text">품목소분류</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 🔑 직접 입력 가능 -->
							<input type="text" id="smallCategory" name="smallCategory"
								placeholder="소분류 유형을 입력하세요"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openSmallCategoryPopup()">
						</div>
					</div>
					<!-- 품명 -->
					<div class="filters-count">
						<div class="filters-text">품명</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 🔑 직접 입력 가능 -->
							<input type="text" id="itemName" name="itemName"
								placeholder="품명을 입력하세요"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openItemNamePopup()">
						</div>
					</div>
					<!-- 품번 (직접 입력) -->
					<div class="filters-count">
						<div class="filters-text">품번</div>
						<div class="filters-value">
							<input type="text" id="itemId" name="itemId"
								placeholder="품번을 입력하세요">
						</div>
					</div>
				</div>
			</div>
			<!-- ✅ 결과 테이블 -->
			<div class="table-container" style="height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 150px">창고</th>
							<th style="width: 150px">창고코드</th>
							<th style="width: 150px">품목자산분류</th>
							<th style="width: 150px">품명</th>
							<th style="width: 150px">규격</th>
							<th style="width: 150px">품번</th>
							<th style="width: 150px">단위</th>
							<th style="width: 150px">입고예정</th>
							<th style="width: 150px">출고예정</th>
							<th style="width: 150px">안전재고</th>
							<th style="width: 150px">생산의뢰</th>
							<th style="width: 150px">구매발주</th>
							<th style="width: 150px">적송요청</th>
							<th style="width: 150px">기타입고요청</th>
							<th style="width: 150px">입고예정계</th>
							<th style="width: 150px">수주</th>
							<th style="width: 150px">적송요청</th>
							<th style="width: 150px">위탁출고요청</th>
							<th style="width: 150px">기타출고요청</th>
							<th style="width: 150px">출고요청계</th>
						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:forEach var="item" items="${items}">
							<tr>
								<td class="text-center">${item.warehouseName}</td>
								<td class="text-center">${item.warehouseId}</td>
								<td class="text-center">${item.assetClass}</td>
								<td class="text-center">${item.itemName}</td>
								<td class="text-center">${item.spec}</td>
								<td class="text-center">${item.itemId}</td>
								<td class="text-center">${item.baseUnit}</td>
								<td class="text-center">${item.expectedQty}</td>
								<td class="text-center">${item.expectedOutQty}</td>
								<td class="text-center">${item.safetyQty}</td>
								<td class="text-center">${item.requestQty}</td>
								<td class="text-center">${item.orderQty}</td>
								<td class="text-center">${item.transferQty}</td>
								<td class="text-center">${item.inboundQty}</td>
								<td class="text-center">${item.expectedQty}</td>
								<td class="text-center">${item.receivedQty}</td>
								<td class="text-center">${item.deliveryQty}</td>
								<td class="text-center">${item.shipmentQty}</td>
								<td class="text-center">${item.otherQty}</td>
								<td class="text-center">${item.expectedOutQty}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>

			<!-- ✅ 하단 상세 영역 -->
			<div style="display: flex; gap: 5px;">
				<!-- 입고예정 -->
				<div style="display: grid; gap: 5px; flex: 1;">
					<div class="filters">
						<div class="filters-main">
							<div class="title">입고예정</div>
							<div class="line"></div>
						</div>
					</div>
					<div class="table-container" style="height: 295px;">
						<table class="table-single-select" style="width: 100%">
							<thead>
								<tr>
									<th>입고예정일자</th>
									<th>구분</th>
									<th>입고예정수량</th>
									<th>입고ID</th>
									<th>특이사항</th>
								</tr>
							</thead>
							<tbody id="inbound-tbody"></tbody>
						</table>
					</div>
				</div>
				<!-- 출고예정 -->
				<div style="display: grid; gap: 5px; flex: 1;">
					<div class="filters">
						<div class="filters-main">
							<div class="title">출고예정</div>
							<div class="line"></div>
						</div>
					</div>
					<div class="table-container" style="height: 295px;">
						<table class="table-single-select" style="width: 100%">
							<thead>
								<tr>
									<th>출고예정일자</th>
									<th>구분</th>
									<th>출고예정수량</th>
									<th>출고ID</th>
									<th>특이사항</th>
								</tr>
							</thead>
							<tbody id="outbound-tbody"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ✅ 스크립트 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		// Ajax 조회
		function search() {
			var formData = {
				buId : document.getElementById("buId").value,
				warehouseName : document.getElementById("warehouseName").value,
				assetClass : document.getElementById("assetClass").value,
				bigCategory : document.getElementById("bigCategory").value,
				midCategory : document.getElementById("midCategory").value,
				smallCategory : document.getElementById("smallCategory").value,
				itemName : document.getElementById("itemName").value,
				itemId : document.getElementById("itemId").value
			};

			$.ajax({
				url : '/availableItems/list',
				data : formData,
				type : 'GET',
				dataType : 'json',
				success : function(result) {
					const tbody = document.getElementById("result-tbody");
					tbody.innerHTML = "";

					result.forEach(function(item) {
						const tr = document.createElement("tr");
						tr.innerHTML = "<td class='text-center'>"
								+ (item.warehouseName || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.warehouseId || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.assetClass || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.itemName || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.spec || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.itemId || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.baseUnit || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.expectedQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.expectedOutQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.safetyQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.requestQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.orderQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.transferQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.inboundQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.expectedQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.receivedQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.deliveryQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.shipmentQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.otherQty || '') + "</td>"
								+ "<td class='text-center'>"
								+ (item.expectedOutQty || '') + "</td>";

						tbody.appendChild(tr);
					});
				}
			});
		}

		// 창고 검색 팝업 열기
		function openWarehousePopup() {
			window.open("/availableItems/warehouseSearch",
					"warehouseSearchPopup",
					"width=600,height=500,scrollbars=yes,resizable=yes");
		}

		// 팝업에서 선택한 값 반영
		function setWarehouseName(name) {
			document.getElementById("warehouseName").value = name;
		}

		function openBigCategoryPopup() {
			window.open("/availableItems/bigCategorySearch",
					"bigCategorySearchPopup",
					"width=600,height=500,scrollbars=yes,resizable=yes");
		}

		function setBigCategory(name) {
			document.getElementById("bigCategory").value = name;
		}

		function openMidCategoryPopup() {
			window.open("/availableItems/midCategorySearch",
					"midCategorySearchPopup",
					"width=600,height=500,scrollbars=yes,resizable=yes");
		}

		function setMidCategory(name) {
			document.getElementById("midCategory").value = name;
		}

		function openSmallCategoryPopup() {
			window.open("/availableItems/smallCategorySearch", // ✅ availableItems 붙여야 함
			"smallCategorySearchPopup",
					"width=600,height=500,scrollbars=yes,resizable=yes");
		}

		function setSmallCategory(name) {
			document.getElementById("smallCategory").value = name;
		}

		function openItemNamePopup() {
			window.open("/availableItems/itemNameSearch", // ✅ availableItems 붙여야 함
			"itemNameSearchPopup",
					"width=600,height=500,scrollbars=yes,resizable=yes");
		}

		function setItemName(name) {
			document.getElementById("itemName").value = name;
		}

		// ✅ 행 더블클릭 시 상세 조회
		$("#result-tbody").on("dblclick", "tr", function() {
			const itemId = $(this).find("td").eq(5).text().trim(); // 품번
			const warehouseId = $(this).find("td").eq(1).text().trim(); // 창고코드
			if (itemId && warehouseId) {
				loadInbound(itemId, warehouseId);
				loadOutbound(itemId, warehouseId);
			}
		});

		// ✅ 입고예정 조회 (item_Search 방식)
		function loadInbound(itemId, warehouseId) {
			$.ajax({
				url : "/inbound/list",
				type : "GET",
				data : {
					itemId : itemId,
					warehouseId : warehouseId
				},
				dataType : "json",
				success : function(result) {
					const tbody = document.getElementById("inbound-tbody");
					tbody.innerHTML = ""; // 기존 내용 초기화

					// 항상 3개의 빈 로우 확보
					const totalRows = result.length + 3;

					// 결과 데이터 표시
					result.forEach(function(row) {
						const dateStr = row.inboundDate ? new Date(
								row.inboundDate).toISOString().slice(0, 10)
								: '';

						const tr = document.createElement("tr");
						tr.innerHTML = '<td class="text-center">' + dateStr
								+ '</td>' + '<td class="text-center">'
								+ (row.inboundType || '') + '</td>'
								+ '<td class="text-center">'
								+ (row.inboundQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (row.inboundDetailId || '') + '</td>'
								+ '<td class="text-center">' + (row.note || '')
								+ '</td>';

						tbody.appendChild(tr);
					});

					// 빈 로우 채우기
					const emptyRows = totalRows - result.length;
					for (let i = 0; i < emptyRows; i++) {
						const tr = document.createElement("tr");
						tr.innerHTML = '<td class="text-center">&nbsp;</td>'
								.repeat(5);
						tbody.appendChild(tr);
					}
				},
				error : function() {
					alert("입고예정 데이터를 불러오는데 실패했습니다.");
				}
			});
		}

		// ✅ 출고예정 조회 (item_Search 방식)
		function loadOutbound(itemId, warehouseId) {
			$.ajax({
				url : "/outbound/list",
				type : "GET",
				data : {
					itemId : itemId,
					warehouseId : warehouseId
				},
				dataType : "json",
				success : function(result) {
					const tbody = document.getElementById("outbound-tbody");
					tbody.innerHTML = ""; // 기존 내용 초기화

					const totalRows = result.length + 3;

					result.forEach(function(row) {
						const dateStr = row.outboundDate ? new Date(
								row.outboundDate).toISOString().slice(0, 10)
								: '';

						const tr = document.createElement("tr");
						tr.innerHTML = '<td class="text-center">' + dateStr
								+ '</td>' + '<td class="text-center">'
								+ (row.outboundType || '') + '</td>'
								+ '<td class="text-center">'
								+ (row.outboundQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (row.outboundDetailId || '') + '</td>'
								+ '<td class="text-center">' + (row.note || '')
								+ '</td>';

						tbody.appendChild(tr);
					});

					const emptyRows = totalRows - result.length;
					for (let i = 0; i < emptyRows; i++) {
						const tr = document.createElement("tr");
						tr.innerHTML = '<td class="text-center">&nbsp;</td>'
								.repeat(5);
						tbody.appendChild(tr);
					}
				},
				error : function() {
					alert("출고예정 데이터를 불러오는데 실패했습니다.");
				}
			});
		}
	</script>
</body>
</html>
