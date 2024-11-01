<%@page import="dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
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
	<%@ include file="header.jsp" %>
	<%
		ProductDao pDao = new ProductDao();
		List<Product> pList = pDao.selectProductCode();
		request.setAttribute("pList", pList);
	%>
	<section>
	<div id='wrapper'>
	<h2>주문목록</h2>
		<table border="1">
			<thead>
			<tr>
				<th>제품코드</th>
				<th>제품명</th>
				<th>단가</th>
				<th>할인율(10%)</th>
				<th>할인율(15%)</th>
			</tr>
			</thead>
			<tbody>
				
					<c:forEach var="p" items="${pList }">
					<tr>
						
						<td>${p.pcode }</td>
						<td>${p.pname }</td>
						<fmt:formatNumber value="${p.cost }" groupingUsed="true" var="cost"/>
						<td>${cost }</td>
						<fmt:formatNumber value="${p.dten }" groupingUsed="true" var="dten"/>
						<td>${dten }</td>
						<fmt:formatNumber value="${p.dfiften }" groupingUsed="true" var="dfiften"/>
						<td>${dfiften }</td>
				</tr>
					</c:forEach>
			</tbody>
		</table>
	</div>
	</section>
	
	<%@ include file="footer.jsp" %>
</body>
</html>