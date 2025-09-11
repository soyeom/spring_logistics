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
	    max-height: 350px;  /* 10행 정도 높이 */
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
			<div>조회</div>
			<div>저장</div>
			<div>삭제</div>
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
							<input type = "text" id = "out_Id" style = "width: 150px;">
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
				console.log(result);	
				
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
	        }
	    }); 
	}
</script>