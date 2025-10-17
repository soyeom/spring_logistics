<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>出庫処理 - ファムスプリングERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class = "layout">
		<%@ include file="/WEB-INF/views/logistics.jsp" %>
    	<div class = "main">
    		<div class = "main-header">
    			<div><span class="btn btn-secondary btn-icon toggle-sidebar">≡</span></div>
	            <div><h1>取引明細書入力</h1></div>
	            <div>
	            	<button class="btn btn-secondary search-btn" id = "save" onclick = "new_out()">新規</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "save()">保存</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "outBound_delete()">削除</button>
					<button class="btn btn-secondary search-btn" id = "save" onclick = "outBound_Update()">出庫/取消</button>
				</div>
    		</div>
    		    		<div class = "filters">
    			<div class = "filters-main">
        			<div class = "title">検索条件</div>
        			<div class = "line"></div>
	        	</div>
    			<div class = "filters-row">
    				<input type = "hidden" id = "out_Complete" name = "out_Complete">
    				<div class = "filters-count">
	            		<div class = "filters-text">事業部</div>
	            		<div class = "filters-value">
	            			<select id = "bu_Id" name = "bu_Id">
								<option value = ""></option>
							    <c:forEach items="${bu_Id}" var="bu_Id">
							        <option value="${bu_Id.value}">${bu_Id.text}</option>
							    </c:forEach>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">取引明細書日</div>
	            		<div class = "filters-value">
	            			 <input type="date" id="out_Daet" name="out_Date">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">取引明細書番号</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "out_Id" readonly>
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="out_Master_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">Local区分</div>
	            		<div class = "filters-value">
	            			<select id = "local_Flag" name = "local_Flag">
								<option value = ""></option>
								<option value = "10">国内</option>
								<option value = "20">Local(後LC)</option>
								<option value = "30">Local(先LC)</option>
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">取引先</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "party_Name">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="party_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">取引先番号</div>
	            		<div class = "filters-value">
							<input type = "text" name = "party_Id" id = "party_Id" readonly>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">担当者</div>
	            		<div class = "filters-value">
	            			<input type = "hidden" id = "contact_Id" name = "contact_id">
	            			<input type = "text" id = "contact_Name" name = "contact_Name" readonly>
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="contact_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">部署</div>
	            		<div class = "filters-value">
	            			<input type = "text" id = "department" name = "department" readonly>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">出庫区分</div>
	            		<div class = "filters-value">
	            			<select id = "out_Type" name = "out_Type">
								<option value = ""></option>
								<option value = "10">受注</option>
								<option value = "20">積送依頼</option>
								<option value = "30">委託出庫依頼</option>
								<option value = "40">その他出庫依頼</option>							    
							</select>
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">委託区分</div>
	            		<div class = "filters-value">
	            			<select id = "consignment_Gubun" name = "consignment_Gubun">
								<option value = ""></option>
								<option value = "10">一般</option>
								<option value = "20">委託</option>
								<option value = "30">販売後保管</option>
							</select>
	            		</div>
            		</div>
    			</div>
    		</div>
    		<div class = "filters">
    			<div class = "filters-main">
        			<div class = "title">追加情報</div>
        			<div class = "line"></div>
	        	</div>
    			<div class = "filters-row">
    				<div class = "filters-count">
	            		<div class = "filters-text">通貨</div>
	            		<div class = "filters-value">
            				<input type = "text" id = "currency_Code" name = "currency_Code">
	            			<img src="https://cdn-icons-png.flaticon.com/512/16799/16799970.png" alt="search" class="search-icon" onclick="currency_Popup()">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">販売金額計</div>
	            		<div class = "filters-value">
	            			 <input type="number" id="total" name="total">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">付加税計</div>
	            		<div class = "filters-value">
	            			<input type="number" id="total_Tax" name="total_Tax">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">総額</div>
	            		<div class = "filters-value">
            				<input type="number" id="total_Sum" name="total_Sum">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">為替レート</div>
	            		<div class = "filters-value">
	            			<input type="number" id="exchange_Rate" name="exchange_Rate">
	            		</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">販売金額計(円)</div>
	            		<div class = "filters-value">
							<input type="number" id="total_Krw" name="total_Krw">
						</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">付加税計(円)</div>
	            		<div class = "filters-value">
            				<input type="number" id="total_Krw_Tax" name="total_Krw_Tax">
            			</div>
            		</div>
            		<div class = "filters-count">
	            		<div class = "filters-text">総額(円)</div>
	            		<div class = "filters-value">
	            			<input type="number" id="total_Krw_Sum" name="total_Krw_Sum">
						</div>
            		</div>
    			</div>
    		</div>
    		<div class = "table-container">
				<table class="table-single-select">
					<thead>
						<tr>
					    	<th style = "width: 160px">品番</th>
					        <th style = "width: 165px">品名</th>
					        <th style = "width: 130px">規格</th>
					        <th style = "width: 130px">取引先品番</th>
					        <th style = "width: 130px">取引先</th>
					        <th style = "width: 115px">数量</th>
					        <th style = "width: 115px">販売単位</th>
					        <th style = "width: 115px">販売単価</th>
					        <th style = "width: 115px">付加税含</th>
					        <th style = "width: 140px">販売金額</th>
					        <th style = "width: 150px">付加税額</th>
					        <th style = "width: 150px">販売基準価</th>
					        <th style = "width: 150px">基準単位</th>
					        <th style = "width: 130px">倉庫</th>
					        <th style = "width: 145px">Lot No.</th>
					        <th style = "width: 175px">その他出庫区分</th>
					        <th style = "width: 175px">有償支給有無</th>
					        <th style = "width: 175px">品目資産分類</th>
					        <th style = "width: 175px">資産処理区分</th>
					        <th style = "width: 115px">現在庫</th>
				        </tr>
				    </thead>
				    <tbody id = "result-tbody">
				    </tbody>
				</table>
		    </div>
    	</div>
	</div>
	<script type="text/javascript" src="../resources/js/logistics.js"></script>
