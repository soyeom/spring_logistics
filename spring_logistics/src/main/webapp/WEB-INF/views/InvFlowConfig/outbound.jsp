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
	            	<button class="btn btn-secondary search-btn" id = "save" onclick = "new_out()">신규</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save()">저장</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "outBound_delete()">삭제</button>
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
	            			<input type = "text" id = "out_Id" readonly>
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
    		<div class = "filters">
    			<div class = "filters-main">
        			<div class = "title">추가정보</div>
        			<div class = "line"></div>
	        	</div>
    			<div class = "filters-row">
    				<div class = "filters-count">
	            		<div class = "filters-text">환율</div>
	            		<div class = "filters-value">
            				<input type = "text" id = "currency_Code" name = "currency_Code">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="currency_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">판매가액계</div>
	            		<div class = "filters-value">
	            			 <input type="number" id="out_Daet" name="out_Date">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">부가세계</div>
	            		<div class = "filters-value">
	            			<input type="number" id="out_Daet" name="out_Date">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">총액</div>
	            		<div class = "filters-value">
            				<input type="number" id="out_Daet" name="out_Date">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">환율</div>
	            		<div class = "filters-value">
	            			<input type="number" id="exchange_Rate" name="exchange_Rate">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">판매가액계(원화)</div>
	            		<div class = "filters-value">
							<input type="number" id="out_Daet" name="out_Date">
						</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">부가세계(원화)</div>
	            		<div class = "filters-value">
            				<input type="number" id="out_Daet" name="out_Date">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">총액(원화)</div>
	            		<div class = "filters-value">
	            			<input type="number" id="out_Daet" name="out_Date">
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

	function new_out() {
		document.getElementById("bu_Id").value = "";
		document.getElementById("out_Daet").value = "";
		document.getElementById("out_Id").value = "자동생성";
		document.getElementById("local_Flag").value = "";
		document.getElementById("party_Name").value = "";
		document.getElementById("party_Id").value = "";
		document.getElementById("contact_Name").value = "";
		document.getElementById("department").value = "";
		document.getElementById("out_Type").value = "";
		document.getElementById("consignment_Gubun").value = "";
		
		const tbody = document.getElementById("result-tbody");
	    tbody.innerHTML = ""; // 기존 내용 초기화
	    
	 	// 빈 로우 추가
	    const emptyRows = 3;
	    for (let i = 0; i < emptyRows; i++) {
	        const tr = document.createElement("tr");
	        tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(20); // 컬럼 수 만큼 빈 칸
	        tr.ondblclick = function() {
	       		open_Item();
	        }
	            
	        tbody.appendChild(tr);
	    }
	}
	
	function save() {
		
	    var formData = {
    		out_Id: document.getElementById("out_Id").value,
            bu_Id: document.getElementById("bu_Id").value,
            out_Date: document.getElementById("out_Daet").value,
            local_Flag: document.getElementById("local_Flag").value,
            party_Id: document.getElementById("party_Id").value,
            contact_Id: document.getElementById("contact_Id").value,
            out_Type: document.getElementById("out_Type").value,
            consignment_Gubun: document.getElementById("consignment_Gubun").value
	    }
	    
	    // AJAX 호출
	    $.ajax({
	        url: '/InvFlowConfig/outbound_save',           // Spring @PostMapping 매핑
	        type: 'POST',
	        data: formData,
	        success: function(result) {
	        	save_Detail1(result);
	        },
	        error: function(xhr, status, error) {
	        	console.error("저장 실패:", error);
	        }
	    });
	}
	
	function save_Detail1(out_Id) {
		
		var tbody = document.getElementById("result-tbody");

		// tbody 안 모든 tr 순회
	    var allData = Array.from(tbody.rows)
	        .filter(function(tr) {
	            var firstValue = tr.cells[0].textContent.trim();
	            return firstValue !== null && firstValue !== "";
	        })
	        .map(function(tr) {
	            // 기존 td 텍스트 수집
	            var rowData = Array.from(tr.cells).map(function(td) {
	            	// td 안에 checkbox가 있는지 확인
	                var checkbox = td.querySelector('input[type="checkbox"]');
	                if (checkbox) {
	                    // 체크 여부를 Y/N으로 변환해서 반환
	                    return checkbox.checked ? "Y" : "N";
	                } else {
	                    // 아니면 그냥 텍스트
	                    return td.textContent.trim();
	                }
	            });
	
	            // bu_Id, wm_id, w_id를 앞에 추가
	            rowData.unshift(out_Id);  // wm_id
	            rowData.unshift(document.getElementById("bu_Id").value);  // bu_Id
	            rowData.unshift(document.getElementById("party_Id").value);  // bu_Id
	
	            return rowData;
	        });
		
		// AJAX 호출
	    $.ajax({
	        url: '/InvFlowConfig/outbound_save_detail',           // Spring @PostMapping 매핑
	        type: 'POST',
	        contentType: 'application/json', // JSON 전송
	        data: JSON.stringify(allData),    // 2차원 배열 → JSON 문자열
	        success: function(result) {
	        	alert("저장되었습니다.");
	        	
	        	document.getElementById("out_Id").value = out_Id;
	        	
	        	var formData = {
	        			bu_Id: document.getElementById("bu_Id").value,
	        			out_Id: out_Id
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
	        	                    '<td class="text-center">' + (board.spec || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.party_Id || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.party_Name || '') + '</td>' +
	        	                    '<td class="text-center"><span contenteditable="true">' + (board.qty || '') + '</span></td>' +
	        	                    '<td class="text-center">' + (board.sales_Unit || '') + '</td>' +
	        	                    '<td class="text-center"><span contenteditable="true">' + (board.unit_Price || '') + '</span></td>' +
	        	                    '<td class="text-center"><input type="checkbox"' + (board.surtax_Yn === 'Y' ? ' checked' : '') + '></td>' +
	        	                    '<td class="text-center">' + (board.sales_Price || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.sales_Price_Sum || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.unit_Price || '') + '</td>' +
	        	                    '<td class="text-center"><input type="hidden" value="' + (board.storage_Location || '') + '" /><span>' + (board.wareHouse_Name || '') + '</span></td>' +
	        	                    '<td class="text-center">' + (board.lot_No || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.other_Out_Code || '') + '</td>' +
	        	                    '<td class="text-center"><input type="checkbox"' + (board.is_Charge_Supply === 'Y' ? ' checked' : '') + '></td>' +
	        	                    '<td class="text-center">' + (board.asset_Class || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.asset_Proc_Type || '') + '</td>' +
	        	                    '<td class="text-center">' + (board.current_Qty || '') + '</td>';
	        	                    
	                            tr.ondblclick = function() {
	                            	open_Item();
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
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 실패:", error);
	        }
	    });
	}
	
	function outBound_delete() {
		if (confirm('삭제하시겠습니까?')) {
		    // 사용자가 예 클릭
		    // 실제 삭제 로직 호출
	    	console.log('삭제 진행');
		    // 예: deleteItem(itemId);
	  	} else {
	    	// 사용자가 취소 클릭
	    	console.log('삭제 취소');
	  	}
	}

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
		document.getElementById("contact_Id").value = data[9];
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
	                    '<td class="text-center">' + (board.spec || '') + '</td>' +
	                    '<td class="text-center">' + (board.party_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.party_Name || '') + '</td>' +
	                    '<td class="text-center"><span contenteditable="true">' + (board.qty || '') + '</span></td>' +
	                    '<td class="text-center">' + (board.sales_Unit || '') + '</td>' +
	                    '<td class="text-center"><span contenteditable="true">' + (board.unit_Price || '') + '</span></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.surtax_Yn === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center">' + (board.sales_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.sales_Price_Sum || '') + '</td>' +
	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.unit_Price || '') + '</td>' +
	                    '<td class="text-center"><input type="hidden" value="' + (board.storage_Location || '') + '" /><span>' + (board.wareHouse_Name || '') + '</span></td>' +
	                    '<td class="text-center">' + (board.lot_No || '') + '</td>' +
	                    '<td class="text-center">' + (board.other_Out_Code || '') + '</td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.is_Charge_Supply === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center">' + (board.asset_Class || '') + '</td>' +
	                    '<td class="text-center">' + (board.asset_Proc_Type || '') + '</td>' +
	                    '<td class="text-center">' + (board.current_Qty || '') + '</td>';
	                    
                    tr.ondblclick = function() {
                    	open_Item();
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
	
	function currency_Popup() {
		
		// 팝업 크기 설정
 	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	// 화면 중앙 좌표 계산
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
 	   	// 팝업창 열기
		window.open(
			"../popup/currency_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function currency_RowData(data) {
 		document.getElementById("currency_Code").value = data[0];
 		document.getElementById("exchange_Rate").value = data[1];
	}
	
	function open_Item() {
	  	
	    // 팝업 크기 설정
	    var popupWidth = 900;
	    var popupHeight = 600;
	
	    // 화면 중앙 좌표 계산
	    var left = (screen.width - popupWidth) / 2;
	    var top = (screen.height - popupHeight) / 2;
	
		// 팝업창 열기
		window.open(
			"../popup/item_popup",
	     	"popupWindow",
	     	"width=" + popupWidth +
	     	",height=" + popupHeight +
	     	",left=" + left +
	     	",top=" + top +
	     	",scrollbars=no,resizable=yes"
	   );
	}
	
	// 팝업에서 선택된 데이터를 받을 함수
  	function item_RowData(data) {
	    
 		var tbody = document.getElementById("result-tbody");
 		// 첫 번째 td 값이 비어있지 않은 tr만 필터링
 	    var filteredRows = Array.from(tbody.querySelectorAll("tr"))
 	        .filter(function(tr) {
 	            var firstValue = tr.cells[0].textContent.trim();
 	            return firstValue !== null && firstValue !== "";
 	        });

 	    // 각 tr의 td 값만 2차원 배열로 수집
 	    var allData = filteredRows.map(function(tr) {
 	        return Array.from(tr.cells).map(function(td) {
 	            return td.textContent.trim();
 	        });
 	    });
 	    
 	    for (var i = 0; i < allData.length; i++) {
 	    	if (allData[i][0] == data[0]) {
 	    		return;
 	    	}
 	    }
 
		var newData = [data[0], data[1], data[2], '', '', '0', data[5], '0', 'N', '0', '0', '0', data[5], data[9], data[10], '', '', 'N', '', '', '0'];
 	   
 		// 중복이 없으면 추가
 	    allData.push(newData);
 		
 	   	tbody.innerHTML = ""; // 기존 내용 초기화
       
       	const totalRows = allData.length + 3; // 테이블에 항상 4개의 로우 유지
       
    	// result 배열 반복
       	allData.forEach(function(board) {
		const tr = document.createElement("tr");
        	tr.innerHTML = 
               '<td class="text-center">' + (board[0] || '') + '</td>' +
               '<td class="text-center">' + (board[1] || '') + '</td>' +
               '<td class="text-center">' + (board[2] || '') + '</td>' +
               '<td class="text-center">' + (board[3] || '') + '</td>' +
               '<td class="text-center">' + (board[4] || '') + '</td>' +
               '<td class="text-center"><span contenteditable="true">' + (board[5] || '') + '</span></td>' +
               '<td class="text-center">' + (board[6] || '') + '</td>' +
               '<td class="text-center"><span contenteditable="true">' + (board[7] || '') + '</span></td>' +
               '<td class="text-center"><input type="checkbox"' + (board[8] === 'Y' ? ' checked' : '') + '></td>' +
               '<td class="text-center">' + (board[9] || '') + '</td>' +
               '<td class="text-center">' + (board[10] || '') + '</td>' +
               '<td class="text-center">' + (board[11] || '') + '</td>' +
               '<td class="text-center">' + (board[12] || '') + '</td>' +
               '<td class="text-center">' + (board[13] || '') + '</td>' +
               '<td class="text-center"><input type="hidden" value="' + (board[15] || '') + '" /><span>' + (board[14] || '') + '</span></td>' +
               '<td class="text-center">' + (board[16] || '') + '</td>' +
               '<td class="text-center"><input type="checkbox"' + (board[17] === 'Y' ? ' checked' : '') + '></td>' +
               '<td class="text-center">' + (board[18] || '') + '</td>' +
               '<td class="text-center">' + (board[19] || '') + '</td>' +
               '<td class="text-center">' + (board[20] || '') + '</td>';
               
            tr.ondblclick = function() {
				open_Item(); // td 값 배열 전달
           	}
               
           	tbody.appendChild(tr);
       });
       
    	// 빈 로우 추가
       const emptyRows = totalRows - allData.length;
       for (let i = 0; i < emptyRows; i++) {
           	const tr = document.createElement("tr");
           	tr.innerHTML = 
               '<td class="text-center">&nbsp;</td>'.repeat(20); // 컬럼 수 만큼 빈 칸
			tr.ondblclick = function() {
   				open_Item();
   			}
            tbody.appendChild(tr);
       }
	}
	
</script>