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
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/logistics.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css"
    href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/colreorder/1.7.0/js/dataTables.colReorder.min.js"></script>

<style>
/* CSS 스타일링 생략 */
.input-group {
	display: flex;
	align-items: center;
	width: 100%;
}
.input-group input[type="text"], .input-group input[type="number"],
.input-group select {
	flex-grow: 1;
	margin-right: 5px;
}
.input-group .btn-primary {
	flex-shrink: 0;
	height: 30px;
	width: 30px;
	padding: 0;
	display: flex;
	align-items: center;
	justify-content: center;
}
.input-with-text {
	display: flex;
	align-items: center;
	gap: 5px;
}
.input-with-text input {
	width: 60px;
	text-align: center;
}
.input-with-text span {
	flex-shrink: 0;
}
.layout {
    display: flex;
    min-height: 100vh;
}
.main {
    flex-grow: 1;
    padding: 20px;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
}
.table-container {
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    flex-grow: 1; 
    overflow-y: hidden;
    min-height: 300px;
    overflow-x: auto;
}
#analysisTable {
    width: 100% !important;
    border-collapse: collapse;
    font-size: 14px;
}
#analysisTable th, #analysisTable td {
    padding: 10px;
    text-align: left;
    border: 1px solid #e0e0e0;
    white-space: nowrap;
}
#analysisTable thead th {
    background-color: #f5f5f5;
    font-weight: bold;
    color: #333;
    position: sticky;
    top: 0;
}
.dataTables_scrollHeadInner {
    width: 100% !important;
}
#analysisTable.dataTable {
    table-layout: fixed;
}
</style>
</head>
<body>
	<div class="layout">
	<%@ include file="/WEB-INF/views/logistics.jsp" %>
		<div class="main">
			<div class="main-header">
				<div>
					<span class="btn btn-secondary btn-icon toggle-sidebar">≡</span>
				</div>
				<div>
					<h1>在庫変動推移分析</h1>
				</div>
				<div>
					<button class="btn btn-primary btn-search" id="btnSearch">検索</button>
					<button class="btn btn-reset" onclick="resetSearch()">初期化</button>
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
							<div class="input-group">
								<input type="text" id="warehouseName" placeholder="倉庫を選択"
									readonly> <input type="hidden" id="warehouseId">
								<button type="button" class="btn-primary" id="btnWarehouse">
									<i class="fa fa-search"></i>
								</button>
							</div>
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
								<option value="">-- 選択 --</option>
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
								<option value="">全体</option>
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
							<div class="input-group">
								<input type="text" id="itemSmallCategoryName"
									placeholder="小分類を選択" readonly> <input type="hidden"
									id="itemSmallCategory">
								<button type="button" class="btn-primary"
									id="btnItemSmallCategory">
									<i class="fa fa-search"></i>
								</button>
							</div>
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
						<div class="filters-value">
							<div class="input-with-text">
								<input type="number" id="periodMonths" value="3" readonly><span>ヶ月</span>
							</div>
						</div>
					</div>
					<div class="filters-count">
						<div class="filters-text">比較回数</div>
						<div class="filters-value">
							<div class="input-with-text">
								<input type="number" id="periodCount" value="4" min="1" readonly><span>回比較</span>
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

			<div class="result-container table-container">
				<table id="analysisTable" class="display">
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
					<tbody id="resultBody"></tbody>
				</table>
			</div>
		</div>
	</div>

<script>
var ctx = '${pageContext.request.contextPath}';
const POPUP_WIDTH = 900, POPUP_HEIGHT = 600;

/** 事業部門(BU)データをロードし、セレクトボックスを更新する */
function loadBusinessUnits() {
    return $.ajax({
        url: ctx + '/common/bus',
        type: "GET",
        dataType: "json",
        success: function(data) {
            const buSelect = $("#buId");
            buSelect.empty();
            buSelect.append('<option value="">全体</option>');
            $.each(data, function(index, bu) {
                buSelect.append('<option value="' + bu.id + '">' + bu.name + '</option>');
            });
        },
        error: function(xhr, status, error) {
             // エラー発生時、デフォルトオプションを設定 (フォールバック)
            const buSelect = $("#buId");
            if (buSelect.children().length === 0) {
                buSelect.append('<option value="">全体</option>');
                buSelect.append('<option value="1">本社</option>');
            }
        }
    });
}

