<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수주입력 - 팜스프링 ERP</title>
<link rel="stylesheet" href="/resources/css/logistics.css"
	type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<style>
/* ✅ 테이블 가로 스크롤 문제 해결 / テーブル横スクロール対応 */
.table-container {
	overflow-x: auto; /* 가로 스크롤 허용 / 横スクロールを許可 */
	overflow-y: auto; /* 세로 스크롤도 유지 / 縦スクロールも維持 */
}

.table-container table {
	width: max-content; /* 내용에 따라 폭 자동 조정 / 内容に応じて幅を自動調整 */
	min-width: 100%; /* 최소한 컨테이너 폭은 유지 / コンテナ幅を最低限維持 */
	table-layout: auto; /* 자동 폭 계산 / 自動レイアウト */
}

</style>

</head>
<body>
	<div class="layout">
			<%@ include file="/WEB-INF/views/logistics.jsp" %>
		<div class="main">
			<div class="main-header">
				<!-- 🇯🇵 タイトルバー 영역 / 🇰🇷 상단 헤더 -->
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>
						受注入力
						<!-- 수주입력 -->
					</h1>
				</div>
				<div>
					<!-- 버튼들: 조회 / 저장 / 삭제 / 단가적용 -->
					<button class="btn btn-secondary search-btn" id="search"
						onclick="searchOrders()">
						照会
						<!-- 조회 -->
					</button>
					<button class="btn btn-secondary search-btn" id="save"
						onclick="save_inBound()">
						保存
						<!-- 저장 -->
					</button>
					<button class="btn btn-secondary search-btn" id="delete"
						onclick="delete_inBound()">
						削除
						<!-- 삭제 -->
					</button>
					<button class="btn btn-secondary search-btn" id="applyPrice"
						onclick="applyUnitPrice()">
						単価適用
						<!-- 단가적용 -->
					</button>
				</div>
			</div>
			<!-- ============================== -->
			<!-- 🇯🇵 基本情報 / 🇰🇷 기본정보 영역 -->
			<!-- ============================== -->
			<div class="filters">
				<div class="filters-main">
					<div class="title">
						基本情報
						<!-- 기본정보 -->
					</div>
					<div class="line"></div>
				</div>

				<div class="filters-row">
					<!-- 사업단위 -->
					<div class="filters-count">
						<div class="filters-text">
							事業単位
							<!-- 사업단위 -->
						</div>
						<div class="filters-value">
							<select id="buId" name="buId">
								<option value=""></option>
								<c:forEach var="bu" items="${buList}">
									<option value="${bu.buId}">${bu.buName}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 수주일 -->
					<div class="filters-count">
						<div class="filters-text">
							受注日
							<!-- 수주일 -->
						</div>
						<div class="filters-value">
							<input type="date" name="createdAt">
						</div>
					</div>

					<!-- 수주번호 -->
					<div class="filters-count">
						<div class="filters-text">
							受注番号
							<!-- 수주번호 -->
						</div>
						<div class="filters-value">
							<input type="text" id="orderId" name="orderId"
								>
							<!-- 수주번호 선택 -->
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openInboundPopup()">
						</div>
					</div>

					<!-- Local 구분 -->
					<div class="filters-count">
						<div class="filters-text">
							ローカル区分
							<!-- Local구분 -->
						</div>
						<div class="filters-value">
							<select name="localFlag">
								<option value=""></option>
								<option value="내수">内需
									<!-- 내수 --></option>
								<option value="Local(전LC)">Local(後LC)
									<!-- Local(후LC) --></option>
								<option value="Local(후LC)">Local(前LC)
									<!-- Local(전LC) --></option>
							</select>
						</div>
					</div>

					<!-- 수주구분 -->
					<div class="filters-count">
						<div class="filters-text">
							受注区分
							<!-- 수주구분 -->
						</div>
						<div class="filters-value">
							<select name="inboundType">
								<option value=""></option>
								<option value="구매요청">購買依頼
									<!-- 구매요청 --></option>
								<option value="생산의뢰">生産依頼
									<!-- 생산의뢰 --></option>
								<option value="거래명세서">取引明細書
									<!-- 거래명세서 --></option>
							</select>
						</div>
					</div>

					<!-- 납기일 -->
					<div class="filters-count">
						<div class="filters-text">
							納期日
							<!-- 납기일 -->
						</div>
						<div class="filters-value">
							<input type="date" name="inboundDate">
						</div>
					</div>

					<!-- 담당자 -->
					<div class="filters-count">
						<div class="filters-text">
							担当者
							<!-- 담당자 -->
						</div>
						<div class="filters-value">
							<input type="text" name="contactName">
							<!-- 담당자 선택 -->
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openContactPopup()">
						</div>
					</div>

					<!-- 부서 -->
					<div class="filters-count">
						<div class="filters-text">
							部署
							<!-- 부서 -->
						</div>
						<div class="filters-value">
							<input type="text" name="department">
							<!-- 부서 선택 -->
