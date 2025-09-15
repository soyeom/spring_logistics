<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재고 출하통제 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="layout">
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

    <!-- 메인 -->
    <div class="main">
        <div class="main-header">
            <span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
            <h1>재고 출하통제</h1>
            <button class="btn btn-secondary search-btn">조회</button>
        </div>

        <!-- 조회조건 -->
        <div class="filters expanded">
            <h2>조회 조건</h2>
            <hr class="filters-divider">

            <div class="filters-row">
                <label>조회기간 <input type="date"></label>
                <label>창고 <select><option>전체</option></select></label>
                <label>품목명 <input type="text"></label>
                <label>상태 <select><option>전체</option></select></label>
            </div>

            <button class="toggle-filters">추가 조건 ▴</button>

            <div class="extra-filters">
                <div class="filters-row">
                    <label>거래처 <input type="text"></label>
                    <label>담당자 <input type="text"></label>
                </div>
            </div>
        </div>

        <!-- 메인 테이블 -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>출하번호</th>
                    <th>품목명</th>
                    <th>수량</th>
                    <th>상태</th>
                    <th>출하일</th>
                    <th>비고</th>
                    <th>추가정보1</th>
                    <th>추가정보2</th>
                    <th>추가정보3</th>
                    <th>추가정보4</th>
                    <th>추가정보5</th>
                    <th>추가정보6</th>
                    <th>추가정보7</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>SH-001</td>
                    <td class="popup-col">상품 A</td>
                    <td>100</td>
                    <td>대기</td>
                    <td>2025-09-10</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript" src="/resources/js/logistics.js"></script>
</body>
</html>
