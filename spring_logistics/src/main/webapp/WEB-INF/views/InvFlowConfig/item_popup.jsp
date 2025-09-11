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

	.table-wrapper {
      max-height: 400px;   /* 높이 제한 (20행 기준) */
      overflow-y: auto;    /* 세로 스크롤 자동 */
      border: 1px solid #ccc;
    }
	
	#table_popup {
      width: 100%;
      border-collapse: collapse; /* 셀 간격 제거 */
    }

    #table_popup th, 
    #table_popup td {
      padding: 8px 12px;
      text-align: left;
      border-bottom: 1px solid #333; /* 가로줄 */
    }

    #table_popup th {
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
	<div style = "display:flex;">
		<div>
			<select name = "" style = "width: 150px;">
				<option value = "10">품목코드</option>
			</select>
		</div>
		<div>
			<input type = "text" style = "width: 400px;">
		</div>
	</div>
	<div class = "table-wrapper">
		<table id="table_popup">
       		<thead>
          		<tr>
	               <th>품번</th>
	               <th>규격</th>
	               <th>품명</th>
	               <th>품목자산분류</th>
	               <th>소분류</th>
	               <th>단위</th>
	               <th>기준단위</th>
	               <th>영문명</th>
           		</tr>
       		</thead>
   		</table>
	</div>
	<div>
		<button>적용</button>
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
				
				$("#table_popup").DataTable({
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
	            $('#table_popup tbody').off('dblclick'); // 기존 이벤트 제거
	            $('#table_popup tbody').on('dblclick', 'tr', function () {
	            	
           			$("#table_popup").DataTable().on('select', function(e, dt, type, indexes) {
           		  		var rowData = $("#table_popup").DataTable().rows(indexes).data().toArray();
            		
           		  		var data = {
            	        	item_id: rowData[0].bu_id
            	      	};
           		  		
           		 		// 부모창 함수 호출 + 데이터 전달
						window.opener.setSelectedRow1(data);
						// 팝업 닫기
				      	window.close();
           			});
	            });
			}
		});
	}
</script>