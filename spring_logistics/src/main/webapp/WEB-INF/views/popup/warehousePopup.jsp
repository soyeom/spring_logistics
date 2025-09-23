<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>창고 검색</title>
<link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
</head>
<body>
	<div class="popup-wrapper">
		<!-- 헤더 -->
		<section class="popup-header">
			<span>창고 검색</span>
		</section>

		<!-- 검색바 -->
		<section class="popup-content">
			<select class="search-bar" id="searchOption">
				<option value="all">전체</option>
				<option value="name">창고명</option>
				<option value="code">창고코드</option>
			</select> <input class="search-text" id="searchKeyword" type="text"
				placeholder="검색어를 입력하세요" autocomplete="off">
			<button class="btn-primary" onclick="filterTable()">검색</button>
		</section>

		<!-- 검색 결과 테이블 -->
		<section class="popup-body">
			<table>
				<thead>
					<tr>
						<th>창고명</th>
						<th>창고코드</th>
					</tr>
				</thead>
				<tbody id="warehouse-tbody">
					<c:forEach var="wh" items="${warehouseNameList}">
						  <tr onclick="selectWarehouse('${wh.WAREHOUSE_NAME}', '${wh.WAREHOUSE_ID}')">
							<td>${wh.WAREHOUSE_NAME}</td>
							<td>${wh.WAREHOUSE_ID}</td>
						</tr>
					</c:forEach>
				</tbody>


			</table>
		</section>
	</div>

	<script>
function filterTable() {
    const option = document.getElementById("searchOption").value;
    const keyword = document.getElementById("searchKeyword").value.toLowerCase();
    const rows = document.querySelectorAll("#warehouse-tbody tr");

    rows.forEach(row => {
        const whName = row.cells[0].innerText.toLowerCase();
        const whCode = row.cells[1].innerText.toLowerCase();

        let match = false;
        if(option === "all") {
            match = whName.includes(keyword) || whCode.includes(keyword);
        } else if(option === "name") {
            match = whName.includes(keyword);
        } else if(option === "code") {
            match = whCode.includes(keyword);
        }

        row.style.display = match ? "" : "none";
    });
}

function selectWarehouse(name, id) {

    window.opener.document.getElementById("warehouseName").value = name;
    window.close();
}



</script>
</body>
</html>
