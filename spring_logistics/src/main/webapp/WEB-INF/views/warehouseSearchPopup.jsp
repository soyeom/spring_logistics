<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%-- 데이터베이스 연결 설정 --%>
<sql:setDataSource var="dataSource"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe" user="system" password="1234" />

<%-- warehouse_detail과 warehouse_master 테이블을 조인하여 필요한 정보 조회 --%>
<sql:query var="warehouses" dataSource="${dataSource}">
    SELECT
        wd.warehouse_id,
        wd.warehouse_name,
        wm.warehouse_internal_code AS warehouse_code
    FROM
        warehouse_detail wd
    JOIN
        warehouse_master wm ON wd.warehouse_master_id = wm.warehouse_master_id
    ORDER BY wd.warehouse_name
</sql:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 검색</title>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
}

#search-form {
	display: flex;
	gap: 10px;
	margin-bottom: 20px;
}

#search-input {
	flex-grow: 1;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

#search-button {
	padding: 8px 12px;
	border: none;
	background-color: #4CAF50;
	color: white;
	border-radius: 4px;
	cursor: pointer;
}

#warehouse-list {
	width: 100%;
	border-collapse: collapse;
}

#warehouse-list th, #warehouse-list td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

#warehouse-list th {
	background-color: #f2f2f2;
}

#warehouse-list tr:hover {
	background-color: #f5f5f5;
	cursor: pointer;
}
</style>
</head>
<body>

	<h3>창고 검색</h3>
	<form id="search-form" onsubmit="return false;">
		<input type="text" id="search-input" placeholder="창고 코드 또는 이름 검색">
		<button id="search-button">검색</button>
	</form>

	<table id="warehouse-list">
		<thead>
			<tr>
				<th>창고 코드</th>
				<th>창고 이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="wh" items="${warehouses.rows}">
				<tr onclick="selectWarehouse('${wh.warehouse_code}', '${wh.warehouse_name}')">
					<td>${wh.warehouse_code}</td>
					<td>${wh.warehouse_name}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script>
    function selectWarehouse(code, name) {
        if (window.opener && !window.opener.closed && window.opener.setWarehouse) {
            window.opener.setWarehouse(code, name);
            window.close();
        } else {
            alert('부모 창이 열려 있지 않거나 창고를 설정하는 함수가 없습니다.');
        }
    }

    const warehouses = [
        <c:forEach var="wh" items="${warehouses.rows}" varStatus="loop">
            {
                warehouse_code: "${wh.warehouse_code}",
                warehouse_name: "${wh.warehouse_name}"
            }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];

    const searchInput = document.getElementById('search-input');
    const searchButton = document.getElementById('search-button');
    const tableBody = document.querySelector('#warehouse-list tbody');

    searchButton.addEventListener('click', () => {
        const searchTerm = searchInput.value.toLowerCase();
        const filteredData = warehouses.filter(wh =>
            wh.warehouse_code.toLowerCase().includes(searchTerm) ||
            wh.warehouse_name.toLowerCase().includes(searchTerm)
        );
        renderTable(filteredData);
    });

    function renderTable(data) {
        tableBody.innerHTML = '';
        data.forEach(wh => {
            const row = document.createElement('tr');
            row.onclick = () => selectWarehouse(wh.warehouse_code, wh.warehouse_name);
            row.innerHTML = `<td>${wh.warehouse_code}</td><td>${wh.warehouse_name}</td>`;
            tableBody.appendChild(row);
        });
    }
</script>

</body>
</html>
