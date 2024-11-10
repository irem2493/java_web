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
	<form action="boardManager" action="post">
		<input type="hidden" name="mode" value="bupd2"/>
		제목 : <input type="text" name="title" value="${param.title }"/>
		내용 : <input type="text" name="contents" value="${param.contents }"/>
		작성자 : <input type="text" name="contents" value="${userId }" readonly/>
		<span>작성일 : ${param.createDate }</span>
		<input type="submit" value="게시글 수정"/>
	</form>
	<script>
		//이전 값 저장
	</script>
</body>
</html>