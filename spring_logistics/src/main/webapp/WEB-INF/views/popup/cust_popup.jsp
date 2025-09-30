<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body style="background-color: #fff;">
	<div class="popup-wrapper">
		<!-- 헤더 -->
		<div class="popup-header">거래처 선택</div>	  

	    <!-- 검색바 -->
	    <div class="popup-search-bar">
	     	<div style="flex: 2;">
     			<select id="gubun">
	            	<option value="0">전체</option>
	            	<option value="10">거래처코드</option>
	            	<option value="20">거래처명</option>
	        	</select>
	     	</div>
	     	<div style="flex: 7;">
	     		<input type="text" id="text" placeholder="검색어를 입력하세요" autocomplete="off">
	     	</div>
	     	<div style="flex: 1;">
	     		<button class="btn-primary" onclick="search()">검색</button>
	     	</div>
	    </div>

	    <!-- 테이블 -->
	    <div class="popup-body">
       		<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
							<th>판매거래처코드</th>
							<th>판매거래처</th>
							<th>판매거래처번호</th>
							<th>사업자번호</th>
							<th>대표자</th>
							<th>주소</th>
							<th>유통분류</th>
							<th>주민등록번호</th>
							<th>상호</th>
							<th>거래처영문약명</th>
							<th>종사업자번호</th>
							<th>약어</th>
							<th>대표거래처</th>
							<th>청구처</th>
				        </tr>
				    </thead>
				    <tbody id="result-tbody">
			    		<c:forEach items="${list}" var="board">
					    	<tr>
				    			<td class="text-center"><c:out value="${board.column1}" /></td>
				    			<td class="text-center"><c:out value="${board.column2}" /></td>
				    			<td class="text-center"><c:out value="${board.column3}" /></td>
				    			<td class="text-center"><c:out value="${board.column4}" /></td>
				    			<td class="text-center"><c:out value="${board.column5}" /></td>
				    			<td class="text-center"><c:out value="${board.column6}" /></td>
				    			<td class="text-center"><c:out value="${board.column7}" /></td>
				    			<td class="text-center"><c:out value="${board.column8}" /></td>
				    			<td class="text-center"><c:out value="${board.column9}" /></td>
				    			<td class="text-center"><c:out value="${board.column10}" /></td>
				    			<td class="text-center"><c:out value="${board.column11}" /></td>
				    			<td class="text-center"><c:out value="${board.column12}" /></td>
				    			<td class="text-center"><c:out value="${board.column13}" /></td>
				    			<td class="text-center"><c:out value="${board.column14}" /></td>
					    	</tr>
				    	</c:forEach>
				    </tbody>
				</table>
		    </div>
	    </div>
	    
	    <!-- 버튼 -->
	    <div class="btn-primary" style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;" onclick="button_Click()">적용</div>
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

	// 검색
	function search() {
		var formData = {
			gubun: document.getElementById("gubun").value,
			text: document.getElementById("text").value
		}
		
		$.ajax({
			url: '/popup/cust_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = "";
	            
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.column1 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column2 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column3 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column4 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column5 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column6 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column7 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column8 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column9 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column10 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column11 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column12 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column13 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column14 || '') + '</td>';
	                tbody.appendChild(tr);
	            });
			}			
		});
	}

	// 적용 버튼
	function button_Click() {
	    if (!selectedRow) {
	        alert("선택된 행이 없습니다!");
	        return;
	    }
	    const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());
	 	window.opener.item_RowData(data); // 부모창 함수 호출
	  	window.close();
	}	
</script>
