<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>倉庫別在庫不足許容設定 - ファムスプリングERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class = "layout">
		<%@ include file="/WEB-INF/views/logistics.jsp" %>
    	<div class = "main">
    		<div class="main-header">
		        <div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>倉庫入出庫属性設定</h1></div>
	            <div>
		            <button class="btn btn-secondary search-btn" id = "search" onclick = "search()">照会</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save()">保存</button>
				</div>
	        </div>
	        <div class="filters">
	        	<div class = "filters-main">
        			<div class = "title">照会条件</div>
        			<div class = "line"></div>
	        	</div>
            	<div class="filters-row">
            		<div class = "filters-count">
	            		<div class = "filters-text">事業単位</div>
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
	            		<div class = "filters-text">倉庫区分</div>
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
	            		<div class = "filters-text">倉庫名</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "wareHouse_Name">
	            		</div>
            		</div>
   			    </div>
			</div>
			<div class = "table-container" style = "height: 300px;">
				<table class="table-single-select">
					<thead>
						<tr>
					    	<th style = "width: 185px">事業単位</th>
					        <th style = "width: 190px">倉庫区分内部コード</th>
					        <th style = "width: 155px">倉庫区分</th>
					        <th style = "width: 155px">倉庫内部コード</th>
					        <th style = "width: 155px">倉庫名</th>
					        <th style = "width: 140px">現場部署</th>
					        <th style = "width: 140px">外注取引先</th>
					        <th style = "width: 140px">委託取引先</th>
					        <th style = "width: 140px">担当者</th>
					        <th style = "width: 155px">在庫不足許容</th>
					        <th style = "width: 175px">倉庫担当者統制</th>
					        <th style = "width: 175px">倉庫担当者登録</th>
					        <th style = "width: 175px">利用可能在庫除外</th>
					        <th style = "width: 155px">利用可能在庫統制</th>
					        <th style = "width: 140px">使用しない</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody1">
			    		<c:forEach items = "${list}" var = "board">
					    	<tr onclick= "row_Click(this)">
				    			<td class = "text-center"><input type="hidden" value="${board.bu_Id}" /><c:out value="${board.bu_Name}" /></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Master_Id}"/></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Internal_Code}"/></td>
				    			<td class = "text-center"><c:out value = "${board.wareHouse_Id}"/></td>
				    			<td><c:out value = "${board.wareHouse_Name}"/></td>
				    			<td><c:out value = "${board.site_Department}"/></td>
				    			<td><c:out value = "${board.outSourcing_Party_Id}"/></td>
				    			<td><c:out value = "${board.consignment_Party_Id}"/></td>
				    			<td><c:out value = "${board.manager_Party_Id}"/></td>
				    			<td class="text-center">
									<input type="checkbox" name="allow_Stock_Shortage" value="Y" <c:if test="${board.allow_Stock_Shortage == 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" name = "manager_Control_Flag" <c:if test="${board.manager_Control_Flag == 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" name = "manager_Regist_Yn" disabled = "disabled" <c:if test="${board.manager_Regist_Yn== 'Y'}">checked</c:if> />
								</td>
								<td class="text-center">
									<input type="checkbox" name = "exclude_From_Available" <c:if test="${board.exclude_From_Available == 'Y'}">checked</c:if> />
								</td>
				    			<td class="text-center">
									<input type="checkbox" name = "available_Control_Flag" <c:if test="${board.available_Control_Flag == 'Y'}">checked</c:if> />
								</td>
				    			<td class="text-center">
									<input type="checkbox" name = "use_Yn" value="${board.use_Yn}" <c:if test="${board.use_Yn == 'Y'}">checked</c:if> />
								</td>
					    	</tr>
				    	</c:forEach>
				    </tbody>
				</table>
		    </div>
		    <div class="filters">
			    <div class="filters-row">
			    	<div class = "filters-count">
	           		<div class = "filters-text">倉庫名</div>
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
		        			<div class = "title">管理品目情報</div>
		        			<div class = "line"></div>
			        	</div>
			    	</div>
			    	<div class = "table-container" style = "height: 295px;">
		    			<table class="table-single-select" style = "width: 100%">
					        <thead>
					            <tr>
					                <th style = "width: 80px;">品名</th>
					                <th style = "width: 100px;">品番</th>
					                <th style = "width: px;">規格</th>
					                <th style = "width: 110px;">安全在庫数量</th>
					                <th style = "width: 100px;">保管位置</th>
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
		        			<div class = "title">担当者情報</div>
		        			<div class = "line"></div>
			        	</div>
			    	</div>
			    	<div class = "table-container" style = "height: 295px;">
		    			<table class="table-single-select" style = "width: 100%">
					        <thead>
					            <tr>
					                <th>社員番号</th>
					                <th>倉庫担当者</th>
					                <th>部署</th>
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
	<script type="text/javascript" src="../resources/js/logistics.js"></script>
