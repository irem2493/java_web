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
	
	<button type="button" onclick="loadDoc()">문화재 목록보기</button><br><br>
	
	<table border="1">
		<thead>
			<tr>
				<th>이미지</th><th>문화재번호</th><th>문화재이름</th>
			</tr>
		</thead>
		<tbody id="demo">
			
		</tbody>
	</table>
	
	<p id="demo"></p>
	<script>
			let i = 0;
		function loadDoc() {
		  const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			 const obj = JSON.parse(this.responseText);
			 let bodyArr = [];
			 bodyArr = obj.gyeongnamculturallist.body.items.item;
			 for(let i=0; i<bodyArr.length;i++){
				 if(bodyArr[i].DOJIJUNG_NO !== null){
					 
			    	document.getElementById("demo").innerHTML += 
			    	"<tr><td><img src=\""+bodyArr[i].fileurl1+"\" width=\"200px\ alt=\""+bodyArr[i].DOJIJUNG_NO+"\"></td><td><a href=\"detail?dojijung_no="+bodyArr[i].DOJIJUNG_NO+"&MYONGCHING="+bodyArr[i].MYONGCHING+"\">"+bodyArr[i].DOJIJUNG_NO+"</a></td><td>"+bodyArr[i].MYONGCHING+"</td></tr>";
				 }else{
					 if(bodyArr[i].fileurl1 !== ''){
						 
						 document.getElementById("demo").innerHTML += 
						    	"<tr><td><img src=\""+bodyArr[i].fileurl1+"\" width=\"200px\" alt=\""+bodyArr[i].MYONGCHING+"\"></td><td><a href=\"detail?dojijung_no="+bodyArr[i].DOJIJUNG_NO+"&MYONGCHING="+bodyArr[i].MYONGCHING+"\">"+bodyArr[i].MYONGCHING+"</a></td><td>"+bodyArr[i].MYONGCHING+"</td></tr>";
					 }else{
						 document.getElementById("demo").innerHTML += 
						    	"<tr><td><img src=\"img/no_img.jpg\" width=\"200px\" alt=\"No Img\"></td><td><a href=\"detail?dojijung_no="+bodyArr[i].DOJIJUNG_NO+"&MYONGCHING="+bodyArr[i].MYONGCHING+"\">"+bodyArr[i].MYONGCHING+"</a></td><td>"+bodyArr[i].MYONGCHING+"</td></tr>";
					 }
					 
				 }
			 }
		    	
		  }
		  xhttp.open("GET", "api");
		  xhttp.send();
	}
	</script>
</body>
</html>