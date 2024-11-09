<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>  
	<h2>게시판</h2>
	<hr>
	<%
		if(userId != null){
	%>
	<button type="button" onclick="goBoard()">게시글 작성하기</button>
	<%} %>
	
	<h3>게시글 목록</h3>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록날짜</th>
			</tr>
		</thead>
		<tbody id='boardList'>
			
		</tbody>
	</table>
	<script>
	
	$.ajax({
	    url: "boardManage", 
	    type: "get",
	    dataType: "json",
	    success: function(data) {
	    	console.log(data);
	    	if(data.length > 0){
	         data.forEach((d)=>{
		        	 var bno = d.bno;
		        	 var title = d.title;
		        	 var contents = d.contents;
		        	 var uid = d.uid;
		        	 var createDate = d.createDate;
		        	 
		        	 var row = '<tr>'+
					 	'<td>'+bno+'</td>'+
					    '<td><a href="reply?bno='+bno+
					    		'&title='+title+
					    		'&contents='+contents+
					    		'&uid='+uid+
					    		'&createDate='+createDate+
					    		'">'+title+'</a></td>'+
					    '<td>'+uid+'</td>'+
					    '<td>'+createDate+'</td>'+
					    '</tr>';
					$('#boardList').append(row);
	         	})// 데이터를 성공적으로 받아오면 출력
	    	}else{
	    		 var row = '<tr><td colspan="4">등록된 게시물이 없습니다.</td></tr>';
	    		 $('#boardList').append(row);
	    		
	    	}
	    },
	    error: function(xhr, status, error) {
	        console.error("AJAX 요청 실패:", status, error);  // 오류 발생 시 상태와 오류 출력
	    }
	});
		function goBoard(){
			location.href="boardReg.jsp";
		}
		
	</script>
</body>
</html>