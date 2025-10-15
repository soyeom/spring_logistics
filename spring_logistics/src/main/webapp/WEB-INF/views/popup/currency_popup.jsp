<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>거래명세서</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body style = "background-color: #fff;">
	<div class="popup-wrapper">
		<!-- 헤더 -->
		<div class = "popup-header">통화</div>	  
	     <!-- 검색바 -->
	     <div class = "popup-search-bar">
	     	<div style = "flex: 2;">
     			<select id = "gubun">
	            	<option value = "0">전체</option>
	            	<option value = "10">통화</option>
	        	</select>
	     	</div>
	     	<div style = "flex: 7;">
	     		<input type="text" id = "text" placeholder="검색어를 입력하세요" autocomplete="off">
	     	</div>
	     	<div style = "flex: 1;">
	     		<button class="btn-primary" onclick = "search()">검색</button>
	     	</div>
	     </div>
	    <!-- 나머지 컨텐츠 -->
	    <div class="popup-body">
       		<div class = "table-container" style = "height: 400px;">
				<table class="table-single-select" style = "width: 100%">
					<thead>					 		<!-- 화면에 보여야 하는 테이블 헤더 수정 -->
						<tr>
					    	<th>통화</th>
					        <th>기준액</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody">		<!-- 화면에 보여야 하는 테이블 바디 수정 -->
			    		<c:forEach items = "${list}" var = "board">
					    	<tr>
								<td class = "text-center"><c:out value = "${board.column1}"/></td>
								<td class = "text-center"><c:out value = "${board.column2}"/></td>
							</tr>
				    	</c:forEach>
				    </tbody>
				</table>
		    </div>
	    </div>
	    <div class = "btn-primary" style = "width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;" onclick = "button_Click()">적용</div>
	</div>
</body>
</html>

<script>

	var selectedRow = null;

	(function() {
	    const tbody = document.querySelector('.table-single-select tbody');
	    if (!tbody) return;
	
	    tbody.addEventListener('click', function(e) {
	        const tr = e.target.closest('tr');
	        if (!tr) return;
	
	        if (selectedRow === tr) {
	            tr.classList.remove('tr-selected');
	            selectedRow = null;
	            return;
	        }
	
	        if (selectedRow) selectedRow.classList.remove('tr-selected');
	
	        tr.classList.add('tr-selected');
	        selectedRow = tr;
	    });
	})();

	// search();

	function search() {
		
		var formData = {
			gubun: document.getElementById("gubun").value,
			text: document.getElementById("text").value
		}
		
		$.ajax({
			url: '/popup/currency_list',			// '/popup/Controller에 불러올 getMapping 주소 입력'
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				// 기존 내용 초기화
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = ""; 
	            
	         	// result 배열 반복
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	            	// tbody 생성한 만큼 입력
	                tr.innerHTML = 
	                	'<td class="text-center">' + (board.column1 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column2 || '') + '</td>';
	                    
	                tbody.appendChild(tr);
	            });
			}			
		});
	}
	
	function button_Click() {
		
	    if (!selectedRow) {
	        alert("선택된 행이 없습니다!");
	        return;
	    }

	    const data = [];

	    selectedRow.querySelectorAll("td").forEach(function(td) {
	    	
	        const text = td.textContent.trim() || "";
	        data.push(text);

	        const hiddenInputs = td.querySelectorAll('input[type="hidden"]');
	        if (hiddenInputs.length > 0) {
	            hiddenInputs.forEach(function(input) {
	                data.push(input.value || "");
	            });
	        }
	    });
	    window.opener.currency_RowData(data);

	    window.close();
	}
	
</script>