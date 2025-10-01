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

<!-- Handsontable -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.css">
<script src="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
		            <button class="btn btn-secondary search-btn" id = "search" onclick = "search()">조회</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save_inBound()">저장</button>
				    <button class="btn btn-secondary search-btn" id = "delete" onclick = "delete_inBound()">저장</button>
				</div>
	        </div>
	        <div class="filters">
	        	<div class = "filters-main">
        			<div class = "title">기본정보</div>
        			<div class = "line"></div>
	        	</div>
		        <div class="filters-row">
	          		<div class = "filters-count">
		           		<div class = "filters-text">사업단위</div>
		           		<div class = "filters-value">
		           			<select id="buId" name="buId">
								<option value = ""></option>
							  	<c:forEach var="bu" items="${buList}">
									<option value="${bu.buId}">${bu.buName}</option>
								</c:forEach>
							</select>
		           		</div>
	          		</div>
	          		<div class = "filters-count">
		           		<div class = "filters-text">수주일</div>
		           		<div class = "filters-value">
		           			<input type="date" name="createdAt">
		           		</div>
	          		</div>
	          		<div class = "filters-count">
		           		<div class = "filters-text">수주번호</div>
		           		<div class = "filters-value">
							<input type="text" id="orderId" name="orderId" placeholder="수주번호 선택"readonly />
							<button type="button" class="btn-icon" onclick="openInboundPopup()">🔍</button>
		           		</div>
	          		</div>
	       		</div>
       		</div>
		</div>
	</div>
	<!-- ✅ 기본정보 -->
	<fieldset>
		<legend>기본정보</legend>
		<div class="form-grid">
			<div class="label-red">사업단위</div>
			
			<select id="buId" name="buId">
				<option value="">-- 선택 --</option>
				<!-- ✅ 빈칸 옵션 -->
				<c:forEach var="bu" items="${buList}">
					<option value="${bu.buId}">${bu.buName}</option>
				</c:forEach>
			</select>

			<div class="label-red">수주일</div>
			<input type="date" name="createdAt">

			<div class="label-red">수주번호</div>
			<div class="search-wrap">
				<input type="text" id="orderId" name="orderId" placeholder="수주번호 선택"
					readonly />
				<button type="button" class="btn-icon" onclick="openInboundPopup()">🔍</button>

			</div>


			<div class="label-red">Local구분</div>
			<select name="localFlag">
				<option value="">-- 선택 --</option>
				<option value="내수">내수</option>
				<option value="Local(후LC)">Local(후LC)</option>
				<option value="Local(전LC)">Local(전LC)</option>
			</select>

			<div class="label-red">수주구분</div>
			<select name="inboundType">
				<option value="">-- 선택 --</option>
				<option value="구매요청">구매요청</option>
				<option value="생산의뢰">생산의뢰</option>
				<option value="거래명세서">거래명세서</option>
			</select>



			<div class="label-red">납기일</div>
			<input type="date" name="inboundDate">

			<div class="label-red">담당자</div>
			<div class="search-wrap">
				<input type="text" class="search-input" name="contactName"
					placeholder="담당자 선택" style="width: 186px;">
				<button type="button" class="btn-icon">🔍</button>
			</div>

			<div class="label-red">부서</div>
			<div class="search-wrap">
				<input type="text" class="search-input" name="department"
					placeholder="부서 선택" style="width: 186px;">
				<button type="button" class="btn-icon">🔍</button>
			</div>

			<div class="label-red">거래처</div>
			<div class="search-wrap">
				<input type="text" class="search-input" name="partyName"
					placeholder="거래처 선택" style="width: 186px;">
				<button type="button" class="btn-icon">🔍</button>
			</div>

			<div class="label-red">거래처번호</div>
			<div class="search-wrap">
				<input type="text" class="search-input" name="partyId"
					placeholder="거래처 번호" style="width: 186px;">
				<button type="button" class="btn-icon">🔍</button>
			</div>





		</div>
	</fieldset>

	<!-- ✅ 추가정보 -->
	<fieldset>
		<legend>추가정보</legend>
		<div class="form-grid">
			<div class="label-red">통화</div>
			<div class="search-wrap">
				<select name="currencyCode" style="width: 186px;">
					<option value="">-- 선택 --</option>
					<c:forEach var="cur" items="${currencyList}">
						<option value="${cur}">${cur}</option>
					</c:forEach>
				</select>
				<button type="button" class="btn-icon"
					onclick="openCurrencyLookup()" aria-label="통화 검색">🔍</button>
			</div>


			<div class="label-red">판매가액계</div>
			<input type="text" name="salesTotal" value="0" readonly>

			<div class="label-red">부가세계</div>
			<input type="text" name="vatTotal" value="0" readonly>

			<div class="label-red">총액</div>
			<input type="text" name="grandTotal" value="0" readonly>

			<div class="label-red">환율</div>
			<input type="number" step="0.01" name="exchangeRate" value="1.00">

			<div class="label-red">할인율</div>
			<div class="inline">
				<input type="number" step="0.1" name="discountRate" value="0">
				<span>%</span>
			</div>
	</fieldset>

	<!-- ✅ 품목 GRID -->
	<div id="orderGrid" class="grid"></div>