<!-- 							<img -->
<!-- 								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" -->
<!-- 								alt="search" class="search-icon" onclick=""> -->
						</div>
					</div>

					<!-- 거래처 -->
					<div class="filters-count">
						<div class="filters-text">
							取引先
							<!-- 거래처 -->
						</div>
						<div class="filters-value">
							<input type="text" name="partyName">
							<!-- 거래처 선택 -->
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openPartyPopup()">
						</div>
					</div>

					<!-- 거래처번호 -->
					<div class="filters-count">
						<div class="filters-text">
							取引先番号
							<!-- 거래처번호 -->
						</div>
						<div class="filters-value">
							<input type="text" name="partyId">
							<!-- 거래처 번호 -->
<!-- 							<img -->
<!-- 								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" -->
<!-- 								alt="search" class="search-icon" onclick=""> -->
						</div>
					</div>
				</div>
			</div>

			<!-- ============================== -->
			<!-- 🇯🇵 追加情報 / 🇰🇷 추가정보 영역 -->
			<!-- ============================== -->
			<div class="filters">
				<div class="filters-main">
					<div class="title">
						追加情報
						<!-- 추가정보 -->
					</div>
					<div class="line"></div>
				</div>

				<div class="filters-row">
					<!-- 통화 -->
					<div class="filters-count">
						<div class="filters-text">
							通貨
							<!-- 통화 -->
						</div>
						<div class="filters-value">
							<select id="currencyCode" name="currencyCode"
								onchange="loadExchangeRate()">
								<option value=""></option>
								<c:forEach items="${currencyList}" var="cItem">
									<option value="${cItem}">${cItem}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 판매가계액 -->
					<div class="filters-count">
						<div class="filters-text">
							販売価計額
							<!-- 판매가계액 -->
						</div>
						<div class="filters-value">
							<input type="text" name="salesTotal" value="0" readonly>
						</div>
					</div>

					<!-- 부가세계 -->
					<div class="filters-count">
						<div class="filters-text">
							付加税額
							<!-- 부가세계 -->
						</div>
						<div class="filters-value">
							<input type="text" name="vatTotal" value="0" readonly>
						</div>
					</div>

					<!-- 총액 -->
					<div class="filters-count">
						<div class="filters-text">
							総額
							<!-- 총액 -->
						</div>
						<div class="filters-value">
							<input type="text" name="grandTotal" value="0" readonly>
						</div>
					</div>

					<!-- 환율 -->
					<div class="filters-count">
						<div class="filters-text">
							為替レート
							<!-- 환율 -->
						</div>
						<div class="filters-value">
							<input type="number" step="0.01" name="exchangeRate" value="1.00">
						</div>
					</div>

					<!-- 할인율 -->
					<div class="filters-count">
						<div class="filters-text">
							割引率
							<!-- 할인율 -->
						</div>
						<div class="filters-value">
							<input type="number" step="0.1" name="discountRate" value="0">
							<span>%</span>
						</div>
					</div>
				</div>
			</div>

			<!-- =============================================================== -->
			<!-- 📋 テーブル領域 / 테이블 영역 -->
			<!-- =============================================================== -->

			<div class="table-container">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 140px">品名<!-- 품명 --></th>
							<th style="width: 120px">品番<!-- 품번 --></th>
							<th style="width: 120px">規格<!-- 규격 --></th>
							<th style="width: 90px">付加税含む<!-- 부가세포함 --></th>
							<th style="width: 100px">販売単価<!-- 판매단가 --></th>
							<th style="width: 90px">数量<!-- 수량 --></th>
							<th style="width: 90px">販売単位<!-- 판매단위 --></th>
							<th style="width: 120px">販売金額<!-- 판매금액 --></th>
							<th style="width: 100px">付加税<!-- 부가세 --></th>
							<th style="width: 120px">ウォン販売金額<!-- 원화판매금액 --></th>
							<th style="width: 120px">ウォン付加税<!-- 원화부가세 --></th>
							<th style="width: 140px">納品取引先<!-- 납품거래처 --></th>
							<th style="width: 120px">納期日<!-- 납기일 --></th>
							<th style="width: 150px">特記事項<!-- 특이사항 --></th>
							<th style="width: 120px">倉庫<!-- 창고 --></th>
							<th style="width: 90px">入庫完了<!-- 입고완료 --></th>
						</tr>
					</thead>


					<tbody id="result-tbody">
						<!-- 🔁 JSTL 반복문で受注詳細を出力 / 수주 상세 반복 출력 -->
						<c:forEach items="${orderList}" var="order">
							<tr onclick="row_Click(this)">
								<td class="text-center"><c:out value="${order.itemName}" /></td>
								<td class="text-center"><c:out value="${order.itemId}" /></td>
								<td class="text-center"><c:out value="${order.spec}" /></td>


								<!-- 💰 単価・数量などの数値列 / 단가, 수량 등 숫자 컬럼 -->
								<td class="text-center"><fmt:formatNumber
										value="${order.unitPrice}" type="number" /></td>
								<td class="text-center"><fmt:formatNumber
										value="${order.qty}" type="number" /></td>
								<td><c:out value="${order.baseUnit}" /></td>
								<td class="text-center"><fmt:formatNumber
										value="${order.amount}" type="number" /></td>
								<td class="text-center"><fmt:formatNumber
										value="${order.vat}" type="number" /></td>
								<td class="text-center"><fmt:formatNumber
										value="${order.krwAmount}" type="number" /></td>
								<td class="text-center"><fmt:formatNumber
										value="${order.krwVat}" type="number" /></td>
								<td class="text-center"><c:out value="${order.partyName}" /></td>
								<td><fmt:formatDate value="${order.inboundDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:out value="${order.note}" /></td>
								<td><c:out value="${order.warehouseName}" /></td>

								<!-- ✅ チェックボックス / 체크박스 -->
							<tr>
								...
								<td class="text-center"><input type="checkbox"
									name="surtaxYn"
									<c:if test="${order.surtaxYn == 'Y'}">checked</c:if> /></td> ...
								<td class="text-center"><input type="checkbox"
									name="inboundComplete"
									<c:if test="${order.inboundComplete == 'Y'}">checked</c:if> />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="../resources/js/logistics.js"></script>