</body>
</html>

<script>

	(function() {
	    const tbody = document.querySelector('.table-single-select tbody');
	    if (!tbody) return;
	
	    let selectedRow = null;
	
	    tbody.addEventListener('click', function(e) {
	        const tr = e.target.closest('tr');
	        if (!tr) return;
	        
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
	            tbody.innerHTML = "";
	            
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
	                    '<td class="text-center"><input type="checkbox"' + (board.allow_Stock_Shortage === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.manager_Control_Flag === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox" disabled' + (board.manager_Regist_Yn === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.exclude_From_Available === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.available_Control_Flag === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.use_Yn === 'Y' ? ' checked' : '') + '></td>';

                    tr.onclick = function() {
                    	var data = this;
                    	
                    	row_Click(data);
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	            document.getElementById("wareHouse_Name2").value = "";
	            
	            const tbody2 = document.getElementById("result-tbody2");
	            tbody2.innerHTML = "";
	            
	            const tbody3 = document.getElementById("result-tbody3");
	            tbody3.innerHTML = "";
			}
		});
	}
	
	function row_Click(row) { 
		
		const data = Array.from(row.cells).map(function(td) {
	        const checkbox = td.querySelector('input[type=checkbox]');
	        
	        if(checkbox) return checkbox.checked ? 'Y' : 'N';
	        
	        const hidden = td.querySelector('input[type=hidden]');
	        
	        if(hidden) return hidden.value;
	        
	        return td.textContent.trim(); 
	    });

		document.getElementById("wareHouse_Name2").value = data[4];
		
		search_Detail1(data);
		search_Detail2(data);
	}
	
	function search_Detail1(data) {
	    
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
	            tbody.innerHTML = "";
	            
	            const totalRows = result.length + 3;
	            
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.item_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.spec || '') + '</td>' +
	                    '<td class="text-center">' + (board.safety_Stock_Qty || '') + '</td>' +
	                    '<td class="text-center">' + (board.storage_Location || '') + '</td>';
	                    
                    tr.ondblclick = function() {
                    	open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(5);
	                tr.ondblclick = function() {
                   		open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            }
			}
		});	
	}
	
	function search_Detail2(data) {
	    
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
	            tbody.innerHTML = "";
	            
	            const totalRows = result.length + 3;
	            
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.contact_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.contact_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.department || '') + '</td>';
	                    
                    tr.onclick = function() {
                    	open_contact();
                    }
	                tbody.appendChild(tr);
	            });
	            
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = 
	                    '<td class="text-center">&nbsp;</td>'.repeat(3);
                    tr.ondblclick = function() {
                    	open_contact();
                    }
	                tbody.appendChild(tr);
	            }
	        }
	    }); 
	}
	
	function save() {
		
	    var selectedRow = document.querySelector('#result-tbody1 .tr-selected');
	    
	    if (!selectedRow) {
	    	alert("選択された行がありません。");
	        return;
	    }

	    var data = Array.from(selectedRow.cells).map(function(td, index) {
	    	
	        if (index === 0) {
	            var hidden = td.querySelector("input[type=hidden]");
	            return hidden ? hidden.value : "";
	        }

	        var checkbox = td.querySelector("input[type=checkbox]");
	        if (checkbox) {
	            return checkbox.checked ? "Y" : "N";
	        }

	        return td.textContent.trim();
	    });

	    var formData = {
    		bu_Id: data[0],
            wareHouse_Master_Id: data[1],
            wareHouse_Id: data[3],
            allow_Stock_Shortage: data[9],
            manager_Control_Flag: data[10],
            exclude_From_Available: data[11],
            available_Control_Flag: data[12],
            use_Yn: data[13]	
	    }
	    
	    $.ajax({
	        url: '/InvFlowConfig/save',
	        type: 'POST',
	        data: formData,
	        success: function(result) {
	        	save_Detail1(data[0], data[1], data[3]);
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 실패:", error);
	        }
	    });
	}
	
	function save_Detail1(bu_Id, wm_id, w_id) {
		
		var tbody = document.getElementById("result-tbody2");

	    var allData = Array.from(tbody.rows)
	        .filter(function(tr) {
	            var firstValue = tr.cells[0].textContent.trim();
	            return firstValue !== null && firstValue !== "";
	        })
	        .map(function(tr) {
	        	
	            var rowData = Array.from(tr.cells).map(function(td) {
	                return td.textContent.trim();
	            });
	
	            rowData.unshift(w_id); 
	            rowData.unshift(wm_id);
	            rowData.unshift(bu_Id);
	
	            return rowData;
	        });
		
	    $.ajax({
	        url: '/InvFlowConfig/save_detail1',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(allData),
	        success: function(result) {
	        	save_Detail2(bu_Id, wm_id, w_id);
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 실패:", error);
	        }
	    });
	}
	
	function save_Detail2(bu_Id, wm_id, w_id) {
		
		var tbody = document.getElementById("result-tbody3");

	    var allData = Array.from(tbody.rows)
	        .filter(function(tr) {
	            var firstValue = tr.cells[0].textContent.trim();
	            return firstValue !== null && firstValue !== "";
	        })
	        .map(function(tr) {
	        	
	            var rowData = Array.from(tr.cells).map(function(td) {
	                return td.textContent.trim();
	            });
	
	            rowData.unshift(w_id); 
	            rowData.unshift(wm_id);
	            rowData.unshift(bu_Id);
	
	            return rowData;
	        });
		
	    $.ajax({
	        url: '/InvFlowConfig/save_detail2',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(allData),
	        success: function(result) {
	        	alert("保存されました");
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 실패:", error);
	        }
	    });
	}
	
	
	function open_Item() {
  	
	    var popupWidth = 900;
	    var popupHeight = 600;
	
	    var left = (screen.width - popupWidth) / 2;
	    var top = (screen.height - popupHeight) / 2;
	
		window.open(
			"../popup/item_popup",
	     	"popupWindow",
	     	"width=" + popupWidth +
	     	",height=" + popupHeight +
	     	",left=" + left +
	     	",top=" + top +
	     	",scrollbars=no,resizable=yes"
	   );
	}
  	
  	function item_RowData(data) {
	    
 		var tbody = document.getElementById("result-tbody2");
 		
 	    var filteredRows = Array.from(tbody.querySelectorAll("tr"))
 	        .filter(function(tr) {
 	            var firstValue = tr.cells[0].textContent.trim();
 	            return firstValue !== null && firstValue !== "";
 	        });

 	    var allData = filteredRows.map(function(tr) {
 	        return Array.from(tr.cells).map(function(td) {
 	            return td.textContent.trim();
 	        });
 	    });
 	    
 	    for (var i = 0; i < allData.length; i++) {
 	    	if (allData[i][0] == data[0]) {
 	    		return;
 	    	}
 	    }
 
		var newData = [data[0], data[1], data[2], data[8], data[9]];
 	   
 	    allData.push(newData);
 		
 	   	tbody.innerHTML = "";
       
       	const totalRows = allData.length + 3;
       
       	allData.forEach(function(board) {
		const tr = document.createElement("tr");
        	tr.innerHTML = 
               '<td class="text-center">' + (board[0] || '') + '</td>' +
               '<td class="text-center">' + (board[1] || '') + '</td>' +
               '<td class="text-center">' + (board[2] || '') + '</td>' +
               '<td class="text-center">' + (board[3] || '') + '</td>' +
               '<td class="text-center">' + (board[4] || '') + '</td>';
               
            tr.onclick = function() {
				open_Item();
           	}
               
           	tbody.appendChild(tr);
       });
       
       const emptyRows = totalRows - allData.length;
       for (let i = 0; i < emptyRows; i++) {
           	const tr = document.createElement("tr");
           	tr.innerHTML = 
               '<td class="text-center">&nbsp;</td>'.repeat(5);
			tr.ondblclick = function() {
   				open_item();
   			}
            tbody.appendChild(tr);
       }
	}
 	
	function open_contact() {
	
		var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
		window.open(
			"../popup/contact_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
 	}
	
	function contact_RowData(data) {
		var tbody = document.getElementById("result-tbody3");
		
 	    var filteredRows = Array.from(tbody.querySelectorAll("tr"))
 	        .filter(function(tr) {
 	            var firstValue = tr.cells[0].textContent.trim();
 	            return firstValue !== null && firstValue !== "";
 	        });

 	    var allData = filteredRows.map(function(tr) {
 	        return Array.from(tr.cells).map(function(td) {
 	            return td.textContent.trim();
 	        });
 	    });
 	    
 	    for (var i = 0; i < allData.length; i++) {
 	    	if (allData[i][0] == data[0]) {
 	    		return;
 	    	}
 	    }
 
		var newData = [data[0], data[1], data[2]];
 	   
 	    allData.push(newData);
 		
 	   	tbody.innerHTML = "";
       
       	const totalRows = allData.length + 3;
       
       	allData.forEach(function(board) {
		const tr = document.createElement("tr");
        	tr.innerHTML = 
               '<td class="text-center">' + (board[0] || '') + '</td>' +
               '<td class="text-center">' + (board[1] || '') + '</td>' +
               '<td class="text-center">' + (board[2] || '') + '</td>';
               
            tr.onclick = function() {
				open_contact();
           	}
               
           	tbody.appendChild(tr);
       });
       
       const emptyRows = totalRows - allData.length;
       for (let i = 0; i < emptyRows; i++) {
           const tr = document.createElement("tr");
           	tr.innerHTML = 
               	'<td class="text-center">&nbsp;</td>'.repeat(3);
			tr.ondblclick = function() {
				open_contact();
			}
           	tbody.appendChild(tr);
       }
	}

</script>



