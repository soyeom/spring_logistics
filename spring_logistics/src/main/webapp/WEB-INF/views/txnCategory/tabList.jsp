<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입출고구분설정</title>
	<link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class = "layout">
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
	                <p>홍길동님, 안녕하세요 👋</p>
	                <div class="auth-btns">
	                    <button class="btn btn-secondary">로그인</button>
	                    <button class="btn btn-secondary">회원가입</button>
	                </div>
	            </div>
	        </div>
	        <nav class="menu">
	            <div class="menu-item">
	                <div class="title"><a href="#">입고 및 출고</a></div>
	                <div class="submenu">
	                    <div><a href="#">입고 내역</a></div>
	                    <div><a href="#">출고 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 출하통제</a></div>
	                <div class="submenu">
	                    <div><a href="#">출하 계획</a></div>
	                    <div><a href="#">출하 내역</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 관리</a></div>
	                <div class="submenu">
	                    <div><a href="#">재고 현황</a></div>
	                    <div><a href="#">재고 이동</a></div>
	                    <div><a href="#">재고 조회</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">사업단위별 수불집계</a></div>
	                <div class="submenu">
	                    <div><a href="#">사업장별 집계</a></div>
	                    <div><a href="#">월별 추이</a></div>
	                </div>
	            </div>
	            <div class="menu-item">
	                <div class="title"><a href="#">재고 변동 추이 분석</a></div>
	                <div class="submenu">
	                    <div><a href="#">그래프 보기</a></div>
	                </div>
	            </div>
	        </nav>
    	</aside>
	<div class="main">
		<div class="main-header">
			<div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
			<div><h1>입출고구분설정</h1></div>
			<div>
				<button class="btn btn-secondary search-btn" onclick="loadData()">조회</button>
				<button class="btn btn-secondary search-btn" onclick="saveAll()">저장</button>
				<button class="btn btn-secondary search-btn" onclick="deleteSelected()">삭제</button>
			</div>
		</div>

		<!-- ✅ 탭 버튼 -->
		<div class="filters">
			<div class="filters-main">
				<div class="title">탭 선택</div>
				<div class="line"></div>
			</div>
			<div class="filters-row">
				<div class="filters-value">
					<button class="btn btn-secondary tab-btn active" onclick="showTab('outTab', this)">출고</button>
					<button class="btn btn-secondary tab-btn" onclick="showTab('inTab', this)">입고</button>
					<button class="btn btn-secondary tab-btn" onclick="showTab('moveTab', this)">이동</button>
				</div>
			</div>
		</div>

		<!-- 📦 출고 탭 -->
		<div id="outTab" class="tab-content active">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width:50px;">번호</th>
		                    <th style="width:140px;">출고구분</th>
		                    <th style="width:80px;">정렬순서</th>
		                    <th style="width:80px;">사용여부</th>
		                    <th style="width:120px;">계정과목</th>
		                    <th style="width:100px;">비용구분</th>
		                    <th style="width:90px;">제상품</th>
		                    <th style="width:90px;">자재</th>
		                    <th style="width:90px;">영업사용</th>
		                    <th style="width:110px;">재고사실조정(출고)</th>
		                    <th style="width:110px;">재고사실조정(입고)</th>
		                    <th style="width:100px;">부가세대상여부</th>
		                    <th style="width:110px;">부가세처리구분</th>
		                    <th style="width:80px;">AS</th>
		                    <th style="width:130px;">품목별전표처리여부</th>
		                    <th style="width:90px;">항목선택</th>
						</tr>
					</thead>
					<tbody id="tbody-out"></tbody>
				</table>
			</div>
		</div>

		<!-- 📦 입고 탭 -->
		<div id="inTab" class="tab-content" style="display:none;">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width:50px;">번호</th>
		                    <th style="width:140px;">입고구분</th>
		                    <th style="width:80px;">정렬순서</th>
		                    <th style="width:80px;">사용여부</th>
		                    <th style="width:120px;">계정과목</th>
		                    <th style="width:100px;">비용구분</th>
		                    <th style="width:90px;">제상품</th>
		                    <th style="width:90px;">자재</th>
		                    <th style="width:110px;">부상품입고</th>
		                    <th style="width:150px;">품목별반입처리여부</th>
		                    <th style="width:90px;">항목선택</th>
						</tr>
					</thead>
					<tbody id="tbody-in"></tbody>
				</table>
			</div>
		</div>

		<!-- 📦 이동 탭 -->
		<div id="moveTab" class="tab-content" style="display:none;">
			<div class="table-container" style="height: 400px;">
				<table class="table-single-select">
					<thead>
						<tr>
							<th style="width:50px;">번호</th>
		                    <th style="width:140px;">이동구분</th>
		                    <th style="width:80px;">정렬순서</th>
		                    <th style="width:80px;">사용여부</th>
		                    <th style="width:90px;">이동</th>
		                    <th style="width:90px;">적송</th>
		                    <th style="width:90px;">AS출고</th>
		                    <th style="width:90px;">AS반납</th>
		                    <th style="width:100px;">무상사급</th>
		                    <th style="width:100px;">배차대상</th>
		                    <th style="width:90px;">항목선택</th>
						</tr>
					</thead>
					<tbody id="tbody-move"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>

