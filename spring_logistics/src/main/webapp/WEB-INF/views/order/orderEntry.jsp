<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>수주입력 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class = "layout">
		<!-- 홈 아이콘 세로 바 -->
	    <div class="home-bar">
	        <span>
	            <a href="/"><img src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png" alt="홈화면" class="home-icon"></a>
	        </span>
	    </div>
	    <!-- 사이드바 -->
	    <aside class="sidebar">
	        <div class="sidebar-header">
	            <div class="profile">
	                <img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png" alt="프로필">
	                <p>홍길동님, 안녕하세요 👋</p>
	                <div class="auth-btns">
	                    <button class="btn btn-secondary">로그인</button>
	                    <button class="btn btn-secondary">회원가입</button>
	                </div>
	            </div>
	        </div>
	        <nav class="menu">
	            <div class="menu-item">
	                <div class="title"><a href="#">입고 및 출고</a></div>
	                <div class="submenu">
	                    <div><a href="#">입고 내역</a></div>
	                    <div><a href="#">출고 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 출하통제</a></div>
	                <div class="submenu">
	                    <div><a href="#">출하 계획</a></div>
	                    <div><a href="#">출하 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 관리</a></div>
	                <div class="submenu">
	                    <div><a href="#">재고 현황</a></div>
	                    <div><a href="#">재고 이동</a></div>
	                    <div><a href="#">재고 조회</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">사업단위별 수불집계</a></div>
	                <div class="submenu">
	                    <div><a href="#">사업장별 집계</a></div>
	                    <div><a href="#">월별 추이</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 변동 추이 분석</a></div>
	                <div class="submenu">
	                    <div><a href="#">그래프 보기</a></div>
	                </div>
	            </div>
	        </nav>
    	</aside>
		    	<div class = "main">
    		<div class="main-header">
		        <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>수주입력</h1></div>
	            <div>
					<button class="btn btn-secondary search-btn" id="search" onclick="searchOrders()">조회</button>
					<button class="btn btn-secondary search-btn" id="save" onclick="save_inBound()">저장</button>
					<button class="btn btn-secondary search-btn" id="delete" onclick="delete_inBound()">삭제</button>
					<button class="btn btn-secondary search-btn" id="applyPrice" onclick="applyUnitPrice()">단가적용</button>
					
				</div>
			</div>
			<div class="filters">
				<div class="filters-main">
					<div class="title">기본정보</div>
					<div class="line"></div>
				</div>
				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">사업단위</div>
						<div class="filters-value">
							<select id="buId" name="buId">
								<option value=""></option>
								<c:forEach var="bu" items="${buList}">
									<option value="${bu.buId}">${bu.buName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">수주일</div>
						<div class="filters-value">
							<input type="date" name="createdAt">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">수주번호</div>
						<div class="filters-value">
							<input type="text" id="orderId" name="orderId"
								placeholder="수주번호 선택"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="openInboundPopup()">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">Local구분</div>
						<div class="filters-value">
							<select name="localFlag">
								<option value=""></option>
								<option value="내수">내수</option>
								<option value="Local(후LC)">Local(후LC)</option>
								<option value="Local(전LC)">Local(전LC)</option>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">수주구분</div>
						<div class="filters-value">
							<select name="inboundType">
								<option value=""></option>
								<option value="구매요청">구매요청</option>
								<option value="생산의뢰">생산의뢰</option>
								<option value="거래명세서">거래명세서</option>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">납기일</div>
						<div class="filters-value">
							<input type="date" name="inboundDate">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">담당자</div>
						<div class="filters-value">
							<input type="text" name="contactName" placeholder="담당자 선택">
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">부서</div>
						<div class="filters-value">
							<input type="text" name="department" placeholder="부서 선택">
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">거래처</div>
						<div class="filters-value">
							<input type="text" name="partyName" placeholder="거래처 선택">
							<img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">거래처번호</div>
						<div class="filters-value">
							<input type="text" name="partyId" placeholder="거래처 번호"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" onclick="">
						</div>
					</div>

				</div>
			</div>

			<div class="filters">
				<div class="filters-main">
					<div class="title">추가정보</div>
					<div class="line"></div>
				</div>
				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">통화</div>
						<div class="filters-value">
							<select id="currencyCode" name="currencyCode" onchange="loadExchangeRate()">
							    <option value=""></option>
							    <c:forEach items="${currencyList}" var="cItem">
							        <option value="${cItem}">${cItem}</option>
							    </c:forEach>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">판매가계액</div>
						<div class="filters-value">
							<input type="text" name="salesTotal" value="0" readonly>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">부가세계</div>
						<div class="filters-value">
							<input type="text" name="vatTotal" value="0" readonly>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">총액</div>
						<div class="filters-value">
							<input type="text" name="grandTotal" value="0" readonly>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">환율</div>
						<div class="filters-value">
							<input type="number" step="0.01" name="exchangeRate" value="1.00">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">할인율</div>
						<div class="filters-value">
							<input type="number" step="0.1" name="discountRate" value="0">
							<span>%</span>
						</div>
					</div>
					
				</div>

			</div>

			<div class="table-container" style="height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 140px">품명</th>
							<th style="width: 120px">품번</th>
							<th style="width: 120px">규격</th>
							<th style="width: 90px">부가세포함</th>
							<th style="width: 100px">판매단가</th>
							<th style="width: 90px">수량</th>
							<th style="width: 90px">판매단위</th>
							<th style="width: 120px">판매금액</th>
							<th style="width: 100px">부가세</th>
							<th style="width: 120px">원화판매금액</th>
							<th style="width: 120px">원화부가세</th>
							<th style="width: 140px">납품거래처</th>
							<th style="width: 120px">납기일</th>
							<th style="width: 150px">특이사항</th>
							<th style="width: 120px">창고</th>
							<th style="width: 90px">입고완료</th>
						</tr>
					</thead>
					
					
					<tbody id="result-tbody">
					  <c:forEach items="${orderList}" var="order">
					    <tr onclick="row_Click(this)">
					      <td class="text-center"><c:out value="${order.itemName}" /></td>
					      <td class="text-center"><c:out value="${order.itemId}" /></td>
					      <td class="text-center"><c:out value="${order.spec}" /></td>
					
				
					
					      <td class="text-right"><fmt:formatNumber value="${order.unitPrice}" type="number" /></td>
					      <td class="text-right"><fmt:formatNumber value="${order.qty}" type="number" /></td>
					      <td><c:out value="${order.baseUnit}" /></td>
					      <td class="text-right"><fmt:formatNumber value="${order.amount}" type="number" /></td>
					      <td class="text-right"><fmt:formatNumber value="${order.vat}" type="number" /></td>
					      <td class="text-right"><fmt:formatNumber value="${order.krwAmount}" type="number" /></td>
					      <td class="text-right"><fmt:formatNumber value="${order.krwVat}" type="number" /></td>
					      <td><c:out value="${order.partyName}" /></td>
					      <td><fmt:formatDate value="${order.inboundDate}" pattern="yyyy-MM-dd" /></td>
					      <td><c:out value="${order.note}" /></td>
					      <td><c:out value="${order.warehouseName}" /></td>
					
					      <!-- ✅ 입고완료 체크박스 -->
					      <tr>
    ...
    <!-- 부가세포함 체크박스 -->
    <td class="text-center">
        <input type="checkbox" name="surtaxYn" <c:if test="${order.surtaxYn == 'Y'}">checked</c:if> />
    </td>
    ...
    <!-- 입고완료 체크박스 -->
    <td class="text-center">
        <input type="checkbox" name="inboundComplete" <c:if test="${order.inboundComplete == 'Y'}">checked</c:if> />
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
	
// 	        if (selectedRow === tr) {
// 	            tr.classList.remove('tr-selected');
// 	            selectedRow = null;
// 	            return;
// 	        }
	
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
						.append("<tr><td colspan='16' class='text-center'>데이터가 없습니다.</td></tr>");
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

// 								// ✅ 부가세포함 체크박스
// 								var surtaxYn = row.surtaxYn === 'Y' ? "checked"
// 										: "";
// 								tr
// 										.append('<td class="text-center"><input type="checkbox" ' + surtaxYn + ' disabled></td>');

// 								tr.append("<td class='text-right'>"
// 										+ (row.unitPrice || 0) + "</td>");
// 								tr.append("<td class='text-right'>"
// 										+ (row.qty || 0) + "</td>");
// 								tr.append("<td>" + (row.baseUnit || '')
// 										+ "</td>");
// 								tr.append("<td class='text-right'>"
// 										+ (row.amount || 0) + "</td>");
// 								tr.append("<td class='text-right'>"
// 										+ (row.vat || 0) + "</td>");
// 								tr.append("<td class='text-right'>"
// 										+ (row.krwAmount || 0) + "</td>");
// 								tr.append("<td class='text-right'>"
// 										+ (row.krwVat || 0) + "</td>");
// 								tr.append("<td>" + (row.partyName || '')
// 										+ "</td>");
// 								tr.append("<td>" + (row.inboundDate || '')
// 										+ "</td>");
// 								tr.append("<td>" + (row.note || '') + "</td>");
// 								tr.append("<td>" + (row.warehouseId || '')
// 										+ "</td>");

// 								// ✅ 입고완료 체크박스
// 								var inboundChk = row.inboundComplete === 'Y' ? "checked"
// 										: "";
// 								tr
// 										.append('<td class="text-center"><input type="checkbox" ' + inboundChk + ' disabled></td>');

// 								tbody.append(tr);
							});
		}
	</script>

