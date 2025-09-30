<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>출고처리하기 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class = "layout">
		<div class="home-bar">
	        <span>
	            <a href="/"><img src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png" alt="홈화면" class="home-icon"></a>
	        </span>
	    </div>
	    <aside class="sidebar">
	        <div class="sidebar-header">
	            <div class="profile">
	                <img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png" alt="프로필">
	                <p>홍길동님, 안녕하세요 👋</p>
	                <div class="auth-btns">
	                    <button class="btn btn-secondary">로그인</button>
	                    <button class="btn btn-secondary">회원가입</button>
	                </div>
	            </div>
	        </div>
	        <nav class="menu">
	            <div class="menu-item">
	                <div class="title"><a href="#">입고 및 출고</a></div>
	                <div class="submenu">
	                    <div><a href="#">입고 내역</a></div>
	                    <div><a href="#">출고 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 출하통제</a></div>
	                <div class="submenu">
	                    <div><a href="#">출하 계획</a></div>
	                    <div><a href="#">출하 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 관리</a></div>
	                <div class="submenu">
	                    <div><a href="#">재고 현황</a></div>
	                    <div><a href="#">재고 이동</a></div>
	                    <div><a href="#">재고 조회</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">사업단위별 수불집계</a></div>
	                <div class="submenu">
	                    <div><a href="#">사업장별 집계</a></div>
	                    <div><a href="#">월별 추이</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 변동 추이 분석</a></div>
	                <div class="submenu">
	                    <div><a href="#">그래프 보기</a></div>
	                </div>
	            </div>
	        </nav>
    	</aside>
    	<div class = "main">
    		<div class = "main-header">
    			<div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>거래명세서입력</h1></div>
	            <div>
		            <button class="btn btn-secondary search-btn" id = "search" onclick = "search()">조회</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save()">저장</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "delete()">삭제</button>
				</div>
    		</div>
    		<div class = "filters">
    			<div class = "filters-main">
    				<div class = "조회조건"></div>
    				<div class = "line"></div>
    			</div>
    			<div class = "filters-row">
    				<div class = "filters-count">
	            		<div class = "filters-text">사업단위</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="bu_Id">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래명세서일</div>
	            		<div class = "filters-value">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래명세서번호</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">Local구분</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래처</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">거래처번호</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">담당자</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">부서</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">출고구분</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">위탁구분</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
    			</div>
    		</div>
    		<div class = "table-container">
				<table class="table-single-select">
					<thead>
						<tr>
					    	<th style = "width: 135px">품번</th>
					        <th style = "width: 140px">품명</th>
					        <th style = "width: 105px">규격</th>
					        <th style = "width: 105px">거래처품번</th>
					        <th style = "width: 105px">거래처</th>
					        <th style = "width: 90px">수량</th>
					        <th style = "width: 90px">판매단위</th>
					        <th style = "width: 90px">판매단가</th>
					        <th style = "width: 90px">부가세포함</th>
					        <th style = "width: 105px">판매금액</th>
					        <th style = "width: 125px">부가세액</th>
					        <th style = "width: 125px">판매기준가</th>
					        <th style = "width: 125px">기준단위</th>
					        <th style = "width: 105px">창고</th>
					        <th style = "width: 90px">Lot No.</th>
					        <th style = "width: 90px">기타출고구분</th>
					        <th style = "width: 90px">유상사급여부</th>
					        <th style = "width: 90px">품목자산분류</th>
					        <th style = "width: 90px">자산처리구분</th>
					        <th style = "width: 90px">현재고</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody1">
				    </tbody>
				</table>
		    </div>
    	</div>
	</div>
</body>
</html>

<script>
	
</script>