<script type="text/javascript" src="../resources/js/logistics.js"></script>

<script>
/* ✅ 탭 전환 */
function showTab(id, btn){
	$(".tab-content").hide();
	$("#"+id).show();
	$(".tab-btn").removeClass("active");
	$(btn).addClass("active");
}

/* ✅ Ajax 조회 */
function loadData(){
	loadTabData("OUT", "#tbody-out");
	loadTabData("IN", "#tbody-in");
	loadTabData("MOVE", "#tbody-move");
}

/* ✅ 탭별 데이터 로드 */
function loadTabData(type, tbodySelector){
	$.ajax({
		url: '/txnCategory/api/list/' + type,
		type: 'GET',
		dataType: 'json',
		success: function(result){
			const tbody = $(tbodySelector);
			tbody.empty();

			result.forEach((r, i) => {
			    let html = `
			        <tr data-txncode="\${r.txnCode}">
			            <td class="text-center">\${i + 1}</td>
			    `;

				/* ✅ 출고 탭 */
				if (type === "OUT") {
					html += `
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="판촉" \${r.categoryName === "판촉" ? "selected" : ""}>판촉</option>
								<option value="폐기" \${r.categoryName === "폐기" ? "selected" : ""}>폐기</option>
								<option value="반품" \${r.categoryName === "반품" ? "selected" : ""}>반품</option>
							</select>
						</td>

						<td contenteditable="true">\${r.sortOrder || ''}</td>
						<td class="text-center"><input type="checkbox" \${r.useYn && r.useYn.toUpperCase() === 'Y' ? "checked" : ""}></td>

						<!-- ✅ 계정과목 -->
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="외화현금" \${r.accountSubject === "외화현금" ? "selected" : ""}>외화현금</option>
								<option value="보통예금" \${r.accountSubject === "보통예금" ? "selected" : ""}>보통예금</option>
								<option value="외화보통예금" \${r.accountSubject === "외화보통예금" ? "selected" : ""}>외화보통예금</option>
								<option value="당좌예금" \${r.accountSubject === "당좌예금" ? "selected" : ""}>당좌예금</option>
							</select>
						</td>

						<!-- ✅ 비용구분 -->
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="제조" \${r.costType === "제조" ? "selected" : ""}>제조</option>
								<option value="판관" \${r.costType === "판관" ? "selected" : ""}>판관</option>
							</select>
						</td>

						<td class="text-center"><input type="checkbox" \${r.isFinishedProduct && r.isFinishedProduct.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isMaterial && r.isMaterial.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isSalesUse && r.isSalesUse.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.adjustOut && r.adjustOut.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.adjustIn && r.adjustIn.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isVatTarget && r.isVatTarget.toUpperCase() === 'Y' ? "checked" : ""}></td>

						<!-- ✅ 부가세처리구분 -->
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="판매기준단가+수량(차액처리포함)" \${r.vatProcessType === "판매기준단가+수량(차액처리포함)" ? "selected" : ""}>판매기준단가+수량(차액처리포함)</option>
								<option value="판매기준단가+수량(차액처리안함)" \${r.vatProcessType === "판매기준단가+수량(차액처리안함)" ? "selected" : ""}>판매기준단가+수량(차액처리안함)</option>
							</select>
						</td>

						<td class="text-center"><input type="checkbox" \${r.isAs && r.isAs.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isItemJournal && r.isItemJournal.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" class="chk-delete"></td>
					`;
				}

				/* ✅ 입고 탭 */
				else if (type === "IN") {
					html += `
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="샘플입고" \${r.categoryName === "샘플입고" ? "selected" : ""}>샘플입고</option>
								<option value="불량입고" \${r.categoryName === "불량입고" ? "selected" : ""}>불량입고</option>
								<option value="정상입고" \${r.categoryName === "정상입고" ? "selected" : ""}>정상입고</option>
							</select>
						</td>

						<td contenteditable="true">\${r.sortOrder || ''}</td>
						<td class="text-center"><input type="checkbox" \${r.useYn && r.useYn.toUpperCase() === 'Y' ? "checked" : ""}></td>

						<!-- ✅ 계정과목 -->
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="외화현금" \${r.accountSubject === "외화현금" ? "selected" : ""}>외화현금</option>
								<option value="보통예금" \${r.accountSubject === "보통예금" ? "selected" : ""}>보통예금</option>
								<option value="외화보통예금" \${r.accountSubject === "외화보통예금" ? "selected" : ""}>외화보통예금</option>
								<option value="당좌예금" \${r.accountSubject === "당좌예금" ? "selected" : ""}>당좌예금</option>
							</select>
						</td>

						<!-- ✅ 비용구분 -->
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="제조" \${r.costType === "제조" ? "selected" : ""}>제조</option>
								<option value="판관" \${r.costType === "판관" ? "selected" : ""}>판관</option>
							</select>
						</td>

						<td class="text-center"><input type="checkbox" \${r.isFinishedProduct && r.isFinishedProduct.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isMaterial && r.isMaterial.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isByproductIn && r.isByproductIn.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isReturnIn && r.isReturnIn.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" class="chk-delete"></td>
					`;
				}

				/* ✅ 이동 탭 (기존 JSP 안전 버전 그대로 유지) */
				else if (type === "MOVE") {
					html += `
						<td>
							<select class="form-select">
								<option value="">선택</option>
								<option value="위탁처리" \${r.categoryName === "위탁처리" ? "selected" : ""}>위탁처리</option>
								<option value="이동처리" \${r.categoryName === "이동처리" ? "selected" : ""}>이동처리</option>
								<option value="자재불출" \${r.categoryName === "자재불출" ? "selected" : ""}>자재불출</option>
								<option value="외주불출" \${r.categoryName === "외주불출" ? "selected" : ""}>외주불출</option>
								<option value="불량처리" \${r.categoryName === "불량처리" ? "selected" : ""}>불량처리</option>
								<option value="양품처리" \${r.categoryName === "양품처리" ? "selected" : ""}>양품처리</option>
							</select>
						</td>
						<td contenteditable="true">\${r.sortOrder || ''}</td>
						<td class="text-center"><input type="checkbox" \${r.useYn && r.useYn.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isMove && r.isMove.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isTransfer && r.isTransfer.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isAsOut && r.isAsOut.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isAsReturn && r.isAsReturn.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isFreeSupply && r.isFreeSupply.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" \${r.isDispatchTarget && r.isDispatchTarget.toUpperCase() === 'Y' ? "checked" : ""}></td>
						<td class="text-center"><input type="checkbox" class="chk-delete"></td>
					`;
				}

				html += `</tr>`;
				tbody.append(html);
			});
			/* ✅ 신규 입력용 빈 행 추가 */
			let emptyRow = `<tr data-txncode="">
			  <td class="text-center">\${result.length + 1}</td>`;

			// ✅ 출고 탭 신규행
			if (type === "OUT") {
			  emptyRow += `
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="판촉">판촉</option>
			        <option value="폐기">폐기</option>
			        <option value="반품">반품</option>
			      </select>
			    </td>
			    <td contenteditable="true"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="외화현금">외화현금</option>
			        <option value="보통예금">보통예금</option>
			        <option value="외화보통예금">외화보통예금</option>
			        <option value="당좌예금">당좌예금</option>
			      </select>
			    </td>
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="제조">제조</option>
			        <option value="판관">판관</option>
			      </select>
			    </td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="판매기준단가+수량(차액처리포함)">판매기준단가+수량(차액처리포함)</option>
			        <option value="판매기준단가+수량(차액처리안함)">판매기준단가+수량(차액처리안함)</option>
			      </select>
			    </td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
			}

			// ✅ 입고 탭 신규행
			else if (type === "IN") {
			  emptyRow += `
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="샘플입고">샘플입고</option>
			        <option value="불량입고">불량입고</option>
			        <option value="정상입고">정상입고</option>
			      </select>
			    </td>
			    <td contenteditable="true"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="외화현금">외화현금</option>
			        <option value="보통예금">보통예금</option>
			        <option value="외화보통예금">외화보통예금</option>
			        <option value="당좌예금">당좌예금</option>
			      </select>
			    </td>
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="제조">제조</option>
			        <option value="판관">판관</option>
			      </select>
			    </td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
			}

			// ✅ 이동 탭 신규행
			else if (type === "MOVE") {
			  emptyRow += `
			    <td>
			      <select class="form-select">
			        <option value="">선택</option>
			        <option value="위탁처리">위탁처리</option>
			        <option value="이동처리">이동처리</option>
			        <option value="자재불출">자재불출</option>
			        <option value="외주불출">외주불출</option>
			        <option value="불량처리">불량처리</option>
			        <option value="양품처리">양품처리</option>
			      </select>
			    </td>
			    <td contenteditable="true"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox"></td>
			    <td class="text-center"><input type="checkbox" class="chk-delete"></td>`;
			}

			emptyRow += `</tr>`;
			tbody.append(emptyRow);

		}
	});
}

