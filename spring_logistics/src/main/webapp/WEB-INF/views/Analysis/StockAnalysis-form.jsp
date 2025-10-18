<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>在庫変動推移分析</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/css/logistics.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="layout">
		<%@ include file="/WEB-INF/views/logistics.jsp"%>
		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>在庫変動推移分析</h1>
				</div>
				<div>
					<button id="btnSearch" class="btn btn-secondary">検索</button>
					<button onclick="resetSearch()" class="btn btn-secondary">初期化</button>
				</div>
			</div>

			<div class="filters search-filters">
				<div class="filters-main">
					<div class="title">検索条件</div>
					<div class="line"></div>
				</div>

				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">事業部門</div>
						<div class="filters-value">
							<select id="buId" name="bu_id"></select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">倉庫</div>
						<div class="filters-value">
							<input type="text" id="warehouseName">
							<input type="hidden" id="warehouseId"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" id="btnWarehouse"
								onclick="open_Warehouse()">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">在庫基準</div>
						<div class="filters-value">
							<select id="stockStandard">
								<option value="REAL">実在庫</option>
								<option value="ASSET">資産在庫</option>
							</select>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">重要度</div>
						<div class="filters-value">
							<select id="importanceLevel">
								<option value=""></option>
								<option value="A">A等級</option>
								<option value="B">B等級</option>
								<option value="C">C等級</option>
							</select>
						</div>
					</div>
				</div>

				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">品目資産分類</div>
						<div class="filters-value">
							<select id="itemAssetClass">
								<option value=""></option>
								<option value="製品">製品</option>
								<option value="半製品">半製品</option>
								<option value="商品">商品</option>
								<option value="原材料">原材料</option>
								<option value="副資材">副資材</option>
								<option value="仕掛品">仕掛品</option>
								<option value="ストック">ストック</option>
							</select>
						</div>
					</div>

					<div class="filters-count">
						<div class="filters-text">品目小分類</div>

						<div class="filters-value">
							<input type="text" id="itemSmallCategoryName"> 
							<input type="hidden" id="itemSmallCategory"> <img
								src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png"
								alt="search" class="search-icon" id="btnItemSmallCategory"
								onclick="open_Isc()">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">品名</div>
						<div class="filters-value">
							<input type="text" id="itemName">
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">品番</div>
						<div class="filters-value">
							<input type="number" id="itemId">
						</div>
					</div>
				</div>

				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">規格</div>
						<div class="filters-value">
							<input type="text" id="spec">
						</div>
					</div>
				</div>
			</div>

			<div class="filters compare-filters">
				<div class="filters-main">
					<div class="title">比較設定</div>
					<div class="line"></div>
				</div>

				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">現在月</div>
						<div class="filters-value">
							<input type="month" id="currentMonth"
								value="<%=new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date())%>"
								readonly>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">期間間隔</div>
						<div class="filters-value" style="">
							<div class="input-with-text">
								<input type="number" id="periodMonths" value="3" readonly
									style="width: 100px;"> <span>ヶ月</span>
							</div>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">比較回数</div>
						<div class="filters-value" style="">
							<div class="input-with-text">
								<input type="number" id="periodCount" value="4" min="1" readonly
									style="width: 100px;"><span>回比較</span>
							</div>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">分析項目</div>
						<div class="filters-value">
							<select id="analysisItem">
								<option>平均在庫量</option>
								<option>在庫回転率(%)</option>
								<option>総入庫量</option>
								<option>総出庫量</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="table-container">
				<!-- テーブルIDをanalysisTableとして追加し、JSから正しく参照できるように修正 -->
				<table class="table-single-select" id="analysisTable" style="width: 100%">
					<thead>
						<tr id="resultHeadRow">
							<th>品目資産分類</th>
							<th>品目大分類</th>
							<th>品目小分類</th>
							<th>品番</th>
							<th>品名</th>
							<th>規格</th>
							<th>品目中分類</th>
							<th>単位</th>
						</tr>
					</thead>
					<tbody id="result-tbody">
						<c:choose>
							<c:when test="${not empty analysisData}">
								<c:forEach var="item" items="${analysisData}" varStatus="status">
									<tr onclick="row_Click(this)">
										<td class="text-center">
											<input type="hidden" value="<c:out value='${item.buId}'/>" />
											<c:out value="${item.itemAssetClass}"/>
										</td>
										<td class="text-center"><c:out value="${item.itemBigCategory}"/></td>
										<td class="text-center"><c:out value="${item.itemSmallCategory}"/></td>
										<td class="text-center"><c:out value="${item.itemId}"/></td>
										<td><c:out value="${item.itemName}"/></td>
										<td><c:out value="${item.spec}"/></td>
										<td><c:out value="${item.itemMidCategory}"/></td>
										<td><c:out value="${item.baseUnit}"/></td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			</div>

			<script>
