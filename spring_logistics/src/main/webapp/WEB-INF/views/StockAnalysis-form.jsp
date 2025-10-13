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
/* ポップアップボタンを含む入力グループ */
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

/* 期間間隔および比較回数入力グループ */
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

/* 🚩 화면 맞춤 조정 CSS 추가/수정 */
.layout {
    display: flex;
    min-height: 100vh;
}
.main {
    flex-grow: 1; /* 남은 공간을 채움 */
    padding: 20px;
    display: flex;
    flex-direction: column; /* 세로 방향으로 요소 배치 */
    overflow-y: auto;
}

/* DataTables スタイル */
.table-container {
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    /* 💡 DataTables 컨테이너가 남은 공간을 차지하도록 설정 */
    flex-grow: 1; 
    overflow-y: hidden; /* DataTables 자체 스크롤 사용을 위해 컨테이너 스크롤 숨김 */
    min-height: 300px; /* 최소 높이 지정 */
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
#analysisTable tbody tr:nth-child(even) {
    background-color: #fafafa;
}
#analysisTable tbody tr:hover {
    background-color: #e6f7ff;
}
/* DataTables ヘッダー・ボディ不一致解決 */
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

window.handleWarehouseData = function(data) {
    // [0]: 倉庫名, [3]: 倉庫ID (Long Type)
    $("#warehouseName").val(data[0]);
    $("#warehouseId").val(data[3]);	
    console.log("창고 선택 (고유 콜백):", data);
};

// =========================================================================
// 🚩 [유지/정의] 품목 소분류에서 재정의해서 쓰는 전역 콜백 함수
// (창고 팝업은 이제 이 함수를 건드리지 않음)
// =========================================================================
window.item_RowData = function(data) {
    // 이 함수는 품목 소분류 버튼 클릭 시 해당 로직으로 재정의되어 사용됩니다.
    console.log("기본/소분류(재정의됨) 선택:", data);
};


// 事業部門(BU)リストをロード
function loadBusinessUnits() {
    // ... (기존과 동일)
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
            console.log("事業部門データがロードされました:", data);
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

// 倉庫ポップアップを開く (창고 전용 콜백 함수 이름 전달하도록 수정)
function open_Warehouse() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    // 💡 변경: 창고 전용 콜백 함수 이름(handleWarehouseData)을 쿼리 파라미터로 전달
    window.open(ctx + '/popup/warehouse_popup?callback=handleWarehouseData', "warehouse_popup",
        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}

// 品目小分類ポップアップを開く (기존과 동일하게 유지)
function open_Isc() {
    var left = (screen.width - POPUP_WIDTH) / 2;
    var top = (screen.height - POPUP_HEIGHT) / 2;
    window.open(ctx + '/popup/category_popup_small', 
        "itemSmallcategory_popup", "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
}


// ページロード後に実行
$(document).ready(function() {
    // 사이드바
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
        // DataTablesインスタンスがあれば削除
        if ($.fn.DataTable.isDataTable('#analysisTable')) {
            $('#analysisTable').DataTable().destroy();
        }
        
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
                
                // DataTables インスタンスがあればディストロイ
                if ($.fn.DataTable.isDataTable('#analysisTable')) {
                    $('#analysisTable').DataTable().destroy();
                }

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
                        let displayValue = '';

                        if (value != null) {
                            let numValue = parseFloat(value);
                            if (!isNaN(numValue)) {
                                displayValue = numValue.toFixed(2);
                            } else {
                                displayValue = value;
                            }
                        }
                        
                        row += "<td style='text-align: right;'>" + displayValue + "</td>";
                    });

                    row += "</tr>";
                    tbody.append(row);
                });
                
                // 5. DataTables 初期化
                let table = $('#analysisTable').DataTable({
                    paging: true,
                    searching: true,
                    ordering: true,
                    info: true,
                    scrollX: true,	
                    // 💡 DataTables가 화면 높이에 맞춰지도록 설정 (400px는 상단 필터 영역의 대략적 높이. 환경에 맞게 조정 필요)
                    scrollY: 'calc(100vh - 400px)', 
                    scrollCollapse: true,
                    autoWidth: false,
                });
                
                setTimeout(function(){
                    table.columns.adjust().draw();
                }, 100);
            },
            error : function() {
                alert("データ検索中にエラーが発生しました。必須値（事業部門など）を確認してください。");
            }
        });
    });

    // =========================================================================
    // 🚩 [수정] Warehouse 버튼 이벤트: item_RowData 재정의 로직을 제거하고 open_Warehouse만 호출
    // =========================================================================
    $("#btnWarehouse").click(function() {
        // 충돌 방지: open_Warehouse에서 'handleWarehouseData' 콜백을 전달하도록 했습니다.
        open_Warehouse();
    });

    // =========================================================================
    // 🚩 [유지] ItemSmallCategory 버튼 이벤트: 기존대로 item_RowData를 소분류용으로 재정의
    // =========================================================================
    $("#btnItemSmallCategory").click(function() {
        window.item_RowData = function(data) {
            // 소분류 팝업 데이터 순서: [0]=품번(ID), [3]=소분류(Name)
            $("#itemSmallCategory").val(data[0]); 
            $("#itemSmallCategoryName").val(data[3]); 
            console.log("소분류 선택 (재정의 콜백):", data);
        };
        open_Isc();
    });

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
});
</script>
</body>
</html>