<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 홈 아이콘 세로 바 -->
<div class="home-bar">
    <span>
        <a href="/">
            <img src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png" alt="홈화면" class="home-icon">
        </a>
    </span>
</div>
<!-- 사이드바 -->
<aside class="sidebar">
    <div class="sidebar-header">
        <div class="profile">
            <img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png" alt="프로필">
			<c:choose>
		        <c:when test="${not empty loginUser}">
		            <p> ${loginUser.contact_Name}님 안녕하세요 👋 </p>
		            <div class="auth-btns">
		                <a href="/Contact/logout" class="btn btn-secondary">로그아웃</a>
		            </div>
		        </c:when>
		        <c:otherwise>
		            <p>안녕하세요 👋</p>
		            <div class="auth-btns">
		                <a href="/Contact/login" class="btn btn-secondary">로그인</a>
		                <a href="/Contact/signin" class="btn btn-secondary">회원가입</a>
		            </div>
		        </c:otherwise>
		    </c:choose>
        </div>
    </div>
    <nav class="menu">
        <div class="menu-item">
            <div class="title">재고부족시 출하 통제</div>
            <div class="submenu">
                <div><a href="/InvFlowConfig/invflowconfig">창고별 재고 부족 허용여부 설정하기</a></div>
                <div><a href="/InvFlowConfig/outbound">출고 처리하기</a></div>
            </div>
        </div>
        <div class="menu-item">
            <div class="title">실재고/자산재고 관리</div>
            <div class="submenu">
                <div><a href="/warehouse/setting">창고별 재고 조회 기준 설정하기</a></div>
                <div><a href="/warehouse/stock">창고별 재고 조회하기</a></div>
                <div><a href="/warehouse/availableItems">가용재고 조회하기</a></div>
            </div>
        </div>
        <div class="menu-item">
            <div class="title">기타입출고 구분 설정</div>
            <div class="submenu">
                <div><a href="/txnCategory/list">기타입출고 항목과 계정과목 설정하기</a></div>
                <div><a href="/order/entry">수주(주문) 입력하기</a></div>
            </div>
        </div>
        <div class="menu-item">
            <div class="title">사업단위별 수불 집계 조회</div>
            <div class="submenu">
                <div><a href="/stock/summary">사업단위별 수불 집계 조회하기</a></div>
            </div>
        </div>
        <div class="menu-item">
            <div class="title">재고 변동 추이 분석</div>
            <div class="submenu">
            	<div><a href="/stock-analysis/form">재고 변동 추이 분석하기</a></div>
        	</div>
    	</div>
	</nav>
</aside>