var ctx = '${pageContext.request.contextPath}';
const POPUP_WIDTH = 900, POPUP_HEIGHT = 600;

/** 数値をフォーマットする関数 (小数点2桁、カンマ区切り) */
function formatNumber(n, decimals = 2, decimalSep = '.', thousandsSep = ',') {
    let num = parseFloat(n);
    if (isNaN(num)) num = 0.00;
    
    const fixed = num.toFixed(decimals);
    const parts = fixed.split(decimalSep);
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, thousandsSep);
    return parts.join(decimalSep);
}

/** 事業部門(BU)データをロードする */
function loadBusinessUnits() {
    return $.ajax({
        url: ctx + '/common/bus',
        type: "GET",
        dataType: "json",
        success: function(data) {
            const buSelect = $("#buId");
            buSelect.empty();
            buSelect.append('<option value=""></option>');
            $.each(data, function(index, bu) {
                buSelect.append('<option value="' + bu.id + '">' + bu.name + '</option>');
            });
        },
        error: function(xhr, status, error) {
            const buSelect = $("#buId");
            // フォールバック、またはロード失敗時でも少なくとも空のオプションが存在するようにする
            if (buSelect.children().length === 0) {
                buSelect.append('<option value=""></option>');
                // 例示データ削除（実際の運用環境では使用しない）
                // buSelect.append('<option value="1">本社</option>');
            }
        }
    });
}

/** テーブル行クリック時のデータ抽出とロギング */
window.row_Click = function(row) {
    // #analysisTable IDを使用して選択された行のクラスを削除
    $("#analysisTable tbody tr").removeClass('selected-row');
    $(row).addClass('selected-row');

    const cells = row.cells;
    const rowData = {};
    // #analysisTable IDを使用してヘッダー行を正確に探す
    const headerRow = $('#analysisTable').find('#resultHeadRow th');
    const fixedColumnsCount = 8;

    // 固定された8つのカラムデータを抽出
    rowData['buId'] = $(cells[0]).find('input[type="hidden"]').val(); 
    rowData[headerRow.eq(0).text().trim()] = $(cells[0]).text().trim();
    rowData[headerRow.eq(1).text().trim()] = $(cells[1]).text().trim();
    rowData[headerRow.eq(2).text().trim()] = $(cells[2]).text().trim();
    rowData[headerRow.eq(3).text().trim()] = $(cells[3]).text().trim();
    rowData[headerRow.eq(4).text().trim()] = $(cells[4]).text().trim();
    rowData[headerRow.eq(5).text().trim()] = $(cells[5]).text().trim();
    rowData[headerRow.eq(6).text().trim()] = $(cells[6]).text().trim();
    rowData[headerRow.eq(7).text().trim()] = $(cells[7]).text().trim();

    // 動的に追加された期間カラムデータを抽出
    for (let i = fixedColumnsCount; i < cells.length; i++) {
        const headerText = headerRow.eq(i).text().trim();
        // 数値フォーマットを削除
        const cellValue = $(cells[i]).text().trim().replace(/,/g, ''); 
        rowData[headerText] = cellValue;
    }

    console.log("--- クリックされた在庫変動データ ---");
    console.log(rowData);
    console.log("-----------------------------------");
};

