<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="css/style.css"></link>
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
		type:"get",
		dataType:'json',
		success: function(data){
			console.log(data);
			data.gyeongnamculturallist.body.items.item.forEach((item)=>{
				var fileurl1 = item.fileurl1 || 'img/no_img.jpg';
				var fileurl2 = item.fileurl2 || 'img/no_img.jpg';
				var fileurl3 = item.fileurl3 || 'img/no_img.jpg';
				var dogijungNo = item.DOJIJUNG_NO || item.MYONGCHING;
				var myongChing = item.MYONGCHING || '등록된 이름 없음';
				var myongChingHannum = item.MYONGCHING_HANMUN || '등록된 한문명 없음';
				var content = item.CONTENT || '등록된 설명 없음';
				var jijungDate = item.JIJUNG_DATE || '등록된 날짜 없음';
				var utmkX = item.UTMK_X;
				var utmkY = item.UTMK_Y;
				
				var row = '<tr>'+
				 '<td><img style="width:200px; height:150px;" src="'+fileurl1+'" alt="Image1"/></td>'+
				    '<td><a href="detail?dogijungNo=' + dogijungNo + 
				    		'&myongChing=' + myongChing + 
				    		'&myongChingHannum=' + myongChingHannum + 
				    		'&content=' + content + 
				    		'&jijungDate=' + jijungDate + 
				    		'&fileurl1=' + fileurl1 + 
				    		'&fileurl2=' + fileurl2 + 
				    		'&fileurl3=' + fileurl3 + 
				    		'&utmkX=' + utmkX + 
				    		'&utmkY=' + utmkY + 
				    		'">' 
				    		+ dogijungNo + '</a></td>'+
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