<script type="text/javascript" src="/resources/js/logistics.js"></script>

	<script>
	const container = document.getElementById("orderGrid");
	const hot = new Handsontable(container, {
	  data : [],
	  colHeaders : [ 
	    "품명", "품번", "규격", "부가세포함", "판매단가", "수량", "판매단위", 
	    "판매금액", "부가세", "원화판매금액", "원화부가세", 
	    "납품거래처", "납기일", "특이사항", "창고", "입고완료"
	  ],
	  columns : [
	    { data : "itemName" },              // 품명
	    { data : "itemId" },                // 품번
	    { data : "spec" },                  // 규격
	    {                                    // 부가세포함
	      data : "surtaxYn",
	      type : "checkbox",
	      checkedTemplate: 'Y',
	      uncheckedTemplate: 'N'
	    },
	    { data : "unitPrice", type : "numeric" },   // 판매단가
	    { data : "qty", type : "numeric" },         // 수량
	    { data : "baseUnit" },                      // 판매단위
	    { data : "amount", type : "numeric" },      // 판매금액
	    { data : "vat", type : "numeric" },         // 부가세
	    { data : "krwAmount", type : "numeric" },   // 원화판매금액
	    { data : "krwVat", type : "numeric" },      // 원화부가세
	    { data : "partyName" },                     // 납품거래처
	    {                                          // 납기일
	      data : "inboundDate",
	      type : "date",
	      dateFormat : "YYYY-MM-DD"
	    },
	    { data : "note" },                          // 특이사항
	    { data : "warehouseId" },                 // 창고
// 	    { data : "extraOutType", type: "dropdown", source: ["수주", "적송요청", "위탁출고요청", "기타출고요청"] }, // 기타출고구분
	    {                                          // 입고완료
	      data : "inboundComplete",
	      type : "checkbox",
	      checkedTemplate: 'Y',
	      uncheckedTemplate: 'N'
	    }
	  ],
	  stretchH : "all",
	  rowHeaders : true,
	  filters : true,
	  dropdownMenu : true,
	  licenseKey : "non-commercial-and-evaluation",
	  minSpareRows : 5,
	  
	// ✅ 이벤트 추가
	  afterChange: function(changes, source) {
	    if (source === 'loadData' || !changes) return;

	    changes.forEach(([row, prop, oldValue, newValue]) => {
	      if (prop === 'surtaxYn' || prop === 'qty' || prop === 'unitPrice') {
	        const rowData = hot.getSourceDataAtRow(row);

	        const qty = parseFloat(rowData.qty) || 0;
	        const unitPrice = parseFloat(rowData.unitPrice) || 0;
	        const amount = qty * unitPrice;

	        // 판매금액 갱신
	        hot.setDataAtRowProp(row, 'amount', amount);

	        // 부가세 체크 시 계산
	        if (rowData.surtaxYn === 'Y') {
	          const vat = Math.round(amount * 0.1); // 10% 부가세
	          hot.setDataAtRowProp(row, 'vat', vat);
	        } else {
	          hot.setDataAtRowProp(row, 'vat', 0);
	        }
	      }

	      // 2️⃣ 입고완료 체크 시 납기일 자동 입력
	      if (prop === 'inboundComplete') {
	        if (newValue === 'Y') {
	          // 오늘 날짜 (YYYY-MM-DD 형식)
	          const today = new Date().toISOString().split("T")[0];
	          hot.setDataAtRowProp(row, 'inboundDate', today);
	        } else if (newValue === 'N') {
	          // 체크 해제 시 납기일 비우기 (선택사항)
	          hot.setDataAtRowProp(row, 'inboundDate', null);
	        }
	      }
	      
	    });
	  }
	});



	// 저장 로직 (TODO 구현)
	function saveOrder() { 
	    alert("저장 기능은 추후 구현 예정"); 
	}

	function goPurchaseRequest() { location.href = "/order/purchaseRequest"; }
	function goProductionRequest() { location.href = "/order/productionRequest"; }
	function goTransactionSlip() { location.href = "/order/transactionSlip"; }


	// 검색 조회
