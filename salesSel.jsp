<%@page import="java.util.List"%>
<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		MemberDao mDao = new MemberDao();
		List<Member> mList = mDao.showSales();
		request.setAttribute("mList", mList);
	
	%>
	<%@include file="header.jsp" %>
	<div id='wrapper'>
		<h2>회원 매출 조회</h2>
		<div>
			<table border="1">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="m" items="${mList }">
				<tr><td>${m.custno }</td>
					<td>${m.custname }</td>
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
					<fmt:formatNumber value="${m.sal }" groupingUsed="true" var="sals"/>
					<td>${sals }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		</div>
	</div>
</body>
</html>