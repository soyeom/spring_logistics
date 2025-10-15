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
			<span>품목대분류 검색</span>
		</section>

		<!-- 검색바 -->
		<section class="popup-content">
			<select class="search-bar" id="searchOption">
				<option value="name">품목대분류</option>
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
					<c:forEach var="bc" items="${bigCategoryList}">
						  <tr onclick="selectBigCategory('${bc.BIG_CATEGORY}')">
							<td>${bc.BIG_CATEGORY}</td>
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
        const bcName = row.cells[0].innerText.toLowerCase();
        let match = false;
        
        if(option === "all") {
            match = bcName.includes(keyword)
        } else if(option === "name") {
            match = bcName.includes(keyword);
        }

        row.style.display = match ? "" : "none";
    });
}

function selectBigCategory(name) {

    window.opener.document.getElementById("bigCategory").value = name;
    window.close();
}



</script>
</body>
</html>