<script>
	(function() {
	    const tbody = document.querySelector('.table-single-select tbody');
	    if (!tbody) return;
	
	    let selectedRow = null;
	
	    tbody.addEventListener('click', function(e) {
	        const tr = e.target.closest('tr');
	        if (!tr) return;

	        if (selectedRow) selectedRow.classList.remove('tr-selected');
	
	        tr.classList.add('tr-selected');
	        selectedRow = tr;
	    });
	})();
	
	
		// ✅ 검색 조회
		function searchOrders() {
			var formData = {
				buId : $("#buId").val(),
				inboundType : $("[name=inboundType]").val(),
				localFlag : $("[name=localFlag]").val()
			};

			$.ajax({
				url : '/order/search',
				data : formData,
				type : 'GET',
				dataType : 'json',
				success : function(result) {
					console.log("검색 결과:", result);

					var allDetails = [];
					$.each(result, function(i, order) {
						if (order.details) {
							$.each(order.details, function(j, d) {
								allDetails.push({
									itemName : d.itemName || '',
									itemId : d.itemId || '',
									spec : d.spec || '',
									surtaxYn : d.surtaxYn || 'N',
									unitPrice : d.unitPrice || 0,
									qty : d.qty || 0,
									baseUnit : d.baseUnit || '',
									amount : d.amount || 0,
									vat : d.vat || 0,
									krwAmount : d.krwAmount || 0,
									krwVat : d.krwVat || 0,
									partyName : order.partyName || '',
									inboundDate : d.inboundDate || '',
									note : d.note || '',
									warehouseName : d.warehouseName || '',
									inboundComplete : d.inboundComplete || 'N'
								});
							});
						}
					});

					renderTable(allDetails);
				},
				error : function(err) {
					console.error("검색 에러:", err);
					alert("조회 실패: " + err.statusText);
				}
			});
		}

		// ✅ 테이블 렌더링
		function renderTable(dataList) {
			var tbody = $("#result-tbody");
			tbody.empty(); // 기존 데이터 제거

			if (!dataList || dataList.length === 0) {
				tbody
						.append("<tr><td colspan='16' class='text-center'></td></tr>");
				return;
			}

			$
					.each(
							dataList,
							function(i, row) {
								var tr = $("<tr>");

								tr.append("<td>" + (row.itemName || '')
										+ "</td>");
								tr
										.append("<td>" + (row.itemId || '')
												+ "</td>");
								tr.append("<td>" + (row.spec || '') + "</td>");
								}
		}
	</script>

<script>
//✅ ポップアップを開く / 팝업 열기
function openInboundPopup() {
    var width = 900;    // 팝업 가로 크기
    var height = 600;   // 팝업 세로 크기

    // 현재 브라우저 창 기준 중앙 좌표 계산
    var left = (window.innerWidth - width) / 2 + window.screenX;
    var top = (window.innerHeight - height) / 2 + window.screenY;

    // 팝업 열기
    window.open(
        "/popup/inbound_popup",
        "inboundPopup",
        "width=" + width +
        ",height=" + height +
        ",left=" + left +
        ",top=" + top +
        ",scrollbars=yes,resizable=yes"
    );
}


//✅ ポップアップから親画面に値を渡す / 팝업에서 부모창으로 값 전달
function inbound_RowData(data) {
    console.log("팝업에서 받은 데이터:", data);

    // 👉 上部フィールドに値を設定 / 상단 필드 값 채우기
    $("#orderId").val(data[0]);        // 受注番号 / 수주번호
    $("#buId").val(data[1]);           // 事業単位 / 사업단위
    $("[name=inboundDate]").val(data[2]);  // 入庫日 / 입고일
    $("[name=createdAt]").val(data[8]);    // 登録日 / 등록일
    $("[name=partyName]").val(data[4]);    // 取引先名 / 거래처명
    $("[name=contactName]").val(data[5]);  // 担当者名 / 담당자명
    $("[name=inboundType]").val(data[6]);  // 入庫区分 / 입고구분
    $("[name=localFlag]").val(data[3]);    // 内外区分 / 내외구분
    $("[name=partyId]").val(data[9]);      // 取引先ID / 거래처ID
    $("[name=department]").val(data[10]);  // 部署 / 부서

    // 👉 詳細データをロード / 상세내역 조회
    loadOrder(data[1], data[0]); // buId, orderId
}

//✅ 単件詳細データを取得 / 단건 상세 조회
function loadOrder(buId, orderId) {
    $.ajax({
        url: '/order/in_detail_list',
        data: { buId: buId, orderId: orderId },
        type: 'GET',
        dataType: 'json',
        success: function(result) {
            console.log("단건 조회 결과:", result);
            renderTable(result || []);
        },
        error: function(err) {
            console.error("단건 조회 에러:", err);
            alert("단건 조회 실패: " + err.statusText);
        }
    });
}

//✅ テーブルを描画 / 테이블 렌더링
function renderTable(dataList) {
    var tbody = $("#result-tbody");
    tbody.empty();

    if (!dataList || dataList.length === 0) {
        tbody.append("<tr><td colspan='16' class='text-center'></td></tr>");
        return;
    }

    $.each(dataList, function(i, row) {
        var tr = $("<tr>");
        tr.append("<td>"+(row.itemName||'')+"</td>");
        tr.append("<td>"+(row.itemId||'')+"</td>");
        tr.append("<td>"+(row.spec||'')+"</td>");
        tr.append('<td class="text-center"><input type="checkbox" '+(row.surtaxYn==="Y"?"checked":"")+' onchange="calcVat(this)"></td>');
        tr.append("<td class='text-center'>"+(row.unitPrice||0)+"</td>");
        tr.append("<td class='text-center'>"+(row.qty||0)+"</td>");
        tr.append("<td>"+(row.baseUnit||'')+"</td>");
        tr.append("<td class='text-center'>"+(row.amount||0)+"</td>");
        tr.append("<td class='text-center'>"+(row.vat||0)+"</td>");
        tr.append("<td class='text-center'>"+(row.krwAmount||0)+"</td>");
        tr.append("<td class='text-center'>"+(row.krwVat||0)+"</td>");
        tr.append("<td class='text-center'>"+(row.partyName||'')+"</td>");
        tr.append("<td>"+(row.inboundDate||'')+"</td>");
        tr.append("<td>"+(row.note||'')+"</td>");
        tr.append("<td>"+(row.warehouseName || row.warehouseId || '')+"</td>");
        tr.append('<td class="text-center">'
        	    + '<input type="checkbox" '
        	    + (row.inboundComplete === "Y" ? "checked" : "")
        	    + ' onchange="handleInboundComplete(this)">'
        	    + '</td>');
        tbody.append(tr);
    });
}

//✅ 全体検索（照会ボタン）/ 전체 검색 (조회 버튼)
function searchOrders() {
    $.ajax({
        url: '/order/search',
        data: {
            buId: $("#buId").val(),
            inboundType: $("[name=inboundType]").val(),
            localFlag: $("[name=localFlag]").val(),
            startDate: $("[name=createdAt]").val(),
            endDate: $("[name=inboundDate]").val(),
            partyId: $("[name=partyId]").val(),
            contactId: $("[name=contactId]").val()   
        },
        type: 'GET',
        dataType: 'json',
        success: function(result) {
            let allDetails = [];
            result.forEach(function(order) {
                if (order.details) {
                    order.details.forEach(d => {
                        allDetails.push({
                            ...d,
                            partyName: order.partyName
                        });
                    });
                }
            });
            renderTable(allDetails);
        },
        error: function(err) {
            console.error("검색 에러:", err);
            alert("조회 실패: " + err.statusText);
        }
    });
}


//✅ 付加税自動計算関数 / 부가세 자동 계산 함수
function calcVat(checkbox) {
    var tr = $(checkbox).closest("tr");

    var amountText = tr.find("td:eq(7)").text().replace(/,/g, "");
    var amount = parseFloat(amountText) || 0;

    var isChecked = $(checkbox).is(":checked");

    var vat = isChecked ? Math.round(amount * 0.1) : 0;

    tr.find("td:eq(8)").text(vat.toLocaleString());

    updateTotals();
}


//✅ 入庫完了チェック時、今日の日付を自動入力 / 입고완료 체크 시 오늘 날짜 자동 입력
function handleInboundComplete(checkbox) {
    var tr = $(checkbox).closest("tr");
    var today = new Date();
    var formatted = today.toISOString().split('T')[0]; 

    if ($(checkbox).is(":checked")) {
        tr.find("td:eq(12)").text(formatted);
    } else {
        // 체크 해제 시 납기일 비움
        tr.find("td:eq(12)").text("");
    }
}
//✅ Ctrlキーで複数行選択+自動合計 / Ctrl 키로 다중 선택 + 자동 합계 계산
(function() {
    const tbody = document.querySelector("#result-tbody");
    if (!tbody) return;

    let selectedRows = new Set();

    tbody.addEventListener("click", function(e) {
        const tr = e.target.closest("tr");
        if (!tr) return;

        if (e.ctrlKey) {
            if (selectedRows.has(tr)) {
                tr.classList.remove("tr-selected");
                selectedRows.delete(tr);
            } else {
                tr.classList.add("tr-selected");
                selectedRows.add(tr);
            }
        } else {
            selectedRows.forEach(r => r.classList.remove("tr-selected"));
            selectedRows.clear();
            tr.classList.add("tr-selected");
            selectedRows.add(tr);
        }

        updateTotals(); 
    });

    // ✅ 合計計算関数 / 합계 계산 함수
    function updateTotals() {
        let totalAmountUSD = 0;
        let totalVatUSD = 0;
        let exchangeRate = parseFloat($("[name=exchangeRate]").val()) || 1;
        let discountRate = parseFloat($("[name=discountRate]").val()) || 0;

        selectedRows.forEach(tr => {
            const $tr = $(tr);
            const amount = parseFloat($tr.find("td:eq(7)").text().replace(/,/g, "")) || 0;
            const vat = parseFloat($tr.find("td:eq(8)").text().replace(/,/g, "")) || 0;
            totalAmountUSD += amount;
            totalVatUSD += vat;
        });

        totalAmountUSD = totalAmountUSD * (1 - discountRate / 100);
        totalVatUSD = totalVatUSD * (1 - discountRate / 100);

        const totalAmountKRW = Math.round(totalAmountUSD * exchangeRate);
        const totalVatKRW = Math.round(totalVatUSD * exchangeRate);
        const totalGrandKRW = totalAmountKRW + totalVatKRW;

        $("[name=salesTotal]").val(totalAmountKRW.toLocaleString());
        $("[name=vatTotal]").val(totalVatKRW.toLocaleString());
        $("[name=grandTotal]").val(totalGrandKRW.toLocaleString());
    }
 

    $("[name=exchangeRate], #currencyCode, [name=discountRate]").on("input change", function() {
        updateTotals();
    });
})();
//✅ 単価適用処理 / 단가적용 처리
function applyUnitPrice() {
    const selected = $(".tr-selected");
    if (selected.length === 0) {
        alert("단가적용할 항목을 선택해주세요.");
        return;
    }

    selected.each(function() {
        const tr = $(this);

        const salesTotalText = $("[name=salesTotal]").val().replace(/,/g, "");
        const salesTotal = parseFloat(salesTotalText) || 0;

        const vatTotalText = $("[name=vatTotal]").val().replace(/,/g, "");
        const vatTotal = parseFloat(vatTotalText) || 0;

        tr.find("td:eq(9)").text(salesTotal.toLocaleString());
        tr.find("td:eq(10)").text(vatTotal.toLocaleString());
    });

}
//✅ 取引先ポップアップを開く / 거래처 팝업 열기
function openPartyPopup() {
    // 팝업 크기 설정
    var width = 900;
    var height = 600;

    // 화면 가운데 위치 계산
    var left = (window.innerWidth - width) / 2 + window.screenX;
    var top = (window.innerHeight - height) / 2 + window.screenY;

    // 팝업 열기
    window.open(
        "/popup/party_popup",
        "partyPopup",
        "width=" + width +
        ",height=" + height +
        ",left=" + left +
        ",top=" + top +
        ",scrollbars=yes,resizable=yes"
    );
}

//✅ 取引先データを受け取る / 거래처 팝업에서 데이터 전달받기
function party_RowData(data) {
    console.log("거래처 팝업에서 받은 데이터:", data);

    $("[name=partyId]").val(data[2]);     
    $("[name=partyName]").val(data[3]);   
}
//✅ 担当者ポップアップを開く / 담당자 팝업 열기
function openContactPopup() {
    var width = 900;   // 팝업 가로 크기
    var height = 600;   // 팝업 세로 크기

    // 현재 브라우저 창 기준으로 중앙 좌표 계산
    var left = (window.innerWidth - width) / 2 + window.screenX;
    var top = (window.innerHeight - height) / 2 + window.screenY;

    // 팝업 열기
    window.open(
        "/popup/contact_popup",    
        "contactPopup",            
        "width=" + width +
        ",height=" + height +
        ",left=" + left +
        ",top=" + top +
        ",scrollbars=yes,resizable=yes"
    );
}


//✅ 担当者データを受け取る / 담당자 팝업에서 데이터 전달받기
function contact_RowData(data) {
    console.log("담당자 팝업에서 받은 데이터:", data);

    // 👉 データ配列の順番に基づき設定 / 전달 순서에 맞게 값 채워넣기
    // column1: 社員番号 / 사원번호
    // column2: 社員名 / 사원명
    // column3: 部署 / 부서
    $("[name=contactId]").val(data[0]);    // ✅ 担当者ID（検索用）/ 담당자 ID (검색용)
    $("[name=contactName]").val(data[1]);  // 担当者名 / 담당자 이름
    $("[name=department]").val(data[2]);   // 部署名 / 부서명
}
</script>