$(document).ready(function() {
    
    // サイドバートグル機能
    $('.toggle-sidebar').on('click', function() {
        $('.layout').toggleClass('sidebar-collapsed');
    });

    // 事業部門ロード後、初期検索を実行
    loadBusinessUnits().done(function() {
        $("#btnSearch").trigger("click");
    });

    // サーバー送信用の分析項目キーを定義
    const analysisMap = {
        '平均在庫量': 'averageStock',
        '在庫回転率(%)': 'turnoverRate',
        '総入庫量': 'totalIn',
        '総出庫量': 'totalOut'
    };

    /** 検索条件を初期化する関数 */
    window.resetSearch = function() {
        // DataTables が初期化されている場合は破棄
        if ($.fn.DataTable.isDataTable('#analysisTable')) {
            $('#analysisTable').DataTable().destroy();
        }

        // 検索条件を初期値にリセット
        $("#buId").val($("#buId option:first").val());
        $("#stockStandard").val('REAL');
        $("#importanceLevel").val($("#importanceLevel option:first").val());
        $("#itemAssetClass").val($("#itemAssetClass option:first").val());
        $("#analysisItem").val($("#analysisItem option:first").val());
        $("#itemName, #itemId, #spec, #warehouseName, #warehouseId, #itemSmallCategoryName, #itemSmallCategory").val('');
        $("#resultBody").empty();

        // テーブルヘッダーを初期状態に戻す
        let thead = $('#analysisTable').find('thead');
        thead.empty();
        thead.append(`
            <tr id="resultHeadRow">
                <th>品目資産分類</th><th>品目大分類</th><th>品目小分類</th>
                <th>品番</th><th>品名</th><th>規格</th><th>品目中分類</th><th>単位</th>
            </tr>
        `);
    };

    // 検索ボタンクリックイベント
    $("#btnSearch").click(function() {

        let buIdValue = $("#buId").val();
        let warehouseIdValue = $("#warehouseId").val().trim();
        let itemIdValue = $("#itemId").val();

        // 検索条件の値をパース
        let parsedBuId = buIdValue ? parseInt(buIdValue) : null;
        let parsedWarehouseId = (!isNaN(warehouseIdValue) && warehouseIdValue !== "") ? parseInt(warehouseIdValue, 10) : null;
        let parsedItemId = (!isNaN(itemIdValue) && itemIdValue !== "") ? parseInt(itemIdValue, 10) : null;

        let selectedAnalysisText = $("#analysisItem option:selected").text();
        let analysisItemServerKey = typeof analysisMap !== 'undefined' ? analysisMap[selectedAnalysisText] : null;

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

        // 🚩 디버깅 코드 추가: 서버로 보내는 데이터 확인
        console.log("--- Stock Analysis Request Data ---");
        console.log("buId (사업부문 ID):", requestData.buId);
        console.log("warehouseId (倉庫 ID):", requestData.warehouseId);
        console.log("itemSmallCategory (品目小分類):", requestData.itemSmallCategory);
        console.log("currentMonth (現在月):", requestData.currentMonth);
        console.log("analysisItem (分析項目 Key):", requestData.analysisItem);
        console.log("Full Request Data:", requestData);
        console.log("-----------------------------------");

        // サーバーに分析データをリクエスト
        $.ajax({
            url : ctx + '/stock-analysis/analysis',
            type : "POST",
            contentType : "application/json",
            data : JSON.stringify(requestData),
            success : function(data) {

                // 🚩 디버깅 코드 추가: 서버 응답 데이터 길이 확인
                console.log("Server Response (Data Length):", data.length); 

                // 既存の DataTables を破棄
                if ($.fn.DataTable.isDataTable('#analysisTable')) {
                    $('#analysisTable').DataTable().destroy();
                }

                let tbody = $("#resultBody").empty();
                let periods = [];
                
                // 動的な期間ヘッダーを抽出（YYYY-MM形式のキーを抽出）
                if (data.length > 0) {
                    $.each(data[0], function(key) {
                        if (/^\d{4}-\d{2}$/.test(key)) periods.push(key);
                    });
                    periods.sort().reverse();
                }

                // テーブルヘッダーを動的に再構築
                let thead = $('#analysisTable').find('thead');
                thead.empty();
                let theadRow = $('<tr id="resultHeadRow"></tr>').appendTo(thead);
                theadRow.append('<th>品目資産分類</th><th>品目大分類</th><th>品目小分類</th><th>品番</th><th>品名</th><th>規格</th><th>品目中分類</th><th>単位</th>');
                $.each(periods, function(i, p) {
                    theadRow.append("<th class='dynamic'>" + p + "</th>");
                });

                // DataTablesのカラム定義を構築
                let columnsDef = [
                    { data: 'itemAssetClass', title: '品目資産分類' },
                    { data: 'itemBigCategory', title: '品目大分類' },
                    { data: 'itemSmallCategory', title: '品目小分類' },
                    { data: 'itemId', title: '品番' },
                    { data: 'itemName', title: '品名' },
                    { data: 'spec', title: '規格' },
                    { data: 'itemMidCategory', title: '品目中分類' },
                    { data: 'baseUnit', title: '単位' }
                ];

                // 動的な期間カラムを追加
                $.each(periods, function(i, p) {
                    columnsDef.push({
                        data: p,
                        title: p,
                        className: 'text-right',
                        defaultContent: '0.00'
                    });
                });

                // DataTables 初期化
                let table = $('#analysisTable').DataTable({
                    data: data,
                    columns: columnsDef,
                    scrollX: true,
                    scrollY: 'calc(100vh - 400px)',
                    scrollCollapse: true,
                    autoWidth: false,
                    paging: true,
                    searching: true,
                    ordering: true,
                    info: true,
                    destroy: true,
                    language: {
                        emptyTable: "検索結果がありません。",
                        zeroRecords: "検索結果がありません。"
                    }
                });

                table.columns.adjust().draw();
            },
            error : function(xhr) {
                alert("データ取得中にエラーが発生しました。");
            }
        });
    });

    // Enterキー押下で検索を実行
    $(document).on("keydown", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            $("#btnSearch").trigger("click");
        }
    });
});

