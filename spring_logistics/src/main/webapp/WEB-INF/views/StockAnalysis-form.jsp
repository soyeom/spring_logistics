<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>在庫変動推移分析</title>
<!-- 在庫変動推移分析 -->

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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js"></script>

<style>
/* --------------------------------------
    ポップアップボタンを含む入力グループ
-------------------------------------- */
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

/* --------------------------------------
    期間間隔および比較回数入力グループ
-------------------------------------- */
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
</style>
</head>
<body>
	<div class="layout">
		<div class="home-bar">
			<span> <a href="/"><img
					src="https://cdn-icons-png.flaticon.com/512/7598/7598650.png"
					alt="ホーム画面" class="home-icon"></a>
			</span>
		</div>
			<!-- サイドバー -->
		<aside class="sidebar">
			<div class="sidebar-header">
				<div class="profile">
					<img src="https://cdn-icons-png.flaticon.com/512/7598/7598657.png"
						alt="プロフィール">
					<p>〇〇様、こんにちは 👋</p>
					<div class="auth-btns">
						<button class="btn btn-secondary">ログイン</button>
						<button class="btn btn-secondary">会員登録</button>
					</div>
				</div>
			</div>

			<nav class="menu">
				<div class="menu-item">
					<div class="title">
						<a href="#">入庫および出庫</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">入庫履歴</a>
						</div>
						<div>
							<a href="#">出庫履歴</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">在庫出荷統制</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">出荷計画</a>
						</div>
						<div>
							<a href="#">出荷履歴</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">在庫管理</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">在庫現況</a>
						</div>
						<div>
							<a href="#">在庫移動</a>
						</div>
						<div>
							<a href="#">在庫照会</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">事業部門別受払集計</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">事業所別集計</a>
						</div>
						<div>
							<a href="#">月別推移</a>
						</div>
					</div>
				</div>
				<div class="menu-item">
					<div class="title">
						<a href="#">在庫変動推移分析</a>
					</div>
					<div class="submenu">
						<div>
							<a href="#">グラフ表示</a>
						</div>
					</div>
				</div>
			</nav>
		</aside>

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

			<!-- 検索条件 -->
			<div class="filters search-filters">
				<div class="filters-main">
					<div class="title">検索条件</div>
					<div class="line"></div>
				</div>

				<div class="filters-row">
					<div class="filters-count">
						<div class="filters-text">事業部門</div>
						<div class="filters-value">
							<select id="buId" name="bu_id">
								<!-- オプションはJavaScriptによって動的に追加されます -->
							</select>
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

			<!-- 比較設定 -->
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

			<!-- 結果テーブル -->
			<div class="result-container table-container">
				<table>
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
							<!-- 動的な期間列がここに挿入される -->
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

// ======================== 事業部門(BU)リストをロード ========================
function loadBusinessUnits() {
    $.ajax({
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
            console.log("사업부문 데이터가 로드되었습니다:", data);
        },
        error: function(xhr, status, error) {
            console.error("事業部門のロード中にエラーが発生しました:", error);
            const buSelect = $("#buId");
            if (buSelect.children().length === 0) {
                buSelect.append('<option value="">全体</option>');
                buSelect.append('<option value="1">本社</option>');
            }
        }
    });
}

