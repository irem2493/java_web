<%@page import="dao.MemberDao"%>
<%@page import="dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		MemberDao mDao = new MemberDao();
		int num = mDao.returnNum();
		int custno = 0;
		String snum = String.valueOf(num);
		if(snum == null){
			num = 1;
			custno = Integer.parseInt("1"+(String.format("%05d",num)));
		}else custno = Integer.parseInt(String.format("%05d",++num));
		request.setAttribute("custno", custno);
	%>
	<div id='wrapper'>
	<h2>홈쇼핑 회원 등록</h2>
	<div>
		<form action="manager" method="post" id='regForm'>
			<input type='hidden' name='mode' value='reg'>
			<table border="1">
				<thead>
					<tr>
						<th>회원번호(자동발생)</th>
						<td><input type='text' name='custno' value="${ custno}"></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>회원성명</th>
						<td><input type='text' name='custname' id='custname' ></td>
					</tr>
					<tr>
						<th>회원전화</th>
						<td><input type='text' name='phone' id='phone'></td>
					</tr>
					<tr>
						<th>회원주소</th>
						<td><input type='text' name='address' id='address'></td>
					</tr>
					<tr>
						<th>가입일자</th>
						<td>
							<c:set var="now" value="<%= new java.util.Date() %>"></c:set>
							<fmt:formatDate value="${now}" pattern="YYYY-MM-dd" var="formattedDate"/>
							<input type='date' name='joindate' id='joindate' value="${formattedDate }">
						</td>
					</tr>
					<tr>
						<th>고객등급[A:VIP,B:일반,C:직원]</th>
						<td>
							<select name='grade'>
								<option value='A' >A(VIP)</option>
								<option value='B'>B(일반)</option>
								<option value='C'>C(직원)</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>도시코드</th>
						<td><input type='text' name='city' id='city'></td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input type='button' name='reg' value='등록' id='reg'>
							<input type='button' name='sel' value='조회' id='sel' onclick="location.href='memberSel.jsp'">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	<script>
	 const custname = document.querySelector('#custname');
     const phone = document.querySelector('#phone');
     const address = document.querySelector('#address');
     
     //date, grade 유효성 검사 해야함
      const joindate = document.getElementById('joindate');
      const selectedDate = new Date(joindate.value);
      const today = new Date();
      
      const grade = document.querySelector('#grade');
	  const city = document.querySelector('#city');
      const regForm = document.getElementById('regForm');
      document.getElementById('reg').addEventListener('click', function(e){
         e.preventDefault();
         if(custname.value === '') {
             alert('이름을 입력해주세요');
             custname.focus();
         }
         else if(phone.value === '') {
             alert('전화번호를 입력해주세요');
             phone.focus();
         }else if(address.value === ''){
             alert('주소를 입력해주세요');
             address.focus();
         }
         
         //날짜
         // 날짜가 선택되지 않았을 경우
         if (!joindate.value) {
             alert("날짜를 선택하세요.");
             joindate.focus();
         }

         // 선택된 날짜가 오늘보다 이후인 경우
         if (joindate.value > today) {
             alert("미래 날짜는 선택할 수 없습니다.");
             joindate.focus();
         }
         
         else if(city.value ===''){
        	 alert('도시코드를 입력해주세요');
        	 city.focus();
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
	      	alert("회원 정보가 성공적으로 등록되었습니다!");
	      </script>
      <%}
      }%> 
</body>
</html>