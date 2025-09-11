<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>수주입력</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.css">
    <script src="https://cdn.jsdelivr.net/npm/handsontable/dist/handsontable.full.min.js"></script>

    <style>
        body { font-family: "맑은 고딕", Arial, sans-serif; margin: 20px; }
        h2 { margin-bottom: 15px; }

        .form-section { margin-bottom: 20px; }
        .form-section label { display: inline-block; width: 120px; font-weight: bold; }
        .form-section input, .form-section select {
            padding: 5px; margin-bottom: 8px; width: 200px;
        }

        .toolbar { margin-bottom: 10px; }
        .toolbar button {
            padding: 8px 15px; margin-right: 5px; cursor: pointer;
            border: 1px solid #ccc; border-radius: 4px;
            background: #f5f5f5;
        }
        .grid { width: 100%; height: 400px; }
    </style>
</head>
<body>
    <h2>수주입력</h2>

    <!-- ✅ 수주 마스터 입력 -->
    <div class="form-section">
        <label>사업단위</label>
        <select name="buId">
            <option value="1">본사</option>
            <option value="2">지사</option>
        </select>
        <br/>

        <label>수주일자</label>
        <input type="date" name="orderDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"/>
        <br/>

        <label>Local구분</label>
        <select name="localFlag">
            <option value="내수">내수</option>
            <option value="수출">수출</option>
        </select>
        <br/>

        <label>거래처</label>
        <input type="text" name="partyName" placeholder="거래처 선택"/>
        <br/>

        <label>담당자</label>
        <input type="text" name="contactName" placeholder="담당자 선택"/>
    </div>

    <!-- ✅ 버튼 -->
    <div class="toolbar">
        <button onclick="saveOrder()">저장</button>
        <button onclick="location.reload()">조회</button>
        <button onclick="goPurchaseRequest()">구매요청</button>
        <button onclick="goProductionRequest()">생산의뢰</button>
        <button onclick="goTransactionSlip()">거래명세서</button>
    </div>

    <!-- ✅ 품목 입력 GRID -->
    <div id="orderGrid" class="grid"></div>

    <script>
        // ✅ Handsontable 기본 설정
        const container = document.getElementById("orderGrid");
        const hot = new Handsontable(container, {
            data: [],
            colHeaders: ["품목코드","품목명","규격","수량","단가","금액","비고"],
            columns: [
                {data:"itemCode"},
                {data:"itemName"},
                {data:"spec"},
                {data:"qty", type:"numeric"},
                {data:"unitPrice", type:"numeric"},
                {data:"amount", type:"numeric", readOnly:true},
                {data:"note"}
            ],
            stretchH: "all",
            rowHeaders: true,
            filters: true,
            dropdownMenu: true,
            licenseKey: "non-commercial-and-evaluation",
            minSpareRows: 5
        });

        // ✅ 저장
        function saveOrder() {
            const master = {
                buId: document.querySelector("[name=buId]").value,
                orderDate: document.querySelector("[name=orderDate]").value,
                localFlag: document.querySelector("[name=localFlag]").value,
                partyName: document.querySelector("[name=partyName]").value,
                contactName: document.querySelector("[name=contactName]").value
            };

            const details = hot.getSourceData().filter(r => r.itemName);

            fetch("/order/save", {
                method: "POST",
                headers: {"Content-Type":"application/json"},
                body: JSON.stringify({ master, details })
            })
            .then(res => alert("저장 완료"))
            .catch(err => alert("저장 실패: " + err));
        }

        // ✅ 구매요청 이동
        function goPurchaseRequest() {
            window.location.href = "/order/purchaseRequest";
        }

        // ✅ 생산의뢰 이동
        function goProductionRequest() {
            window.location.href = "/order/productionRequest";
        }

        // ✅ 거래명세서 이동
        function goTransactionSlip() {
            const orderId = 1; // TODO: 실제 저장된 orderId 바인딩 필요
            window.location.href = "/order/transactionSlip?orderId=" + orderId;
        }
    </script>
</body>
</html>
