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
		작성자 : ${ param.uid }
		작성일 : ${param.createDate }
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
			<input type='hidden' name='createDate' value=${param.createDate }>
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
				<%
					if(userId != null && userId.equals(uid)){
				%>
				<th>수정</th>
				<th>삭제</th>
				<%} %>
			</tr>
		</thead>
		<tbody id='replyList'>
			
		</tbody>
	</table>
	
	<%
     
	int presult;
      if(request.getAttribute("presult") != null){
    	  presult = (int)request.getAttribute("presult");
     		 if(presult > 0){

     %>
     	<script>
	      	alert("댓글이 성공적으로 등록되었습니다!");
	      	 location.href = 'replyReg.jsp?bno=' + ${param.bno} +
             '&title=' + encodeURIComponent("${param.title}") +
             '&contents=' + encodeURIComponent("${param.contents}") +
             '&uid=' + encodeURIComponent("${param.uid}")+
             '&createDate='+encodeURIComponent("${param.createDate}");
	      </script>
      <%}
      }%> 
      
      <script>
      var userId = '<%=userId%>';
      var bno = '${param.bno.split("t")[0]}';
      var title = '${param.title}';
      var contents = '${param.contents}';
      var createDate = '${param.createDate}';
      $.ajax({
  	    url: "showReply", 
  	    type: "get",
  	    data: {bno : '${param.bno.split("t")[0]}',
  	    	titile : '${param.title}',
  	    	contents: '${param.contents}',
  	    	createdate : '${param.createDate }'},
  	    dataType: "json",
  	  success: function(data) {
          // 댓글 데이터가 있을 경우
          if (Array.isArray(data) && data.length > 0) {
              data.forEach((p) => {
                  var rno = p.rno;
                  var uid = p.uid;
                  var rcontents = p.rcontents;
                  var rCreateDate = p.r_create_date;

                  var row = '<tr>' +
                      '<td>' + rno + '</td>' +
                      '<td>' + uid + '</td>' +
                      '<td>' + rcontents + '</td>' +
                      '<td>' + rCreateDate + '</td>';

                  // 로그인한 사용자와 댓글 작성자가 같을 경우, 수정/삭제 링크 추가
                  if (userId === uid) {
                      row += '<td><a href="showReply?rno=' + rno +
                          '&uid=' + encodeURIComponent(uid) +
                          '&rcontents=' + encodeURIComponent(rcontents) +
                          '&rCreateDate=' + encodeURIComponent(rCreateDate) +
                          '&mode=pmod&bno=' + bno +
                          '&title=' + title + 
                          '&contents=' + contents + 
                          '&createDate=' + createDate + '">댓글수정</a></td>';

                      row += '<td><a href="showReply?rno=' + rno +
                          '&uid=' + encodeURIComponent(uid) +
                          '&rcontents=' + encodeURIComponent(rcontents) +
                          '&rCreateDate=' + encodeURIComponent(rCreateDate) +
                          '&mode=pdel&bno=' + bno + 
                          '&title=' + title + 
                          '&contents=' + contents + 
                          '&createDate=' + createDate + '">댓글삭제</a></td>';
                  }

                  row += '</tr>';
                  $('#replyList').append(row);
              });
          } else {
              // 댓글이 없을 경우
              var row = '<tr><td colspan="6">등록된 댓글이 없습니다.</td></tr>';
              $('#replyList').append(row);
          }
      },
  	    error: function(xhr, status, error) {
  	        console.error("AJAX 요청 실패:", status, error);  // 오류 발생 시 상태와 오류 출력
  	    }
  	});
      
      function deleteBoard(){
    	  $.ajax({
    		  url:"boardManage",
    		  type: "post",
    		  data: {bno : '${param.bno.split("t")[0]}',
    			  	uid : '${userId}',
    			  	mode : 'bdel'
    		  },success: function(data){    
    			    alert("게시글이 삭제되었습니다.");
    			    location.href="index.jsp";
    		    },
    		   error : function (data) {
    		    alert('죄송합니다. 잠시 후 다시 시도해주세요.');
    		    return false;
    		   }
    	  });
      }
      
      
      </script>
      <%
     
	int pdel_result;
      if(request.getAttribute("pdel_result") != null){
    	  pdel_result = (int)request.getAttribute("pdel_result");
     		 if(pdel_result > 0){

     %>
     	<script>
	      	alert("댓글이 삭제되었습니다");
	      	location.href = 'replyReg.jsp?bno=' + ${param.bno} +
            '&title=' + encodeURIComponent("${param.title}") +
            '&contents=' + encodeURIComponent("${param.contents}") +
            '&uid=' + encodeURIComponent("${param.uid}")+
            '&createDate='+encodeURIComponent("${param.createDate}");
	      </script>
      <%}
      }%> 
</body>
</html>