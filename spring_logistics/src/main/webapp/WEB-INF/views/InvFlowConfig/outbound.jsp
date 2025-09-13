<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.7.0/css/select.dataTables.min.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js"></script>

<!DOCTYPE html>
<html>
<style>

	/* 전체 테이블 스타일 */
	.table {
		width: 100%;
	    border-collapse: collapse;
	    font-family: Arial, sans-serif;
	    font-size: 14px;
	}

	.table thead, .table tbody tr {
	    display: table;
	    width: 100%;
	    table-layout: fixed;
	}
	
	/* 헤더 스타일 */
	.table thead th {
	    background-color: #4CAF50;
	    color: white;
	    text-align: center;
	    padding: 8px;
	}
	
	/* 데이터 행 스타일 */
	.table tbody tr {
	    text-align: center;
	    height: 35px;       /* 행 높이 */
	    cursor: pointer;    /* 마우스 오버시 포인터 */
	}
	
	/* 홀수/짝수 행 색상 */
	.table tbody tr:nth-child(odd) {
	    background-color: #f9f9f9;
	}
	
	.table tbody tr:nth-child(even) {
	    background-color: #ffffff;
	}
	
	/* 마우스 오버 */
	.table tbody tr:hover {
	    background-color: #d1e7fd;
	}
	
	/* 선택된 행 강조 */
	.table tbody tr.selected {
	    background-color: #a8d5ff !important;
	    font-weight: bold;
	}

	.table tbody {
	    display: block;
	    max-height: 71.3vh;  /* 10행 정도 높이 */
	    overflow-y: auto;
	}
	
	.table tbody tr {
	    display: table;
	    width: 100%;
	    table-layout: fixed;
	}
	
	.container {
    	display: flex;
    	flex-wrap: wrap; /* 자동 줄바꿈 */
    	gap: 5px;       /* div 사이 간격 */
  	}
  	
	.item {
		display: flex;
		flex: 1 0 22%;  /* 한 줄에 4개 (100% / 4 ≈ 25% - 여유로 22%) */
    	box-sizing: border-box;
    	text-align: center;
    	gap: 5px;
  	}
  	
  	.dataTables_scrollHeadInner {
    	width: 100% !important;
	}
	table.dataTable {
	    width: 100% !important;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<body>
	<div style = "display: flex; justify-content: space-between;">
		<div>거래명세서입력</div>
		<div style = "display: flex; gap: 5px;">
			<div id = "search">조회</div>	
			<div id = "new" onclick = "new_OutBound()">신규</div>
			<div id = "save" onclick = "save_OutBound()">저장</div>
			<div id = "delete">삭제</div>
		</div>
	</div>
	<div style = "display: flex; gap: 5px;">
		<div style = "width: 10%; border: solid 1px black;">
			<table class = "table" id="table1">
		        <thead>
		            <tr>
		                <th>사업단위</th>
		                <th>출고번호</th>
		            </tr>
		        </thead>
	    	</table>
		</div>
		<div style = "display:grid; gap: 5px; width: 90%;">
			<form id = "formData" role = "form" method = "post">
				<div style = "border: solid 1px black;">
					<div class = "container">
						<div class = "item">
							<div>사업단위</div>
							<div>
								<select id = "bu_Id" name = "bu_Id" style = "width: 150px;">
									<option value = ""></option>
									<option value = "10">본사</option>
									<option value = "20">PC기기 유통사업</option>
								</select>
							</div>
						</div>
						<div class = "item">
							<div>거래서명세일</div>
							<div>
								<input type = "date" id = "out_Date">
							</div>
						</div>
						<div class = "item">
							<div>거래명세서번호</div>
							<div>
								<input type = "text" id = "out_Id" style = "width: 150px;" readonly>
							</div>
							</div>
						<div class = "item">
							<div>Local구분</div>
							<div>
								<select id = "local_Flag" name = "local_Flag" style = "width: 150px;">
									<option value = ""></option>
									<option value = "10">내수</option>
									<option value = "20">Local(후LC)</option>
									<option value = "30">Local(선LC)</option>
								</select>
							</div>
						</div>
						<div class = "item">
							<div>거래처</div>
							<div>
								<input type = "text" id = "party_Name" style = "width: 150px;">
							</div>
						</div>
						<div class = "item">
							<div>거래처번호</div>
							<div>
								<input type = "text" id = "party_Id" style = "width: 150px;">
							</div>
						</div>
						<div class = "item">
							<div>담당자</div>
							<div>
								<input type = "text" id = "contact_Name" style = "width: 150px;">
							</div>
						</div>
						<div class = "item">
							<div>부서</div>
							<div>
								<input type = "text" id = "department" style = "width: 150px;">
							</div>
						</div>
						<div class = "item">
							<div>출고구분</div>
							<div>
								<select id = "out_Type" name = "out_Type" style = "width: 150px;">
									<option value = ""></option>
									<option value = "10">수주</option>
									<option value = "20">적송요청</option>
									<option value = "30">위탁출고요청</option>
									<option value = "40">기타출고요청</option>
								</select>
							</div>
						</div>
						<div class = "item">
							<div>위탁구분</div>
							<div>
								<select id = "consignment_Gubun" name = "consignment_Gubun" style = "width: 150px;">
									<option value = ""></option>
									<option value = "10">일반</option>
									<option value = "20">위탁</option>
									<option value = "30">판매후보관</option>
								</select>
							</div>
						</div>
						<div class = "item">
						</div>
						<div class = "item">
						</div>
					</div>
				</div>
			</form>
			<div style = "border: solid 1px black;">
				<div class = "container" style = "margin-top: 5px;">
					<div class = "item">
						<div>통화</div>
						<div>
							<select name = "bu_Id" style = "width: 150px;">
								<option value = ""></option>
								<option value = "10">본사</option>
							</select>
						</div>
					</div>
					<div class = "item">
					<div>판매가액계</div>
					<div>
						<select name = wareHouse_Master_Id style = "width: 150px;">
							<option value = ""></option>
						</select>
					</div>
					</div>
					<div class = "item">
					<div>부가세계</div>
					<div>
						<input type = "text" style = "width: 150px;">
					</div>
					</div>
					<div class = "item">
					<div>총액</div>
					<div>
						<select name = "" style = "width: 150px;">
							<option value = ""></option>
						</select>
					</div>
					</div>
					<div class = "item">
					<div>환율</div>
					<div>
						<select name = "bu_Id" style = "width: 150px;">
							<option value = ""></option>
							<option value = "10">본사</option>
						</select>
					</div>
					</div>
					<div class = "item">
					<div>판매가액계(원화)</div>
					<div>
						<select name = wareHouse_Master_Id style = "width: 150px;">
							<option value = ""></option>
						</select>
					</div>
					</div>
					<div class = "item">
						<div>부가세계(원화)</div>
						<div>
							<input type = "text" style = "width: 150px;">
						</div>
					</div>
					<div class = "item">
					<div>총액(원화)	</div>
					<div>
						<input type = "text" style = "width: 150px;">
					</div>
					</div>
				</div>
			</div>
			<div style = "border: solid 1px black; height: 78vh">  
				<table class = "table" id="table2">
			        <thead>
			            <tr>
			                <th style = "width: 30px;">품번</th>
			                <th>품명</th>
			                <th>규격</th>
			                <th>거래처품번</th>
			                <th>거래처명</th>
			                <th>수량</th>
			                <th>판매단위</th>
			                <th>판매단가</th>
			                <th>부가세포함</th>
			                <th>판매금액</th>
			                <th>부가세액</th>
			                <th>판매기준가</th>
			                <th>판매금액계</th>
			                <th>기준단위</th>
			                <th>창고</th>
			                <th>특이사항</th>
			                <th>Lot No.</th>
			                <th>기타출고구분</th>
			                <th>유상사급여부</th>
			                <th>품목자산분류</th>
			                <th>자산처리구분</th>
			            </tr>
			        </thead>
			        <tbody>
			        </tbody>
	    		</table>
			</div>
		</div>
	</div>
</body>
</html>

<script>

	master_Search();

	function master_Search() {
	
		$.ajax({
	    	url: '/InvFlowConfig/outbound_master',
	        type: 'GET',
	        dataType: 'json',
	        data: "",
	        success: function(result) {
	        	
	            // 기존 DataTable 초기화
	            if ($.fn.DataTable.isDataTable('.table')) {
	                $('.table').DataTable().clear().destroy();
	            }

	            $("#table1").DataTable({
	                lengthChange: false, // 표시건수기능
	                searching: false,    // 검색 기능
	                ordering: false,     // 정렬 기능
	                info: false,         // 정보 표시
	                paging: false,       // 페이징기능
	                data: result,
	                select: {
				      style: 'single'  // 단일 행 선택 (or 'multi' / 'os')
				    },
	                columns: [
	                    { data: "bu_Name" },
	                    { data: "out_Id" }
	                ]
	            });
	            
	            $('#table1 tbody').off('click'); // 기존 이벤트 제거
	            $('#table1 tbody').on('click', 'tr', function () {
	            	var data = $("#table1").DataTable().row(this).data();
	            	
	            	detail_Search1(data.bu_Id, data.out_Id);
	            	detail_Search2(data.bu_Id, data.out_Id);
	            });
	        }
	    }); 
	}
	
	function detail_Search1(bu_Id, out_Id) {
	
		$.ajax({
	    	url: '/InvFlowConfig/outbound_detail1',
	        type: 'GET',
	        dataType: 'json',
	        data: { bu_Id: bu_Id, out_Id: out_Id }, // key-value
	        success: function(result) {
	        	$("#bu_Id").val(result[0].bu_Id); 	
				$("#out_Date").val(result[0].out_Date); 	
				$("#out_Id").val(result[0].out_Id); 	
				$("#local_Flag").val(result[0].local_Flag); 	
				$("#party_Name").val(result[0].party_Name); 	
				$("#party_Id").val(result[0].party_Id); 	
				$("#contact_Name").val(result[0].contact_Name); 	
				$("#department").val(result[0].department); 	
				$("#out_Type").val(result[0].out_Type); 	
				$("#consignment_Gubun").val(result[0].consignment_Gubun); 	
	        }
	    }); 
	}
	
	function detail_Search2(bu_Id, out_Id) {
		
		$.ajax({
	    	url: '/InvFlowConfig/outbound_detail2',
	        type: 'GET',
	        dataType: 'json',
	        data: { bu_Id: bu_Id, out_Id: out_Id }, // key-value
	        success: function(result) {
				// 기존 DataTable 초기화
	            if ($.fn.DataTable.isDataTable('#table2')) {
	                $('#table2').DataTable().clear().destroy();
	                $('#table2 tbody').empty(); // 기존 데이터 제거
	            }

	            $("#table2").DataTable({
	                lengthChange: false, // 표시건수기능
	                searching: false,    // 검색 기능
	                ordering: false,     // 정렬 기능
	                info: false,         // 정보 표시
	                paging: false,       // 페이징기능
	                data: result,
	                select: {
				      style: 'single'  // 단일 행 선택 (or 'multi' / 'os')
				    },
	                columns: [
	                    { data: "item_Id" },
	                    { data: "item_Name" },
	                    { data: "spec" },
	                    { data: "party_Id" },
	                    { data: "party_Name" },
	                    { data: "qty" },
	                    { data: "sales_Unit" },
	                    { data: "unit_Price" },
	                    { data: "surtax_Yn", render: function(data, type, row, meta) {
	                        if (data === "Y") {
	                            return '<input type="checkbox" checked>';
	                        } else {
	                            return '<input type="checkbox">';
	                        }
	                    } },
	                    { data: "sales_Price" },
	                    { data: "surtax_Price" },
	                    { data: "unit_Price" },
	                    { data: "sales_Price_Sum" },
	                    { data: "base_Unit" },
	                    { data: "storage_Location" },
	                    { data: "special_Note" },
	                    { data: "lot_No" },
	                    { data: "other_Out_Code", render: function(data, type, row, meta) {
	                        return '<select class="form-select">'
	                        + '<option value="" ' + (data === '' ? 'selected' : '') + '></option>'
	                        + '<option value="10" ' + (data === '10' ? 'selected' : '') + '>판촉</option>'
	                        + '<option value="20" ' + (data === '20' ? 'selected' : '') + '>샘플출고</option>'
	                        + '</select>';
	                	} },
	                    { data: "is_Charge_Supply", render: function(data, type, row, meta) {
	                        if (data === "Y") {
	                            return '<input type="checkbox" checked>';
	                        } else {
	                            return '<input type="checkbox">';
	                        }
	                    } },
	                    { data: "asset_Class" },
	                    { data: "asset_Proc_Type" }
	                ],
	                autoWidth: false, // 자동 컬럼 너비 비활성화
	                scrollX: true // 가로 스크롤
	            });
	            
	            $('#table2 tbody').off('dblclick'); // 기존 이벤트 제거
	            $('#table2 tbody').on('dblclick', 'tr', function () {
	            	var data = $("#table2").DataTable().row(this).data();
	            	
	            	openPopup4(data);		// 품번
	            });
	        }
	    }); 
	}
	
	function new_OutBound () {
		
		var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	    
	    var today = year + '-' + month + '-' + day;
		
	    var result = [];
	    
		// 선택 해제
		$('#table1').DataTable().rows({ selected: true }).deselect();
		
		$("#bu_Id").val(""); 	
		$("#out_Date").val(today); 	
		$("#out_Id").val("자동생성"); 	
		$("#local_Flag").val(""); 	
		$("#party_Name").val(""); 	
		$("#party_Id").val(""); 	
		$("#contact_Name").val(""); 	
		$("#department").val(""); 	
		$("#out_Type").val(""); 	
		$("#consignment_Gubun").val("");
		
		// 기존 DataTable 초기화
        if ($.fn.DataTable.isDataTable('#table2')) {
            $('#table2').DataTable().clear().destroy();
            $('#table2 tbody').empty(); // 기존 데이터 제거
        }
		
		for (var i = 0; i < 50; i++) {
			result.push({ 
				item_Id: '', item_Name: '', spec: '', party_Id: '', party_Name: '', qty: '', sales_Unit: '', unit_Price: ''
			  , surtax_Yn: '', sales_Price: '', surtax_Price: '', unit_Price: '', sales_Price_Sum: '', base_Unit: '', storage_Location: ''
			  , special_Note: '', lot_No: '', other_Out_Code: '', is_Charge_Supply: '', asset_Class: '', asset_Proc_Type: '' }); // 빈값
		}
		
		$("#table2").DataTable({
            lengthChange: false, // 표시건수기능
            searching: false,    // 검색 기능
            ordering: false,     // 정렬 기능
            info: false,         // 정보 표시
            paging: false,       // 페이징기능
            data: result,
            select: {
		      style: 'single'  // 단일 행 선택 (or 'multi' / 'os')
		    },
            columns: [
                { data: "item_Id" },
                { data: "item_Name" },
                { data: "spec" },
                { data: "party_Id" },
                { data: "party_Name" },
                { data: "qty" },
                { data: "sales_Unit" },
                { data: "unit_Price" },
                { data: "surtax_Yn", render: function(data, type, row, meta) {
                    if (data === "Y") {
                        return '<input type="checkbox" checked>';
                    } else {
                        return '<input type="checkbox">';
                    }
                } },
                { data: "sales_Price" },
                { data: "surtax_Price" },
                { data: "unit_Price" },
                { data: "sales_Price_Sum" },
                { data: "base_Unit" },
                { data: "storage_Location" },
                { data: "special_Note" },
                { data: "lot_No" },
                { data: "other_Out_Code", render: function(data, type, row, meta) {
                    return '<select class="form-select">'
                    + '<option value="" ' + (data === '' ? 'selected' : '') + '></option>'
                    + '<option value="10" ' + (data === '10' ? 'selected' : '') + '>판촉</option>'
                    + '<option value="20" ' + (data === '20' ? 'selected' : '') + '>샘플출고</option>'
                    + '</select>';
            	} },
                { data: "is_Charge_Supply", render: function(data, type, row, meta) {
                    if (data === "Y") {
                        return '<input type="checkbox" checked>';
                    } else {
                        return '<input type="checkbox">';
                    }
                } },
                { data: "asset_Class" },
                { data: "asset_Proc_Type" }
            ],
            autoWidth: false, // 자동 컬럼 너비 비활성화
            scrollX: true // 가로 스크롤
        });
		
		$('#table2 tbody').off('dblclick'); // 기존 이벤트 제거
        $('#table2 tbody').on('dblclick', 'tr', function () {
        	var rowIndex = $('#table2').DataTable().row(this).index();
        	var data = $("#table2").DataTable().row(this).data();
        	
        	openPopup4();		// 품번
        });
	}
	
	function openPopup4() {
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
	     "item_popup",
	     "popupWindow",
	     "width=" + popupWidth +
	     ",height=" + popupHeight +
	     ",left=" + left +
	     ",top=" + top +
	     ",scrollbars=yes,resizable=yes"
	   );
	}
	
	// 팝업에서 선택된 데이터를 받을 함수
  	function selectRow_Item(data) {
 		
  	    var result = $("#table2").DataTable().rows().data().toArray();

  	    var data = {
			item_Id: data.item_Id, item_Name: data.item_Name, spec: '', party_Id: '', party_Name: '', qty: '', sales_Unit: '', unit_Price: ''
  		  , surtax_Yn: '', sales_Price: '', surtax_Price: '', unit_Price: '', sales_Price_Sum: '', base_Unit: '', storage_Location: ''
  		  , special_Note: '', lot_No: '', other_Out_Code: '', is_Charge_Supply: '', asset_Class: '', asset_Proc_Type: ''};

  	    for (var i = 0; i < result.length; i++) {
  	    	if (result[i].item_Id != null) {
  	    		result.splice(i, 0, data);
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
            data: result,
            select: {
		      style: 'single'  // 단일 행 선택 (or 'multi' / 'os')
		    },
            columns: [
                { data: "item_Id" },
                { data: "item_Name" },
                { data: "spec" },
                { data: "party_Id" },
                { data: "party_Name" },
                { data: "qty" },
                { data: "sales_Unit" },
                { data: "unit_Price" },
                { data: "surtax_Yn", render: function(data, type, row, meta) {
                    if (data === "Y") {
                        return '<input type="checkbox" checked>';
                    } else {
                        return '<input type="checkbox">';
                    }
                } },
                { data: "sales_Price" },
                { data: "surtax_Price" },
                { data: "unit_Price" },
                { data: "sales_Price_Sum" },
                { data: "base_Unit" },
                { data: "storage_Location" },
                { data: "special_Note" },
                { data: "lot_No" },
                { data: "other_Out_Code", render: function(data, type, row, meta) {
                    return '<select class="form-select">'
                    + '<option value="" ' + (data === '' ? 'selected' : '') + '></option>'
                    + '<option value="10" ' + (data === '10' ? 'selected' : '') + '>판촉</option>'
                    + '<option value="20" ' + (data === '20' ? 'selected' : '') + '>샘플출고</option>'
                    + '</select>';
            	} },
                { data: "is_Charge_Supply", render: function(data, type, row, meta) {
                    if (data === "Y") {
                        return '<input type="checkbox" checked>';
                    } else {
                        return '<input type="checkbox">';
                    }
                } },
                { data: "asset_Class" },
                { data: "asset_Proc_Type" }
            ],
            autoWidth: false, // 자동 컬럼 너비 비활성화
            scrollX: true // 가로 스크롤
        });
 	}
	
	function save_OutBound() {
		
		var form = document.getElementById("formData");
		var formData = new FormData(form);
		
		console.log(form);
		console.log(formData);
		
		// 값 가져오기
// 		var data = {
// 		    itemName: formData.get("itemName"),   // "품목A"
// 		    qty: formData.get("qty"),             // "10" (문자열)
// 		    isAvailable: formData.get("isAvailable") !== null // 체크박스는 체크 시 값이 존재
// 		};

		
// 		$.ajax({
// 			url: '/uploadAjaxAction',
// 			processData: false,
// 			contentType: false,
// 			data: formData,
// 			type: 'POST',
// 			dataType: 'json',
// 			success: function(result) {
// 				console.log(result);
// 				showUploadedFile(result);	
// 			} 
// 		});
	}
	
</script>