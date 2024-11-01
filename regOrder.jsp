<%@page import="dao.OrderDao"%>
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
	<%@include file="header.jsp" %>
	<%
	OrderDao oDao = new OrderDao();
	int num = oDao.returnNum();
	int orderno = 0;
	String snum = String.valueOf(num);
	if(snum == null){
		num = 1;
		orderno = Integer.parseInt("1"+(String.format("%05d",num)));
	}else orderno = Integer.parseInt(String.format("%05d",++num));
	request.setAttribute("orderno", orderno);

	%>
	<section>
	<div id="wrapper">
	<h2>주문 등록</h2>
	<div>
		<form action="manager" method="post" id='regForm'>
			<input type='hidden' name='mode' value='reg'>
			<table border="1">
				<thead>
					<tr>
						<th>주문번호</th>
						<td><input type='text' name='orderno' id='orderno' value='${orderno }' readonly></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>주문점포</th>
						<td>
							<select name="shopno" id='shopno'>
								<option value='' disabled selected>점포 선택</option>
								<option value="S001">AA할인점</option>
								<option value="S002">BB할인점</option>
								<option value="S003">CC할인점</option>
								<option value="S004">DD할인점</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>주문일자</th>
						<td>
							<c:set var="now" value="<%= new java.util.Date() %>"></c:set>
							<fmt:formatDate value="${now}" pattern="YYYYMMdd" var="formattedDate"/>
							<input type='text' name='orderdate' id='orderdate' value="${formattedDate }" readonly>
						</td>
					</tr>
					<tr>
						<th>제품코드</th>
						<td>
							<select name="pcode" id='pcode'>
								<option value='' disabled selected>코드선택</option>
								<option value="AA01">삼각김밥</option>
								<option value="AA02">도시락</option>
								<option value="AA03">봉지만두</option>	
								<option value="AA04">컵라면</option>
								<option value="AA05">아메리카노</option>
								<option value="AA06">콜라</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>주문수량</th>
						<td>
							
							<input type='number' name='amount' id='amount' >
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input type='button' name='reg' value='주문등록' id='reg'>
							<input type='reset' name='sel' value='다시쓰기' id='reReg'>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	</section>
	<script>
	 const orderno = document.querySelector('#orderno');
	 
	 //유효성 검사 되지 않음
	 const shopno = document.querySelector('select[name="shopno"]');
	 
     const orderdate = document.querySelector('#orderdate');
     
   //유효성 검사 되지 않음
     const pcode = document.querySelector('select[name="pcode"]');
   
     const amount = document.querySelector('#amount');
     document.getElementById('reg').addEventListener('click', function(e){
         e.preventDefault();
         if(orderno.value === '') {
             alert('주문번호를 입력해주세요');
             orderno.focus();
         }
         else if(shopno.value === '') {
             alert('주문점포를 입력해주세요');
             shopno.focus();
         }else if(orderdate.value === ''){
             alert('주문일자를 입력해주세요');
             orderdate.focus();
         }else if(pcode.value ===''){
        	 alert('주문코드를 입력해주세요');
        	 pcode.focus();
         }else if(amount.value ===''){
        	 alert('주문수량을 입력해주세요');
        	 amount.focus();
         }
         else{
        	 regForm.submit();
         }
     });
     
    
     
	</script>
	<%
      boolean regYN;
      if(request.getAttribute("regYN") != null){
     		 regYN = (boolean)request.getAttribute("regYN");
     		 if(regYN){

     %>
     	<script>
	      	alert("주문 정보가 성공적으로 등록되었습니다!");
	      	location.href='index.jsp';
	      </script>
      <%}
      }%> 
	<%@include file="footer.jsp" %>
</body>
</html>