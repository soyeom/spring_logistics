<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>倉庫選択</title>
<link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
<link rel="stylesheet" href="/resources/css/logistics.css"
	type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
</head>

<body style="background-color: #fff;">
	<div class="popup-wrapper">
		<div class="popup-header">倉庫</div>
		<div class="popup-search-bar">
			<div style="flex: 2;">
				<select id="gubun">
					<option value="20">倉庫名</option>
					<option value="10">倉庫コード</option>
				</select>
			</div>
			<div style="flex: 7;">
				<input type="text" id="text" placeholder="検索キーワードを入力してください"
					autocomplete="off">
			</div>
			<div style="flex: 1;">
				<button class="btn-primary" onclick="search()">検索</button>
			</div>
		</div>
		<div class="popup-body">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
							<th>倉庫名</th>
							<th>倉庫コード</th>
							<th>事業部門名</th>
							<th>倉庫区分</th>
							<th>事業部門コード</th>
							<th>倉庫区分コード</th>
						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:forEach items="${list}" var="wh">
							<tr>
								<td class="text-center"><c:out value="${wh.warehouseName}" /></td>
								<td class="text-center"><c:out value="${wh.warehouseId}" /></td>
								<td class="text-center"><c:out value="${wh.buName}" /></td>
								<td class="text-center"><c:out value="${wh.warehouseInternalCode}" /></td>
								<td class="text-center"><c:out value="${wh.buId}" /></td>
								<td class="text-center"><c:out value="${wh.warehouseMasterId}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="btn-primary"
			style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;"
			onclick="button_Click()">適用</div>
	</div>
</body>
</html>

<script>
var selectedRow = null;

// 行クリック時に選択効果を付与/解除しselectedRow変数に保存
(function() {
    const tbody = document.querySelector('.table-single-select tbody');
    if (!tbody) return;

    tbody.addEventListener('click', function(e) {
        const tr = e.target.closest('tr');
        if (!tr) return;

        // 既に選択された行を再度クリックすると選択解除
        if (selectedRow === tr) {
            tr.classList.remove('tr-selected');
            selectedRow = null;
            return;
        }

        // 以前に選択された行のスタイルを解除
        if (selectedRow) selectedRow.classList.remove('tr-selected');

        // 現在の行を選択し変数に保存
        tr.classList.add('tr-selected');
        selectedRow = tr;
    });
})();

// 検索入力欄でEnterキー入力時にsearch()関数を実行
document.getElementById("text").addEventListener("keyup", function(event) {
    // 13はEnterキーコード
    if (event.keyCode === 13) { 
        event.preventDefault(); // Enterキーの既定の動作防止
        search();
    }
});


// 倉庫検索 AJAX
function search() {
	const gubun = document.getElementById("gubun").value;
    // 400エラー防止のため、キーワードの前後にある空白を削除します。
	const text = document.getElementById("text").value.trim(); 
	
	// GETリクエストなので、データはクエリ文字列として安全に渡されます。
	const formData = {
		gubun: gubun,
		text: text
	}
	
	$.ajax({
		url: '/popup/warehouse_list', // 倉庫リストを取得するサーバーURL
		data: formData,
		type: 'GET',
        // GETリクエスト時にはcontentTypeは不要
		dataType: 'json',
		success: function(result) {
			const tbody = document.getElementById("result-tbody");
			tbody.innerHTML = ""; // 既存の内容を初期化
			selectedRow = null;   // 検索結果が変わったため選択を初期化
			 
			// 検索結果がない時の処理
			if (result.length === 0) {
				const tr = document.createElement("tr");
				// テーブルの列数(6)に合わせてcolspanを設定
				tr.innerHTML = '<td colspan="6" class="text-center" style="color:#888;">検索結果がありません。(검색 결과가 없습니다.)</td>'; 
				tbody.appendChild(tr);
				return;
			}

			// 検索結果をテーブルに動的に追加
			result.forEach(function(wh) {
				const tr = document.createElement("tr");

				tr.innerHTML =	
					'<td class="text-center">' + (wh.warehouseName || '') + '</td>' +	// 倉庫名
					'<td class="text-center">' + (wh.warehouseId || '') + '</td>' +	    // 倉庫コード
					'<td class="text-center">' + (wh.buName || '') + '</td>' +	        // 事業部門名
					'<td class="text-center">' + (wh.warehouseInternalCode || '') + '</td>' +	// 倉庫区分
					'<td class="text-center">' + (wh.buId || '') + '</td>' +	        // 事業部門コード
					'<td class="text-center">' + (wh.warehouseMasterId || '') + '</td>';	// 倉庫区分コード
						
				tbody.appendChild(tr);
			});
		},
        // 400エラー発生時のデバッグのため、詳細な応答メッセージをコンソールに出力
        error: function(xhr, status, error) {
            console.error("AJAX Error: ", status, error);
            // サーバー応答本文を出力して400エラーの具体的な原因（パラメータの型など）を確認
            console.error("Server Response Text:", xhr.responseText); 
            alert("検索中にエラーが発生しました。(HTTP " + xhr.status + ")");
        }
	});
}

// 選択されたデータを親ウィンドウに渡しポップアップを閉じる
function button_Click() {
	if (!selectedRow) {
		alert("選択された行がありません！");
		return;
	}

	// td内のテキストを配列として収集 (6つのデータ)
	const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());

	// 親ウィンドウの関数 setWarehouseData を呼び出す
	if (window.opener && typeof window.opener.setWarehouseData === "function") {
		window.opener.setWarehouseData(data);	
	} else {
		// alertの代わりにconsole.warnに変更し、ユーザーに混乱を与えないように改善
		console.warn("親ウィンドウの関数が定義されていません。(부모 창의 setWarehouseData 함수가 정의되지 않았습니다.)"); 
	}

	// ポップアップを閉じる
	window.close();
}	
</script>