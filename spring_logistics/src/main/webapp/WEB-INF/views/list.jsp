<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고별 재고 조회</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background: #f2f2f2;
        }
        .criteria {
            margin-bottom: 15px;
        }
        .criteria label {
            margin-right: 15px;
        }
    </style>
</head>
<body>

<h2>창고별 재고 조회</h2>

<!-- ✅ 조회 기준 선택 -->
<form action="<c:url value='/list'/>" method="get" class="criteria">
    <label>
        <input type="checkbox" name="chkAsset" value="Y"
               <c:if test="${chkAsset}">checked</c:if> />
        자산재고
    </label>

    <label>
        <input type="checkbox" name="chkAvailable" value="Y"
               <c:if test="${chkAvailable}">checked</c:if> />
        가용재고
    </label>

    <label>
        <input type="checkbox" name="chkActual" value="Y"
               <c:if test="${chkActual}">checked</c:if> />
        실재고
    </label>

    <button type="submit">조회</button>
</form>

<!-- ✅ 조회 결과 테이블 -->
<table>
    <thead>
        <tr>
            <th>창고 ID</th>
            <th>창고명</th>
            <th>재고수량</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="wh" items="${warehouseList}">
            <tr>
                <td>${wh.warehouseId}</td>
                <td>${wh.warehouseName}</td>
                <td>${wh.qty}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty warehouseList}">
            <tr>
                <td colspan="3">조회 결과가 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

</body>
</html>
