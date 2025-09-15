<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.7.0/css/select.dataTables.min.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/select/1.7.0/js/dataTables.select.min.js"></script>

<!DOCTYPE html>
<html>
<style>
	.dataTables_scrollHeadInner {
		width: 100% !important;  /* 헤드 너비 강제 조정 */
	}
	.dataTables_scrollBody > table {
		width: 100% !important;
	}
	table.dataTable {
  		table-layout: fixed;
	}
</style>
<head>
	<meta charset="UTF-8">
    <title>창고별 재고 부족 허용여부 설정 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
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
    	<div class = "main">
    		<div class="main-header">
		        <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>창고수불속성설정</h1></div>
	            <div>
		            <button class="btn btn-secondary search-btn" id = "search" onclick = "search()">조회</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save_OutBound()">저장</button>
				</div>
	        </div>
	        <div class="filters">
	        	<div class = "filters-main">
        			<div class = "title">조회 조건</div>
        			<div class = "line"></div>
	        	</div>
            	<div class="filters-row">
            		<div class = "filters-count">
	            		<div class = "filters-text">사업단위</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="buItem">
							        <option value="${buItem.value}">${buItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">창고구분</div>
	            		<div class = "filters-value">
	            			<select id = "wareHouse_Master_Id" name = "wareHouse_Master_Id">
								<option value = ""></option>
							    <c:forEach items="${wareHouse_Master_Id}" var="wareHouseItem">
							        <option value="${wareHouseItem.value}">${wareHouseItem.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">창고명</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "wareHouse_Name">
	            		</div>
            		</div>
   			    </div>
			</div>
			<div class = "table-container" style = "height: 300px;">
				<table class="table-single-select" style = "width: 100%">
					<thead>
						<tr>
					    	<th>사업단위</th>
					        <th>창고구분내부코드</th>
					        <th>창고구분</th>
					        <th>창고내부코드</th>
					        <th>창고명</th>
					        <th>현장부서</th>
					        <th>외주거래처</th>
					        <th>위탁거래처</th>
					        <th>담당자</th>
					        <th>재고부족허용</th>
					        <th>창고담당자통제</th>
					        <th>창고담당자등록</th>
					        <th>가용재고미포함</th>
					        <th>가용재고통제</th>
					        <th>사용안함</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody1">
			    		<c:forEach items = "${list}" var = "board">
					    	<tr onclick= "row_Click(this)">
				    			<td class = "text-center"><input type="hidden" value="${board.bu_Id}" /><span><c:out value="${board.bu_Name}" /></span></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Master_Id}"/></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Internal_Code}"/></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Id}"/></td>
				    			<td><c:out value = "${board.wareHouse_Name}"/></td>
				    			<td><c:out value = "${board.site_Department}"/></td>
				    			<td><c:out value = "${board.outSourcing_Party_Id}"/></td>
				    			<td><c:out value = "${board.consignment_Party_Id}"/></td>
				    			<td><c:out value = "${board.manager_Party_Id}"/></td>
				    			<td class="text-center">
									<input type="checkbox" name="bu_Dependent_Flag" value="Y" <c:if test="${board.bu_Dependent_Flag == 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" <c:if test="${board.allow_Stock_Shortage == 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" disabled = "disabled" <c:if test="${board.manager_Control_Flag == 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" <c:if test="${board.exclude_From_Available == 'Y'}">checked</c:if> />
								</td>
				    			<td class="text-center">
									<input type="checkbox" <c:if test="${board.available_Control_Flag == 'Y'}">checked</c:if> />
								</td>
				    			<td class="text-center">
									<input type="checkbox" <c:if test="${board.use_Yn == 'Y'}">checked</c:if> />
								</td>
					    	</tr>
				    	</c:forEach>
				    </tbody>
				</table>
		    </div>
		    <div class="filters">
			    <div class="filters-row">
			    	<div class = "filters-count">
	           		<div class = "filters-text">창고명</div>
	           		<div class = "filters-value">
	           			<input type = "text" id = "wareHouse_Name2" readonly>
	           		</div>
	          		</div>
			    </div>
		    </div>
		    <div style = "display: flex; gap: 5px;">
		    	<div style = "display: grid; gap: 5px; width: 550px;">
			    	<div class="filters">
			    		<div class = "filters-main">
		        			<div class = "title">관리품목정보</div>
		        			<div class = "line"></div>
			        	</div>
			    	</div>
			    	<div class = "table-container" style = "height: 295px;">
		    			<table class="table-single-select" style = "width: 100%">
					        <thead>
					            <tr>
					                <th>품명</th>
					                <th>품번</th>
					                <th>규격</th>
					                <th>안전재고수량</th>
					                <th>보관위치</th>
					            </tr>
					        </thead>
					        <tbody id = "result-tbody2">
						    </tbody>
					    </table>
		    		</div>
	    		</div>
	    		<div style = "display: grid; gap: 10px; width: 550px;">
			    	<div class="filters">
			    		<div class = "filters-main">
		        			<div class = "title">담당자정보</div>
		        			<div class = "line"></div>
			        	</div>
			    	</div>
			    	<div class = "table-container" style = "height: 295px;">
		    			<table id="table3">
					        <thead>
					            <tr>
					                <th>창고담당자</th>
					                <th>부서</th>
					            </tr>
					        </thead>
					         <tbody id = "result-tbody3">
						    </tbody>
					    </table>
		    		</div>
		    	</div>
		    </div> 
		</div>
	</div>
