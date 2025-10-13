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
			<span>품목중분류 검색</span>
		</section>

		<!-- 검색바 -->
		<section class="popup-content">
			<select class="search-bar" id="searchOption">
				<option value="name">품목중분류</option>
			</select> <input class="search-text" id="searchKeyword" type="text"
				placeholder="검색어를 입력하세요" autocomplete="off">
			<button class="btn-primary" onclick="filterTable()">검색</button>
		</section>

		<!-- 검색 결과 테이블 -->
		<section class="popup-body">
			<table>
				<thead>
					<tr>
						<th>품목대분류</th>
					</tr>
				</thead>
				<tbody id="category-tbody">
					<c:forEach var="mc" items="${midCategoryList}">
						  <tr onclick="selectMidCategory('${mc.MID_CATEGORY}')">
							<td>${mc.MID_CATEGORY}</td>
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
    const rows = document.querySelectorAll("#category-tbody tr");

    rows.forEach(row => {
        const mcName = row.cells[0].innerText.toLowerCase();
        let match = false;
        
        if(option === "all") {
            match = mcName.includes(keyword)
        } else if(option === "name") {
            match = mcName.includes(keyword);
        }

        row.style.display = match ? "" : "none";
    });
}

function selectMidCategory(name) {

    window.opener.document.getElementById("midCategory").value = name;
    window.close();
}



</script>
</body>
</html>
