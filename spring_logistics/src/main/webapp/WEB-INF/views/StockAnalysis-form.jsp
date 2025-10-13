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
	// =========================================================================
	window.item_RowData = function(data) {
	    // 이 함수는 품목 소분류 버튼 클릭 시 해당 로직으로 재정의되어 사용됩니다.
	    console.log("기본/소분류(재정의됨) 선택:", data);
	};


	// 事業部門(BU)リストをロード (AJAX 객체를 반환하도록 수정)
	function loadBusinessUnits() {
	    // 🚨 수정: $.ajax 객체(jqXHR)를 반환하여 done() 체이닝을 가능하게 합니다.
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
	            console.log("事業部門データがロードされました:", data);
	        },
	        error: function(xhr, status, error) {
	            console.error("事業部門のロード中にエラーが発生しました:", error);
	            const buSelect = $("#buId");
	            // 에러 발생 시 더미 데이터 추가 (혹시 모를 오류 방지)
	            if (buSelect.children().length === 0) {
	                buSelect.append('<option value="">全体</option>');
	                buSelect.append('<option value="1">本社</option>');
	            }
	        }
	    });
	}

	// 倉庫ポップアップを開く
	function open_Warehouse() {
	    var left = (screen.width - POPUP_WIDTH) / 2;
	    var top = (screen.height - POPUP_HEIGHT) / 2;
	    window.open(ctx + '/popup/warehouse_popup?callback=handleWarehouseData', "warehouse_popup",
	        "width=" + POPUP_WIDTH + ",height=" + POPUP_HEIGHT + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes");
	}

	// 品目小分類ポップアップを開く
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
	    
	    // 🚩 [추가] 사업부문 로드 후 자동 검색 실행 (페이지 로드 시 전체 목록 조회)
	    loadBusinessUnits().done(function() {
	        // 사업부문 드롭다운이 채워진 후, 검색 버튼 자동 클릭
	        $("#btnSearch").trigger("click");
	    });
	    
        // 🚩 [수정] analysisItem 텍스트와 서버 키를 매핑하는 Map 정의
	    const analysisMap = {
	        '平均在庫量' : 'averageStock',
	        '在庫回転率(%)' : 'turnoverRatio',
	        '総入庫量' : 'totalIn',
	        '総出庫量' : 'totalOut'
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
	        // 초기화 시 정적 헤더로 되돌림
	        $("#resultHeadRow").empty().append(`
	            <th>品目資産分類</th>
	            <th>品目大分類</th>
	            <th>品目小分類</th>
	            <th>品番</th>
	            <th>品名</th>
	            <th>規格</th>
	            <th>品目中分類</th>
	            <th>単位</th>
	        `);
	    };

	    // 検索ボタンクリックイベント
	    $("#btnSearch").click(function() {
            // 💡 ID 필드의 값을 숫자로 변환합니다. (null/빈 문자열이면 null로 유지)
	    	let buIdValue = $("#buId").val();
	    	let warehouseIdValue = $("#warehouseId").val();
	    	let itemIdValue = $("#itemId").val();
            
            let parsedBuId = buIdValue ? parseInt(buIdValue) : null;
            let parsedWarehouseId = warehouseIdValue ? parseInt(warehouseIdValue) : null;
            let parsedItemId = itemIdValue ? parseInt(itemIdValue) : null;

            // 🚩 [수정] analysisItem 셀렉트 박스에서 선택된 텍스트를 가져와 Map으로 서버 키를 찾습니다.
            let selectedAnalysisText = $("#analysisItem option:selected").text();
            let analysisItemServerKey = analysisMap[selectedAnalysisText];
	    	    
	    	    let requestData = {
	    	        // 💡 Long/Integer 타입이 String으로 바인딩되어 400 에러를 유발하는 것을 방지합니다.
	    	        buId : parsedBuId,             // 사업부문 ID (숫자 또는 null)
	    	        warehouseId : parsedWarehouseId, // 창고 ID (숫자 또는 null)
	    	        itemId : parsedItemId,         // 품목 ID (숫자 또는 null)
	    	        
	    	        // String 타입 필드는 그대로 전송
	    	        itemName : $("#itemName").val(),
	    	        spec : $("#spec").val(),
	    	        itemAssetClass : $("#itemAssetClass").val(),
	    	        importanceLevel : $("#importanceLevel").val(),
	    	        stockStandard : $("#stockStandard").val(),
	                currentMonth : $("#currentMonth").val(),
	    	        itemSmallCategory : $("#itemSmallCategory").val() || null, // 소분류도 추가
	    	        
                // 🚩 [핵심 수정] analysisItem을 객체 대신 단일 문자열 키로 전송합니다.
	    	        analysisItem : analysisItemServerKey,
                
                // 💡 DTO의 잠재적 필드 누락 문제를 방지하기 위해 기간 설정 필드를 추가합니다.
                periodMonths: parseInt($("#periodMonths").val()),
                periodCount: parseInt($("#periodCount").val())
	    	    };

	        $.ajax({
	            url : ctx + '/stock-analysis/analysis',
	            type : "POST",
	            contentType : "application/json",
	            data : JSON.stringify(requestData),
	            success : function(data) {
	                let tbody = $("#resultBody");
	                let periods = [];
	                
	                // DataTables 인스턴스가 존재하면 파괴하고 tbody를 비웁니다.
	                if ($.fn.DataTable.isDataTable('#analysisTable')) {
	                    $('#analysisTable').DataTable().destroy();
	                }
	                tbody.empty(); // 🚩 [강화] tbody를 명시적으로 비웁니다.

	                // 1. 動的期間キー (YYYY-MM) 抽出
	                if (data.length > 0) {
	                    $.each(data[0], function(key) {
	                        if (/^\d{4}-\d{2}$/.test(key)) periods.push(key);
	                    });
	                    periods.sort().reverse();
	                }
	                
	                // 2. 🚩 [강화] 動的期間ヘッダー再生성: 기존 내용을 완전히 비우고 다시 그립니다.
	                let theadRow = $("#resultHeadRow").empty(); 

	                // 정적 컬럼 8개 재추가
	                theadRow.append('<th>品目資産分類</th>');
	                theadRow.append('<th>品目大分類</th>');
	                theadRow.append('<th>品目小分類</th>');
	                theadRow.append('<th>品番</th>');
	                theadRow.append('<th>品名</th>');
	                theadRow.append('<th>規格</th>');
	                theadRow.append('<th>品目中分類</th>');
	                theadRow.append('<th>単位</th>');

	                // 동적 기간 컬럼 추가
	                $.each(periods, function(i, p) {
	                    theadRow.append("<th class='dynamic'>" + p + "</th>");
	                });
	                 
	             // 3. DataTables 초기화 준비
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

	// 동적 기간 컬럼 정의 추가
	$.each(periods, function(i, p) {
	    columnsDef.push({
	        data: p, // JSON 키 (예: "2025-01")
	        title: p, // 헤더 텍스트 (예: "2025-01")
	        className: 'text-right' // 우측 정렬
	    });
	});

	// DataTables 인스턴스 초기화
	let table = $('#analysisTable').DataTable({
	    data: data, // 💡 DataTables에 데이터(JSON) 자체를 전달!
	    columns: columnsDef, // 💡 컬럼 정의 적용
	    
	    // 🚩 [추가] 렌더링을 지연하여 DOM이 안정화된 후 DataTables가 데이터를 읽도록 합니다.
	    deferRender: true,
	    
	    // 기존 옵션 유지
	    paging: true,
	    searching: true,
	    ordering: true,
	    info: true,
	    scrollX: true,
	    scrollY: 'calc(100vh - 400px)',
	    scrollCollapse: true,
	    autoWidth: false,
	    
	    // HTML 렌더링 방식 변경
	    destroy: true, // 이전 인스턴스 파괴
	    dom: 'lfrtip', // DataTables 기본 DOM (필요에 따라 조정)
	    // 데이터가 없을 때 DataTables가 표시할 메시지 설정
	    language: {
            emptyTable: "検索結果がありません。",
            zeroRecords: "検索結果がありません。"
        }
	});

	// 렌더링 지연(deferRender)을 사용하므로, 컬럼 조정은 즉시 실행합니다.
	table.columns.adjust().draw();

	            }, // success: function(data) 콜백 함수 종료
	            error : function(xhr) {
	                let errorMessage = "データ取得中にエラーが発生しました。";
	                if (xhr.status === 400) {
	                    errorMessage = "リクエストデータが無効です (400 Bad Request)。";
	                } else if (xhr.status === 500) {
	                    errorMessage = "サーバー内部エラーが発生しました (500 Internal Server Error)。";
	                }
	                alert(errorMessage);
	            }
	        });
	    }); // <-- $("#btnSearch").click 함수 종료

	// ... (나머지 코드 동일)
	    // =========================================================================
	    // 팝업 관련 버튼 이벤트
	    // =========================================================================
	    $("#btnWarehouse").click(function() {
	        open_Warehouse();
	    });

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
	}); // <-- $(document).ready 함수 종료

	const toggleButton = document.querySelector('.toggle-sidebar');
	const sidebar = document.querySelector('.sidebar');

	toggleButton.addEventListener('click', function(){
	    sidebar.classList.toggle('hidden');
	});
</script>
</body>
</html>