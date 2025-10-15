<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>倉庫別在庫照会</title>
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
		<%@ include file="/WEB-INF/views/logistics.jsp" %>
		<!-- ✅ 메인 -->
		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>倉庫別在庫照会</h1>
				</div>
				<div>
					<button class="btn btn-secondary" onclick="doSearch()">照会</button>
				</div>
			</div>

			<!-- ✅ 조회 조건 -->
			<div class="filters">
				<div class="filters-main">
					<div class="title">検索条件</div>
					<div class="line"></div>
				</div>
				<div class="filters-row">
					<!-- 事業単位 -->
						<div class="filters-count">
						<div class="filters-text">事業単位</div>
						<div class="filters-value">
							<select id="buId" name="buId">
							<option value=""></option>
								<c:forEach items="${buList}" var="bu">
									<option value="${bu.buId}">${bu.buName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">在庫基準</div>
						<div class="filters-value">
							<select id="criteria" name="criteria">
								<option value="actual" ${criteria eq 'actual' ? 'selected' : ''}>実在庫</option>
								<option value="available"
									${criteria eq 'available' ? 'selected' : ''}>利用可能在庫</option>
								<option value="asset" ${criteria eq 'asset' ? 'selected' : ''}>資産在庫</option>
							</select>
						</div>
					</div>

					<!-- 倉庫名 -->
					<div class="filters-count">
						<div class="filters-text">倉庫名</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 直接入力可能 -->
							<input type="text" id="warehouseName" name="warehouseName">
							<!-- 参照ボタン -->
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openWarehousePopup()">
						</div>
					</div>
						<!-- 資産区分 -->
					<div class="filters-count">
						<div class="filters-text">資産区分</div>
						<div class="filters-value">
							<select id="assetClass" name="assetClass">
								<option value=""></option>
								<c:forEach items="${assetClassList}" var="asset">
									<option value="${asset.assetClass}">${asset.assetClass}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">規格</div>
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
						<div class="filters-text">重要度</div>
						<div class="filters-value">
							<select id="importanceLevel" name="importanceLevel">
								<option value=""></option>
								<c:forEach items="${importanceLevelList}" var="importanceLevel">
									<option value="${importanceLevel.importanceLevel}">${importanceLevel.importanceLevel}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 品目大分類 -->
					<div class="filters-count">
						<div class="filters-text">品目大分類</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 直接入力可能 -->
							<input type="text" id="bigCategory" name="bigCategory"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openBigCategoryPopup()">
						</div>
					</div>
					<!-- 品目中分類 -->
					<div class="filters-count">
						<div class="filters-text">品目中分類</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 直接入力可能 -->
							<input type="text" id="midCategory" name="midCategory"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openMidCategoryPopup()">

						</div>
					</div>
					<!-- 品目小分類 -->
					<div class="filters-count">
						<div class="filters-text">品目小分類</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 直接入力可能 -->
							<input type="text" id="smallCategory" name="smallCategory">
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon"
								onclick="openSmallCategoryPopup()">
						</div>
					</div>
					<!-- 品名 -->
					<div class="filters-count">
						<div class="filters-text">品名</div>
						<div class="filters-value d-flex align-items-center">
							<!-- 直接入力可能 -->
							<input type="text" id="itemName" name="itemName" placeholder="">
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openItemNamePopup()">
						</div>
					</div>
					<!-- 品番 (直接入力) -->
					<div class="filters-count">
						<div class="filters-text">品番</div>
						<div class="filters-value">
							<input type="text" id="itemId" name="itemId">
						</div>
					</div>
				</div>
			</div>
			
			<div class="table-container">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 120px;">品目資産分類</th>
							<th style="width: 200px;">品名</th>
							<th style="width: 120px;">規格</th>
							<th style="width: 120px;">品番</th>
							<th style="width: 80px;">単位</th>
							<th style="width: 150px;">品目大分類</th>
							<th style="width: 150px;">品目中分類</th>
							<th style="width: 150px;">品目小分類</th>
							<th style="width: 100px;">重要度</th>
							<th style="width: 180px;">倉庫名</th>
							<th style="width: 120px;">在庫数量</th>
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
				        buId: $("#buId").val(),
				        criteria: $("#criteria").val(),
				        warehouseName: $("#warehouseName").val(),
				        assetClass: $("#assetClass").val(),
				        spec: $("#spec").val(),
				        importanceLevel: $("#importanceLevel").val(),
				        bigCategory: $("#bigCategory").val(),
				        midCategory: $("#midCategory").val(),
				        smallCategory: $("#smallCategory").val(),
				        itemName: $("#itemName").val(),
				        itemId: $("#itemId").val()
				    };

			    $.ajax({
			        url : '/warehouse/stockList',
			        data : formData,
			        type : 'GET',
			        dataType : 'json',
			        cache : false,
			        success : function(result) {

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


			function openPopup(url) {
				var popupWidth = 900, popupHeight = 600;
				var left = (screen.width - popupWidth) / 2;
				var top = (screen.height - popupHeight) / 2;

				window.open(url, "popupWindow", "width=" + popupWidth + ",height="
						+ popupHeight + ",left=" + left + ",top=" + top
						+ ",scrollbars=yes,resizable=yes");
			}

			function openWarehousePopup() {
				openPopup("/popup/warehouse_popup");
			}
			function openBigCategoryPopup() {
				openPopup("/popup/category_popup_big");
			}
			function openMidCategoryPopup() {
				openPopup("/popup/category_popup_mid");
			}
			function openSmallCategoryPopup() {
				openPopup("/popup/category_popup_small");
			}
			function openItemNamePopup() {
				openPopup("/popup/item_name_popup");
			}

			
			function item_RowData(data) {
				let targetId = "bigCategory";

				if (data.length === 7) {
					targetId = "itemName";
				} else if (data.length === 2) {
					targetId = "bigCategory";
				} else if (data.length === 3) {
					targetId = "midCategory";
				} else if (data.length === 4) {
					if (/^[A-Za-z]*\d+$/.test(data[1])) {
						targetId = "warehouseName";
					} else {
						targetId = "smallCategory";
					}
				} else if (data.length === 5) {
					targetId = "warehouseName";
				}

				let textValue = "";

				if (targetId === "itemName") {
					textValue = data[2];
				} else if (targetId === "warehouseName") {
					textValue = data[0]; //
				} else if (targetId === "smallCategory") {
					textValue = data[3] || data[0]; // 
				} else if (targetId === "midCategory") {
					textValue = data[2];
				} else {
					textValue = data[1] || data[0];
				}

				const inputEl = document.getElementById(targetId);
				if (inputEl) {
					inputEl.value = textValue;
				}
				
				doSearch();
			}
			</script>
</body>
</html>
