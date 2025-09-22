<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<title>재고변동추이분석</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* ===== 상단 헤더 ===== */
.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #4b5563;
	color: #fff;
	padding: 10px 16px;
	margin: 12px;
	border-radius: 4px;
	box-sizing: border-box;
}

.page-header h2 {
	margin: 0;
	font-size: 21px;
	font-weight: 600;
	line-height: 1;
}

.page-header .btn-search {
	background: transparent;
	color: #fff;
	border: none;
	font-size: 18px;
	padding: 4px 10px;
	height: 26px;
	line-height: 26px;
	cursor: pointer;
}

/* ===== 조회조건 (grid) ===== */
.search-container {
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin: 8px 12px;
	padding: 10px 12px;
	box-sizing: border-box;
	display: grid;
	/* label열 + control열 묶음을 4세트 => 총 8컬럼 */
	grid-template-columns: repeat(4, minmax(90px, 130px) 1fr);
	column-gap: 12px;
	row-gap: 8px;
	align-items: center;
}

/* search header spans full width only in search-container */
.search-container .search-header {
	grid-column: 1/-1;
	font-weight: 600;
	font-size: 15px;
	color: #222;
	margin-bottom: 8px;
	padding: 0 0 8px 0;
	border-bottom: 1px solid #eee;
}

/* flatten search fields (keeps label/control pairs in grid cells) */
.search-container>.field {
	display: contents;
}

/* labels inside search-container (right aligned) */
.search-container label {
	justify-self: end;
	text-align: right;
	font-size: 13px;
	color: #333;
	padding-right: 6px;
	align-self: center;
}

/* search inputs/selects/buttons: full width in their grid cell */
.search-container select, .search-container input, .search-container button
	{
	width: 100%;
	height: 26px;
	padding: 2px 8px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background: #fff;
	box-sizing: border-box;
}

/* ===== 비교대상 기간설정 (flex 한줄) ===== */
.compare-container {
	background-color: #f9f9ff;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin: 8px 12px;
	padding: 10px 12px;
	box-sizing: border-box;
}

/* header for compare-container - not grid-based */
.compare-container .search-header {
	display: block;
	font-weight: 600;
	font-size: 15px;
	color: #222;
	margin-bottom: 8px;
	padding: 0 0 8px 0;
	border-bottom: 1px solid #eee;
}

/* 실제 항목을 한 줄로 놓을 wrapper */
.compare-row {
	display: flex;
	align-items: center;
	gap: 16px;
	flex-wrap: nowrap; /* 데스크탑에서는 한 줄 */
}

/* 라벨은 inline 형태 (오른쪽 정렬이 아닌 일반 텍스트로) */
.compare-row label {
	margin: 0;
	font-size: 13px;
	color: #333;
	min-width: 70px; /* 라벨 너비 고정하면 컬럼 정렬감이 생김 */
}

/* compare inputs/selects: 자동 너비 (컨테이너에 따라 늘어나지 않도록) */
.compare-row input, .compare-row select {
	width: auto;
	min-width: 60px;
	height: 26px;
	padding: 2px 8px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 3px;
	box-sizing: border-box;
}

