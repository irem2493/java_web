<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css"></link>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h2>경남 자주 찾는 문화재</h2>
	<hr>
	<table border="1">
		<thead>
			<tr>
				<th>이미지</th><th>문화재번호</th><th>문화재이름</th>
			</tr>
		</thead>
		<tbody id="demo">
			
		</tbody>
	</table>
	
	<script>
	$.ajax({
		url:"api",
		type:"GET",
		dataType:'json',
		success: function(data){
			console.log(data);
			data.gyeongnamculturallist.body.items.item.forEach((item)=>{
				var fileurl1 = item.fileurl1 || 'img/no_img.jpg';
				var fileurl2 = item.fileurl2 || 'img/no_img.jpg';
				var fileurl3 = item.fileurl3 || 'img/no_img.jpg';
				var dogijungNo = item.DOJIJUNG_NO || item.MYONGCHING;
				var myongChing = item.MYONGCHING;
				
				var row = '<tr>'+
				 '<td><img style="width:200px; height:150px;" src="'+fileurl1+'" alt="Image1"/></td>'+
				    '<td><a href="detail?dogijungNo=' + dogijungNo + '&myongChing=' + myongChing + '">' + dogijungNo + '</a></td>'+
				    '<td>' + myongChing + '</td>'+
				    '</tr>';
				$('#demo').append(row);
			});
			
		},
		error:function(xhr, status, error){
			console.error("AJAX 요청 실패",status,error);
		}
	})
		
	</script>
</body>
</html>