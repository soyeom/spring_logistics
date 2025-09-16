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
/* ===== 상단 헤더 (변경 없음) ===== */
.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #4b5563;
	color: #fff;
	padding: 10px 16px;
	margin: 12px; /* ✅ search-container랑 동일 margin */
	border-radius: 4px; /* ✅ search-container처럼 모서리 둥글게 */
	box-sizing: border-box;
}

.page-header h2 {
	margin: 0;
	font-size: 21px;
	font-weight: 600;
	line-height: 1; /* 👈 줄 높이 딱 맞추기 */
}

/* 헤더의 조회 버튼은 작게 유지 */
.page-header .btn-search {
	background: transparent;
	color: #fff;
	border: none;
	font-size: 18px;
	padding: 4px 10px; /* 위아래 여백 줄임 */
	height: 26px; /* 👈 h2 기준 맞춤 */
	line-height: 26px; /* 글자 수직 가운데 */
	cursor: pointer;
}

/* ===== 조회조건 컨테이너 그리드화 ===== */
.search-container {
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin: 12px;
	padding: 14px 16px;
	box-sizing: border-box;
	/* 핵심: label열 + control열 을 한쌍으로 4개 만들기 => 총 8컬럼 */
	display: grid;
	grid-template-columns: repeat(4, minmax(90px, 130px) 1fr);
	column-gap: 16px;
	row-gap: 10px;
	align-items: center;
}

/* search-header(타이틀)는 전체 가로를 차지하도록 */
.search-container .search-header {
	grid-column: 1/-1;
	font-weight: 600;
	font-size: 15px;
	color: #222;
	margin-bottom: 8px;
	padding: 0; /* 좌우 여백 제거 */
	border-bottom: 1px solid #eee;
}

.search-container button {
	line-height: 20px; /* height: 26px에 맞춤 */
	cursor: pointer;
	background: #f9f9f9;
}

.search-container button:hover {
	background: #f0f0f0;
}

/* 사용자가 넣어둔 그룹용 div를 평평하게 만들어 자식들이 그리드에 직접 참여하게 함 */
.search-container>div {
	display: contents;
}

/* 라벨은 오른쪽 정렬(셀 내 오른쪽 끝에 위치) */
.search-container label {
	justify-self: end; /* label 컬럼의 오른쪽 끝으로 */
	text-align: right;
	font-size: 13px;
	color: #333;
	padding-right: 6px;
	align-self: center;
}

/* 입력/셀렉트/버튼은 control 컬럼을 채우도록 */
.search-container select, .search-container input[type="text"],
	.search-container input[type="hidden"], .search-container button {
	width: 100%;
	box-sizing: border-box;
	height: 26px;
	padding: 2px 8px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background: #fff;
}

/* 컨테이너 내부의 버튼은 작고 단정하게 (단, 헤더 btn-search 제외) */
.search-container {
	display: grid;
	grid-template-columns: repeat(4, minmax(90px, 130px) 1fr);
	gap: 12px 16px;
}

.search-container .field {
	display: contents; /* 라벨과 컨트롤이 그리드에 직접 배치되도록 */
}

.search-container label {
	justify-self: end;
	align-self: center;
	font-size: 13px;
	color: #333;
}

.search-container select, .search-container input, .search-container button
	{
	width: 100%;
	height: 26px;
	padding: 2px 8px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background: #fff;
}
/* 규격 같은 단독 항목이 왼쪽부터 시작하게 하려면,
   마지막 label/input 쌍이 자동으로 다음 가용 셀에 배치됩니다. 필요시 강제 위치 지정 가능. */
/* 검색 그룹 (입력창 + 버튼) */
/* 검색 그룹 (입력창 + 버튼) */
.input-group {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 220px; /* 필요시 조정 */
	border: 1px solid #ccc;
	border-radius: 4px;
	overflow: hidden; /* 일체형 모서리 */
	background: #fff;
	height: 26px;
}

/* 입력창 */
.input-group input {
	flex: 1;
	border: none;
	padding: 0 8px;
	font-size: 13px;
	outline: none;
	height: 100%;
	background: transparent;
}

/* 돋보기 버튼 */
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
	border-left: 1px solid #ccc; /* 입력창과 구분선 */
}

.input-group button:hover {
	background: #e3e5e7;
}

/* ===== 결과 테이블 스타일 ===== */
table {
	width: calc(100% - 24px); /* 좌우 margin(12px)과 맞추기 */
	margin: 12px auto;
	border-collapse: collapse;
	font-size: 13px;
	background: #fff;
	box-sizing: border-box;
}

th, td {
	border: 1px solid #ddd;
	padding: 6px 8px;
	text-align: center;
	vertical-align: middle;
}

th {
	background: #f0f2f5;
	font-weight: 600;
	color: #333;
}

