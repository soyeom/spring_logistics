<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>출고처리하기 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class = "layout">
		<%@ include file="/WEB-INF/views/logistics.jsp" %>
    	<div class = "main">
    		<div class = "main-header">
    			<div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>거래명세서입력</h1></div>
	            <div>
	            	<button class="btn btn-secondary search-btn" id = "save" onclick = "new()">신규</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save()">저장</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "delete()">삭제</button>
				</div>
    		</div>
    		<div class = "filters">
    			<div class = "filters-main">
        			<div class = "title">조회 조건</div>
        			<div class = "line"></div>
	        	</div>
    			<div class = "filters-row">
    				<div class = "filters-count">
	            		<div class = "filters-text">사업단위</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="bu_Id">
							        <option value="${bu_Id.value}">${bu_Id.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래명세서일</div>
	            		<div class = "filters-value">
	            			 <input type="date" id="out_Daet" name="out_Date">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래명세서번호</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "out_Id">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="out_Master_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">Local구분</div>
	            		<div class = "filters-value">
	            			<select id = "local_Flag" name = "local_Flag">
								<option value = ""></option>
								<option value = "10">내수</option>
								<option value = "20">Local(후LC)</option>
								<option value = "30">Local(선LC)</option>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래처</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "party_Name">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="party_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래처번호</div>
	            		<div class = "filters-value">
							<input type = "text" name = "party_Id" id = "party_Id" readonly>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">담당자</div>
	            		<div class = "filters-value">
	            			<input type = "hidden" id = "contact_Id" name = "contact_id">
	            			<input type = "text" id = "contact_Name" name = "contact_Name">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="contact_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">부서</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "department" name = "department" readonly>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">출고구분</div>
	            		<div class = "filters-value">
	            			<select id = "out_Type" name = "out_Type">
								<option value = ""></option>
								<option value = "10">수주</option>
								<option value = "20">적송요청</option>
								<option value = "30">위탁출고요청</option>
								<option value = "40">기타출고요청</option>							    
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">위탁구분</div>
	            		<div class = "filters-value">
	            			<select id = "consignment_Gubun" name = "consignment_Gubun">
								<option value = ""></option>
								<option value = "10">일반</option>
								<option value = "20">위탁</option>
								<option value = "30">판매후보관</option>
							</select>
	            		</div>
            		</div>
    			</div>
    		</div>
    		<div class = "table-container">
				<table class="table-single-select">
					<thead>
						<tr>
					    	<th style = "width: 135px">품번</th>
					        <th style = "width: 140px">품명</th>
					        <th style = "width: 105px">규격</th>
					        <th style = "width: 105px">거래처품번</th>
					        <th style = "width: 105px">거래처</th>
					        <th style = "width: 90px">수량</th>
					        <th style = "width: 90px">판매단위</th>
					        <th style = "width: 90px">판매단가</th>
					        <th style = "width: 90px">부가세포함</th>
					        <th style = "width: 105px">판매금액</th>
					        <th style = "width: 125px">부가세액</th>
					        <th style = "width: 125px">판매기준가</th>
					        <th style = "width: 125px">기준단위</th>
					        <th style = "width: 105px">창고</th>
					        <th style = "width: 120px">Lot No.</th>
					        <th style = "width: 150px">기타출고구분</th>
					        <th style = "width: 150px">유상사급여부</th>
					        <th style = "width: 150px">품목자산분류</th>
					        <th style = "width: 150px">자산처리구분</th>
					        <th style = "width: 90px">현재고</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody">
				    </tbody>
				</table>
		    </div>
    	</div>
	</div>
	<script type="text/javascript" src="../resources/js/logistics.js"></script>
</body>
</html>

<script>
	
	function out_Master_Popup() {
		
		// 팝업 크기 설정
 	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	// 화면 중앙 좌표 계산
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
 	   	// 팝업창 열기
		window.open(
			"../popup/out_id_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function out_Id_RowData(data) {
		
		document.getElementById("bu_Id").value = data[1];
		document.getElementById("out_Daet").value = data[3];
		document.getElementById("out_Id").value = data[2];
		document.getElementById("local_Flag").value = data[5];
		document.getElementById("party_Name").value = data[6];
		document.getElementById("party_Id").value = data[7];
		document.getElementById("contact_Name").value = data[8];
		document.getElementById("department").value = data[10];
		document.getElementById("out_Type").value = data[12];
		document.getElementById("consignment_Gubun").value = data[14];
		
		var formData = {
			bu_Id: data[1],
			out_Id: data[2]
		}
		
		$.ajax({
			url: '/InvFlowConfig/out_detail_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = ""; // 기존 내용 초기화
	            
	            const totalRows = result.length + 3; // 테이블에 항상 3개의 빈 로우
	            
	         	// result 배열 반복
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.item_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>';
	                    
                    tr.ondblclick = function() {
                    	// open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	         	// 빈 로우 추가
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(20); // 컬럼 수 만큼 빈 칸
	                tr.ondblclick = function() {
                   		open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            }
			}
		});	
	}
	
	function party_Popup() {
		
		// 팝업 크기 설정
 	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	// 화면 중앙 좌표 계산
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
 	   	// 팝업창 열기
		window.open(
			"../popup/party_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function party_RowData(data) {
		
		console.log(data);
		
		document.getElementById("party_Name").value = data[3];
		document.getElementById("party_Id").value = data[2];
	}
	
	function contact_Popup() {
		
		// 팝업 크기 설정
 	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	// 화면 중앙 좌표 계산
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
 	   	// 팝업창 열기
		window.open(
			"../popup/contact_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function contact_RowData(data) {
		document.getElementById("contact_Id").value = data[0];
		document.getElementById("contact_Name").value = data[1];
		document.getElementById("department").value = data[2];
	}
	
	
</script>