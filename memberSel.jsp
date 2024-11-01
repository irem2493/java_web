<%@page import="dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDao mDao = new MemberDao();
	List<Member> mList = mDao.showMembers();
 	request.setAttribute("mList", mList);
%>
	<%@include file="header.jsp" %>
	<div id='wrapper'>
	<h2>회원목록 조회/수정</h2>
	<table border="1">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>회원전화번호</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="m" items="${mList }">
			<c:set var="grade" value="${m.grade}"/>
				<tr><td><a href="memberUpd.jsp?custno=${m.custno }">${m.custno }</a></td>
					<td>${m.custname }</td>
					<td>${m.phone }</td>
					<td>${m.address }</td>
					<td>${m.joindate }</td>
					<c:choose>
						<c:when test="${m.grade eq 'A'}">
							<td>VIP</td>
						</c:when>
						<c:when test="${m.grade eq 'B'}">
							<td>일반</td>
						</c:when>
						<c:otherwise>
							<td>직원</td>
						</c:otherwise>
					</c:choose>
					<td>${m.city }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</body>
</html>