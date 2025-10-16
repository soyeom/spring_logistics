<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>팜스프링물류관리시스템 - 물류관리 ERP</title>
    <meta
            name="description"
            content="팜스프링물류관리시스템 - 입고 및 출고, 재고 출하통제, 재고 관리, 사업단위별 수불집계, 재고 변동 추이 분석을 제공하는 물류관리 ERP 시스템"
    />
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
</head>
<body>
<main>
    <section class="section">
        <header>
            <h1>팜스프링물류관리시스템</h1>
            <p>물류관리 ERP</p>
        </header>
        <section class="features-grid" aria-label="시스템 주요 기능">
            <article class="card" tabindex="0" role="button" aria-label="입고 및 출고" onclick="location.href='/InvFlowConfig/invflowconfig'">
                <span class="card__number">1</span>
                <h2 class="card__title">재고부족시 출하 통제</h2>
            </article>
            <article class="card card--blue" tabindex="0" role="button" aria-label="재고 관리" onclick="location.href='/warehouse/setting'">
                <span class="card__number">2</span>
                <h2 class="card__title">실재고/자산재고 관리</h2>
            </article>
            <article class="card card--teal" tabindex="0" role="button" aria-label="재고 출하통제" onclick="location.href='/txnCategory/list'">
                <span class="card__number">3</span>
                <h2 class="card__title">기타입출고 구분 설정</h2>
            </article>
            <article class="card card--green" tabindex="0" role="button" aria-label="사업단위별 수불집계" onclick="location.href='/stock/summary'">
                <span class="card__number">4</span>
                <h2 class="card__title">사업단위별 수불 집계 조회</h2>
            </article>
            <article class="card card--olive" tabindex="0" role="button" aria-label="재고 변동 추이 분석"onclick="window.location.href='/stock-analysis/form'">
                <span class="card__number">5</span>
                
                <h2 class="card__title">재고 변동 추이 분석</h2>
            </article>
        </section>
    </section>
</main>
</body>
</html>