$(document).ready(function() {
    
    $('.toggle-sidebar').on('click', function() {
           $('.sidebar').toggleClass('hidden');
    		$('.layout').toggleClass('sidebar-collapsed');
    });

    loadBusinessUnits();

    const analysisMap = {
        '平均在庫量': 'averageStock',
        '在庫回転率(%)': 'turnoverRate',
        '総入庫量': 'totalIn',
        '総出庫量': 'totalOut'
    };

    /** 検索条件を初期化する関数 */
    window.resetSearch = function() {
        $("#buId").val($("#buId option:first").val());
        $("#stockStandard").val('REAL');
        $("#importanceLevel").val($("#importanceLevel option:first").val());
        $("#itemAssetClass").val($("#itemAssetClass option:first").val());
        $("#analysisItem").val($("#analysisItem option:first").val());
        $("#itemName, #itemId, #spec, #warehouseName, #warehouseId, #itemSmallCategoryName, #itemSmallCategory").val('');
        
        $("#result-tbody").empty(); 

        // #analysisTable IDを使用してtheadを探す
        let thead = $('#analysisTable').find('thead');
        thead.empty();
        // IDをresultHeadRowとして明示し、動的/初期ヘッダーの区別を明確にする
        thead.append(`
            <tr id="resultHeadRow">
                <th>品目資産分類</th><th>品目大分類</th><th>品目小分類</th>
                <th>品番</th><th>品名</th><th>規格</th><th>品目中分類</th><th>単位</th>
            </tr>
        `);
        // テーブルIDを使用してすべての行の選択クラスを削除
        $("#analysisTable tbody tr").removeClass('selected-row');
    };

    $("#btnSearch").click(function() {

        let buIdValue = $("#buId").val();
        let warehouseIdValue = $("#warehouseId").val().trim();
        let itemIdValue = $("#itemId").val();

        // 入力された値が""の場合、nullとして処理してサーバーに送信
        let parsedBuId = buIdValue ? parseInt(buIdValue) : null;
        let parsedWarehouseId = (!isNaN(warehouseIdValue) && warehouseIdValue !== "") ? parseInt(warehouseIdValue, 10) : null;
        let parsedItemId = (!isNaN(itemIdValue) && itemIdValue !== "") ? parseInt(itemIdValue, 10) : null;

        let selectedAnalysisText = $("#analysisItem option:selected").text();
        // analysisMapの定義を確認（ページ上部に定義済み）
        let analysisItemServerKey = analysisMap[selectedAnalysisText] || null;

        let requestData = {
            buId : parsedBuId,
            warehouseId : parsedWarehouseId,
            itemId : parsedItemId,
            itemName : $("#itemName").val(),
            spec : $("#spec").val(),
            itemAssetClass : $("#itemAssetClass").val(),
            importanceLevel : $("#importanceLevel").val(),
            stockStandard : $("#stockStandard").val(),
            currentMonth : $("#currentMonth").val(),
            itemSmallCategory : $("#itemSmallCategory").val() || null,
            analysisItem : analysisItemServerKey,
            periodMonths: parseInt($("#periodMonths").val()),
            periodCount: parseInt($("#periodCount").val())
        };

        $.ajax({
            url : ctx + '/stock-analysis/analysis',
            type : "POST",
            contentType : "application/json",
            data : JSON.stringify(requestData),
            beforeSend: function() {
                // tbodyのcolspanを十分に大きく設定し、ローディングメッセージがよく見えるようにする
                $("#result-tbody").html('<tr><td colspan="100%" style="text-align:center;">データを検索中です...</td></tr>');
            },
            success : function(data) {

                let tbody = $("#result-tbody").empty();
                // テーブルIDを使用して既存の選択クラスを削除
                $("#analysisTable tbody tr").removeClass('selected-row');
                let periods = [];
                
                if (data.length > 0) {
                    // データオブジェクトから'YYYY-MM'形式のキー（期間）を抽出
                    $.each(data[0], function(key) {
                        if (/^\d{4}-\d{2}$/.test(key)) periods.push(key);
                    });
                    periods.sort().reverse(); // 期間を降順にソート
                }

                // **テーブルヘッダーの動的生成**
                // #analysisTable IDを使用してtheadを探す
                let thead = $('#analysisTable').find('thead');
                thead.empty();
                let theadRow = $('<tr id="resultHeadRow"></tr>').appendTo(thead);
                theadRow.append('<th>品目資産分類</th><th>品目大分類</th><th>品目小分類</th><th>品番</th><th>品名</th><th>規格</th><th>品目中分類</th><th>単位</th>');
                
                // 動的期間カラムの追加
                $.each(periods, function(i, p) {
                    // pは'YYYY-MM'形式です。
                    theadRow.append("<th class='dynamic'>" + p + "</th>");
                });
                
                // **テーブルボディの動的生成**
                if (data.length > 0) {
                    $.each(data, function(i, row) {
                        let tr = $('<tr onclick="row_Click(this)"></tr>');
                        
                        // 固定されたカラムデータ
                        tr.append('<td class="text-center"><input type="hidden" value="' + (row.buId || '') + '" />' + (row.itemAssetClass || '') + '</td>');
                        tr.append('<td class="text-center">' + (row.itemBigCategory || '') + '</td>');
                        tr.append('<td class="text-center">' + (row.itemSmallCategory || '') + '</td>');
                        tr.append('<td class="text-center">' + (row.itemId || '') + '</td>');
                        tr.append('<td>' + (row.itemName || '') + '</td>');
                        tr.append('<td>' + (row.spec || '') + '</td>');
                        tr.append('<td>' + (row.itemMidCategory || '') + '</td>');
                        tr.append('<td>' + (row.baseUnit || '') + '</td>');
                        
                        // 動的期間カラムデータ（ソートされたperiodsの順序に従って）
                        $.each(periods, function(j, p) {
                            let value = row[p] !== undefined && row[p] !== null ? row[p] : 0.00;
                            tr.append('<td class="text-right">' + formatNumber(value) + '</td>');
                        });
                        
                        tbody.append(tr);
                    });
                } else {
                    // データがない場合のcolspan計算
                    let colspanCount = 8 + periods.length;
                    if (colspanCount < 8) colspanCount = 8; // 最小8つの固定カラム
                    tbody.append('<tr><td colspan="' + colspanCount + '" class="text-center">検索結果がありません。</td></tr>');
                }
            },
            error : function(xhr) {
                console.error("データ取得中にエラーが発生しました:", xhr);
                // エラー時のcolspan計算
                let currentColspan = $('#resultHeadRow th').length || 8;
                $("#result-tbody").html('<tr><td colspan="' + currentColspan + '" style="text-align:center; color: red;">データのロード中にエラーが発生しました。</td></tr>');
            }
        });
    });

    $(document).on("keydown", function(e) {
        if (e.key === "Enter") {
            if ($(e.target).closest('.filters').length) {
                e.preventDefault();
                $("#btnSearch").trigger("click");
            }
        }
    });
});