/* input + 단위 조합 */
.field-inline {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.field-inline input {
	width: 60px;
	text-align: right;
	box-sizing: border-box;
}

.field-inline span {
	font-size: 13px;
	color: #333;
	line-height: 26px;
}

/* 컨트롤 공통 버튼 (search 컨테이너에서 사용) */
.search-container button {
	line-height: 20px;
	cursor: pointer;
	background: #f9f9f9;
}

.search-container button:hover {
	background: #f0f0f0;
}

/* ===== 결과 컨테이너 ===== */
.result-container {
	margin: 8px 12px;
	padding: 10px 12px;
	box-sizing: border-box;
	background: #fff;
	border-radius: 4px;
	border: 1px solid #ddd;
}

/* 결과 테이블 */
.result-container table {
	width: 100%;
	border-collapse: collapse;
	font-size: 13px;
	background: #fff;
}

.result-container th, .result-container td {
	border: 1px solid #ddd;
	padding: 6px 8px;
	text-align: center;
	vertical-align: middle;
}

.result-container th {
	background: #f0f2f5;
	font-weight: 600;
	color: #333;
}

/* 라벨 강조용 */
.label {
	color: red;
	margin-left: 10px;
	margin-right: 5px;
}

/* ===== 검색 그룹 (input + button) ===== */
.input-group {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 220px;
	border: 1px solid #ccc;
	border-radius: 4px;
	overflow: hidden;
	background: #fff;
	height: 26px;
}

.input-group input {
	flex: 1;
	border: none;
	padding: 0 8px;
	font-size: 13px;
	outline: none;
	height: 100%;
	background: transparent;
}

.input-group button {
	width: 34px;
	height: 100%;
	border: none;
	background: #f5f6f7;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #666;
	font-size: 14px;
	border-left: 1px solid #ccc;
}

.input-group button:hover {
	background: #e3e5e7;
}

/* ===== 반응형 ===== */
@media ( max-width : 900px) {
	.search-container {
		grid-template-columns: repeat(2, minmax(80px, 120px) 1fr);
	}
	.compare-row {
		flex-wrap: wrap; /* 좁아지면 줄바꿈 */
		gap: 10px;
	}
}

@media ( max-width : 520px) {
	.search-container {
		grid-template-columns: minmax(80px, 120px) 1fr;
		row-gap: 8px;
	}
	.search-container label {
		font-size: 12px;
	}
	.page-header h2 {
		font-size: 14px;
	}
	.compare-row {
		gap: 8px;
	}
	.compare-row label {
		min-width: 60px;
	}
}
</style>
</head>
<body>
	<!-- 페이지 상단 -->
	<div class="page-header">
		<h2>재고변동추이분석</h2>
		<button class="btn-search" id="btnSearch">조회</button>
	</div>

	<!-- 1) 조회조건 컨테이너 -->
	<div class="search-container">
		<div class="field">
			<div class="search-header">조회조건</div>
		</div>

		<!-- hidden fields for popups -->
		<input type="hidden" id="warehouseId" /> <input type="hidden"
			id="itemSmallCategory" />

		<div class="field">
			<label>사업단위</label> <select id="buId">
				<option value="">-- 선택 --</option>
				<option value="1">본사</option>
			</select>
		</div>

		<div class="field">
			<label>창고</label>
			<div class="input-group">
				<input type="text" id="warehouseName" placeholder="창고 선택" readonly />
				<input type="hidden" id="warehouseId" />			
				<button type="button" id="btnWarehouse">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>

		<div class="field">
			<label>재고기준</label> <select id="stockStandard">
				<option value="REAL">실재고</option>
				<option value="ASSET">자산재고</option>
			</select>
		</div>

		<div class="field">
			<label>중요도</label> <select id="importanceLevel">
				<option value="">-- 선택 --</option>
				<option value="A">A등급</option>
				<option value="B">B등급</option>
				<option value="C">C등급</option>
			</select>
		</div>

		<div class="field">
			<label>품목자산분류</label> <select id="itemAssetClass">
				<option value="">-- 선택 --</option>
				<option value="제품">제품</option>
				<option value="반제품">반제품</option>
				<option value="상품">상품</option>
				<option value="원자재">원자재</option>
				<option value="부자재">부자재</option>
				<option value="재공품">재공품</option>
				<option value="저장품">저장품</option>
			</select>
		</div>

		<div class="field">
			<label>품목소분류</label>
			<div class="input-group">
				<input type="text" id="itemSmallCategoryName" placeholder="소분류 선택"
					readonly />
				<input type="hidden" id="itemSmallCategory"/>
				<button type="button" id="btnItemSmallCategory">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>

		<div class="field">
			<label>품명</label> <input type="text" id="itemName" />
		</div>

		<div class="field">
			<label>품번</label> <input type="number" id="itemId" />
		</div>

		<div class="field">
			<label>규격</label> <input type="text" id="spec" />
		</div>
	</div>

	<!-- 2) 비교대상 기간설정 컨테이너 (한 줄 레이아웃) -->
	<div class="compare-container">
		<div class="search-header">비교대상 기간설정</div>

		<div class="compare-row">
			<label>현재월</label>
<input type="month" id="currentMonth"
       value="<%= new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date()) %>"
       readonly>


			<label>기간간격</label>
			<div class="field-inline">
				<input type="number" id="periodMonths" value="3" readonly> <span>개월</span>
			</div>

			<div class="field-inline">
				<input type="number" id="periodCount" value="4" min="1"> <span>회
					비교</span>
			</div>

			<label>분석항목</label> <select id="analysisItem">
				<option>평균재고량</option>
				<option>재고회전율(%)</option>
				<option>총입고량</option>
				<option>총출고량</option>
			</select>
		</div>
	</div>

	<!-- 3) 결과 컨테이너 -->
	<div class="result-container">
		<table>
			<thead>
				<tr id="resultHeadRow">
					<th>품목자산분류</th>
					<th>품목대분류</th>
					<th>품목소분류</th>
					<th>품번</th>
					<th>품명</th>
					<th>규격</th>
					<th>품목중분류</th>
					<th>단위</th>
					<!--  yyyy-MM(1회) yyyy-MM(2회) yyyy-MM(3회) yyyy-MM(4회)의 값을 빈 공간에 집어넣을것 -->
				</tr>
			</thead>
			<tbody id="resultBody">
				<!-- Ajax로 데이터 채움 -->
			</tbody>
		</table>
	</div>