function searchOrders() {
    var formData = { 
        buId: $("#buId").val(),
        inboundType: $("[name=inboundType]").val(),
        localFlag: $("[name=localFlag]").val()
    };

    $.ajax({
        url: '/order/search',
        data: formData,
        type: 'GET',
        dataType: 'json',
        success: function(result) {
            console.log("검색 결과:", result);

            let allDetails = [];
            result.forEach(function(order) {
                if (order.details) {
                    allDetails.push(...order.details.map(d => ({
                        ...d,
                        orderId: order.orderId,
                        partyName: order.partyName,
                        inboundType: order.inboundType, 
                        vat: d.vat || 0,
                        krwAmount: d.krwAmount || 0,
                        krwVat: d.krwVat || 0,
                        extraOutType: d.extraOutType || null
                    })));
                }
            });

            hot.loadData(allDetails);
        },
        error: function(err) {
            console.error("검색 에러:", err);
            alert("조회 실패: " + err.statusText);
        }
    });
}

	// ✅ 페이지 진입 시 자동 조회 실행
// 	$(document).ready(function() {
// 	    searchOrders();
// 	});
	
  	function openPopup2(row) {
 	   // 예: 첫 번째 셀 값 가져오기
 	   // var rowId = row.cells[0].innerText;
 	
 	   // 팝업 크기 설정
 	   var popupWidth = 900;
 	   var popupHeight = 600;
 	
 	   // 화면 중앙 좌표 계산
 	   var left = (screen.width - popupWidth) / 2;
 	   var top = (screen.height - popupHeight) / 2;
 	
 	   // 팝업창 열기
 	   window.open(
 	     "contact_popup",
 	     "popupWindow",
 	     "width=" + popupWidth +
 	     ",height=" + popupHeight +
 	     ",left=" + left +
 	     ",top=" + top +
 	     ",scrollbars=yes,resizable=yes"
 	   );
 	}
  	
	function setSelectedRow2(data) {
 		
  	    var result1 = $("#table2").DataTable().rows().data().toArray();
  	    var data = {item_Id: data.item_id, item_Name: '', spec: '', safety_Stock_Qty: '', storage_Location: ''};
  	    
  	    for (var i = 0; i < result1.length; i++) {
  	    	if (result1[i].item_Id != null) {
  	    		result1.splice(i, 0, data);
  	    		break;
  	    	}
  	    }
  
  		// 기존 DataTable 초기화
        if ($.fn.DataTable.isDataTable('#table2')) {
            $('#table2').DataTable().clear().destroy();
        }
  		

        $("#table2").DataTable({
            lengthChange: false, // 표시건수기능
            searching: false,    // 검색 기능
            ordering: false,     // 정렬 기능
            info: false,         // 정보 표시
            paging: false,       // 페이징기능
            data: result1,
            columns: [
                { data: "item_Id" },
                { data: "item_Name" },
                { data: "spec" },
                { data: "safety_Stock_Qty" },
                { data: "storage_Location" }
            ]
        });
 	}
	
	function openInboundPopup() {
		window.open(
    		"/popup/inbound_popup",
	        "inboundPopup",
	        "width=1000,height=600,scrollbars=yes,resizable=yes"
	    );
	}
	
	// 부모창 (수주입력.jsp)
	function inbound_RowData(data) {
	    console.log("팝업에서 받은 데이터:", data);
	
	 // [0] 수주번호, [1] buId(코드값), [2] 납기일, [3] Local구분,
	 // [4] 거래처명, [5] 담당자, [6] 수주구분, [7] 입고상태,
	 // [8] 수주일, [9] 거래처번호, [10] 부서

	    $("#orderId").val(data[0]);        // 수주번호
	    $("#buId").val(data[1]);         
	    $("[name=inboundDate]").val(data[2]);
	    $("[name=createdAt]").val(data[8]);
	    $("[name=partyName]").val(data[4]);
	    $("[name=contactName]").val(data[5]);
	    $("[name=inboundType]").val(data[6]);
	    $("[name=inboundComplete]").val(data[7]);
	    $("[name=localFlag]").val(data[3]);
	    $("[name=partyId]").val(data[9]);   // 거래처번호
	    $("[name=department]").val(data[10]); // 부서

// 	    console.log("loadOrder 호출 인자:", data[1], data[0]);
	    loadOrder(data[1], data[0]);   // buId(코드값), orderId 전달
	}

	function loadOrder(buId, orderId) {
		
		var formData = {
	    	buId: buId,
	        orderId: orderId
      	}
		
      	$.ajax({
         	url: '/order/in_detail_list',
	        data: formData,
	        type: 'GET',
	        dataType: 'json',
	        success: function(result) {

//         		console.log(result);
        		
//         		hot.loadData(result || []);
// 	        },

	            console.log("단건 조회 결과:", result);

	            if (result && result.length > 0) {
	                // 👉 조회된 디테일을 그리드에 로드
	                hot.loadData(result);
	            } else {
	                alert("조회된 데이터가 없습니다.");
	                hot.loadData([]); // 빈 테이블 초기화
	            }
	        },
	        error: function(err) {
	            console.error("단건 조회 에러:", err);
	            alert("단건 조회 실패: " + err.statusText);
	        }
      	});
	        	
	}


</script>


</body>
</html>
