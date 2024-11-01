<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	int custno = Integer.parseInt(request.getParameter("custno"));
	MemberDao mDao = new MemberDao();
	Member m = mDao.showMember(custno);
	request.setAttribute("m", m);
%>
	<%@include file="header.jsp" %>
	<div id='wrapper'>
	<h2>홈쇼핑 회원 수정</h2>
	<div>
		<form action="manager" method="post" id='modForm'>
			<input type='hidden' name='mode' value='mod'>
			<table border="1">
				<thead>
					<tr>
						<th>회원번호(자동발생)</th>
						<td><input type='text' name='custno' value="${ param.custno}" readonly="readonly"></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>회원성명</th>
						<td><input type='text' name='custname' id='custname' value="${m.custname }"></td>
					</tr>
					<tr>
						<th>회원전화</th>
						<td><input type='text' name='phone' id='phone' value="${m.phone }"></td>
					</tr>
					<tr>
						<th>회원주소</th>
						<td><input type='text' name='address' id='address' value="${m.address }"></td>
					</tr>
					<tr>
						<th>가입일자</th>
						<td><input type='date' name='joindate' id='joindate' value="${m.joindate }"></td>
					</tr>
					<tr>
						<th>고객등급[A:VIP,B:일반,C:직원]</th>
						<td>
							<select name='grade'>
							<c:choose>
							<c:when test="${m.grade eq 'A'}">
								<option value='A' selected>A(VIP)</option>
								<option value='B' >B(일반)</option>
								<option value='C' >C(직원)</option>
							</c:when>
							<c:when test="${m.grade eq 'B'}">
								<option value='A' >A(VIP)</option>
								<option value='B' selected>B(일반)</option>
								<option value='C' >C(직원)</option>
							</c:when>
							<c:otherwise>
								<option value='A' >A(VIP)</option>
								<option value='B' >B(일반)</option>
								<option value='C' selected>C(직원)</option>
							</c:otherwise>
							</c:choose>
							</select>
						</td>
					</tr>
					<tr>
						<th>도시코드</th>
						<td><input type='text' name='city' id='city' value="${m.city }"></td>
					</tr>
					<tr>
						<th></th>
						<td>
							<input type='button' name='mod' value='수정' id='mod'>
							<input type='button' name='sel' value='조회' id='sel' onclick="location.href='memberSel.jsp'">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	<script>
		 const m_custname = document.querySelector('#custname');
	     const m_phone = document.querySelector('#phone');
	     const m_address = document.querySelector('#address');
	     
	     //date, grade 유효성 검사 해야함
	      const m_joindate = document.getElementById('joindate');
	      const m_selectedDate = new Date(m_joindate.value);
	      const today = new Date();
	      
		  const m_city = document.querySelector('#city');
	      const modForm = document.getElementById('modForm');
	      const m_grade = document.querySelector('select[name="grade"]');
	      const m_gradeValue = m_grade.value;
	      
	      
	      const custname = m_custname.value;
	      const phone = m_phone.value;
	      const address = m_address.value;
	      const joindate = m_joindate.value;
	      const grade = m_gradeValue;
	      const city = m_city.value;
	      
	      
	      document.getElementById('mod').addEventListener('click', function(e){
	    	  console.log('Mod button clicked'); // Debug line
	         e.preventDefault();
	         if(m_custname.value === '') {
	        	 m_custname.value = custname;
	         }
	         else if(m_phone.value === '') {
	        	 m_phone = phone;
	         }else if(m_address.value === ''){
	        	 m_address.value = address;
	         }
	         
	         //날짜
	         // 날짜가 선택되지 않았을 경우
	         if (!m_joindate.value) {
	        	 m_joindate.value = joindate;
	         }
	
	         // 선택된 날짜가 오늘보다 이전인 경우
	         if (m_joindate.value > today) {
	             alert("미래 날짜는 선택할 수 없습니다.");
	             joindate.focus();
	         }
	         
	         else if(m_city.value ===''){
	        	 m_city.value = city;
	         }
	         else{
	        	 modForm.submit();
	        	 
	        	//회원수정 테이블에 반영된 다음 alert창이 떠야 한다.
	        	 alert("회원수정이 완료되었습니다!");
	         }
	      });
	  </script>
	  
	   <%
      boolean modYN;
      if(request.getAttribute("modYN") != null){
    	  modYN = (boolean)request.getAttribute("modYN");
     		 if(modYN){

     %>
     	<script>
	      	alert("회원 정보가 성공적으로 등록되었습니다!");
	      </script>
      <%}
      }%> 
</body>
</html>