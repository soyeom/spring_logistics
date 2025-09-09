<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기타출고입력</title>
</head>
<body>
    <h1>기타출고 입력</h1>
    <form:form modelAttribute="outRequestDTO" action="/out/create" method="post">
        <label>출고일:</label><form:input path="outDate" /><br/>
        <table>
            <thead>
                <tr>
                    <th>품번</th>
                    <th>품명</th>
                    <th>수량</th>
                    </tr>
            </thead>
            <tbody>
                </tbody>
        </table>
        
        <button type="submit">저장</button>
    </form:form>
</body>
</html>