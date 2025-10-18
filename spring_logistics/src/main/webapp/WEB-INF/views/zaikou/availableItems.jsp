<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>可用在庫照会</title>
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
		<%@ include file="/WEB-INF/views/logistics.jsp"%>
		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>可用在庫照会</h1>
				</div>
				<div>
					<button class="btn btn-secondary" onclick="searchAvailable()">照会</button>
				</div>
			</div>

			<!-- 검색기능(検索機能） -->
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

			<div class="table-container" style="height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 150px">倉庫</th>
							<th style="width: 150px">倉庫コード</th>
							<th style="width: 150px">品目資産分類</th>
							<th style="width: 150px">品名</th>
							<th style="width: 150px">規格</th>
							<th style="width: 150px">品番</th>
							<th style="width: 150px">単位</th>
							<th style="width: 150px">安全在庫</th>
							<th style="width: 150px">有効在庫</th>
							<th style="width: 150px">入庫予定</th>
							<th style="width: 150px">出庫予定</th>
							<th style="width: 150px">生産依頼</th>
							<th style="width: 150px">購買発注</th>
							<th style="width: 150px">積送依頼</th>
							<th style="width: 150px">その他入庫依頼</th>
							<th style="width: 150px">入庫予定計</th>
							<th style="width: 150px">受注</th>
							<th style="width: 150px">積送依頼</th>
							<th style="width: 150px">委託出庫依頼</th>
							<th style="width: 150px">その他出庫依頼</th>
							<th style="width: 150px">出庫依頼計</th>

						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:forEach var="item" items="${items}">
							<tr onclick="row_Click(this)">
								<td class="text-center">${item.warehouseName}</td>
								<td class="text-center">${item.warehouseId}</td>
								<td class="text-center">${item.assetClass}</td>
								<td class="text-center">${item.itemName}</td>
								<td class="text-center">${item.spec}</td>
								<td class="text-center">${item.itemId}</td>
								<td class="text-center">${item.baseUnit}</td>
								<td class="text-center">${item.safetyQty}</td>
								<td class="text-center">${item.availableQty}</td>
								<td class="text-center">${item.expectedQty}</td>
								<td class="text-center">${item.expectedOutQty}</td>
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

			<!-- 詳細エリア -->
			<div style="display: flex; gap: 5px;">
				<!-- 入庫予定 -->
				<div style="display: grid; gap: 5px; flex: 1;">
					<div class="filters">
						<div class="filters-main">
							<div class="title">入庫予定</div>
							<div class="line"></div>
						</div>
					</div>
					<div class="table-container" style="height: 295px;">
						<table class="table-single-select" style="width: 100%">
							<thead>
								<tr>
									<th>入庫予定日</th>
									<th>区分</th>
									<th>入庫予定数量</th>
									<th>入庫ID</th>
									<th>特記事項</th>

								</tr>
							</thead>
							<tbody id="inbound-tbody"></tbody>
						</table>
					</div>
				</div>
				<!-- 出庫予定 -->
				<div style="display: grid; gap: 5px; flex: 1;">
					<div class="filters">
						<div class="filters-main">
							<div class="title">出庫予定</div>
							<div class="line"></div>
						</div>
					</div>
					<div class="table-container" style="height: 295px;">
						<table class="table-single-select" style="width: 100%">
							<thead>
								<tr>
									<th>出庫予定日</th>
									<th>区分</th>
									<th>出庫予定数量</th>
									<th>出庫ID</th>
									<th>特記事項</th>

								</tr>
							</thead>
							<tbody id="outbound-tbody"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../resources/js/logistics.js"></script>

	<script>
		(function() {
			const tbody = document.querySelector('#result-tbody');
			if (!tbody)
				return;

			let selectedRow = null;
			tbody.addEventListener('click', function(e) {
				const tr = e.target.closest('tr');
				if (!tr)
					return;

				if (selectedRow)
					selectedRow.classList.remove('tr-selected');
				tr.classList.add('tr-selected');
				selectedRow = tr;
			});
		})();

		// =============================
		// 가용재고조회 (可用在庫照会)
		// =============================
		function searchAvailable() {
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
				url : '/warehouse/availableList',
				data : formData,
				type : 'GET',
				dataType : 'json',
				success : function(result) {
					const tbody = document.getElementById("result-tbody");
					tbody.innerHTML = "";

					result.forEach(function(item) {
						const tr = document.createElement("tr");
						tr.innerHTML = '<td class="text-center">'
								+ (item.warehouseName || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.warehouseId || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.assetClass || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.itemName || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.spec || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.itemId || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.baseUnit || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.safetyQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.availableQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.expectedQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.expectedOutQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.requestQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.orderQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.transferQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.inboundQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.expectedQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.receivedQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.deliveryQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.shipmentQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.otherQty || '') + '</td>'
								+ '<td class="text-center">'
								+ (item.expectedOutQty || '') + '</td>';

						tr.onclick = function() {
							row_Click(this);
						}
						tbody.appendChild(tr);
					});

					document.getElementById("inbound-tbody").innerHTML = "";
					document.getElementById("outbound-tbody").innerHTML = "";
				},
				error : function(xhr, status, error) {
					console.error("エラーが発生しました。", error);
				}
			});
		}

		// =============================
		// 행 클릭시 상세조회 (行クリック → 詳細照会)
		// =============================
		function row_Click(row) {

			console.log(row);

			const data = Array.from(row.cells).map(function(td) {
				const hidden = td.querySelector('input[type=hidden]');
				return hidden ? hidden.value : td.textContent.trim();
			});

			const warehouseId = data[1]; // hidden에 넣은 warehouseId (hiddenに入れたwarehouseId)
			const itemId = data[5]; // 품번 (6번째 열)　＝品番（6列目）

			if (warehouseId && itemId) {
				loadInbound(itemId, warehouseId);
				loadOutbound(itemId, warehouseId);
			}
		}

		// =============================
		// 입고예정조회 (入庫予定照会)
		// =============================
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
					tbody.innerHTML = "";
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
				}

			});
		}

		// =============================
		// 출고예정조회(出庫予定照会)
		// =============================
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
					tbody.innerHTML = "";

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

				}
			});
		}

		// =============================
		// 팝업 (ポップアップ)
		// =============================
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

		//팝업에서 선택된 행 데이터가 부모창으로 넘어올 때 호출되는 콜백
		//ポップアップで選択した行データが親画面へ渡される際のコールバック
		function item_RowData(data) {
			let targetId = "bigCategory";

			if (data.length === 7) {
				targetId = "itemName";
			} else if (data.length === 2) {
				targetId = "bigCategory";
			} else if (data.length === 3) {
				targetId = "midCategory";
			} else if (data.length === 4) {
				targetId = "warehouseName";
			} else if (data.length === 5) {
				targetId = "warehouseName";
			}

			if (targetId === "itemName") {
				const itemIdInput = document.getElementById("itemId");
				const itemNameInput = document.getElementById("itemName");

				if (itemIdInput && itemNameInput) {
					itemIdInput.value = data[0];
					itemNameInput.value = data[2]; 
				}

				searchAvailable();
				return;
			}

			let textValue = "";
			if (targetId === "warehouseName") {
				textValue = data[0]; 
			} else if (targetId === "smallCategory") {
				textValue = data[3] || data[0];
			} else if (targetId === "midCategory") {
				textValue = data[2];
			} else {
				textValue = data[1] || data[0];
			}

			const inputEl = document.getElementById(targetId);
			if (inputEl) {
				inputEl.value = textValue;
			}

			searchAvailable();
		}
		
		document.getElementById("itemId").addEventListener("input", function() {
		    document.getElementById("itemName").value = "";
		});
		
	</script>
</body>
</html>



</body>
</html>