<script>
/* contextPath 안전하게 가져오기 */
var ctx = '${pageContext.request.contextPath}';

$(document).ready(function () {
  const analysisMap = {
    '평균재고량': 'averageStock',
    '재고회전율(%)': 'turnoverRate',
    '총입고량': 'totalIn',
    '총출고량': 'totalOut'
  };

  // ==============================
  // 조회 버튼 클릭 시 AJAX
  // ==============================
  $("#btnSearch").click(function () {
    let sel = $("#analysisItem").val();
    let analysisItem = analysisMap[sel] || sel;

    let requestData = {
      buId: $("#buId").val(),
      itemName: $("#itemName").val(),
      spec: $("#spec").val(),
      itemAssetClass: $("#itemAssetClass").val(),
      importanceLevel: $("#importanceLevel").val(),
      stockStandard: $("#stockStandard").val(),
      itemId: $("#itemId").val(),
      currentMonth: $("#currentMonth").val(),
      analysisItem: analysisItem,
      warehouseId: $("#warehouseId").val()  
      itemSmallCategory: $("itemSmallCategory").val()
    };

    $.ajax({
      url: ctx + '/stock-analysis/analysis',
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(requestData),
      success: function (data) {
        let tbody = $("#resultBody");
        tbody.empty();

        // data는 List<Map<String,Object>>
        let periods = [];
        if (data.length > 0) {
          let sample = data[0];
          $.each(sample, function (key, value) {
            if (/^\d{4}-\d{2}$/.test(key)) periods.push(key);
          });
          periods.sort(); // 오름차순
        }

        // 헤더 갱신
        let theadRow = $("#resultHeadRow");
        theadRow.find("th.dynamic").remove();
        $.each(periods, function (i, p) {
          theadRow.append("<th class='dynamic'>" + p + "</th>");
        });

        if (!data || data.length === 0) {
          tbody.append("<tr><td colspan='" + (8 + periods.length) + "'>조회 결과가 없습니다.</td></tr>");
          return;
        }

        // 로우 구성
        $.each(data, function (idx, item) {
          let row = "<tr>"
            + "<td>" + (item.itemAssetClass || "") + "</td>"
            + "<td>" + (item.itemBigCategory || "") + "</td>"
            + "<td>" + (item.itemSmallCategory || "") + "</td>"
            + "<td>" + (item.itemId || "") + "</td>"
            + "<td>" + (item.itemName || "") + "</td>"
            + "<td>" + (item.spec || "") + "</td>"
            + "<td>" + (item.itemMidCategory || "") + "</td>"
            + "<td>" + (item.baseUnit || "") + "</td>";

          $.each(periods, function (i, p) {
            let cell = item[p];
            if (cell === null || typeof cell === 'undefined') cell = '';
            row += "<td>" + cell + "</td>";
          });

          row += "</tr>";
          tbody.append(row);
        });
      },
      error: function (xhr, status, error) {
        console.error("AJAX ERROR:", status, error);
        console.error("Response Text:", xhr.responseText);
        alert("데이터 조회 중 오류가 발생했습니다. 필수값(사업단위)을 입력하세요.");
      }
    });
  });

  // ==============================
  // 창고 선택 팝업 열기
  // ==============================
  $("#btnWarehouse").click(function () {
    window.open(
      ctx + '/popup/warehouse_popup',
      "warehouse_popup",
      "width=600,height=400,scrollbars=yes,resizable=no"
    );
  });

  // ==============================
  // 팝업에서 선택된 창고 데이터 받기
  // ==============================
  window.setWarehouseData = function (data) {
    // data = [창고ID, 창고명, 사업단위, 창고구분, 사업단위코드, 창고구분코드]
    console.log("팝업에서 받은 값:", data);
    // 화면 표시
    $("#warehouseName").val(data[1]);
    // hidden 값 (검색용)
    $("#warehouseId").val(data[0]);
  };

  // ==============================
  // 소분류 선택 팝업 열기
  // ==============================
  $("#btnItemSmallCategory").click(function () {
    window.open(
      ctx + '/popup/item_popup',
      "contact_popup",
      "width=700,height=500,scrollbars=yes,resizable=no"
    );
  });
  
 window.setItemSmallCategoryData = function (data) {
	 console.log("소분류 팝업에서 받은 값: ", data);
	 $("itemsmallcategoryName").val(data[1]);
	 @("#itemsmallcategory").val(data[0]);
 };
  

  // ==============================
  // 엔터 키 → 조회 실행
  // ==============================
  $(document).on("keydown", function (e) {
    if (e.key === "Enter") {
      e.preventDefault();
      $("#btnSearch").trigger("click");
    }
  });
});


</script>



</html>