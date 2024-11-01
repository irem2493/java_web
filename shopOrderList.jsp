<%@page import="dto.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	OrderDao oDao = new OrderDao();
	List<Order> sList = oDao.selectShopOrders();
	pageContext.setAttribute("sList", sList);
%>
	<%@include file="header.jsp" %>
	<section>
	<div id='wrapper'>
	<h2>점포별 주문 목록</h2>
		<table border="1">
			<thead>
			<tr>
				<th>할인점코드</th>
				<th>제품코드</th>
				<th>제품명</th>
				<th>주문총수량</th>
			</tr>
			</thead>
			<tbody>
				
					<c:forEach var="s" items="${sList }">
					<tr>
						<td>${s.shopno }</td>
						<td>${s.pcode }</td>
						<td>${s.pname }</td>
						<td>${s.amount }</td>
				</tr>
					</c:forEach>
			</tbody>
		</table>
	</div>
	</section>
	<%@include file="footer.jsp" %>
</body>
</html>