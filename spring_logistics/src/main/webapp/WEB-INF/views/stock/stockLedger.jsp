<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>事業部門別 在庫元帳照会</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="layout">
    	<!-- 홈 아이콘 세로 바 -->
	    <div class="home-bar">
	        <span>
	            <a href="/"><img src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png" alt="홈화면" class="home-icon"></a>
	        </span>
	    </div>
	    <!-- 사이드바 -->
	    <aside class="sidebar">
	        <div class="sidebar-header">
	            <div class="profile">
	                <img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png" alt="프로필">
	                <p>山田様、こんにちは 👋</p>
	                <div class="auth-btns">
	                    <button class="btn btn-secondary">ログイン</button>
	                    <button class="btn btn-secondary">会員登録</button>
	                </div>
	            </div>
	        </div>
	        <nav class="menu">
	            <div class="menu-item">
	                <div class="title"><a href="#">入庫および出庫</a></div>
	                <div class="submenu">
	                    <div><a href="#">入庫履歴</a></div>
	                    <div><a href="#">出庫履歴</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">在庫出荷管理</a></div>
	                <div class="submenu">
	                    <div><a href="#">出荷計画</a></div>
	                    <div><a href="#">出荷履歴</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">在庫管理</a></div>
	                <div class="submenu">
	                    <div><a href="#">在庫状況</a></div>
	                    <div><a href="#">在庫移動</a></div>
	                    <div><a href="#">在庫照会</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">事業部門別 在庫受払集計</a></div>
	                <div class="submenu">
	                    <div><a href="#">事業所別 集計</a></div>
	                    <div><a href="#">月別 推移</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">在庫変動推移分析</a></div>
	                <div class="submenu">
	                    <div><a href="#">グラフ表示/a></div>
	                </div>
	            </div>
	        </nav>
    	</aside>
    	
    	<div class="main">
    		<div class="main-header">
		        <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>事業部門別 在庫元帳照会</h1></div>
	            
	            <div>
		            <button type="button" class="btn btn-secondary">照会</button>
		            <button type="button" class="btn btn-secondary" id="resetBtn">初期化</button>
				</div>
	        </div>

	        <form id="searchForm">
		        <div class="filters">
		        	<div class="filters-main">
	        			<div class="title">照会条件</div>
	        			<div class="line"></div>
		        	</div>
	            	<div class="filters-row">
	            		<div class="filters-count">
		            		<div class="filters-text">事業部門</div>
		            		<div class="filters-value">
		            			<select id="businessBuName" name="businessBuName">
									<option value=""></option>
								    <option value="본사">本社</option>
								    <option value="부산지사">釜山支社</option>
								</select>
		            		</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">照会期間</div>
	            			<div class="filters-value">
	            				<input type="date" id="searchPeriodStart" name="searchPeriodStart">
								<span>~</span>
								<input type="date" id="searchPeriodEnd" name="searchPeriodEnd">
	            			</div>
	            		</div>
	            		<div class="filters-count">
		            		<div class="filters-text">在庫基準</div>
		            		<div class="filters-value">
		            			<select id="stockStandard" name="stockStandard">
									<option value=""></option>
								    <option value="실재고">実在庫</option>
								    <option value="자산재고">資産在庫</option>
								</select>
		            		</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品名</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemName" name="itemName">
	            				<img id="search-item-name-btn" src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品番</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemId" name="itemId">
	            				<img id="search-item-id-btn" src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">単位照会基準</div>
	            			<div class="filters-value">
	            				<select id="unitStandard" name="unitStandard">
									<option value=""></option>
								    <option value="KG">KG</option>
								    <option value="EA">EA</option>
								    <option value="SET">SET</option>
								</select>
	            			</div>
	            		</div>
	   			    </div>
				</div>
			</form>
			
			<div class="table-container" style="height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width: 90">日付</th>
							<th style="width: 90">区分</th>
	                        <th style="width: 90">入出庫区分</th>
	                        <th style="width: 90">単位</th>
	                        <th style="width: 90">入庫数量</th>
	                        <th style="width: 90">出庫数量</th>
	                        <th style="width: 90">在庫数量</th>
	                        <th style="width: 90">管理番号</th>
	                        <th style="width: 90">事業部門</th>
	                        <th style="width: 90">入庫倉庫</th>
	                        <th style="width: 90">出庫倉庫</th>
	                        <th style="width: 90">取引先</th>
	                        <th style="width: 90">処理部署</th>
	                        <th style="width: 90">処理者</th>
						</tr>
					</thead>
					
					<tbody id="resultTableBody">
	                    <!-- ここにデータが動的に挿入されます -->
	                </tbody>
				</table>
				
				<div id="noDataMessage" class="no-data" style="display: none;">
                	データがありません。
            	</div>
			</div>
    	</div>
    	