<script>
// ✅ 팝업 열기
function openInboundPopup() {
    window.open(
        "/popup/inbound_popup",
        "inboundPopup",
        "width=1000,height=600,scrollbars=yes,resizable=yes"
    );
}

// ✅ 팝업에서 부모창으로 값 전달
function inbound_RowData(data) {
    console.log("팝업에서 받은 데이터:", data);

    // 👉 상단 필드 채우기
    $("#orderId").val(data[0]);        // 수주번호
    $("#buId").val(data[1]);           // 사업단위
    $("[name=inboundDate]").val(data[2]); 
    $("[name=createdAt]").val(data[8]); 
    $("[name=partyName]").val(data[4]);
    $("[name=contactName]").val(data[5]);
    $("[name=inboundType]").val(data[6]);
    $("[name=localFlag]").val(data[3]);
    $("[name=partyId]").val(data[9]);   
    $("[name=department]").val(data[10]);

    // 👉 상세내역 조회
    loadOrder(data[1], data[0]); // buId, orderId
}

// ✅ 단건 상세 조회
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

// ✅ 테이블 렌더링
function renderTable(dataList) {
    var tbody = $("#result-tbody");
    tbody.empty();

    if (!dataList || dataList.length === 0) {
        tbody.append("<tr><td colspan='16' class='text-center'>데이터가 없습니다.</td></tr>");
        return;
    }

    $.each(dataList, function(i, row) {
        var tr = $("<tr>");
        tr.append("<td>"+(row.itemName||'')+"</td>");
        tr.append("<td>"+(row.itemId||'')+"</td>");
        tr.append("<td>"+(row.spec||'')+"</td>");
        tr.append('<td class="text-center"><input type="checkbox" '+(row.surtaxYn==="Y"?"checked":"")+' onchange="calcVat(this)"></td>');
        tr.append("<td class='text-right'>"+(row.unitPrice||0)+"</td>");
        tr.append("<td class='text-right'>"+(row.qty||0)+"</td>");
        tr.append("<td>"+(row.baseUnit||'')+"</td>");
        tr.append("<td class='text-right'>"+(row.amount||0)+"</td>");
        tr.append("<td class='text-right'>"+(row.vat||0)+"</td>");
        tr.append("<td class='text-right'>"+(row.krwAmount||0)+"</td>");
        tr.append("<td class='text-right'>"+(row.krwVat||0)+"</td>");
        tr.append("<td>"+(row.partyName||'')+"</td>");
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

//✅ 전체 검색 (조회 버튼)
function searchOrders() {
    $.ajax({
        url: '/order/search',
        data: { 
            buId: $("#buId").val(),
            inboundType: $("[name=inboundType]").val(),
            localFlag: $("[name=localFlag]").val()
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
}   // ✅ 여기까지가 searchOrders 끝

// ✅ 부가세 자동 계산 함수 (searchOrders 바깥에 있어야 함!)
function calcVat(checkbox) {
    // 클릭한 체크박스가 속한 행(tr) 찾기
    var tr = $(checkbox).closest("tr");

    // 판매금액(td 8번째 칸) 가져오기
    var amountText = tr.find("td:eq(7)").text().replace(/,/g, "");
    var amount = parseFloat(amountText) || 0;

    // 체크 여부 확인
    var isChecked = $(checkbox).is(":checked");

    // 부가세 계산 (10%)
    var vat = isChecked ? Math.round(amount * 0.1) : 0;

    // 부가세 칸(td 9번째 칸) 업데이트
    tr.find("td:eq(8)").text(vat.toLocaleString());

    // 총합 다시 계산
    updateTotals();
}

// // ✅ 부가세 총합 업데이트 함수
// function updateTotals() {
//     var totalVat = 0;
//     $("#result-tbody tr").each(function() {
//         var vatText = $(this).find("td:eq(8)").text().replace(/,/g, "");
//         var vat = parseFloat(vatText) || 0;
//         totalVat += vat;
//     });
//     $("[name=vatTotal]").val(totalVat.toLocaleString());
// }

//✅ 판매금액, 부가세, 총액 자동 계산
// function updateSummary() {
//     let totalAmount = 0;
//     let totalVat = 0;

//     $("#result-tbody tr").each(function () {
//         const tr = $(this);
//         const amountText = tr.find("td:eq(7)").text().replace(/,/g, "");
//         const vatText = tr.find("td:eq(8)").text().replace(/,/g, "");

//         const amount = parseFloat(amountText) || 0;
//         const vat = parseFloat(vatText) || 0;

//         totalAmount += amount;
//         totalVat += vat;
//     });

//     // 계산된 값 화면 반영
//     $("[name=salesTotal]").val(totalAmount.toLocaleString());
//     $("[name=vatTotal]").val(totalVat.toLocaleString());
//     $("[name=grandTotal]").val((totalAmount + totalVat).toLocaleString());
// }

//✅ 입고완료 체크박스 클릭 시 오늘 날짜 자동 입력
function handleInboundComplete(checkbox) {
    var tr = $(checkbox).closest("tr");
    var today = new Date();
    var formatted = today.toISOString().split('T')[0]; // yyyy-MM-dd 형식

    if ($(checkbox).is(":checked")) {
        // 체크되면 납기일 셀에 오늘 날짜 입력
        tr.find("td:eq(12)").text(formatted);
    } else {
        // 체크 해제 시 납기일 비움
        tr.find("td:eq(12)").text("");
    }
}
//✅ Ctrl 키 다중 선택 + 자동 합계 계산
(function() {
    const tbody = document.querySelector("#result-tbody");
    if (!tbody) return;

    let selectedRows = new Set();

    tbody.addEventListener("click", function(e) {
        const tr = e.target.closest("tr");
        if (!tr) return;

        // Ctrl 키 누르면 다중 선택
        if (e.ctrlKey) {
            if (selectedRows.has(tr)) {
                tr.classList.remove("tr-selected");
                selectedRows.delete(tr);
            } else {
                tr.classList.add("tr-selected");
                selectedRows.add(tr);
            }
        } else {
            // Ctrl 안 누르면 단일 선택
            selectedRows.forEach(r => r.classList.remove("tr-selected"));
            selectedRows.clear();
            tr.classList.add("tr-selected");
            selectedRows.add(tr);
        }

        updateTotals(); // 선택 시마다 합계 갱신
    });

    // ✅ 합계 계산 함수 (수정 버전)
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

        // 💵 할인 적용 (USD 기준)
        totalAmountUSD = totalAmountUSD * (1 - discountRate / 100);
        totalVatUSD = totalVatUSD * (1 - discountRate / 100);

        // 💰 원화 환산
        const totalAmountKRW = Math.round(totalAmountUSD * exchangeRate);
        const totalVatKRW = Math.round(totalVatUSD * exchangeRate);
        const totalGrandKRW = totalAmountKRW + totalVatKRW;

        // ✅ 상단 표시: 전부 원화 기준으로 들어가게
        $("[name=salesTotal]").val(totalAmountKRW.toLocaleString());
        $("[name=vatTotal]").val(totalVatKRW.toLocaleString());
        $("[name=grandTotal]").val(totalGrandKRW.toLocaleString());
    }
 

    // ✅ 통화/환율/할인율 변경 시 자동 계산
    $("[name=exchangeRate], #currencyCode, [name=discountRate]").on("input change", function() {
        updateTotals();
    });
})();
function applyUnitPrice() {
    // 선택된 행(tr-selected 클래스)
    const selected = $(".tr-selected");
    if (selected.length === 0) {
        alert("단가적용할 항목을 선택해주세요.");
        return;
    }

    selected.each(function() {
        const tr = $(this);

        // 판매가계액(=USD 기준 금액)
        const salesTotalText = $("[name=salesTotal]").val().replace(/,/g, "");
        const salesTotal = parseFloat(salesTotalText) || 0;

        // 부가세(USD)
        const vatTotalText = $("[name=vatTotal]").val().replace(/,/g, "");
        const vatTotal = parseFloat(vatTotalText) || 0;

        // ✅ 판매가계액 그대로 원화판매금액으로 반영
        tr.find("td:eq(9)").text(salesTotal.toLocaleString());
        tr.find("td:eq(10)").text(vatTotal.toLocaleString());
    });

//     alert("단가적용이 되었습니다.✅");
}

</script>
