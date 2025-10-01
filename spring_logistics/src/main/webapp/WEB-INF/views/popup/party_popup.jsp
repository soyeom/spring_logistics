<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>거래처</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body style = "background-color: #fff;">
	<div class="popup-wrapper">
		<!-- 헤더 -->
		<div class = "popup-header">거래처</div>	  
	     <!-- 검색바 -->
	     <div class = "popup-search-bar">
	     	<div style = "flex: 2;">
     			<select id = "gubun">
	            	<option value = "0">전체</option>
	            	<option value = "10">사업단위</option>
	            	<option value = "20">거래처</option>
	            	<option value = "30">거래처번호</option>
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
				<table class="table-single-select">
					<thead>					 		<!-- 화면에 보여야 하는 테이블 헤더 수정 -->
						<tr>
					    	<th style = "width: 100px;">사업단위</th>
					        <th style = "width: 100px;">거래처코드</th>
					        <th style = "width: 150px;">거래처</th>
					        <th style = "width: 100px;">유통분류</th>
					        <th style = "width: 100px;">사업자번호</th>
					        <th style = "width: 100px;">상호</th>
					        <th style = "width: 100px;">약어</th>
					        <th style = "width: 150px;">주소</th>
					        <th style = "width: 150px;">연락처</th>
					        <th style = "width: 150px;">이메일</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody">		<!-- 화면에 보여야 하는 테이블 바디 수정 -->
			    		<c:forEach items = "${list}" var = "board">
					    	<tr>
								<td class = "text-center"><input type = "hidden" value = "${board.column1}"><c:out value = "${board.column2}"/></td>
								<td class = "text-center"><c:out value = "${board.column3}"/></td>
								<td class = "text-center"><c:out value = "${board.column4}"/></td>
								<td class = "text-center"><input type = "hidden" value = "${board.column5}"><c:out value = "${board.column6}"/></td>
								<td class = "text-center"><c:out value = "${board.column7}"/></td>
								<td class = "text-center"><c:out value = "${board.column8}"/></td>
								<td class = "text-center"><c:out value = "${board.column9}"/></td>
								<td class = "text-center"><c:out value = "${board.column10}"/></td>
								<td class = "text-center"><c:out value = "${board.column11}"/></td>
								<td class = "text-center"><c:out value = "${board.column12}"/></td>
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

	function search() {
		
		var formData = {
			gubun: document.getElementById("gubun").value,
			text: document.getElementById("text").value
		}
		
		$.ajax({
			url: '/popup/party_list',			// '/popup/Controller에 불러올 getMapping 주소 입력'
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
	                	'<td class="text-center"><input type="hidden" value="' + (board.column1 || '') + '">' + (board.column2 || '') + '</td>' + 
	                	'<td class="text-center">' + (board.column3 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column4 || '') + '</td>' +
	                	'<td class="text-center"><input type="hidden" value="' + (board.column5 || '') + '">' + (board.column6 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column7 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column8 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column9 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column10 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column11 || '') + '</td>' +
	                	'<td class="text-center">' + (board.column12 || '') + '</td>' +
	                    
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
	        // td 텍스트 (없으면 "")
	        const text = td.textContent.trim() || "";
	        data.push(text);

	        // td 안의 hidden input 값들 (없으면 "")
	        const hiddenInputs = td.querySelectorAll('input[type="hidden"]');
	        if (hiddenInputs.length > 0) {
	            hiddenInputs.forEach(function(input) {
	                data.push(input.value || "");
	            });
	        }
	    });

	    // 부모창 함수 호출 + 데이터 전달
	    window.opener.party_RowData(data);
	    // 팝업 닫기
	    window.close();
	}
	
</script>