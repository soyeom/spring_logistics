<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 선택</title>
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
		<!-- 헤더 -->
		<div class="popup-header">창고</div>
		<!-- 검색바 -->
		<div class="popup-search-bar">
			<div style="flex: 2;">
				<select id="gubun">
					<option value="0">창고</option>
					<option value="10">창고코드</option>
				</select>
			</div>
			<div style="flex: 7;">
				<input type="text" id="text" placeholder="검색어를 입력하세요"
					autocomplete="off">
			</div>
			<div style="flex: 1;">
				<button class="btn-primary" onclick="search()">검색</button>
			</div>
		</div>
		<!-- 나머지 컨텐츠 -->
		<div class="popup-body">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select" style="width: 100%">
					<thead>
						<tr>
							<th>창고</th>
							<th>창고코드</th>
							<th>사업단위</th>
							<th>창고구분</th>
							<th>사업단위코드</th>
							<th>창고구분코드</th>
						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:forEach items="${list}" var="wh">
							<tr>
								<td class="text-center"><c:out value="${wh.warehouseId}" /></td>
								<td class="text-center"><c:out value="${wh.warehouseName}" /></td>
								<td class="text-center"><c:out value="${wh.buName}" /></td>
								<td class="text-center"><c:out
										value="${wh.warehouseInternalCode}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="btn-primary"
			style="width: 100px; text-align: center; padding: 0.5rem 1.2rem; font-size: 18px; margin: auto; margin-top: 10px;"
			onclick="button_Click()">적용</div>
	</div>
</body>
</html>

<script>

var selectedRow = null;

// 행 클릭 시 선택 효과
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

// 검색 AJAX
function search() {
	var formData = {
		gubun: document.getElementById("gubun").value,
		text: document.getElementById("text").value
	}
	
	$.ajax({
		url: '/popup/warehouse_list',
		data: formData,
		type: 'GET',
		dataType: 'json',
		success: function(result) {
			const tbody = document.getElementById("result-tbody");
            tbody.innerHTML = ""; // 기존 내용 초기화
            
            result.forEach(function(wh) {
            	const tr = document.createElement("tr");

                tr.innerHTML = 
                    '<td class="text-center">' + (wh.warehouseId || '') + '</td>' +
                    '<td class="text-center">' + (wh.warehouseName || '') + '</td>' +
                    '<td class="text-center">' + (wh.buName || '') + '</td>' +
                    '<td class="text-center">' + (wh.warehouseInternalCode || '') + '</td>' +
                    '<td class="text-center">' + (wh.buId || '') + '</td>' +
                    '<td class="text-center">' + (wh.warehouseMasterId || '') + '</td>';
                   
                tbody.appendChild(tr);
            });
		}			
	});
}

// 선택된 데이터 부모창으로 전달
function button_Click() {
    if (!selectedRow) {
        alert("선택된 행이 없습니다!");
        return;
    }

    // td 안의 텍스트를 배열로 수집
    const data = Array.from(selectedRow.querySelectorAll("td")).map(td => td.textContent.trim());

 	// 부모창 함수 호출 (stockanalysis.jsp에 정의해야 함)
	if (window.opener && typeof window.opener.setWarehouseData === "function") {
		window.opener.setWarehouseData(data);
	} else {
		alert("부모창 함수가 정의되지 않았습니다.");
	}

	// 팝업 닫기
  	window.close();
}	
</script>

</script>
