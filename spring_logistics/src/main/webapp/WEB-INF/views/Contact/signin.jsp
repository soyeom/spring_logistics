<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<style>
	.login-box {
    	margin: auto;
        background-color: #fff;
        padding: 40px 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        text-align: center;
        width: 380px;
	}
	
	.login-box h2 {
		margin-bottom: 20px;
        color: #333;
	}
	
	.login-box select,
	.login-box input[type="text"],
	.login-box input[type="password"] {
	    width: 240px;             /* 전체 너비 */
	    height: 36px;            /* 높이 맞추기 */
	    padding: 10px;           /* 안쪽 여백 */
	    font-size: 0.9rem;       /* 글자 크기 */
	    border: 1px solid #ccc;  /* 테두리 통일 */
	    border-radius: 5px;      /* 모서리 둥글게 */
	    box-sizing: border-box;   /* padding 포함해서 크기 계산 */
	    vertical-align: middle;  /* 수직 위치 정렬 */
	}

    .login-box .buttons {
    	margin: 0;
	}

	.login-box button {
    	width: 48%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-size: 0.95rem;
       	cursor: pointer;
	}
	
	.form-group {
		margin-bottom: 15px;
	    display: flex;
	    flex-direction: row; /* 라벨 위, 입력 박스 아래 */
	    flex: 1; /* 동일한 비율로 늘어남 */
	}

	.form-group .label {
		margin: auto;
		width: 80px;
		max-width: 80px;
	    font-weight: bold;
	    font-size: 0.9rem;
	    text-align: left;
	}
	
</style>
<head>
	<meta charset="UTF-8">
    <title>회원가입 - 팜스프링 ERP</title>
    <link rel="stylesheet" href="/resources/css/logistics.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class = "layout">
		<%@ include file="/WEB-INF/views/logistics.jsp" %>
		<div class = "main">
			<div class="main-header">
		        <div class="btn btn-secondary btn-icon toggle-sidebar">≡</div>
	            <div></div>
	            <div></div>
	        </div>
	        <div class="login-box">
			    <h2>회원가입</h2>
		    	<div class = "form-group">
		    		<div class = "label">사업단위</div>
			    	<div>
				    	<select id = "bu_Id" name = "bu_Id">
							<option value = ""></option>
						    <c:forEach items="${bu_Id}" var="buItem">
						        <option value="${buItem.value}">${buItem.text}</option>
						    </c:forEach>
						</select>
					</div>
				</div>
			    <div class="form-group">
			    	<div class = "label">아이디</div>
			        <input type="text" id="username" name="username">
			    </div>
				<div class="form-group">
					<div class = "label">패스워드</div>
			        <input type="password" id="password" name="password">
			    </div>
			    <div class="form-group">
			    	<div class = "label">이름</div>
			        <input type="text" id="name" name="name">
			    </div>
			    <div class="form-group">
			    	<div class = "label">부서</div>
			        <input type="text" id="department" name="department">
			    </div>
			    <div class="form-group">
			    	<div class = "label">연락처</div>
			        <input type="text" id="phone" name="phone">
			    </div>
			    <div class="form-group">
			    	<div class = "label">핸드폰</div>
			        <input type="text" id="mobile" name="mobile">
			    </div>
			    <div class="form-group">
			    	<div class = "label">이메일</div>
			        <input type="text" id="email" name="email">
			    </div>
		        <div class="buttons">
		            <button type="button" class="btn btn-secondary" onclick="signin()">회원가입</button>
		        </div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="../resources/js/logistics.js"></script>
</body>
</html>

<script>

	function signin() {
		
		var bu_Id = document.getElementById("bu_Id").value.trim();
	    var contact_Id = document.getElementById("username").value.trim();
	    var password = document.getElementById("password").value.trim();
	    var contact_Name = document.getElementById("name").value.trim();
	    
		// ✅ 필수값 검증
	    if (!bu_Id) {
	        alert("사업단위를 입력해주세요.");
	        document.getElementById("bu_Id").focus();
	        return;
	    }
	    if (!contact_Id) {
	        alert("아이디를 입력해주세요.");
	        document.getElementById("username").focus();
	        return;
	    }
	    if (!password) {
	        alert("비밀번호를 입력해주세요.");
	        document.getElementById("password").focus();
	        return;
	    }
	    if (!contact_Name) {
	        alert("이름 입력해주세요.");
	        document.getElementById("name").focus();
	        return;
	    }
		
		var formData = {
			bu_Id: document.getElementById("bu_Id").value,
			contact_Id: document.getElementById("username").value,
			password: document.getElementById("password").value,
			contact_Name: document.getElementById("name").value,
			department: document.getElementById("department").value,
			phone: document.getElementById("phone").value,
			mobile: document.getElementById("mobile").value,
			email: document.getElementById("email").value
		}
		
	    $.ajax({
	        url: '/Contact/save',
	        type: 'POST',
	        data: formData,
	        success: function(result) {
	        	if (result == "success") {
	        		alert("회원가입이 완료되었습니다.");
	        		location.href = "/Contact/login";
	        	} else {
	        		alert("이미 등록된 아이디 입니다.");
	        	}
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 실패:", error);
	        }
	    });
	}
</script>