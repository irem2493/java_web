<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="header.jsp" %>  
	<h2>로그인 페이지</h2>
	<hr>
		<input type='hidden' name='mode' value='login' id='mode'> 
		ID : <input type='text' name='userId' id='userId'>
		PW : <input type='password' name='userPw' id='userPw'>
		<button onclick = "login()">Login</button>
		
		<script>
		function login() {
	        var userId = document.getElementById('userId').value;
	        var userPw = document.getElementById('userPw').value;
			var mode = document.getElementById('mode').value;
	        $.ajax({
	            url: "login",  
	            type: "POST",  
	            data: {
	                userId: userId,
	                userPw: userPw,
	                mode : mode
	            },
	            dataType: "text",  
	            success: function(resData) {
	            	console.log(resData);
	                if (resData === "fail") {
	                    alert("아이디 또는 비밀번호가 잘못되었습니다.");
	                    document.getElementById('userId').value = '';
	                    document.getElementById('userPw').value = '';
	                } else {
	                    window.location.href = "index.jsp";
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX 요청 실패: " + error);
	                alert("로그인 중 오류가 발생했습니다.");
	            }
	        });
	    }
		</script>
</body>
</html>