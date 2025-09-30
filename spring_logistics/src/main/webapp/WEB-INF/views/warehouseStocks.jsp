<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고별 재고조회</title>
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
					<h1>창고별 재고 조회하기</h1>
				</div>
				<div>
					<button class="btn btn-secondary" onclick="doSearch()">조회</button>
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
					<div class="filters-count">
						<div class="filters-text">재고기준</div>
						<div class="filters-value">
							<select id="criteria" name="criteria">
								<option value="actual" ${criteria eq 'actual' ? 'selected' : ''}>실재고</option>
								<option value="available"
									${criteria eq 'available' ? 'selected' : ''}>가용재고</option>
								<option value="asset" ${criteria eq 'asset' ? 'selected' : ''}>자산재고</option>
							</select>
						</div>
					</div>

					<!-- 창고명 -->
					<div class="filters-count">
						<div class="filters-text">창고</div>
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
					<div class="filters-count">
						<div class="filters-text">규격</div>
						<div class="filters-value">
							<select id="spec" name="spec">
								<option value=""></option>
								<c:forEach items="${specList}" var="spec">
									<option value="${spec.SPEC}">${spec.SPEC}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">중요도</div>
						<div class="filters-value">
							<select id="importanceLevel" name="importanceLevel">
								<option value=""></option>
								<c:forEach items="${importanceLevelList}" var="importanceLevel">
									<option value="${importanceLevel.IMPORTANCE_LEVEL}">${importanceLevel.IMPORTANCE_LEVEL}</option>
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
							<th style="width: 120px;">품목자산분류</th>
							<th style="width: 200px;">품명</th>
							<th style="width: 120px;">규격</th>
							<th style="width: 120px;">품번</th>
							<th style="width: 80px;">단위</th>
							<th style="width: 150px;">품목대분류</th>
							<th style="width: 150px;">품목중분류</th>
							<th style="width: 150px;">품목소분류</th>
							<th style="width: 100px;">중요도</th>
							<th style="width: 180px;">창고명</th>
							<th style="width: 120px;">재고수량</th>
						</tr>
					</thead>

					<tbody id="result-tbody">
						<c:forEach var="item" items="${items}">
							<tr>
								<td class="text-center">${item.assetClass}</td>
								<td class="text-center">${item.itemName}</td>
								<td class="text-center">${item.spec}</td>
								<td class="text-center">${item.itemId}</td>
								<td class="text-center">${item.baseUnit}</td>
								<td class="text-center">${item.bigCategory}</td>
								<td class="text-center">${item.midCategory}</td>
								<td class="text-center">${item.smallCategory}</td>
								<td class="text-center">${item.importanceLevel}</td>
								<td class="text-center">${item.warehouseName}</td>
								<td class="text-center">${item.stockQty}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>


			<script>
			function doSearch() {
			    var formData = {
			        buId : $("#buId").val(),
			        warehouseName : $("#warehouseName").val(),
			        assetClass : $("#assetClass").val(),
			        criteria: $("#criteria").val()
			    };

			    $.ajax({
			        url : '/warehouseStocks/list',
			        data : formData,
			        type : 'GET',
			        dataType : 'json',
			        cache : false,
			        success : function(result) {
			            console.log(result); // JSON 확인용

			            const tbody = $("#result-tbody");
			            tbody.empty();

			            result.forEach(function(item) {
			                const tr = `
			                    <tr>
			                        <td class="text-center">\${item.assetClass || ''}</td>
			                        <td class="text-center">\${item.itemName || ''}</td>
			                        <td class="text-center">\${item.spec || ''}</td>
			                        <td class="text-center">\${item.itemId || ''}</td>
			                        <td class="text-center">\${item.baseUnit || ''}</td>
			                        <td class="text-center">\${item.bigCategory || ''}</td>
			                        <td class="text-center">\${item.midCategory || ''}</td>
			                        <td class="text-center">\${item.smallCategory || ''}</td>
			                        <td class="text-center">\${item.importanceLevel || ''}</td>
			                        <td class="text-center">\${item.warehouseName || ''}</td>
			                        <td class="text-center">\${item.stockQty != null ? item.stockQty : 0}</td>
			                    </tr>`;
			                tbody.append(tr);
			            });
			        }
			    });
			}



				// 창고 검색 팝업 열기
				function openWarehousePopup() {
					window
							.open("/warehouseStocks/warehouseSearch",
									"warehouseSearchPopup",
									"width=600,height=500,scrollbars=yes,resizable=yes");
				}

				// 팝업에서 선택한 값 반영
				function setWarehouseName(name) {
					document.getElementById("warehouseName").value = name;
				}

				function openBigCategoryPopup() {
					window
							.open("/warehouseStocks/bigCategorySearch",
									"bigCategorySearchPopup",
									"width=600,height=500,scrollbars=yes,resizable=yes");
				}

				function setBigCategory(name) {
					document.getElementById("bigCategory").value = name;
				}

				function openMidCategoryPopup() {
					window
							.open("/warehouseStocks/midCategorySearch",
									"midCategorySearchPopup",
									"width=600,height=500,scrollbars=yes,resizable=yes");
				}

				function setMidCategory(name) {
					document.getElementById("midCategory").value = name;
				}

				function openSmallCategoryPopup() {
					window
							.open("/warehouseStocks/smallCategorySearch",
									"smallCategorySearchPopup",
									"width=600,height=500,scrollbars=yes,resizable=yes");
				}

				function setSmallCategory(name) {
					document.getElementById("smallCategory").value = name;
				}

				function openItemNamePopup() {
					window
							.open("/warehouseStocks/itemNameSearch",
									"itemNameSearchPopup",
									"width=600,height=500,scrollbars=yes,resizable=yes");
				}

				function setItemName(name) {
					document.getElementById("itemName").value = name;
				}
			</script>
</body>
</html>