/** 倉庫検索ポップアップを開く */
const open_Warehouse = function() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    window.currentPopupType = 'warehouse';
    window.open(ctx + '/popup/warehouse_popup', "warehouse_popup",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

/** 品目小分類検索ポップアップを開く */
const open_Isc = function() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    window.currentPopupType = 'category_popup_small';
    window.open(ctx + '/popup/category_popup_small', "category_popup_small",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

/**
 * ポップアップからのコールバック処理
 * @param {Array<any>} data - 選択されたデータ
 */
window.item_RowData = function(data) {
    const argsLength = arguments.length;
    let callbackType = window.currentPopupType || 'warehouse'; 

    if (argsLength !== 1 || !Array.isArray(data)) {
        return;
    }
    
    if (callbackType === 'warehouse') {
        if (data.length >= 2) {
            $("#warehouseName").val(data[0]); 
            $("#warehouseId").val(data[1]);
        }
    } else if (callbackType === 'category_popup_small') {
        if (data.length >= 4) {
            $("#itemSmallCategory").val(data[3]); 
            $("#itemSmallCategoryName").val(data[3]);
        }
    }
    
    window.currentPopupType = null;
};

$("#btnWarehouse").click(function() {
    window.currentPopupType = 'warehouse';
    open_Warehouse();
});

$("#btnItemSmallCategory").click(function() {
    window.currentPopupType = 'category_popup_small';
    open_Isc();
});
</script>
</div>
</div>
</body>
</html>