/* ✅ 저장 */
function saveAll() {
  const active = $(".tab-btn.active").text();
  let type = active === "출고" ? "OUT" : (active === "입고" ? "IN" : "MOVE");
  let tbody = type === "OUT" ? "#tbody-out" : type === "IN" ? "#tbody-in" : "#tbody-move";
  let data = [];

  $(tbody + " tr").each(function () {
    const tr = $(this);
    const txnCode = tr.data("txncode"); // 기존 데이터 식별용 코드
    const tds = tr.find("td");

    let obj = {
      txnCode: txnCode || null, // 신규는 null
      categoryName: type === "MOVE" ? $(tds[1]).find("select").val() : $(tds[1]).find("select").val() || $(tds[1]).text().trim(),
      sortOrder: $(tds[2]).text().trim(),
      useYn: $(tds[3]).find("input").prop("checked") ? "Y" : "N",
      txnType: type,
      buId: 1
    };

    /* ✅ 출고 */
    if (type === "OUT") {
      obj.accountSubject = $(tds[4]).find("select").val();
      obj.costType = $(tds[5]).find("select").val();
      obj.isFinishedProduct = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
      obj.isMaterial = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
      obj.isSalesUse = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
      obj.adjustOut = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
      obj.adjustIn = $(tds[10]).find("input").prop("checked") ? "Y" : "N";
      obj.isVatTarget = $(tds[11]).find("input").prop("checked") ? "Y" : "N";
      obj.vatProcessType = $(tds[12]).find("select").val();
      obj.isAs = $(tds[13]).find("input").prop("checked") ? "Y" : "N";
      obj.isItemJournal = $(tds[14]).find("input").prop("checked") ? "Y" : "N";
    }

    /* ✅ 입고 */
    if (type === "IN") {
      obj.accountSubject = $(tds[4]).find("select").val();
      obj.costType = $(tds[5]).find("select").val();
      obj.isFinishedProduct = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
      obj.isMaterial = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
      obj.isByproductIn = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
      obj.isReturnIn = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
    }

    /* ✅ 이동 */
    if (type === "MOVE") {
      obj.isMove = $(tds[4]).find("input").prop("checked") ? "Y" : "N";
      obj.isTransfer = $(tds[5]).find("input").prop("checked") ? "Y" : "N";
      obj.isAsOut = $(tds[6]).find("input").prop("checked") ? "Y" : "N";
      obj.isAsReturn = $(tds[7]).find("input").prop("checked") ? "Y" : "N";
      obj.isFreeSupply = $(tds[8]).find("input").prop("checked") ? "Y" : "N";
      obj.isDispatchTarget = $(tds[9]).find("input").prop("checked") ? "Y" : "N";
    }

    // ✅ 신규행 또는 수정된 행만 추가
    if (obj.categoryName && obj.categoryName !== "선택") {
      if (!txnCode || tr.hasClass("modified")) {
        data.push(obj);
      }
    }
  });

  if (data.length === 0) {
    alert("저장할 항목이 없습니다.");
    return;
  }

  let successCount = 0;
  data.forEach((row, idx) => {
    $.ajax({
      url: '/txnCategory/api/save',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(row),
      success: () => {
        successCount++;
        if (successCount === data.length) {
          alert("저장 완료");
          loadData(); // ✅ 저장 후 자동 새로고침
        }
      },
      error: (err) => console.error("저장 실패:", err)
    });
  });
}