</body>
</html>

<script>

	function new_out() {
	    
	    document.getElementById("bu_Id").value = "";
	    document.getElementById("out_Daet").value = "";
	    document.getElementById("out_Id").value = "自動生成";
	    document.getElementById("local_Flag").value = "";
	    document.getElementById("party_Name").value = "";
	    document.getElementById("party_Id").value = "";
	    document.getElementById("contact_Name").value = "";
	    document.getElementById("department").value = "";
	    document.getElementById("out_Type").value = "";
	    document.getElementById("consignment_Gubun").value = "";
	    
	    const tbody = document.getElementById("result-tbody");
	    tbody.innerHTML = "";
	    
	    const emptyRows = 3;
	    for (let i = 0; i < emptyRows; i++) {
	        const tr = document.createElement("tr");
	        tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(20);
	        tr.ondblclick = function() {
	            open_Item();
	        }
	        tbody.appendChild(tr);
	    }
	}
	
	function save() {
	    
	    var out_Complete = document.getElementById("out_Complete").value;
	    
	    if (out_Complete == "Y") {
	        alert("すでに出庫処理済みです。");
	        return;
	    }
	    
	    var formData = {
	        out_Id: document.getElementById("out_Id").value,
	        bu_Id: document.getElementById("bu_Id").value,
	        out_Date: document.getElementById("out_Daet").value,
	        local_Flag: document.getElementById("local_Flag").value,
	        party_Id: document.getElementById("party_Id").value,
	        contact_Id: document.getElementById("contact_Id").value,
	        out_Type: document.getElementById("out_Type").value,
	        consignment_Gubun: document.getElementById("consignment_Gubun").value
	    }
	   
	    $.ajax({
	        url: '/InvFlowConfig/outbound_save',
	        type: 'POST',
	        data: formData,
	        success: function(result) {
	            save_Detail1(result);
	        },
	        error: function(xhr, status, error) {
	            console.error("保存に失敗しました:", error);
	        }
	    });
	}
	
	function save_Detail1(out_Id) {
	    
	    var tbody = document.getElementById("result-tbody");
	
	    var allData = Array.from(tbody.rows)
	        .filter(function(tr) {
	            var firstValue = tr.cells[0].textContent.trim();
	            return firstValue !== null && firstValue !== "";
	        })
	        .map(function(tr) {
	            var rowData = Array.from(tr.cells).map(function(td) {
	                var checkbox = td.querySelector('input[type="checkbox"]');
	                if (checkbox) {
	                    return checkbox.checked ? "Y" : "N";
	                } else {
	                    return td.textContent.trim();
	                }
	            });
	
	            rowData.unshift(out_Id);
	            rowData.unshift(document.getElementById("bu_Id").value); 
	            rowData.unshift(document.getElementById("party_Id").value);
	
	            return rowData;
	        });
	    
	    $.ajax({
	        url: '/InvFlowConfig/outbound_save_detail',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(allData), 
	        success: function(result) {
	            alert("保存されました。");
	            document.getElementById("out_Id").value = out_Id;
	            
	            var formData = {
	                bu_Id: document.getElementById("bu_Id").value,
	                out_Id: out_Id
	            }
	            
	            $.ajax({
	                url: '/InvFlowConfig/out_detail_list',
	                data: formData,
	                type: 'GET',
	                dataType: 'json',
	                success: function(result) {
	                    
	                    const tbody = document.getElementById("result-tbody");
	                    tbody.innerHTML = ""; 
	                    
	                    const totalRows = result.length + 3; 
	                    
	                    result.forEach(function(board) {
	                        const tr = document.createElement("tr");
	                        tr.innerHTML = 
	                            '<td class="text-center">' + (board.item_Id || '') + '</td>' +
	                            '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                            '<td class="text-center">' + (board.spec || '') + '</td>' +
	                            '<td class="text-center">' + (board.party_Id || '') + '</td>' +
	                            '<td class="text-center">' + (board.party_Name || '') + '</td>' +
	                            '<td class="text-center"><span contenteditable="true">' + (board.qty || '') + '</span></td>' +
	                            '<td class="text-center">' + (board.sales_Unit || '') + '</td>' +
	                            '<td class="text-center"><span contenteditable="true">' + (board.unit_Price || '') + '</span></td>' +
	                            '<td class="text-center"><input type="checkbox"' + (board.surtax_Yn === 'Y' ? ' checked' : '') + '></td>' +
	                            '<td class="text-center">' + (board.sales_Price || '') + '</td>' +
	                            '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                            '<td class="text-center">' + (board.sales_Price_Sum || '') + '</td>' +
	                            '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                            '<td class="text-center">' + (board.unit_Price || '') + '</td>' +
	                            '<td class="text-center"><input type="hidden" value="' + (board.storage_Location || '') + '" /><span>' + (board.wareHouse_Name || '') + '</span></td>' +
	                            '<td class="text-center">' + (board.lot_No || '') + '</td>' +
	                            '<td class="text-center">' + (board.other_Out_Code || '') + '</td>' +
	                            '<td class="text-center"><input type="checkbox"' + (board.is_Charge_Supply === 'Y' ? ' checked' : '') + '></td>' +
	                            '<td class="text-center">' + (board.asset_Class || '') + '</td>' +
	                            '<td class="text-center">' + (board.asset_Proc_Type || '') + '</td>' +
	                            '<td class="text-center">' + (board.current_Qty || '') + '</td>';
	                            
	                        tr.ondblclick = function() {
	                            open_Item();
	                        }
	                            
	                        tbody.appendChild(tr);
	                    });
	                    
	                    const emptyRows = totalRows - result.length;
	                    for (let i = 0; i < emptyRows; i++) {
	                        const tr = document.createElement("tr");
	                        tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(20);
	                        tr.ondblclick = function() {
	                            open_Item();
	                        }
	                        tbody.appendChild(tr);
	                    }
	                }
	            }); 
	        },
	        error: function(xhr, status, error) {
	            console.error("保存に失敗しました:", error);
	        }
	    });
	}
	
	function outBound_delete() {
	    
	    var out_Complete = document.getElementById("out_Complete").value;
	    
	    if (out_Complete == "Y") {
	        alert("すでに出庫処理済みです。");
	        return;
	    }
	    
	    if (confirm('削除しますか？')) {
	        
	        var formData = {
	            bu_Id: document.getElementById("bu_Id").value,
	            out_Id: document.getElementById("out_Id").value
	        }
	            
	        $.ajax({
	            url: '/InvFlowConfig/outBound_delete',
	            data: formData,
	            type: 'GET',
	            dataType: 'text',
	            success: function(result) {
	                
	                document.getElementById("bu_Id").value = "";
	                document.getElementById("out_Daet").value = "";
	                document.getElementById("out_Id").value = "";
	                document.getElementById("local_Flag").value = "";
	                document.getElementById("party_Name").value = "";
	                document.getElementById("party_Id").value = "";
	                document.getElementById("contact_Name").value = "";
	                document.getElementById("department").value = "";
	                document.getElementById("out_Type").value = "";
	                document.getElementById("consignment_Gubun").value = "";
	                
	                const tbody = document.getElementById("result-tbody");
	                tbody.innerHTML = "";
	                
	                alert("削除されました。");
	            },
	            error: function(xhr, status, error) {
	                console.error("削除に失敗しました:", error);
	            }
	        }); 
	    }
	}
	
	function outBound_Update() {
	    
	    var out_Complete = document.getElementById("out_Complete").value;
	    
	    var formData = {
	        bu_Id: document.getElementById("bu_Id").value,
	        out_Id: document.getElementById("out_Id").value
	    }
	    
	    if (out_Complete == "N") {
	        if (confirm('出庫しますか？')) {
	            
	            $.ajax({
	                url: '/InvFlowConfig/outBound_update',
	                data: formData,
	                type: 'POST',
	                dataType: 'text',
	                success: function(result) {
	                    document.getElementById("out_Complete").value = "Y";
	                    alert("処理されました。");
	                },
	                error: function(xhr, status, error) {
	                    console.error("処理に失敗しました:", error);
	                }
	            }); 
	        }
	    } else {
	        if (confirm('取消しますか？')) {
	            $.ajax({
	                url: '/InvFlowConfig/outBound_update',
	                data: formData,
	                type: 'POST',
	                dataType: 'text',
	                success: function(result) {
	                    document.getElementById("out_Complete").value = "N";
	                    alert("処理されました。");
	                },
	                error: function(xhr, status, error) {
	                    console.error("処理に失敗しました:", error);
	                }
	            }); 
	        }
	    }       
	}

	function out_Master_Popup() {
		
		var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
		window.open(
			"../popup/out_id_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function out_Id_RowData(data) {
		
		document.getElementById("bu_Id").value = data[1];
		document.getElementById("out_Daet").value = data[3];
		document.getElementById("out_Id").value = data[2];
		document.getElementById("local_Flag").value = data[5];
		document.getElementById("party_Name").value = data[6];
		document.getElementById("party_Id").value = data[7];
		document.getElementById("contact_Name").value = data[8];
		document.getElementById("contact_Id").value = data[9];
		document.getElementById("department").value = data[10];
		document.getElementById("out_Type").value = data[12];
		document.getElementById("consignment_Gubun").value = data[14];
		document.getElementById("out_Complete").value = data[15];
		
		var formData = {
			bu_Id: data[1],
			out_Id: data[2]
		}
		
		$.ajax({
			url: '/InvFlowConfig/out_detail_list',
			data: formData,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				
				const tbody = document.getElementById("result-tbody");
	            tbody.innerHTML = "";
	            
	            const totalRows = result.length + 3;
	            
	            result.forEach(function(board) {
	            	const tr = document.createElement("tr");
	
	                tr.innerHTML = 
	                    '<td class="text-center">' + (board.item_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.item_Name || '') + '</td>' +
	                    '<td class="text-center">' + (board.spec || '') + '</td>' +
	                    '<td class="text-center">' + (board.party_Id || '') + '</td>' +
	                    '<td class="text-center">' + (board.party_Name || '') + '</td>' +
	                    '<td class="text-center"><span contenteditable="true">' + (board.qty || '') + '</span></td>' +
	                    '<td class="text-center">' + (board.sales_Unit || '') + '</td>' +
	                    '<td class="text-center"><span contenteditable="true">' + (board.unit_Price || '') + '</span></td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.surtax_Yn === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center">' + (board.sales_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.sales_Price_Sum || '') + '</td>' +
	                    '<td class="text-center">' + (board.surtax_Price || '') + '</td>' +
	                    '<td class="text-center">' + (board.unit_Price || '') + '</td>' +
	                    '<td class="text-center"><input type="hidden" value="' + (board.storage_Location || '') + '" /><span>' + (board.wareHouse_Name || '') + '</span></td>' +
	                    '<td class="text-center">' + (board.lot_No || '') + '</td>' +
	                    '<td class="text-center">' + (board.other_Out_Code || '') + '</td>' +
	                    '<td class="text-center"><input type="checkbox"' + (board.is_Charge_Supply === 'Y' ? ' checked' : '') + '></td>' +
	                    '<td class="text-center">' + (board.asset_Class || '') + '</td>' +
	                    '<td class="text-center">' + (board.asset_Proc_Type || '') + '</td>' +
	                    '<td class="text-center">' + (board.current_Qty || '') + '</td>';
	                    
                    tr.ondblclick = function() {
                    	open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            });
	            
	            const emptyRows = totalRows - result.length;
	            for (let i = 0; i < emptyRows; i++) {
	                const tr = document.createElement("tr");
	                tr.innerHTML = '<td class="text-center">&nbsp;</td>'.repeat(20);
	                tr.ondblclick = function() {
                   		open_Item();
                    }
	                    
	                tbody.appendChild(tr);
	            }
			}
		});	
	}
	
	function party_Popup() {
		
	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
		window.open(
			"../popup/party_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function party_RowData(data) {
		document.getElementById("party_Name").value = data[3];
		document.getElementById("party_Id").value = data[2];
	}
	
	function contact_Popup() {
		
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
		document.getElementById("contact_Id").value = data[0];
		document.getElementById("contact_Name").value = data[1];
		document.getElementById("department").value = data[2];
	}
	
	function currency_Popup() {
		
	   	var popupWidth = 900;
 	   	var popupHeight = 600;
 	
 	   	var left = (screen.width - popupWidth) / 2;
 	   	var top = (screen.height - popupHeight) / 2;
 	
		window.open(
			"../popup/currency_popup",
 	     	"popupWindow",
 	     	"width=" + popupWidth +
 	     	",height=" + popupHeight +
 	     	",left=" + left +
 	     	",top=" + top +
 	     	",scrollbars=no,resizable=yes"
 	   	);
	}
	
	function currency_RowData(data) {
		document.getElementById("currency_Code").value = data[0];
 		document.getElementById("exchange_Rate").value = data[1];
 		
 		var tbody = document.getElementById("result-tbody");
 		
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
 	    
 	    var total = 0;
 	    var total_tax = 0;
 	    
 		for (var i = 0; i < allData.length; i++) {
 			total += Number(allData[i][9]);
 			total_tax += Number(allData[i][11]);
 		}
 		
 		var total_Sum = total + total_tax;
 		
		var total_Exchange = total / data[1];
		var total_Exchange_Tax = total_tax / data[1];
		var total2 = total_Exchange + total_Exchange_Tax;
		
 		document.getElementById("total").value = total_Exchange.toFixed(2);
 		document.getElementById("total_Tax").value = total_Exchange_Tax.toFixed(2);
 		document.getElementById("total_Sum").value = total2.toFixed(2);
 	
 		document.getElementById("total_Krw").value = total;
 		document.getElementById("total_Krw_Tax").value = total_tax;
 		document.getElementById("total_Krw_Sum").value = total_Sum;
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
	    
 		var tbody = document.getElementById("result-tbody");
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
 
		var newData = [data[0], data[1], data[2], '', '', '0', data[5], '0', 'N', '0', '0', '0', data[5], data[9], data[10], '', '', 'N', '', '', '0'];
 	   
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
               '<td class="text-center">' + (board[4] || '') + '</td>' +
               '<td class="text-center"><span contenteditable="true">' + (board[5] || '') + '</span></td>' +
               '<td class="text-center">' + (board[6] || '') + '</td>' +
               '<td class="text-center"><span contenteditable="true">' + (board[7] || '') + '</span></td>' +
               '<td class="text-center"><input type="checkbox"' + (board[8] === 'Y' ? ' checked' : '') + '></td>' +
               '<td class="text-center">' + (board[9] || '') + '</td>' +
               '<td class="text-center">' + (board[10] || '') + '</td>' +
               '<td class="text-center">' + (board[11] || '') + '</td>' +
               '<td class="text-center">' + (board[12] || '') + '</td>' +
               '<td class="text-center">' + (board[13] || '') + '</td>' +
               '<td class="text-center"><input type="hidden" value="' + (board[15] || '') + '" /><span>' + (board[14] || '') + '</span></td>' +
               '<td class="text-center">' + (board[16] || '') + '</td>' +
               '<td class="text-center"><input type="checkbox"' + (board[17] === 'Y' ? ' checked' : '') + '></td>' +
               '<td class="text-center">' + (board[18] || '') + '</td>' +
               '<td class="text-center">' + (board[19] || '') + '</td>' +
               '<td class="text-center">' + (board[20] || '') + '</td>';
               
            tr.ondblclick = function() {
				open_Item();
           	}
               
           	tbody.appendChild(tr);
       });
       
       const emptyRows = totalRows - allData.length;
       for (let i = 0; i < emptyRows; i++) {
           	const tr = document.createElement("tr");
           	tr.innerHTML = 
               '<td class="text-center">&nbsp;</td>'.repeat(20);
			tr.ondblclick = function() {
   				open_Item();
   			}
            tbody.appendChild(tr);
       }
	}
	
</script>