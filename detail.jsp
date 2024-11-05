<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css"></link>
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</head>
<body>
<%
	String dogijungNo = request.getParameter("dogijungNo");
    System.out.println(dogijungNo);
if(!dogijungNo.equals("null")){
%>
	<h2><span>${ param.dogijungNo}</span>의 상세페이지</h2>
<%}else{ %>
	<h2><span>${ param.myongChing}</span>의 상세페이지</h2>
<%
}
%>
<hr>
<button type="button" onclick="loadDoc()">문화재 상세설명 보기</button><br><br>
<div id="demo"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8b376f60014ff4bb03a51d93220acf37"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.7.2/proj4.js"></script>
<script>
//EPSG:5179 (UTMK) 좌표계를 정의합니다.
proj4.defs("EPSG:5179", "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=1 +x_0=1000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs");
function loadDoc() {
	let find = 0;
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function() {
	 const obj = JSON.parse(this.responseText);
	 let bodyArr = [];
	 bodyArr = obj.gyeongnamculturallist.body.items.item;
	 console.log(bodyArr);
	 for(let i = 0; i < bodyArr.length; i++){
		 console.log(bodyArr[i].DOJIJUNG_NO);
		 if(bodyArr[i].DOJIJUNG_NO === '${param.dogijungNo}'){
			 document.getElementById("demo").innerHTML = 
			    	"<p><img src=\""+bodyArr[i].fileurl1+"\" width=\"200px\"></p>"+
			    	"<p>이름 : "+bodyArr[i].MYONGCHING+"</p>"+
			    	"<p>한자명 : "+bodyArr[i].MYONGCHING_HANMUN+"</p>"+
			    	"<p>설명 : "+bodyArr[i].CONTENT+"</p>"+
			    	"<p>등록일자 : "+bodyArr[i].JIJUNG_DATE+"</p>"+
			    	"<p>"+bodyArr[i].ADDRESS1+"</p>"+
			    	"<div id=\"map\" style=\"width:100%;height:350px;\"></div>";
			    	
			    	//console.log(typeof bodyArr[i].UTMK_X);
			    	//console.log(typeof bodyArr[i].UTMK_Y);
			    	kakaoMap(Number(bodyArr[i].UTMK_X), Number(bodyArr[i].UTMK_Y));
			 find++;
			 break;
		 }
	 }
	 if(find === 0){
		 for(let i = 0; i < bodyArr.length; i++){
			 console.log(bodyArr[i].DOJIJUNG_NO);
			 if(bodyArr[i].MYONGCHING === '${param.myongChing}'){
				 document.getElementById("demo").innerHTML = 
				    	"<p><img src=\""+bodyArr[i].fileurl1+"\" width=\"200px\"></p>"+
				    	"<p>이름 : "+bodyArr[i].MYONGCHING+"</p>"+
				    	"<p>한자명 : "+bodyArr[i].MYONGCHING_HANMUN+"</p>"+
				    	"<p>설명 : "+bodyArr[i].CONTENT+"</p>"+
				    	"<p>등록일자 : "+bodyArr[i].JIJUNG_DATE+"</p>"+
				    	"<p>"+bodyArr[i].ADDRESS1+"</p>"+
				    	"<div id=\"map\" style=\"width:100%;height:350px;\"></div>";
				    	kakaoMap(Number(bodyArr[i].UTMK_X), Number(bodyArr[i].UTMK_Y));
				 break;
			 }
		 }
	 }
  }
  xhttp.open("GET", "api");
  xhttp.send();
}
function utmkToLatLng(utmkX, utmkY) {
    // UTMK (EPSG:5179) 좌표계를 WGS84 (EPSG:4326)로 변환
    var proj4 = window.proj4;
    var utmk = proj4('EPSG:5179', 'EPSG:4326', [utmkX, utmkY]);
    return { lat: utmk[1], lng: utmk[0] };  // 변환된 위도와 경도 반환
  }
function kakaoMap(utmkX, utmkY){
	 var utmk = utmkToLatLng(utmkX, utmkY);
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	
	
	
    mapOption = { 
        center: new kakao.maps.LatLng(utmk.lat, utmk.lng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(utmk.lat, utmk.lng); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);
	

}
</script>
</body>
</html>