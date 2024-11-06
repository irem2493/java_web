<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %> 
	<h2>게시글 내용보기</h2>
	<hr>
	<div>
		제목 : ${param.title }
		내용 : ${param.contents }
		<%
			
		String uid = request.getParameter("uid");
		if(userId != null && userId.equals(uid)){//게시글 작성자와 같을 때 버튼 띄우기(현재는 아님)
		%>
		<button onclick="updateBoard()">수정</button>
		<button onclick="deleteBoard()">삭제</button>
		<%} %>
	</div>
	<%
		if(userId != null){		
	%>
	<div>
		
		<p>[댓글달기]</p>
		<form action='reply' method='post'>
			<input type='hidden' name='mode' value='regRp'>
			<input type='hidden' name='bno' value=${param.bno }>
			<input type='hidden' name='title' value=${param.title }>
			<input type='hidden' name='contents' value=${param.contents }>
			작성자 : <input type="text" name="uid" value=${userId } readonly><br>
			댓글 내용 : <input type="text" name="rcontents">
			<input type="submit" value="댓글달기">
		</form>
	</div>
	<%} %>
	<h3>댓글 목록</h3>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>댓글 내용</th>
				<th>작성 날짜</th>
			</tr>
		</thead>
		<tbody id='replyList'>
			
		</tbody>
	</table>
	
	<%
     
	int bresult;
      if(request.getAttribute("presult") != null){
    	  bresult = (int)request.getAttribute("presult");
     		 if(bresult > 0){

     %>
     	<script>
	      	alert("댓글이 성공적으로 등록되었습니다!");
	      	 location.href = 'replyReg.jsp?bno=' + ${param.bno} +
             '&title=' + encodeURIComponent("${param.title}") +
             '&contents=' + encodeURIComponent("${param.contents}") +
             '&uid=' + encodeURIComponent("${param.uid}");
	      </script>
      <%}
      }%> 
      
      <script>
      $.ajax({
  	    url: "showReply", 
  	    type: "get",
  	    data: {bno : '${param.bno.split("t")[0]}'},
  	    dataType: "json",
  	    success: function(data) {
  	    	console.log(data);
  	         data.forEach((p)=>{
  	        	 var rno = p.rno;
  	        	 var uid = p.uid;
  	        	 var rcontents = p.rcontents;
  	        	 var rCreateDate = p.r_create_date;
  	        	 
  	        	 var row = '<tr>'+
  	        		'<td>'+rno+'</td>'+
  				    '<td>'+uid+'</td>'+
  				  	'<td>'+rcontents+'</td>'+
  				    '<td>'+rCreateDate+'</td>'+
  				    '</tr>';
  				$('#replyList').append(row);
  	        	 
  	        	 
  	         })// 데이터를 성공적으로 받아오면 출력
  	    },
  	    error: function(xhr, status, error) {
  	        console.error("AJAX 요청 실패:", status, error);  // 오류 발생 시 상태와 오류 출력
  	    }
  	});
      
      
      function deleteBoard(){
    	  
      }
      </script>
</body>
</html>