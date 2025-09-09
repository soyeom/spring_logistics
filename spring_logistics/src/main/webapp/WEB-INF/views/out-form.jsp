<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>기타 출고 입력</title>
<style>
/* 기본 스타일 */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 헤더 */
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 2px solid #eee;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.header-left h1 {
	margin: 0;
	font-size: 24px;
}

.header-right button {
	padding: 8px 16px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

/* 입력 폼 */
.input-form {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	margin-bottom: 20px;
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 6px;
}

.input-group {
	display: flex;
	flex-direction: column;
}

.input-group label {
	font-size: 14px;
	margin-bottom: 5px;
	color: #555;
}

.input-group input, .input-group select {
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

/* 탭 메뉴 */
.tabs {
	border-bottom: 2px solid #ddd;
	margin-bottom: 15px;
}

.tab-button {
	padding: 10px 15px;
	border: 1px solid transparent;
	border-bottom: none;
	background-color: #f9f9f9;
	cursor: pointer;
}

.tab-button.active {
	border-color: #ddd;
	border-bottom: 2px solid #fff;
	background-color: #fff;
}

/* 테이블 */
.table-container {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
}

table th, table td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: left;
}

table thead th {
	background-color: #f2f2f2;
}

.table-scroll {
	max-height: 400px; /* 스크롤을 위한 높이 설정 */
	overflow-y: auto;
}

.placeholder-row td {
	color: #aaa;
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<header>
			<div class="header-left">
				<h1>기타 출고 입력</h1>
			</div>
			<div class="header-right">
				<button>조회</button>
			</div>
		</header>

		<div class="input-form">
			<div class="input-group">
				<label for="buId">사업단위</label> <select id="buId">
					<option>본사</option>
				</select>
			</div>
			<div class="input-group">
				<label for="outDate">출고일</label> <input type="date" id="outDate"
					value="2018-08-12">
			</div>
			<div class="input-group">
				<label for="outNo">출고번호</label> <input type="text" id="outNo"
					value="201808120001" readonly>
			</div>
			<div class="input-group">
				<label for="party">거래처</label> <input type="text" id="party">
			</div>
			<div class="input-group">
				<label for="wh">출고창고</label> <select id="wh">
					<option>재상용창고</option>
				</select>
			</div>
			<div class="input-group">
				<label for="dept">처리부서</label> <select id="dept">
					<option>영업1팀</option>
				</select>
			</div>
			<div class="input-group">
				<label for="contact">담당자</label> <input type="text" id="contact"
					value="나영업">
			</div>
			<div class="input-group">
				<label for="userDept">사용부서</label> <input type="text" id="userDept">
			</div>
			<div class="input-group" style="grid-column: span 4;">
				<label for="note">특이사항</label> <input type="text" id="note">
			</div>
		</div>

		<div class="tabs">
			<button class="tab-button active">품목 정보</button>
			<button class="tab-button">팔렛 정보</button>
		</div>

		<div class="table-scroll">
			<table>
				<thead>
					<tr>
						<th></th>
						<th>품번</th>
						<th>품명</th>
						<th>규격</th>
						<th>단위</th>
						<th>수량</th>
						<th>기타출고구분</th>
						<th>기준단위</th>
						<th>기준단위수량</th>
						<th>현재고</th>
						<th>LotNo</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="detail" items="${outDetails}">
						<tr>
							<td><input type="checkbox" name="selectedItems"
								value="${detail.outDetailId}"></td>
							<td>${detail.itemInternalCode}</td>
							<td>${detail.itemName}</td>
							<td>${detail.spec}</td>
							<td>${detail.baseUnit}</td>
							<td><input type="number" name="qty" value="${detail.qty}"></td>
							<td><select name="otherOutCode">
									<option value="">-- 선택 --</option>
									<c:forEach var="category" items="${otherOutCategories}">
										<option value="${category.otherOutCode}"
											<c:if test="${detail.otherOutCode eq category.otherOutCode}">selected</c:if>>
											${category.categoryName}</option>
									</c:forEach>
							</select></td>
							<td>${detail.baseUnit}</td>
							<td>${detail.qty}</td>
							<td>${detail.currentStock}</td>
							<td>${detail.lotNo}</td>
						</tr>
					</c:forEach>

					<c:forEach begin="1" end="10">
						<tr class="placeholder-row">
							<td></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="number"></td>
							<td><select>
									<option value="">-- 선택 --</option>
							</select></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
					</c:forEach>
				</tbody>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>