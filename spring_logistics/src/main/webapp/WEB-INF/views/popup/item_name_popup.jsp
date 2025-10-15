<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>品名</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body style = "background-color: #fff;">
	<div class="popup-wrapper">
		<!-- 헤더 -->
		<div class = "popup-header">品名 照会</div>	  
	     <!-- 검색바 -->
	     <div class = "popup-search-bar">
	     	<div style = "flex: 2;">
     			<select id = "gubun">
	            	<option value = "0">全体</option>
	            	<option value = "10">品名</option>
	            	<option value = "20">品番</option>
	            	<option value = "30">規格</option>
	            	<option value = "40">英字名</option>
	        	</select>
	     	</div>
	     	<div style = "flex: 7;">
	     		<input type="text" id = "text" placeholder="検索語を入力してください" autocomplete="off">
	     	</div>
	     	<div style = "flex: 1;">
	     		<button class="btn-primary" onclick = "search()">검색</button>
	     	</div>
	     </div>
	    <!-- 나머지 컨텐츠 -->
	    <div class="popup-body">
       		<div class = "table-container" style = "height: 400px;">
				<table class="table-single-select" style = "width: 100%">
					<thead>
						<tr>
					    	<th>品番</th>
					        <th>規格</th>
					        <th>品名</th>
					        <th>品目資産分類</th>
					        <th>小分類</th>
					        <th>単位</th>
					        <th>英字名</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody">
			    		<c:forEach items = "${list}" var = "board">
					    	<tr>
				    			<td class = "text-center"><c:out value = "${board.column1}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column2}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column3}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column4}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column5}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column6}" /></td>
				    			<td class = "text-center"><c:out value = "${board.column7}" /></td>
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
		
		console.log(formData);
		
		$.ajax({
			url: '/popup/item_name_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = ""; // 既存の内容初期化
	            
	         	// result 配列を反復処理し、テーブル行を生成
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.column1 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column2 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column3 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column4 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column5 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column6 || '') + '</td>' +
	                    '<td class="text-center">' + (board.column7 || '') + '</td>';
	                   
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
	
	    // td 内のテキストを配列として収集
	    const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());
	
	 	// 親ウィンドウの関数を呼び出し + データを渡す
		window.opener.item_RowData(data);
		// ポップアップ閉める
	  	window.close();
	}
	
</script>