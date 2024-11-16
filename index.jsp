<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<style>
	a{margin-right: 10px;}
</style>
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
	<div class="totalNum">
			<span>전체 게시글 수 : <b><span id="totalBoard"></span></b>개</span>
		</div>
	<table border="1">
		<colgroup>
				<col width="10%" />
				<col width="25%" />
				<col width="15%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성날짜</th>
				</tr>
			</thead>
			<tbody id="tbody" style="text-align: center;">
			
			</tbody>
		</table>
		<div id="pageResult">
		    <div id="pageLinks"></div>  <!-- Pagination links will be added here -->
		</div>
	<script>
	let page=1;		//기본 페이지 번호 설정
	let size = 10;	//기본 페이지 크기 설정
	const totalBoard = document.getElementById('totalBoard');
	const pageResult = document.getElementById('pageResult');
	const tbody = document.getElementById('tbody');
	 const pageLinks = document.getElementById('pageLinks');  // 페이지 번호를 넣을 div
	 function fetchData(page) {
		 tbody.innerHTML = '';  // 테이블 내용 초기화
	 $.ajax({
	    url: "boardManage", 
	    type: "get",
	    data: {
            pageNum: page  // 요청할 페이지 번호 전달
        },
        dataType: "json",  // 서버에서 JSON 형식의 응답을 기대
        success: function(data) {
        	console.log(data);
            const bList = data.bList;  // 게시글 목록
            const pager = data.pager;  // 페이징 정보
            const totalCount = data.totalCount;  // 총 게시글 수

            totalBoard.innerHTML = totalCount;  // 총 게시글 수 출력

            // 테이블 업데이트
            updateTable(bList);

            // 페이지 네비게이션 업데이트
            console.log(page);
            updatePagination(pager, page);  // 현재 페이지를 전달하여 업데이트
        },
        error: function(xhr, status, error) {
            console.error("Error fetching data:", status, error);  // 오류 처리
        }
    });
	 }
	//테이블 내용 업데이트
		function updateTable(bList){
			 bList.forEach(post => {
		            const row = document.createElement('tr');
		            row.innerHTML = `
		                <td>\${post.bno}</td>
		                <td><a href='detail/\${post.bno}'>\${post.title}</a></td>
		                <td>\${post.uid}</td>
		                <td>\${post.createDate}</td>
		            `;

		            tbody.appendChild(row);
		        });
		}
		function updatePagination(pager, currentPage) {
		    pageLinks.innerHTML = '';  // 기존 페이지 링크 초기화
			console.log(pager.prePage);
		    // "이전" 버튼 추가
		    if (currentPage > 1) {
		        const prevLink = document.createElement('a');
		        prevLink.href = "javascript:void(0)";
		        prevLink.textContent = '이전';
		        prevLink.onclick = function() {
		            fetchData(currentPage-1);  // 이전 페이지로 이동
		        };
		        pageLinks.appendChild(prevLink);
		    }

		    // 페이지 번호 링크 추가
		    for (let i = pager.startPage; i <= pager.endPage; i++) {
		        const pageLink = document.createElement('a');
		        pageLink.href = "javascript:void(0)";
		        pageLink.textContent = i;
		        if (i === currentPage) {
		            pageLink.style.fontWeight = 'bold';  // 현재 페이지 강조
		        }
		        pageLink.onclick = function() {
		            fetchData(i);  // 해당 페이지로 이동
		        };
		        pageLinks.appendChild(pageLink);
		    }
		    // "다음" 버튼 추가
		    if (currentPage+1 <= pager.totalPage) {
		        const nextLink = document.createElement('a');
		        nextLink.href = "javascript:void(0)";
		        nextLink.textContent = '다음';
		        nextLink.onclick = function() {
		            fetchData(currentPage+1);  // 다음 페이지로 이동
		        };
		        pageLinks.appendChild(nextLink);
		    }
		}
		
		function goBoard(){
			location.href="boardReg.jsp";
		}
		fetchData(page);
	</script>
</body>
</html>