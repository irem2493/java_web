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
	<hr>
	<div>
		<form action="boardManage" method="post">
		<input type="hidden" type="text" name="mode" value="breg">
			제목 : <input type="text" name="btitle">
			내용 : <input type="text" name="bcontent">
			<input type="submit" value="게시글등록">
		</form>
	</div>
	<%
     
	int bresult;
      if(request.getAttribute("bresult") != null){
    	  bresult = (int)request.getAttribute("bresult");
     		 if(bresult > 0){

     %>
     	<script>
	      	alert("게시글이 성공적으로 등록되었습니다!");
	      	location.href='index.jsp';
	      </script>
      <%}
      }%> 
</body>
</html>