@media ( max-width : 900px) {
	.search-container {
		grid-template-columns: repeat(2, minmax(80px, 120px) 1fr);
	}
}

@media ( max-width : 520px) {
	.search-container {
		grid-template-columns: minmax(80px, 120px) 1fr; /* 1열 (label+control) */
		row-gap: 8px;
	}
	.search-container label {
		justify-self: end;
		font-size: 12px;
	}
	.page-header h2 {
		font-size: 14px;
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

	<!-- ✅ 조회조건 컨테이너 -->

	<div class="search-container">
		<div class="field">
			<div class="search-header">조회조건</div>
		</div>

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
				<button type="button" id="btnItemSmallCategory">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>

		<div class="field">
			<label>품명</label> <input type="text" id="itemName" />
		</div>
		<div class="field">
			<label>품번</label> <input type="text" id="itemCode" />
		</div>
		<div class="field">
			<label>규격</label> <input type="text" id="spec" />
		</div>

	</div>
	<!--컨테이너  -->
	<!-- ✅ 결과 테이블 -->
	<table>
		<thead>
			<tr>
				<th>품목자산분류</th>
				<th>품목대분류</th>
				<th>품목중분류</th>
				<th>품목소분류</th>
				<th>품번</th>
				<th>품명</th>
				<th>규격</th>
				<th>기초재고</th>
				<th>입고수량</th>
				<th>출고수량</th>
				<th>기말재고</th>
			</tr>
		</thead>
		<tbody id="resultBody">
			<!-- Ajax로 데이터 채움 -->
		</tbody>
	</table>
</body>



<script>
$(document).ready(function() {
	  $("#btnSearch").click(function() {
	    let requestData = {
	      buId: $("#buId").val(),
	      itemName: $("#itemName").val(),
	      spec: $("#spec").val(),
	      itemAssetClass: $("#itemAssetClass").val(),
	      importanceLevel: $("#importanceLevel").val(),
	      stockStandard: $("#stockStandard").val(),
	      itemId: $("#itemId").val()
	    };
	    $.ajax({
	      url: "${pageContext.request.contextPath}/stock-analysis/analysis",
	      type: "POST",
	      contentType: "application/json",
	      data: JSON.stringify(requestData),
	      success: function(data) {
	        let tbody = $("#resultBody");
	        tbody.empty();
	        if (data.length === 0) {
	          tbody.append("<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>");
	          return;
	        }
	        $.each(data, function(index, item) {
	          let row = "<tr>"
	            + "<td>" + (item.itemAssetClass || '') + "</td>"
	            + "<td>" + (item.itemBigCategory || '') + "</td>"
	            + "<td>" + (item.itemMidCategory || '') + "</td>"
	            + "<td>" + (item.itemSmallCategory || '') + "</td>"
	            + "<td>" + (item.itemId || '') + "</td>"
	            + "<td>" + (item.itemName || '') + "</td>"
	            + "<td>" + (item.spec || '') + "</td>"
	            + "<td>" + (item.beginningStock || 0) + "</td>"
	            + "<td>" + (item.inboundQty || 0) + "</td>"
	            + "<td>" + (item.outQty || 0) + "</td>"
	            + "<td>" + (item.endingStock || 0) + "</td>"
	            + "</tr>";
	          tbody.append(row);
	        });
	      },
	      error: function(xhr, status, error) {
	        alert("데이터 조회 중 오류 발생: " + error);
	      }
	    });
	  });
	});

	// 📌 창고 선택 팝업 열기
	$("#btnWarehouse").click(function() {
	  window.open(
	    "${pageContext.request.contextPath}/stock-analysis/warehouse-popup",
	    "warehousePopup",
	    "width=600,height=400,scrollbars=yes,resizable=no"
	  );
	});

	$(document).on("click", "#warehouseTable tr", function() {
	  let id = $(this).data("id");
	  let name = $(this).data("name");
	  window.opener.document.getElementById("warehouseId").value = id;
	  window.opener.document.getElementById("btnWarehouse").innerText = name;
	  window.close();
	});

	// 📌 소분류 선택 팝업 열기
	$("#btnItemSmallCategory").click(function() {
	  window.open(
	    "${pageContext.request.contextPath}/stock-analysis/item-small-category-popup",
	    "itemSmallCategoryPopup",
	    "width=700,height=500,scrollbars=yes,resizable=no"
	  );
	});

	// 📌 소분류 선택 이벤트
	$(document).on("click", "#smallCategoryTable tr", function() {
	  let id = $(this).data("id");
	  let name = $(this).data("name");
	  window.opener.document.getElementById("itemSmallCategory").value = id;
	  window.opener.document.getElementById("btnItemSmallCategory").innerText = name;
	  window.close();
	});

</script>
</body>
</html>