</body>
</html>

<script type="text/javascript" src="/resources/js/logistics.js"></script>

<script>
	
	(function() {
	    const tbody = document.querySelector('.table-single-select tbody');
	    if (!tbody) return;
	
	    let selectedRow = null;
	
	    tbody.addEventListener('click', function(e) {
	        const tr = e.target.closest('tr');
	        if (!tr) return;
	
	        if (selectedRow === tr) {
	            tr.classList.remove('tr-selected');
	            selectedRow = null;
	            return;
	        }
	
	        if (selectedRow) selectedRow.classList.remove('tr-selected');
	
	        tr.classList.add('tr-selected');
	        selectedRow = tr;
	    });
	})();
	
	function search() {
		
		var formData = {
			bu_Id: document.getElementById("bu_Id").value,
			wareHouse_Master_Id: document.getElementById("wareHouse_Master_Id").value
		}
		
		$.ajax({
			url: '/InvFlowConfig/list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				const tbody = document.getElementById("result-tbody1");
	            tbody.innerHTML = ""; // 기존 내용 초기화
	            
	         	// result 배열 반복
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	            	
	                tr.innerHTML = 
	                	'<td class="text-center"><input type="hidden" value="' + (board.bu_Id || '') + '" /><span>' + (board.bu_Name || '') + '</span></td>' +
	                    '<td class="text-center">' + (board.wareHouse_Master_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.wareHouse_Internal_Code || '') + '</td>' +
	                    '<td class="text-center">' + (board.wareHouse_Id || '') + '</td>' +
	                    '<td>' + (board.wareHouse_Name || '') + '</td>' +
	                    '<td>' + (board.site_Department || '') + '</td>' +
	                    '<td>' + (board.outsourcing_Party_Id || '') + '</td>' +
	                    '<td>' + (board.consignment_Party_Id || '') + '</td>' +
	                    '<td>' + (board.manager_Party_Id || '') + '</td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.bu_Dependent_Flag === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.allow_Stock_Shortage === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox" disabled' + (board.manager_Control_Flag === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.exclude_From_Available === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.available_Control_Flag === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.use_Yn === 'Y' ? ' checked' : '') + '></td>';

                    tr.onclick = function() {
                    	var data = this;
                    	
                    	row_Click(data);
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	            // 초기화
	            document.getElementById("wareHouse_Name2").value = "";
	            
	            const tbody2 = document.getElementById("result-tbody2");
	            tbody2.innerHTML = ""; // 기존 내용 초기화
	            
	            const tbody3 = document.getElementById("result-tbody3");
	            tbody3.innerHTML = ""; // 기존 내용 초기화
			}
		});
	}
	
	function row_Click(row) { 
		
		const data = Array.from(row.cells).map(td => {
	        const checkbox = td.querySelector('input[type=checkbox]');
	        
	        if(checkbox) return checkbox.checked ? 'Y' : 'N';  // 체크 여부 Y/N
	        
	        const hidden = td.querySelector('input[type=hidden]');
	        
	        if(hidden) return hidden.value;  // hidden 값
	        
	        return td.textContent.trim();   // 일반 텍스트
	    });

		document.getElementById("wareHouse_Name2").value = data[4];
		
		item_Search(data);
		contact_Search(data);
	}
	
	function item_Search(data) {
	    
		var formData = {
			bu_Id: data[0],
			wareHouse_Id: data[3]
		}
		
		$.ajax({
			url: '/InvFlowConfig/item_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				const tbody = document.getElementById("result-tbody2");
	            tbody.innerHTML = ""; // 기존 내용 초기화
	            
	            const totalRows = result.length + 3; // 테이블에 항상 3개의 빈 로우
	            
	         	// result 배열 반복
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.item_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.spec || '') + '</td>' +
	                    '<td class="text-center">' + (board.safety_Stock_Qty || '') + '</td>' +
	                    '<td class="text-center">' + (board. storage_Location || '') + '</td>';
	                    
                    tr.ondblclick = function() {
                    	open_Item(this);
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	         	// 빈 로우 추가
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(5); // 컬럼 수 만큼 빈 칸
                    
	                tr.ondblclick = function() {
                   		open_Item(this);
                    }
	                    
	                tbody.appendChild(tr);
	            }
			}
		});	
	}
	
	function contact_Search(data) {
	    
		var formData = {
			bu_Id: data[0],
			wareHouse_Id: data[3]
		}

	    $.ajax({
	    	url: '/InvFlowConfig/contact_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				const tbody = document.getElementById("result-tbody3");
	            tbody.innerHTML = ""; // 기존 내용 초기화
	            
	            const totalRows = result.length + 3; // 테이블에 항상 4개의 로우 유지
	            
	         	// result 배열 반복
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.contact_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.department || '') + '</td>';
	                    
//                     tr.onclick = function() {
//                     	// this → 클릭된 tr
//                         const data = Array.from(this.cells).map(td => td.textContent);
                        
//                     	row_Click(data); // td 값 배열 전달
//                     }
	                    
	                tbody.appendChild(tr);
	            });
	            
	         	// 빈 로우 추가
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = 
	                    '<td class="text-center">&nbsp;</td>'.repeat(2); // 컬럼 수 만큼 빈 칸
	                tbody.appendChild(tr);
	            }
	        }
	    }); 
	} 
	
  	function open_Item() {
  		
	   // 예: 첫 번째 셀 값 가져오기
	   // var rowId = row.cells[0].innerText;
	
	   // 팝업 크기 설정
	   var popupWidth = 900;
	   var popupHeight = 600;
	
	   // 화면 중앙 좌표 계산
	   var left = (screen.width - popupWidth) / 2;
	   var top = (screen.height - popupHeight) / 2;
	
	   // 팝업창 열기
		window.open(
			"item_popup",
	     	"popupWindow",
	     	"width=" + popupWidth +
	     	",height=" + popupHeight +
	     	",left=" + left +
	     	",top=" + top +
	     	",scrollbars=yes,resizable=yes"
	   );
	}
  	
 	// 팝업에서 선택된 데이터를 받을 함수
  	function setSelectedRow1(data) {
 		
  	    var result1 = $("#table2").DataTable().rows().data().toArray();
  	    var data = {item_Id: data.item_id, item_Name: '', spec: '', safety_Stock_Qty: '', storage_Location: ''};
  	    
  	    for (var i = 0; i < result1.length; i++) {
  	    	if (result1[i].item_Id != null) {
  	    		result1.splice(i, 0, data);
  	    		break;
  	    	}
  	    }
  
  		// 기존 DataTable 초기화
        if ($.fn.DataTable.isDataTable('#table2')) {
            $('#table2').DataTable().clear().destroy();
        }
  		

        $("#table2").DataTable({
            lengthChange: false, // 표시건수기능
            searching: false,    // 검색 기능
            ordering: false,     // 정렬 기능
            info: false,         // 정보 표시
            paging: false,       // 페이징기능
            data: result1,
            columns: [
                { data: "item_Id" },
                { data: "item_Name" },
                { data: "spec" },
                { data: "safety_Stock_Qty" },
                { data: "storage_Location" }
            ]
        });
 	}
 	
  	function openPopup2(row) {
 	   // 예: 첫 번째 셀 값 가져오기
 	   // var rowId = row.cells[0].innerText;
 	
 	   // 팝업 크기 설정
 	   var popupWidth = 900;
 	   var popupHeight = 600;
 	
 	   // 화면 중앙 좌표 계산
 	   var left = (screen.width - popupWidth) / 2;
 	   var top = (screen.height - popupHeight) / 2;
 	
 	   // 팝업창 열기
 	   window.open(
 	     "contact_popup",
 	     "popupWindow",
 	     "width=" + popupWidth +
 	     ",height=" + popupHeight +
 	     ",left=" + left +
 	     ",top=" + top +
 	     ",scrollbars=yes,resizable=yes"
 	   );
 	}
  	
	function setSelectedRow2(data) {
 		
  	    var result1 = $("#table2").DataTable().rows().data().toArray();
  	    var data = {item_Id: data.item_id, item_Name: '', spec: '', safety_Stock_Qty: '', storage_Location: ''};
  	    
  	    for (var i = 0; i < result1.length; i++) {
  	    	if (result1[i].item_Id != null) {
  	    		result1.splice(i, 0, data);
  	    		break;
  	    	}
  	    }
  
  		// 기존 DataTable 초기화
        if ($.fn.DataTable.isDataTable('#table2')) {
            $('#table2').DataTable().clear().destroy();
        }
  		

        $("#table2").DataTable({
            lengthChange: false, // 표시건수기능
            searching: false,    // 검색 기능
            ordering: false,     // 정렬 기능
            info: false,         // 정보 표시
            paging: false,       // 페이징기능
            data: result1,
            columns: [
                { data: "item_Id" },
                { data: "item_Name" },
                { data: "spec" },
                { data: "safety_Stock_Qty" },
                { data: "storage_Location" }
            ]
        });
 	}

</script>