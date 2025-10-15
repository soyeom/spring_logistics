<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>事業単位別 在庫受払集計 照会</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="layout">
    	<%@ include file="/WEB-INF/views/logistics.jsp" %>
    	<div class="main">
    		<div class="main-header">
		        <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>事業単位別 在庫受払集計</h1></div>
	            
	            <div>
		            <button class="btn btn-secondary" id="search-btn">照会</button>
		            <button class="btn btn-secondary" id="reset-btn">初期化</button>
				</div>
	        </div>
	        
	        <form id="search-form">
		        <div class="filters">
		        	<div class="filters-main">
	        			<div class="title">照会条件</div>
	        			<div class="line"></div>
		        	</div>
	            	<div class="filters-row">
	            		<div class="filters-count">
		            		<div class="filters-text">事業単位</div>
		            		<div class="filters-value">
		            			<select id="businessBuName" name="businessBuName">
									<option value=""></option>
								    <c:forEach items="${businessBuNameList}" var="item">
						                <option value="${item.value}">${item.text}</option>
						            </c:forEach>
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
		            		<div class="filters-text">品目資産分類</div>
		            		<div class="filters-value">
		            			<select id="itemAssetClass" name="itemAssetClass">
		            				<option value=""></option>
		            				
		            				<c:forEach items="${itemAssetClassList}" var="item">
                						<option value="${item.value}">${item.text}</option>
            						</c:forEach>
		            			</select>
		            		</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品目大分類</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemBigCategory" name="itemBigCategory">
	            				<img id="search-big-category-btn" src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品目中分類</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemMidCategory" name="itemMidCategory">
	            				<img id="search-mid-category-btn" src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品目小分類</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemSmallCategory" name="itemSmallCategory">
	            				<img id="search-small-category-btn" src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品名</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemName" name="itemName">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">品番</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemId" name="itemId">
	            			</div>
	            		</div>
	            		<div class="filters-count">
	            			<div class="filters-text">規格</div>
	            			<div class="filters-value">
	            				<input type="text" id="itemSpec" name="itemSpec">
	            			</div>
	            		</div>
	   			    </div>
	   			    
	   			    <button type="button" class="toggle-filters" onclick="toggleExtraFilters()">追加照会条件</button>
	   			    
	   			    <div class="extra-filters" style="display:none;">
	   			    	
	   			    	<hr class="filters-divider">
	   			    	<div class="filters-row">
	   			    		<div class="filters-count">
	            				<div class="filters-text">品目ステータス</div>
	            				<div class="filters-value">
	            					<select id="itemStatus" name="itemStatus">
			            				<option value=""></option>
			            				<c:forEach items="${itemStatusList}" var="item">
							                <option value="${item.value}">${item.text}</option>
							            </c:forEach>
		            				</select>
	            				</div>
	            			</div>
	            			<div class="filters-count">
	            				<div class="filters-text">単位照会基準</div>
	            				<div class="filters-value">
	            					<select id="unitStandard" name="unitStandard">
			            				<option value=""></option>
			            				<option value="基準単位">基準単位</option>
			            				<option value="受払単位">受払単位</option>
			            				<option value="換算単位">換算単位</option>
		            				</select>
	            				</div>
	            			</div>
	            			<div class="filters-count">
	            				<div class="filters-text">ゼロ数量 照会有無</div>
	            				<div class="filters-value">
	            					<input id="includeZeroQty" name="includeZeroQty" type="checkbox">
	            				</div>
	            			</div>
	   			    	</div>
	   			    </div>
				</div>
			</form>
		
			<div class="table-container" style="height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th rowspan="2" style="width: 90">品番</th>
							<th rowspan="2" style="width: 90">品目資産分類</th>
	                        <th rowspan="2" style="width: 90">品目大分類</th>
	                        <th rowspan="2" style="width: 90">品目中分類</th>
	                        <th rowspan="2" style="width: 90">品名</th>
	                        <th rowspan="2" style="width: 90">入庫数量</th>
	                        <th rowspan="2" style="width: 90">単位</th>
	                        <th rowspan="2" style="width: 90">品目ステータス</th>
	                        <th rowspan="2" style="width: 90">在庫数量</th>
	                        <th rowspan="2" style="width: 90">繰越数量</th>
	                        <th rowspan="2" style="width: 90">出庫数量</th>
	                        
	                        <th colspan="4">入庫</th>
	                        <th colspan="5">出庫</th>
						</tr>
						
						<tr>
	                        <th class="p-3" style="width: 90">生産入庫</th>
	                        <th class="p-3" style="width: 90">外注入庫</th>
	                        <th class="p-3" style="width: 90">購買入庫</th>
	                        <th class="p-3" style="width: 90">輸入入庫</th>
	                        <th class="p-3" style="width: 90">取引明細書</th>
	                        <th class="p-3" style="width: 90">その他出庫</th>
	                        <th class="p-3" style="width: 90">販売保管品出庫</th>
	                        <th class="p-3" style="width: 90">作業実績</th>
	                        <th class="p-3" style="width: 90">外注入庫</th>
	                    </tr>
					</thead>
					
					<tbody id="stockSummaryTableBody">
	                    <!-- ここにデータが動的に挿入されます -->
	                </tbody>
				</table>
				
				<div id="noDataMessage" class="no-data" style="display: none;">
	                	データがありません。
	            </div>
			</div>
    	</div>
	
