<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- ホームアイコン縦バー -->
<div class="home-bar">
    <span>
        <a href="/">
            <img src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png" alt="ホーム" class="home-icon">
        </a>
    </span>
</div>

<!-- サイドバー -->
<aside class="sidebar">
    <div class="sidebar-header">
        <div class="profile">
            <img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png" alt="プロフィール">
			<c:choose>
		        <c:when test="${not empty loginUser}">
		            <p>${loginUser.contact_Name} さん、こんにちは 👋</p>
		            <div class="auth-btns">
		                <a href="/Contact/logout" class="btn btn-secondary">ログアウト</a>
		            </div>
		        </c:when>
		        <c:otherwise>
		            <p>こんにちは 👋</p>
		            <div class="auth-btns">
		                <a href="/Contact/login" class="btn btn-secondary">ログイン</a>
		                <a href="/Contact/signin" class="btn btn-secondary">新規登録</a>
		            </div>
		        </c:otherwise>
		    </c:choose>
        </div>
    </div>

    <nav class="menu">
        <div class="menu-item">
            <div class="title">在庫出荷統制</div>
            <div class="submenu">
                <div><a href="/InvFlowConfig/invflowconfig">倉庫別在庫不足許可設定</a></div>
            </div>
        </div>

        <div class="menu-item">
            <div class="title">入庫・出庫</div>
            <div class="submenu">
                <div><a href="/txnCategory/list">入出庫項目と勘定科目設定</a></div>
                <div><a href="/order/entry">入庫登録</a></div>
                <div><a href="/InvFlowConfig/outbound">出庫処理</a></div>
            </div>
        </div>

		<div class="menu-item">
            <div class="title">在庫管理</div>
            <div class="submenu">
                <div><a href="/warehouse/setting">倉庫別在庫照会基準設定</a></div>
                <div><a href="/warehouse/stock">倉庫別在庫照会</a></div>
                <div><a href="/warehouse/availableItems">利用可能在庫照会</a></div>
            </div>
        </div>

        <div class="menu-item">
            <div class="title">事業単位別収支集計照会</div>
            <div class="submenu">
                <div><a href="/stock/summary">事業単位別収支集計照会</a></div>
            </div>
        </div>

        <div class="menu-item">
            <div class="title">在庫変動推移分析</div>
            <div class="submenu">
            	<div><a href="/stock-analysis/form">在庫変動推移分析</a></div>
        	</div>
    	</div>
	</nav>

</aside>
