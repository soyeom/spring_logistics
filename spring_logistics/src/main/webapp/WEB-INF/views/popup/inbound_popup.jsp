<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- ✅ jQuery 로드 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>受注照会</title> <!-- 수주조회 -->
<!-- ✅ 스타일シート読込 / CSS 스타일 로드 -->
<link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
<link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
</head>

<body style="background-color: #fff;">
	<div class="popup-wrapper">

		<!-- ================== ヘッダー / 헤더 ================== -->
		<div class="popup-header">受注照会</div> <!-- 수주 조회 -->

		<!-- ================== 検索バー / 검색바 ================== -->
		<div class="popup-search-bar">
			<div style="flex: 2;">
				<!-- 🔽 検索区分選択 / 검색 구분 선택 -->
				<select id="gubun">
					<option value="0">全体</option> <!-- 전체  -->
					<option value="10">受注番号</option><!-- 수주번호  -->
					<option value="20">事業部</option><!-- 사업단위  -->
					<option value="30">納期日</option><!-- 납기일  -->
					<option value="40">国内区分</option><!-- Local구분  -->
					<option value="50">取引先</option><!-- 거래처  -->
					<option value="60">担当者</option><!-- 담당자  -->
					<option value="70">受注区分</option><!-- 수주구분  -->
					<option value="80">入庫状態</option><!-- 입고상태  -->
					<option value="90">受注日</option><!-- 수주일  -->
				</select>
			</div>

			<!-- 🔍 検索入力 / 검색 입력 -->
			<div style="flex: 7;">
				<input type="text" id="text" placeholder="検索語を入力してください" autocomplete="off">
			</div>

			<!-- 🔎 検索ボタン / 검색 버튼 -->
			<div style="flex: 1;">
				<button class="btn-primary" onclick="search()">検索</button><!-- 검색  -->
			</div>
		</div>

		<!-- ================== テーブル本体 / 본문 테이블 ================== -->
		<div class="popup-body">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
							<th>受注番号</th><!-- 수주번호  -->
							<th>事業部</th><!-- 사업단위  -->
							<th>納期日</th><!-- 납기일  -->
							<th>国内区分</th><!-- Local구분  -->
							<th>取引先</th><!-- 거래처  -->
							<th>担当者</th><!-- 담당자  -->
							<th>受注区分</th><!-- 수주구분  -->
							<th>入庫状態</th><!-- 입고상태  -->
							<th>受注日</th><!-- 수주일  -->
						</tr>
					</thead>

					<tbody id="result-tbody">
						<!-- ✅ JSTLループ: 検索結果表示 / JSTL 반복문으로 검색결과 표시 -->
						<c:forEach items="${list}" var="board">
							<tr>
								<td class="text-center"><c:out value="${board.column1}" /></td>
								<td class="text-center">
									<input type="hidden" value="${board.column12}" />
									<c:out value="${board.column2}" />
								</td>
								<td class="text-center"><c:out value="${board.column3}" /></td>
								<td class="text-center"><c:out value="${board.column4}" /></td>
								<td class="text-center"><c:out value="${board.column5}" /></td>
								<td class="text-center"><c:out value="${board.column6}" /></td>
								<td class="text-center"><c:out value="${board.column7}" /></td>
								<td class="text-center"><c:out value="${board.column8}" /></td>
								<td class="text-center"><c:out value="${board.column9}" /></td>

								<!-- ✅ 非表示カラム / 숨김 컬럼 -->
								<td class="text-center" style="display:none;"><c:out value="${board.column10}" /></td>
								<td class="text-center" style="display:none;"><c:out value="${board.column11}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- ================== 適用ボタン / 적용 버튼 ================== -->
		<div class="btn-primary"
			style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;"
			onclick="button_Click()">適用</div><!-- 적용 -->
	</div>
</body>
</html>

<!-- ========================================================= -->
<!-- 🧩 JavaScript 部分 / 자바스크립트 부분 -->
<!-- ========================================================= -->

<script>
	// ======================================================
	// 🟦 単一行選択機能 / 단일 행 선택 기능
	// ======================================================
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


	// ======================================================
	// 🔍 Ajax検索処理 / Ajax 검색 처리
	// ======================================================
	function search() {
		var formData = {
			gubun: document.getElementById("gubun").value,
			text: document.getElementById("text").value
		}
		
		$.ajax({
			url: '/popup/inbound_list', // ✅ 수주목록 요청 / 受注リスト取得
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
	                    '<td class="text-center">' + (board.column11 || '') + '</td>';
	                tbody.appendChild(tr);
			    });
			}
		});
	}


	// ======================================================
	// 🟩 適用ボタンクリック / 적용 버튼 클릭 처리
	// ======================================================
	function button_Click() {
	    if (!selectedRow) {
	        alert("選択された行がありません。");
	        return;
	    }

	    // ✅ 선택 행의 데이터 추출 / 選択行データ抽出
	    const data = Array.from(selectedRow.querySelectorAll("td")).map(function(td) {
	        const hiddenInput = td.querySelector("input[type=hidden]");
	        if (hiddenInput) {
	            return hiddenInput.value.trim();
	        } else {
	            return td.textContent.trim();
	        }
	    });
	    
	    console.log("팝업 → 부모창으로 넘긴 data:", data); // ✅ デバッグ出力 / 디버그 출력
	    
	    // ✅ 부모창 함수 호출 / 親画面関数呼び出し
	    window.opener.inbound_RowData(data);
	    window.close();
	}
</script>