/** 倉庫検索ポップアップを開く関数 */
const open_Warehouse = function() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    // 倉庫ポップアップを開く (경로 수정: /popup/warehouse_popup -> /stock-analysis/warehouse_popup)
    window.open(ctx + '/popup/warehouse_popup', "warehouse_popup",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

/** 品目小分類検索ポップアップを開く関数 */
const open_Isc = function() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    // 品目小分類ポップアップを開く (경로 수정: /popup/category_popup_small -> /stock-analysis/category_popup_small)
    window.open(ctx + '/popup/category_popup_small', "category_popup_small",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

/**
 * 統合ポップアップコールバック関数。
 * 팝업에서 전달된 데이터 배열 (인자 1개)을 처리하며, window.currentPopupType을 사용하여 분기 처리
 * @param {Array<any>} data - 選択された行のデータ配列
 */
window.item_RowData = function(data) {
    const argsLength = arguments.length;
    // 전역 변수에서 팝업 타입을 가져오거나 기본값 'warehouse' 사용
    let callbackType = window.currentPopupType || 'warehouse'; 

    if (argsLength !== 1 || !Array.isArray(data)) {
        return;
    }
    
    // 팝업 타입별 분기 처리
    if (callbackType === 'warehouse') {
        // 倉庫ポップアップの処理: data[0] = 倉庫名, data[1] = 倉庫コード
        if (data.length >= 2) {
            $("#warehouseName").val(data[0]); 
            $("#warehouseId").val(data[1]);
        }
    } else if (callbackType === 'category_popup_small') {
        // 品目小分類ポップアップの処理: data[3] = 小分類
        if (data.length >= 4) { // 品目 소분류 팝업의 데이터 구조에 따라 data[3]을 사용
            $("#itemSmallCategory").val(data[3]); 
            $("#itemSmallCategoryName").val(data[3]);
        }
    }
    
    // 콜백 처리 후 전역 타입 변수 초기화
    window.currentPopupType = null;
};

// 倉庫検索ボタンクリック時、ポップアップタイプを設定
$("#btnWarehouse").click(function() {
    window.currentPopupType = 'warehouse';
    open_Warehouse();
});

// 品目小分類検索ボタンクリック時、ポップアップタイプを設定
$("#btnItemSmallCategory").click(function() {
    window.currentPopupType = 'category_popup_small';
    open_Isc();
});

// サイドバーの表示/非表示切り替え
const toggleButton = document.querySelector('.toggle-sidebar');
const sidebar = document.querySelector('.sidebar');
toggleButton.addEventListener('click', function() {
    sidebar.classList.toggle('hidden');
});
</script>
</body>
</html>