<script>

	function toggleExtraFilters() {
	    const extra = document.querySelector('.extra-filters');
	    extra.style.display = (extra.style.display === 'none' || extra.style.display === '') 
	        ? 'block' : 'none';
	}
	
    // ==========================================================
    // 1. ポップアップ関数 (window.openerを介した連携のためにグローバル関数として定義)
    // ==========================================================
    
    // ポップアップの種類を保存するグローバル変数
    let currentCategoryType = '';
    
 	// 共通ポップアップオープン関数（画面中央寄せロジック）
    function openPopup(url, windowName) {
    	currentCategoryType = windowName; // ポップアップの種類をグローバル変数に保存
    	
        var popupWidth = 900;
        var popupHeight = 600;
        
        // 画面中央座標計算
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
    
    // 共通コールバック関数（ポップアップから window.opener.item_RowData(data) で呼び出し）
    // 品目 大/中/小 分類ポップアップから受け取った配列データを処理します。
    function item_RowData(data) {
    	
    	let categoryName = '';
    	let targetElementId = '';

    	// ポップアップの種類(currentCategoryType)に応じて、値のインデックスとターゲットフィールドIDを設定
     	if (currentCategoryType === 'big') {
	 		categoryName = data[1];
	 		targetElementId = 'itemBigCategory';
        } else if (currentCategoryType === 'mid') {
        	categoryName = data[2];
        	targetElementId = 'itemMidCategory';
        } else if (currentCategoryType === 'small') {
        	categoryName = data[3];
        	targetElementId = 'itemSmallCategory';
        } else {
        	console.error("不明なポップアップタイプです:", currentCategoryType);
        	return;
        }
    
    	// 該当フィールドに値を適用
    	if (targetElementId && categoryName !== undefined) {
    		document.getElementById(targetElementId).value = categoryName;
    	}
    
    	// データ処理後 currentCategoryType を初期化
    	currentCategoryType = '';
    	
    	console.log(`[コールバック] \${targetElementId} フィールドに名称適用完了: \${categoryName}`);
    }
    
    // ==========================================================
    // 2. jQuery ロジック
    // ==========================================================
    // ドキュメントがロードされたら実行
    $(document).ready(function() {

        // 照会ボタンクリックイベント
        $('#search-btn').on('click', function() {
            event.preventDefault(); // フォームのデフォルトの送信動作を防止
            searchStockSummary();
        });

      	// 初期化ボタンクリックイベント
        $('#reset-btn').on('click', function() {
            $('#search-form')[0].reset(); // フォームタグの reset() 関数を使用
            
            // 初期化された検索条件を反映するために再度照会
            searchStockSummary(); 
        });
      	
      	// 初期ロード時に照会関数を呼び出し
        searchStockSummary();


        // ==========================================================
        // 3. ポップアップボタンイベントリスナー
        // ==========================================================

        // 品目大分類ボタンイベントリスナー
        $('#search-big-category-btn').on('click', function() {
            openPopup('/popup/category_popup_big', 'big');
        });
     	
        // 品目中分類ボタンイベントリスナー
        $('#search-mid-category-btn').on('click', function() {
            openPopup('/popup/category_popup_mid', 'mid');
        });
     	
        // 品目小分類ボタンイベントリスナー
        $('#search-small-category-btn').on('click', function() {
            openPopup('/popup/category_popup_small', 'small');
        });

         
        // 照会関数
        function searchStockSummary() {
            const criteria = {
                businessBuName: $('#businessBuName').val(), // 事業単位
                searchPeriodStart: $('#searchPeriodStart').val(), // 照会期間開始日
                searchPeriodEnd: $('#searchPeriodEnd').val(), // 照会期間終了日
                stockStandard: $('#stockStandard').val(), // 在庫基準
                itemAssetClass: $('#itemAssetClass').val(), // 品目資産分類
                itemBigCategory: $('#itemBigCategory').val(), // 品目大分類
                itemMidCategory: $('#itemMidCategory').val(), // 品目中分類
                itemSmallCategory: $('#itemSmallCategory').val(), // 品目小分類
                itemName: $('#itemName').val(), // 品名
                itemId: $('#itemId').val(), // 品番
                itemSpec: $('#itemSpec').val(), // 規格
                itemStatus: $('#itemStatus').val(), // 品目ステータス
                unitStandard: $('#unitStandard').val(), // 単位照会基準
                includeZeroQty: $('#includeZeroQty').is(':checked') // ゼロ数量 照会有無
            };

            // ... (AJAX 通信ロジック) ...
            $.ajax({
                url: '/stock/summary/search',
                type: 'GET',
                data: criteria,
                dataType: 'json',
                success: function(response) {
                    console.log('Server response:', response);
                    const $tbody = $('#stockSummaryTableBody');
                    const $noDataMessage = $('#noDataMessage');
                    $tbody.empty();

                    if (response && response.length > 0) {
                        $noDataMessage.hide();
                        $.each(response, function(index, item) {
                            if (item) {
                                const row = `
                                    <tr data-item-id="\${item.itemId}" data-item-name="\${item.itemName}">
                                        <td>\${item.itemId}</td> // 品番
                                        <td>\${item.itemAssetClass}</td> // 品目資産分類
                                        <td>\${item.itemBigCategory}</td> // 品目大分類
                                        <td>\${item.itemMidCategory}</td> // 品目中分類
                                        <td>\${item.itemName}</td> // 品名
                                        <td>\${item.inboundQty}</td> // 入庫数量
                                        <td>\${item.itemUnit}</td> // 単位
                                        <td>\${item.itemStatus}</td> // 品目ステータス
                                        <td>\${item.stockQty}</td> // 在庫数量
                                        <td>\${item.carriedOverQty}</td> // 繰越数量
                                        <td>\${item.outboundQty}</td> // 出庫数量
                                        <td>\${item.productionInbound}</td> // 入庫（生産入庫）
                                        <td>\${item.outsourcingInbound}</td> // 入庫（外注入庫）
                                        <td>\${item.purchaseInbound}</td> // 入庫（購買入庫）
                                        <td>\${item.importInbound}</td> // 入庫（輸入入庫）
                                        <td>\${item.deliverySlipOutbound}</td> // 出庫（取引明細書）
                                        <td>\${item.otherOutbound}</td> // 出庫（その他出庫）
                                        <td>\${item.salesConsignmentOutbound}</td> // 出庫（販売保管品出庫）
                                        <td>\${item.workPerformanceOutbound}</td> // 出庫（作業実績）
                                        <td>\${item.outsourcingOutbound}</td> // 出庫（外注入庫）
                                    </tr>
 								`;
                                $tbody.append(row);
                            }
                        });
                    } else {
                        $noDataMessage.text('データがありません。').show();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('An error occurred:', status, error);
                    $('#noDataMessage').text('データの読み込み中にエラーが発生しました。').show();
                }
            });
        }
 
 		$('#stockSummaryTableBody').on('dblclick', 'tr', function() {
 			const $row = $(this);
 			
 			const itemId = $row.data('itemId');
 			const itemName = $row.data('itemName');
 			
 			if (itemId) {
 				console.log(`Double-clicked Item ID: \${itemId}`);
 				
 				const redirectUrl = `/stock/ledger?itemId=\${encodeURIComponent(itemId)}&itemName=\${encodeURIComponent(itemName)}`;
 				
 				window.location.href = redirectUrl;
 			} else {
 				console.error('Item ID not found on the double-clicked row.');
 			}
 		})
 
    });
</script>
</body>
</html>