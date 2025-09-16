<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/popup.css">
</head>
<body>
<div class="popup-wrapper">
    <!-- 헤더 -->
    <section class="popup-header">
        <span>상품 등록</span>
    </section>

    <!-- 검색바 -->
    <section class="popup-content">
        <select class = "search-bar">
            <option>전체</option>
            <option>상품명</option>
            <option>출하번호</option>
        </select>
        <input class = "search-text" type="text" placeholder="검색어를 입력하세요" autocomplete="off">
        <button class="btn-primary">검색</button>
    </section>

    <!-- 나머지 컨텐츠 -->
    <section class="popup-body">
        <!-- 여기에 테이블이나 입력폼 추가 -->
    </section>
</div>
</body>
</html>