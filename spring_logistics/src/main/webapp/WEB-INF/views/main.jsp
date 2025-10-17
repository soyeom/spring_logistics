<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>ファームスプリング物流管理システム - 物流管理ERP</title>
    <meta
            name="description"
            content="ファームスプリング物流管理システム - 入庫・出庫、在庫出荷統制、在庫管理、事業単位別収支集計、在庫変動推移分析を提供する物流管理ERPシステム"
    />
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
</head>
<body>
<main>
    <section class="section">
        <header>
            <h1>ファームスプリング物流管理システム</h1>
            <p>物流管理ERP</p>
        </header>
        <section class="features-grid" aria-label="システム主要機能">
            <article class="card" tabindex="0" role="button" aria-label="在庫出荷統制" onclick="location.href='/InvFlowConfig/invflowconfig'"> 
                <span class="card__number">1</span>
                <h2 class="card__title">在庫出荷統制</h2> 
            </article>
            <article class="card card--blue" tabindex="0" role="button" aria-label="在庫管理" onclick="location.href='/warehouse/setting'">
                <span class="card__number">2</span>
                <h2 class="card__title">在庫管理</h2>
            </article>
            <article class="card card--teal" tabindex="0" role="button" aria-label="入庫および出庫" onclick="location.href='/txnCategory/list'"> 
                <span class="card__number">3</span>
                <h2 class="card__title">入庫および出庫</h2> 
            </article>
            <article class="card card--green" tabindex="0" role="button" aria-label="事業単位別収支集計照会" onclick="location.href='/stock/summary'"> 
                <span class="card__number">4</span>
                <h2 class="card__title">事業単位別収支集計照会</h2>
            </article>
            <article class="card card--olive" tabindex="0" role="button" aria-label="在庫変動推移分析" onclick="window.location.href='/stock-analysis/form'">
                <span class="card__number">5</span>
                <h2 class="card__title">在庫変動推移分析</h2>
            </article>
        </section>
    </section>
</main>
</body>
</html>