function deleteSelected() {
	  const active = $(".tab-btn.active").text();
	  let tbody = active === "출고" ? "#tbody-out" : active === "입고" ? "#tbody-in" : "#tbody-move";
	  let checked = $(tbody + " .chk-delete:checked");

	  if (checked.length === 0) {
	    alert("삭제할 항목을 선택하세요.");
	    return;
	  }

	  if (!confirm("선택한 항목을 삭제하시겠습니까? (DB에서도 삭제됩니다)")) return;

	  const buId = 1;
	  let successCount = 0;
	  const total = checked.length;

	  checked.each(function () {
	    const tr = $(this).closest("tr");
	    const txnCode = tr.data("txncode");

	    if (txnCode) {
	      $.ajax({
	        url: "/txnCategory/api/delete",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({ txnCode: txnCode, buId: buId }),
	        success: function (res) {
	          tr.remove();
	          successCount++;
	          if (successCount === total) {
	            reorderRowNumbers(tbody); // ✅ 삭제 후 번호 자동 정렬
	            alert("삭제 완료!");
	          }
	        },
	        error: function (xhr) {
	          console.error("삭제 실패:", xhr);
	          alert("삭제 중 오류가 발생했습니다.");
	        }
	      });
	    } else {
	      tr.remove();
	    }
	  });

	  // ✅ 삭제 후 번호 재정렬
	  reorderRowNumbers(tbody);
	}

	/* ✅ 번호 재정렬 함수 */
	function reorderRowNumbers(tbodySelector) {
	  $(tbodySelector + " tr").each(function (index) {
	    $(this).find("td:first").text(index + 1);
	  });
	}





/* ✅ 페이지 로드시 자동 조회 */
$(document).ready(loadData);
</script>
