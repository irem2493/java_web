<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
	
	<%
	boolean loginYN;
	String userId = (String)session.getAttribute("userId");
      if(session.getAttribute("loginYN") != null){
    	  loginYN = (boolean)session.getAttribute("loginYN");
    	  System.out.println(loginYN);
     		 if(loginYN){
			
     %>
     <h2><%=userId %>님, 환영합니다.</h2>
     	<ul>
            <li><a href="logout.jsp">로그아웃</a></li>
            <li><a href="index.jsp">메인으로 이동</a></li>
        </ul>
     <%} }else{ 
     %>
     <ul>
		<li><a href="join.jsp">회원가입</a></li>
		<li><a href="login.jsp">로그인</a></li>
		<li><a href="index.jsp">메인으로 이동</a></li>
	</ul>
	<%} %>
	
</header>
</body>
</html>