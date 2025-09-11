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
	#table1 {
		width: 100%;
	    min-height: 350px;
	    border-collapse: collapse;
	    font-family: Arial, sans-serif;
	    font-size: 14px;
	}

	#table1 thead, #table1 tbody tr {
	    display: table;
	    width: 100%;
	    table-layout: fixed;
	}
	
	/* 헤더 스타일 */
	#table1 thead th {
	    background-color: #4CAF50;
	    color: white;
	    text-align: center;
	    padding: 8px;
	}
	
	/* 데이터 행 스타일 */
	#table1 tbody tr {
	    text-align: center;
	    height: 35px;       /* 행 높이 */
	    cursor: pointer;    /* 마우스 오버시 포인터 */
	}
	
	/* 홀수/짝수 행 색상 */
	#table1 tbody tr:nth-child(odd) {
	    background-color: #f9f9f9;
	}
	
	#table1 tbody tr:nth-child(even) {
	    background-color: #ffffff;
	}
	
	/* 마우스 오버 */
	#table1 tbody tr:hover {
	    background-color: #d1e7fd;
	}
	
	/* 선택된 행 강조 */
	#table1 tbody tr.selected {
	    background-color: #a8d5ff !important;
	    font-weight: bold;
	}

	#table1 tbody {
	    display: block;
	    max-height: 350px;  /* 10행 정도 높이 */
	    overflow-y: auto;
	}
	
	#table1 tbody tr {
	    display: table;
	    width: 100%;
	    table-layout: fixed;
	}
	
	.table-wrapper {
      max-height: 400px;   /* 높이 제한 (20행 기준) */
      overflow-y: auto;    /* 세로 스크롤 자동 */
      border: 1px solid #ccc;
    }
	
	#table2 {
      width: 100%;
      border-collapse: collapse; /* 셀 간격 제거 */
    }

    #table2 th, 
    #table2 td {
      padding: 8px 12px;
      text-align: left;
      border-bottom: 1px solid #333; /* 가로줄 */
    }

    #table2 th {
      background-color: #f2f2f2;
      position: sticky; /* 스크롤 내려도 헤더 고정 */
      top: 0;
      z-index: 1;
    }
    
    #table3 {
      width: 100%;
      border-collapse: collapse; /* 셀 간격 제거 */
    }

    #table3 th, 
    #table3 td {
      padding: 8px 12px;
      text-align: left;
      border-bottom: 1px solid #333; /* 가로줄 */
    }

    #table3 th {
      background-color: #f2f2f2;
      position: sticky; /* 스크롤 내려도 헤더 고정 */
      top: 0;
      z-index: 1;
    }
    
    
</style>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>		
		<div>조회조건</div>
		<div style = "display: flex; justify-content: space-between">
			<div style = "display: flex; gap: 5px;">
				<div>사업단위</div>
				<div>
					<select name = "bu_Id" style = "width: 150px;">
						<option value = ""></option>
						<option value = "10">본사</option>
					</select>
				</div>
				<div>창고구분</div>
				<div>
					<select name = wareHouse_Master_Id style = "width: 150px;">
						<option value = ""></option>
					</select>
				</div>
				<div>창고명</div>
				<div>
					<input type = "text" style = "width: 150px;">
				</div>
				<div>창고그룹
				</div>
				<div>
					<select name = "" style = "width: 150px;">
						<option value = ""></option>
					</select>
				</div>
				<div>
					<button type = "button">창고구분별 재고조회설정</button>
				</div>
			</div>
			<div style = "display: flex; gap: 5px">
				<div>조회</div>
				<div>저장</div>
			</div>
		</div>
	</div>
	<div>
		<table id="table1">
	        <thead>
	            <tr>
	                <th>사업단위</th>
	                <th>창고구분내부코드</th>
	                <th>창고구분</th>
	                <th>창고내부코드</th>
	                <th>창고명</th>
	            </tr>
	        </thead>
	    </table>
    </div>
    <div style = "display: flex; gap: 5px; margin-top: 5px;">
    	<div>창고명</div>
    	<div><input type = "text" id = "wareHouse_Name" style = "width: 150px;"></div>
    </div>
    <div style = "display: flex; gap: 5px;">
    	<div>
    		<div>관리품목정보</div>
    		<div class = "table-wrapper">
    			<table id="table2">
			        <thead>
			            <tr>
			                <th>품명</th>
			                <th>품번</th>
			                <th>규격</th>
			                <th>안전재고수량</th>
			                <th>보관위치</th>
			            </tr>
			        </thead>
			    </table>
    		</div>
    	</div>
    	<div>
    		<div>담당자정보</div>
    		<div class = "table-wrapper">
    			<table id="table3">
			        <thead>
			            <tr>
			                <th>창고담당자</th>
			                <th>부서</th>
			            </tr>
			        </thead>
			    </table>
    		</div>
    	</div>
    </div>
