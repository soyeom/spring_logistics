<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>商品登録</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body style="background-color: #fff;">
	<div class="popup-wrapper">
		<!-- ヘッダー -->
		<div class="popup-header">商品登録</div>	  
	     <!-- 検索バー -->
	     <div class="popup-search-bar">
	     	<div style="flex: 2;">
     			<select id="gubun">
	            	<option value="0">全て</option>
	            	<option value="10">品番</option>
	            	<option value="20">品名</option>
	        	</select>
	     	</div>
	     	<div style="flex: 7;">
	     		<input type="text" id="text" placeholder="検索語を入力してください" autocomplete="off">
	     	</div>
	     	<div style="flex: 1;">
	     		<button class="btn-primary" onclick="search()">検索</button>
	     	</div>
	     </div>
	    <!-- コンテンツ本体 -->
	    <div class="popup-body">
       		<div class="table-container" style="height: 400px;">
				<table class="table-single-select">
					<thead>
						<tr>
					    	<th style="width: 100px">品番</th>
					        <th style="width: 100px">品名</th>
					        <th style="width: 100px">規格</th>
					        <th style="width: 100px">品目資産分類</th>
					        <th style="width: 100px">小分類</th>
					        <th style="width: 100px">単位</th>
					        <th style="width: 100px">基準単位</th>
					        <th style="width: 100px">英語名</th>
					        <th style="width: 100px">安全在庫数量</th>
					        <th style="width: 100px">保管場所</th>
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
				    			<td class="text-center"><input type="hidden" value="${board.column11}" /><c:out value="${board.column10}" /></td>
					    	</tr>
				    	</c:forEach>
				    </tbody>
				</table>
		    </div>
	    </div>
	    
	    <div class="btn-primary" style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;" onclick="button_Click()">適用</div>
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
			url: '/popup/item_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = ""; // 既存内容初期化
	            
	         	// 結果配列を繰り返し
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
	                    '<td class="text-center"><input type="hidden" value="' + (board.column11 || '') + '" /><span>' + (board.column10 || '') + '</span></td>';
	                tbody.appendChild(tr);
	            });
			}			
		});
	}
	
	function button_Click() {
		
		if (!selectedRow) {
	        alert("選択された行がありません！");
	        return;
	    }

	    const data = [];

	    selectedRow.querySelectorAll("td").forEach(function(td) {
	        // tdテキスト (無ければ "")
	        const text = td.textContent.trim() || "";
	        data.push(text);

	        // td内のhidden input値 (無ければ "")
	        const hiddenInputs = td.querySelectorAll('input[type="hidden"]');
	        if (hiddenInputs.length > 0) {
	            hiddenInputs.forEach(function(input) {
	                data.push(input.value || "");
	            });
	        }
	    });
	    
	    console.log(data);

	    // 親ウィンドウ関数呼び出し + データ送信
	    window.opener.item_RowData(data);
	    // ポップアップ閉じる
	    window.close();
	}
	
</script>