<script>

		// ==========================================================
	    // 1. ポップアップ関数 (window.openerのためにグローバル関数として定義)
	    // ==========================================================

	   	// ポップアップの種類を保存するグローバル変数
    	let currentCategoryType = '';
    	
    	// ポップアップ関数
    	function openPopup(url, windowName) {
    		currentCategoryType = windowName; // ポップアップの種類をグローバル変数に保存
    		
    		var popupWidth = 900;
    		var popupHeight = 600;
    		
    		var left = (screen.width - popupWidth) / 2;
    		var top = (screen.height - popupHeight) / 2;
    		
    		window.open
    		(
    			url,
    			windowName,
    			"width=" + popupWidth +
    			",height=" + popupHeight +
    			",left=" + left +
    			",top=" + top +
    			",scrollbars=yes,resizable=yes"
    		);
    	}
    	
    	// 統一されたコールバック関数 (ポップアップから window.opener.item_RowData(data) として呼び出し)
        // 品名、品番ポップアップから受け取った配列データを処理します。
        function item_RowData(data) {
        	
        	let itemId = ''; // 品番
        	let itemName = ''; // 品名

        	// ポップアップの種類(currentCategoryType)に応じて値のインデックスとターゲットフィールドIDを設定
         	if (data && data.length > 2) {
    	 		// 品番は data[0]
    	 		itemId = data[0];
    	 		// 品名は data[2]
    	 		itemName = data[2];
            } else {
            	console.error("ポップアップから有効なデータを受け取れませんでした。");
            	return;
            }
        
        	// 品名 (itemName) フィールドに値を適用
        	const itemNameElement = document.getElementById('itemName');
        	if (itemNameElement) {
        		itemNameElement.value = itemName;
        	}
        
        	// 品番 (itemId) フィールドに値を適用
        	const itemIdElement = document.getElementById('itemId');
        	if (itemIdElement) {
        		itemIdElement.value = itemId;
        	}
        	
        	console.log(`[コールバック] 品名適用完了: ${itemName}, 品番適用完了: ${itemId}`);
        	
        	// データ処理後 currentCategoryType 初期化。
        	currentCategoryType = '';
        }
    	
     	// ==========================================================
        // 2. jQuery ロジック
        // ==========================================================
        // ドキュメントがロードされたら実行
        $(document).ready(function() {
            const $searchForm = $('#searchForm');
            const $resultTableBody = $('#resultTableBody');
            const $noDataMessage = $('#noDataMessage');
            
            // 照会ボタン クリックイベント追加
            $('#searchBtn').on('click', function(event) {
                event.preventDefault(); // 기본 동작 방지
                $searchForm.submit(); // 폼의 submit 이벤트를 수동으로 호출
            });
            
            // 初期化ボタン クリックイベント
            $('#resetBtn').on('click', function() {
            	$searchForm[0].reset(); // 폼의 모든 필드를 기본값으로 리셋
            	
            	$('#itemName').val('');
            	$('#itemId').val('');
            });
            
         	// ==========================================================
            // 3. ポップアップボタン イベントリスナー
            // ==========================================================

            // 品名ボタン イベントリスナー
            $('#search-item-name-btn').on('click', function() {
                openPopup('/popup/item_name_popup', 'item_name');
            });
         	
            // 品番ボタン イベントリスナー
            $('#search-item-id-btn').on('click', function() {
                openPopup('/popup/item_popup', 'item');
            });
     
            $searchForm.on('submit', function(event) {
                event.preventDefault(); // フォームの基本提出動作を防止

                const formData = $(this).serialize(); // フォームデータを直列化

                $.ajax({
                    url: '/stock/ledger/search',
                    type: 'GET',
                    data: formData,
                    success: function(data) {
                        $resultTableBody.empty();
                        $noDataMessage.hide();

                        if (data && data.length > 0) {
                            data.forEach(function(item) {
                                // transactionDateをJavaScriptで変換
                                const transactionDate = item.transactionDate ? new Date(item.transactionDate) : null;
                                const formattedDate = transactionDate ? transactionDate.toISOString().split('T')[0] : '';
                                
                                const row = `
                                    <tr>
                                        <td>${formattedDate}</td>
                                        <td>${item.type || ''}</td>
                                        <td>${item.inOutboundType || ''}</td>
                                        <td>${item.inOutboundCategory || ''}</td>
                                        <td>${item.unit || ''}</td>
                                        <td>${item.inboundQty !== null ? item.inboundQty : ''}</td>
                                        <td>${item.outboundQty !== null ? item.outboundQty : ''}</td>
                                        <td>${item.stockQty !== null ? item.stockQty : ''}</td>
                                        <td>${item.managementId || ''}</td>
                                        <td>${item.buName || ''}</td>
                                        <td>${item.inboundWarehouse || ''}</td>
                                        <td>${item.outboundWarehouse || ''}</td>
                                        <td>${item.customer || ''}</td>
                                        <td>${item.processingDepartment || ''}</td>
                                        <td>${item.processor || ''}</td>
                                    </tr>
                                `;
                                $resultTableBody.append(row);
                            });
                        } else {
                            $noDataMessage.text('データがありません。').show();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('An error occurred:', status, error);
                        $noDataMessage.text('データを読み込む中にエラーが発生しました。').show();
                    }
                });
            });
            
         	// ページロード時に自動照会
            $searchForm.submit();
        });
    </script>
</body>
</html>