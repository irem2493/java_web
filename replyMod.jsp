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
<h2>게시글 내용 수정하기</h2>
<hr>
<div>
	<form action="reply" method="post">
		<input type="hidden" name="mode" value="modRp"/>
		<input type="hidden" name="bno" value="${param.bno }"/>
		<input type="hidden" name="title" value="${param.title }"/>
		<input type="hidden" name="contents" value="${param.contents }"/>
		<input type="hidden" name="createDate" value="${param.createDate }"/>
		<input type="hidden" name="rno" value="${param.rno }"/>
		작성자 : <input type="text" name="uid" value="${param.uid }" readonly/>
		댓글 내용 : <input type="text" name="rcontents" value="${param.rcontents }"/>
		<input type="submit" value="댓글 수정"/>
	</form>
</div>
</body>
</html>