</body>
</html>

<script>
	$(document).ready(function() {
		search();
		
		
	});

	function search() {
	
		$.ajax({
			url: '/InvFlowConfig/list',
			processData: false,
			contentType: false,
			data: "",
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				 // 기존 DataTable 초기화
	            if ($.fn.DataTable.isDataTable('#table1')) {
	                $('#table1').DataTable().clear().destroy();
	            }
				
				$("#table1").DataTable({
					lengthChange: false,		// 표시건수기능
					searching: false,			// 검색 기능
					ordering: false,			// 정렬 기능
					info: false,				// 정보 표시
					paging: false,				// 페이징기능	
					data: result,
				 	select: {
				      style: 'single'  // 단일 행 선택 (or 'multi' / 'os')
				    },
					columns: [
		                { data: "bu_Name" },
		                { data: "wareHouse_Master_Id" },
		                { data: "wareHouse_Internal_Code" },
		                { data: "wareHouse_Id" },
		                { data: "wareHouse_Name" }
		            ]
				});
				
				// **행 더블클릭 이벤트 등록**
	            $('#table1 tbody').off('dblclick'); // 기존 이벤트 제거
	            $('#table1 tbody').on('dblclick', 'tr', function () {
	            	var data = $("#table1").DataTable().row(this).data(); 	// 클릭한 행의 데이터 가져오기
	            	$("#wareHouse_Name").val(data.wareHouse_Name);			// 행 데이터 창고명에 입력

	            	item_Search(data.wareHouse_Id);
	            	contact_Search(data.wareHouse_Id);
	            	
// 	            	var data = $("#table1").DataTable().row(this).data(); // 클릭한 행의 데이터 가져오기
// 	                if (data) {
// 	                    alert("창고ID: " + data.wareHouse_Id + ", 창고명: " + data.wareHouse_Name);
// 	                }
	            });
			}
		});
	}
	
	function item_Search(wareHouse_Id) {
	    
		var minRows = 5;

	    $.ajax({
	    	url: '/InvFlowConfig/item_list',
	        type: 'GET',
	        dataType: 'json',
	        data: { wareHouse_Id: wareHouse_Id }, // key-value
	        success: function(result) {

       		 	// 실제 데이터 개수보다 최소 행이 더 많으면 빈 행 추가
	            while (result.length < minRows) {
	                result.push({ item_Id: '', item_Name: '', spec: '', safety_Stock_Qty: '', storage_Location: ''
	                }); // 빈값
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
	                columns: [
	                    { data: "item_Id" },
	                    { data: "item_Name" },
	                    { data: "spec" },
	                    { data: "safety_Stock_Qty" },
	                    { data: "storage_Location" }
	                ]
	            });
	            
	         	// **행 더블클릭 이벤트 등록**
	            $('#table2 tbody').off('dblclick'); // 기존 이벤트 제거
	            $('#table2 tbody').on('dblclick', 'tr', function () {
	            	var data = $("#table2").DataTable().row(this).data();
	            	
	            	openPopup1(data);
	            });
	            
	        } // success function 끝
	    }); // ajax 끝
	} // item_Search 끝
	
	function contact_Search(wareHouse_Id) {
	    
		var minRows = 5;

	    $.ajax({
	    	url: '/InvFlowConfig/contact_list',
	        type: 'GET',
	        dataType: 'json',
	        data: { wareHouse_Id: wareHouse_Id }, // key-value
	        success: function(result) {
	        	
       		 	// 실제 데이터 개수보다 최소 행이 더 많으면 빈 행 추가
	            while (result.length < minRows) {
	                result.push({ contact_Name: '', wareHouse_Name: '' }); // 빈값
	            }

	            // 기존 DataTable 초기화
	            if ($.fn.DataTable.isDataTable('#table3')) {
	                $('#table3').DataTable().clear().destroy();
	            }

	            $("#table3").DataTable({
	                lengthChange: false, // 표시건수기능
	                searching: false,    // 검색 기능
	                ordering: false,     // 정렬 기능
	                info: false,         // 정보 표시
	                paging: false,       // 페이징기능
	                data: result,
	                columns: [
	                    { data: "contact_Name" },
	                    { data: "wareHouse_Name" }
	                ]
	            });
	            
	            $('#table3 tbody').off('dblclick'); // 기존 이벤트 제거
	            $('#table3 tbody').on('dblclick', 'tr', function () {
	            	var data = $("#table3").DataTable().row(this).data();
	            	
	            	openPopup2(data);
	            });
	        }
	    }); 
	} 
	
  	function openPopup1(row) {
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
  	function setSelectedRow1(data) {
 		
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

</script>