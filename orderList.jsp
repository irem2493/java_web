<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dto.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	OrderDao oDao = new OrderDao();
	List<Order> oList = oDao.selectOrders();
	pageContext.setAttribute("oList", oList);
%>
	<%@include file="header.jsp" %>
	<section>
	<div id='wrapper'>
	<h2>주문목록</h2>
		<table border="1">
			<thead>
			<tr>
				<th>할인점코드</th>
				<th>점포명</th>
				<th>주문번호</th>
				<th>주문일자</th>
				<th>제품코드</th>
				<th>제품명</th>
				<th>주문수량</th>
				<th>단가</th>
				<th>소비자가격</th>
				<th>할인가격</th>
			</tr>
			</thead>
			<tbody>
				
					<c:forEach var="o" items="${oList }">
					<tr>
						<td>${o.shopno }</td>
						<td>${o.shopname }</td>
						<c:set var="originalOrder" value="${o.orderno }" />
						<c:set var="orderno1" value="${fn:substring(originalOrder, 0, 4)}" />
						<c:set var="orderno2" value="${fn:substring(originalOrder, 4, 8)}" />
						<td>${orderno1 }-${orderno2}</td>
						
						<c:set var="originalOrderdate" value="${o.orderdate }" />
						<c:set var="orderdate1" value="${fn:substring(originalOrderdate, 0, 4)}" />
						<c:set var="orderdate2" value="${fn:substring(originalOrderdate, 4, 6)}" />
						<c:set var="orderdate3" value="${fn:substring(originalOrderdate, 6, 8)}" />
						<td>${orderdate1 }-${orderdate2}-${orderdate3}</td>
						<td>${o.pcode }</td>
						<td>${o.pname }</td>
						<td>${o.amount }</td>
						<fmt:formatNumber value="${o.pcost }" groupingUsed="true" var="pcost"/>
						<td>${pcost }</td>
						<fmt:formatNumber value="${o.custprice }" groupingUsed="true" var="custprice"/>
						<td>${custprice }</td>
						<fmt:formatNumber value="${o.disPrice }" groupingUsed="true" var="disPrice"/>
						<td>${disPrice }</td>
				</tr>
					</c:forEach>
			</tbody>
		</table>
	</div>
	</section>
	<%@include file="footer.jsp" %>
</body>
</html>