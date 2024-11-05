<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8b376f60014ff4bb03a51d93220acf37"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.7.2/proj4.js"></script>
<link rel="stylesheet" href="css/style.css"></link>
<style>
	  body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            text-align: center;
        }

        .gallery {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px; /* 그림과 설명 사이의 간격 */
        }

        .image-container {
            position: relative;
            width: 200px;
            height: 200px;
            overflow: hidden;
            border-radius: 10px;
            /* 이미지 컨테이너에서 커버되게 설정 */
            transition: transform 0.3s ease; /* 컨테이너 자체에 transition을 적용 */
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease; /* 이미지에 부드러운 확대 효과 추가 */
        }

        .image-container:hover img {
             transform: scale(1.2); /* 이미지 컨테이너 자체가 확대 */
        }

        .description {
            font-size: 16px;
            color: #333;
            line-height: 1.5;
            background: white;
            border:1px solid #333;
            border-radius: 10px;
            padding:20px;
        }
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
</style>
</head>
<body>
<h2>${param.myongChing} 문화재 상세페이지</h2>
	<hr>
	<div class="container">
    <!-- 사진 갤러리 -->
    <div class="gallery">
        <div class="image-container">
            <img src="${param.fileurl1 }" alt="사진 1">
        </div>
        <div class="image-container">
            <img src="${param.fileurl2 }" alt="사진 2">
        </div>
        <div class="image-container">
            <img src="${param.fileurl3 }" alt="사진 3">
        </div>
    </div>
	<div style="text-align: center; padding:20px;">
		등록날짜 : ${param.jijungDate}
	</div>
    <!-- 사진 설명 -->
    <div class="description">
        <p>${param.content }</p>
    </div><br><br>
    <div id="map" style="width:100%;height:350px;"></div><br><br>
    <div><a href="index.jsp">문화재 목록으로 이동하기</a></div>
</div>
<script>
// EPSG:5179 (UTMK) 좌표계를 정의합니다.
proj4.defs("EPSG:5179", "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=1 +x_0=1000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs");

// 페이지 로드 시 카카오맵을 초기화합니다.
window.onload = function() {
    var utmkX = Number('${param.utmkX}');  // UTMK X 좌표
    var utmkY = Number('${param.utmkY}');  // UTMK Y 좌표
    kakaoMap(utmkX, utmkY);  // 카카오맵 초기화
};

// UTMK 좌표를 WGS84 좌표로 변환하는 함수
function utmkToLatLng(utmkX, utmkY) {
    var proj4 = window.proj4;
    var utmk = proj4('EPSG:5179', 'EPSG:4326', [utmkX, utmkY]);
    return { lat: utmk[1], lng: utmk[0] };  // 변환된 위도와 경도 반환
}

// 카카오맵에 마커를 표시하는 함수
let overlay;

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}
function kakaoMap(utmkX, utmkY) {
    var utmk = utmkToLatLng(utmkX, utmkY);  // UTMK -> WGS84 변환
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = { 
            center: new kakao.maps.LatLng(utmk.lat, utmk.lng), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다.

    // 마커가 표시될 위치입니다.
    var markerPosition = new kakao.maps.LatLng(utmk.lat, utmk.lng);

    // 마커를 생성합니다.
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

 // 커스텀 오버레이에 표시할 컨텐츠 입니다
 // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
 // 별도의 이벤트 메소드를 제공하지 않습니다 
 var content = '<div class="wrap">' + 
             '    <div class="info">' + 
             '        <div class="title">' + 
             '            ${param.myongChing}' + 
             '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
             '        </div>' + 
             '        <div class="body">' + 
             '            <div class="img">' +
             '                <img src="${param.fileurl1}" width="73" height="70">' +
             '           </div>' + 
             '            <div class="desc">' + 
             '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +    
             '            </div>' + 
             '        </div>' + 
             '    </div>' +    
             '</div>';

 // 마커 위에 커스텀오버레이를 표시합니다
 // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
 overlay = new kakao.maps.CustomOverlay({
     content: content,
     map: map,
     position: marker.getPosition()       
 });

 // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
 kakao.maps.event.addListener(marker, 'click', function() {
     overlay.setMap(map);
 });


}
</script>
</body>
</html>