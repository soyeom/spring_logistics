<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>品目小分類選択</title>
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
		<!-- ヘッダー -->
		<div class="popup-header">品目小分類</div>

		<!-- 検索バー -->
		<div class="popup-search-bar">
			<div style="flex: 2;">
				<select id="gubun">
					<option value="0">小分類</option>
					<option value="10">小分類ID</option>
					<option value="20">小分類名</option>
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

		<!-- 結果テーブル -->
		<div class="popup-body">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
							<th>小分類ID</th>
							<th>小分類名</th>
							<th>大分類名</th>
							<th>中分類名</th>
						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:forEach items="${list}" var="sc">
							<tr>
								<!-- 初期データ: ID(column1), 名前(column2), 大分類(column4), 中分類(column3)の順 -->
								<td class="text-center"><c:out value="${sc.column1}" /></td>
								<td class="text-center"><c:out value="${sc.column2}" /></td>
								<td class="text-center"><c:out value="${sc.column4}" /></td>
								<td class="text-center"><c:out value="${sc.column3}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 適用ボタン -->
		<div class="btn-primary"
			style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;"
			onclick="button_Click()">適用</div>
	</div>

<script>
var selectedRow = null;

// 行選択ロジック
(function() {
	const tbody = document.getElementById('result-tbody');
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

// 検索 AJAX
function search() {
	var formData = {
		gubun: $("#gubun").val(),
		text: $("#text").val()
	};

	$.ajax({
		url: '/popup/itemSmallcategory_List', // APIエンドポイント
		data: formData,
		type: 'GET',
		dataType: 'json',
		success: function(result) {
			const tbody = $("#result-tbody");
			tbody.empty(); // 既存の内容をクリア

			result.forEach(function(sc) {
				const tr = $('<tr></tr>');
				// 小分類ID, 名前, 大分類名, 中分類名の順
				tr.append('<td class="text-center">' + (sc.column1 || '') + '</td>'); // 小分類ID
				tr.append('<td class="text-center">' + (sc.column2 || '') + '</td>'); // 小分類名
				tr.append('<td class="text-center">' + (sc.column4 || '') + '</td>'); // 大分類名
				tr.append('<td class="text-center">' + (sc.column3 || '') + '</td>'); // 中分類名
				tbody.append(tr);
			});
		},
		error: function(err) {
			alert("データ検索失敗: " + err.responseText);
		}
	});
}

// 選択されたデータを親ウィンドウに渡す
function button_Click() {
	if (!selectedRow) {
		alert("選択された行がありません！");
		return;
	}

	// [小分類ID, 小分類名, 大分類名, 中分類名] の順でデータを収集
	const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());

	// 親ウィンドウの setItemSmallCategoryData 関数を呼び出し、データを渡す
	if (window.opener && typeof window.opener.setItemSmallCategoryData === "function") {
		window.opener.setItemSmallCategoryData(data);
	} else {
		alert("親ウィンドウの関数が定義されていません。");
	}

	// ポップアップを閉じる
	window.close();
}
</script>

</body>
</html>
