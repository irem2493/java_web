<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="header.jsp" %> 
	<h2>회원가입</h2>
	<hr>
	<form action="login" method="post">
		<input type='hidden' name='mode' value='reg' id='mode'> 
		ID : <input type="text" name="id" id="id"> <button type="button" onclick="checkID()">ID 중복확인</button><br>
		<div id="check"></div><br>
		PW : <input type="password" name="pw" id="pw"><br><br>
		<input type="submit" value="회원등록">
	</form>
	<script>
	  const id = document.getElementById('id');
	  const mode = document.getElementById('mode');
		function checkID() {
		  const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
		    document.getElementById("check").innerHTML = this.responseText;
		  }
		  xhttp.open("GET", "login?id="+id.value+"&mode="+mode.value);
		  xhttp.send();
		}
		
		
	</script>
	<%
     
	boolean joinYN;
      if(request.getAttribute("joinYN") != null){
    	  joinYN = (boolean)request.getAttribute("joinYN");
     		 if(joinYN){

     %>
     	<script>
	      	alert("회원등록이 성공적으로 등록되었습니다!");
	      	location.href='index.jsp';
	      </script>
      <%} }%> 
</body>
</html>