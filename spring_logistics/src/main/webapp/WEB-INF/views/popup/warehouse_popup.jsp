<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>倉庫検索</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body style="background-color: #fff;">
	<div class="popup-wrapper">
		<div class="popup-header">倉庫検索</div>	  

	    <div class="popup-search-bar">
	     	<div style="flex: 2;">
     			<select id="gubun">
	            	<option value="0">全体</option>
    				<option value="10">倉庫</option>
    				<option value="20">倉庫コード</option>
    				<option value="30">事業単位</option>
	        	</select>
	     	</div>
	     	<div style="flex: 7;">
	     		<input type="text" id="text" placeholder="검색어를 입력하세요" autocomplete="off">
	     	</div>
	     	<div style="flex: 1;">
	     		<button class="btn-primary" onclick="search()">검색</button>
	     	</div>
	    </div>

	    <div class="popup-body">
       		<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
					    	<th>倉庫</th>
					        <th>倉庫コード</th>
					        <th>事業単位</th>
					        <th>倉庫区分</th>
				        </tr>
				    </thead>
				    <tbody id="result-tbody">
			    		<c:forEach items="${list}" var="board">
					    	<tr>
				    			<td class="text-center"><c:out value="${board.column1}" /></td>
				    			<td class="text-center"><c:out value="${board.column2}" /></td>
				    			<td class="text-center"><c:out value="${board.column3}" /></td>
				    			<td class="text-center"><c:out value="${board.column4}" /></td>
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

	// 행 클릭 시 선택 처리 (行クリック時の選択処理)
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

	// Ajax 검색 (Ajax 検索)
	function search() {
		var formData = {
			gubun: document.getElementById("gubun").value,
			text: document.getElementById("text").value
		};
		
		$.ajax({
			url: '/popup/warehouse_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = ""; // 기존 내용 초기화 ( 既存の内容を初期化)
	            
	         	// result 배열 반복 (result 配列を反復処理)
	            result.forEach(function(wh) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (wh.column1 || '') + '</td>' +
	                    '<td class="text-center">' + (wh.column2 || '') + '</td>' +
	                    '<td class="text-center">' + (wh.column3 || '') + '</td>' +
	                    '<td class="text-center">' + (wh.column4 || '') + '</td>';
	                   
	                tbody.appendChild(tr);
	            });
			}			
		});
	}
	
	//선택한 행 부모창으로 전달 (選択した行を親ウィンドウに渡し、ポップアップを閉じる)
	function button_Click() {
	    if (!selectedRow) {
	        alert("選択された行がありません。");
	        return;
	    }
	
	    const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());
	
		window.opener.item_RowData(data);
	  	window.close();
	}
</script>
