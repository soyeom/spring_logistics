<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>수주입력</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

/* === 공통 규격 === */
:root {
  --label-w: 150px;
  --input-w: 220px;
  --row-h: 30px;
  --gap: 14px;
}

fieldset {
	border: 1px solid #ddd;
	margin-bottom: 12px;
}

legend {
	font-weight: 700;
	padding: 0 6px;
}

.label-red {
	color: #c00;
	font-weight: 700;
	text-align: right;
	padding-right: 6px;
}

/* 4쌍(라벨,입력)*4 = 8칸 그리드 (한 줄에 4필드) */
.form-grid {
  display: grid;
  grid-template-columns: var(--label-w) var(--input-w)
                         var(--label-w) var(--input-w)
                         var(--label-w) var(--input-w)
                         var(--label-w) var(--input-w);
  column-gap: var(--gap);
  row-gap: 10px;
  align-items: center;
}

.form-grid input[type="text"],
.form-grid input[type="date"],
.form-grid input[type="number"],
.form-grid select {
  width: var(--input-w);
  height: var(--row-h);
  box-sizing: border-box;
}

.form-grid input[readonly] {
	background: #f5f6f8;
}

/* 검색 인풋 + 돋보기 버튼 */
.search-wrap {
	display: flex;
	align-items: center;
}

.btn-icon {
	width: 30px;
	height: var(--row-h);
	margin-left: 4px;
	cursor: pointer;
}

/* 오른쪽 버튼 묶음 */
.btns-right {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
}

.btn-blue {
	background: #3b82f6;
	color: #fff;
	border: 0;
	height: var(--row-h);   /* ✅ 오타 수정 */
	padding: 0 14px;
	border-radius: 4px;
	cursor: pointer;
}

/* % 같이 붙는 입력 */
.inline {
	display: flex;
	align-items: center;
	gap: 6px;
}

/* ✅ col-span-2 정의 추가 */
.col-span-2 {
	grid-column: span 2;
}
</style>
</head>

<body>




	
	<h2>수주입력</h2>
	<!-- ✅ 버튼 -->
	<div class="toolbar">
		<button type="button" onclick="searchOrders()">신규</button>
		<button type="button" onclick="searchOrders()">저장</button>
		<button type="button" onclick="searchOrders()">삭제</button>

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

	<script>
	const container = document.getElementById("orderGrid");
	const hot = new Handsontable(container, {
	  data : [],
	  colHeaders : [ 
	    "품명", "품번", "규격", "부가세포함", "판매단가", "수량", "판매단위", 
	    "판매금액", "부가세", "원화판매금액", "원화부가세", 
	    "납품거래처", "납기일", "특이사항", "창고", "출고구분", "입고완료"
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
	    { data : "extraOutType", type: "dropdown", source: ["불량폐기", "판촉", "연구개발", "실사기타출고", "불량재고정리", "샘플출고"] }, // 기타출고구분
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