// ======================== ポップアップを開く (倉庫) ========================
function open_Warehouse() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    window.open(ctx + '/popup/warehouse_popup', "warehouse_popup",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

// ポップアップから選択された倉庫データを受け取る
window.setWarehouseData = function(data) {
    $("#warehouseName").val(data[0]);
    $("#warehouseId").val(data[1]);
    console.log("倉庫選択:", data);
};

// 品目小分類ポップアップを開く
function open_Isc() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    window.open(ctx + '/popup/itemSmallcategory_popup',
        "itemSmallcategory_popup", "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

// ポップアップから選択された小分類データを受け取る
window.setItemSmallCategoryData = function(data) {
    $("#itemSmallCategory").val(data[0]);
    $("#itemSmallCategoryName").val(data[1]);
    console.log("小分類選択:", data);
};

// ======================== ページロード後に実行 ========================
$(document).ready(function() {
    // 💡 [사이드바 토글 기능]
    // .toggle-sidebar 버튼 클릭 시, 최상위 .layout 요소에 'sidebar-collapsed' 클래스를 토글합니다.
    $('.toggle-sidebar').on('click', function() {
        $('.layout').toggleClass('sidebar-collapsed');
    });
    
    loadBusinessUnits();
    
    const analysisMap = {
        '平均在庫量' : 'averageStock',
        '在庫回転率(%)' : 'turnoverRatio',
        '総入庫量' : 'totalInbound',
        '総出庫量' : 'totalOutbound'
    };

    // 初期化関数
    window.resetSearch = function() {
        $("#buId").val($("#buId option:first").val());
        $("#stockStandard").val('REAL');
        $("#importanceLevel").val($("#importanceLevel option:first").val());
        $("#itemAssetClass").val($("#itemAssetClass option:first").val());
        $("#analysisItem").val($("#analysisItem option:first").val());
        $("#itemName, #itemId, #spec, #warehouseName, #warehouseId, #itemSmallCategoryName, #itemSmallCategory").val('');
        $("#resultBody").empty();
        $("#resultHeadRow").find("th.dynamic").remove();
    };

    // 検索ボタンクリックイベント
    $("#btnSearch").click(function() {
        let sel = $("#analysisItem").val();
        let analysisItem = analysisMap[sel] || sel;

        let requestData = {
            buId : $("#buId").val(),
            itemName : $("#itemName").val(),
            spec : $("#spec").val(),
            itemAssetClass : $("#itemAssetClass").val(),
            importanceLevel : $("#importanceLevel").val(),
            stockStandard : $("#stockStandard").val(),
            itemId : $("#itemId").val() ? $("#itemId").val().toString() : null,
            currentMonth : $("#currentMonth").val(),
            analysisItem : analysisItem,
            warehouseId : $("#warehouseId").val(),
            itemSmallCategory : $("#itemSmallCategory").val()
        };

        $.ajax({
            url : ctx + '/stock-analysis/analysis',
            type : "POST",
            contentType : "application/json",
            data : JSON.stringify(requestData),
            success : function(data) {
                let tbody = $("#resultBody").empty();
                let periods = [];

                // 1. 動的期間キー (YYYY-MM) 抽出
                if (data.length > 0) {
                    $.each(data[0], function(key) {
                        if (/^\d{4}-\d{2}$/.test(key)) periods.push(key);
                    });
                    periods.sort().reverse();
                }

                // 2. 動的期間ヘッダー再生性
                let theadRow = $("#resultHeadRow").find("th.dynamic").remove().end();
                $.each(periods, function(i, p) {
                    theadRow.append("<th class='dynamic'>" + p + "</th>");
                });

                // 3. データがない場合
                if (!data || data.length === 0) {
                    let totalCols = 8 + periods.length;
                    tbody.append("<tr><td colspan='" + totalCols + "'>検索結果がありません。</td></tr>");
                    return;
                }

                // 4. 結果データテーブルに描画
                $.each(data, function(idx, item) {
                    let row = "<tr>"
                        + "<td>" + (item.itemAssetClass || "") + "</td>"
                        + "<td>" + (item.itemBigCategory || "") + "</td>"
                        + "<td>" + (item.itemSmallCategory || "") + "</td>"
                        + "<td>" + (item.itemId || "") + "</td>"
                        + "<td>" + (item.itemName || "") + "</td>"
                        + "<td>" + (item.spec || "") + "</td>"
                        + "<td>" + (item.itemMidCategory || "") + "</td>"
                        + "<td>" + (item.baseUnit || "") + "</td>";

                    $.each(periods, function(i, p) {
                        let value = item[p];
                        row += "<td>" + (value != null ? value : '') + "</td>";
                    });

                    row += "</tr>";
                    tbody.append(row);
                });
            },
            error : function() {
                alert("データ検索中にエラーが発生しました。必須値（事業部門など）を確認してください。");
            }
        });
    });

    // ボタンイベント接続
    $("#btnWarehouse").click(open_Warehouse);
    $("#btnItemSmallCategory").click(open_Isc);

    // Enter キーで検索
    $(document).on("keydown", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            $("#btnSearch").trigger("click");
        }
    });
});

	const toggleButton = document.querySelector('.toggle-sidebar');
	const sidebar = document.querySelector('.sidebar');
	
	toggleButton.addEventListener('click', function(){
		sidebar.classList.toggle('hidden');
	})
</script>
</body>
</html>
