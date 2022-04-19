<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>contact_us/contact_us.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$("#contact_div").css({
			float:"left",
			margin:"10px 0 0 30px",
			textAlign:"left",
			width:"600px"
		});
		$("#contact_div h1").css({
			fontFamily: "Times New Roman",
			fontSize: "45px",
			margin: "20px"
		});
		
		$("#contact_sub").css({
			float:"right",
			width:"270px",
			margin: "91px 30px 0 0",
			textAlign: "right"
		});
	});
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"><img src="../images/company/sub_back_r.png"></div>

		<!-- 본문 내용 -->
<!-- 		<article> -->
		<div id="contact_div">
			<h1>Contact Us</h1>
<!-- ======================================= 지도 연결 ============================================ -->
			<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=32wnysh2ar"></script>
			<div id="map"></div>
			<script>
			var mapOptions = {
			  center: new naver.maps.LatLng(37.4981125, 127.0379399),
			  zoom: 10
			};
			var map = new naver.maps.Map('map', mapOptions);
			
			$(document).ready(function () {
		        let map = new naver.maps.Map('map', {
		            center: new naver.maps.LatLng(35.228801, 128.889312), 
		            zoom: 15,

		            zoomControl: true,
		            zoomControlOptions: {
		                style: naver.maps.ZoomControlStyle.SMALL,
		                position: naver.maps.Position.TOP_RIGHT
		            }
		        });

		        let marker = new naver.maps.Marker({
		              position: new naver.maps.LatLng(35.228801, 128.889312),
		              map: map,
		        });
			});
			</script>
<!-- ============================================================================================ -->
		</div>
		<div id="contact_sub">
			<h3>tel</h3>
			<hr>
			010.1111.2222<br>
			055.123.1233
			<br>
			<h3>email</h3>
			<hr>
			study@gmail.com
		</div>
<!-- 		</article> -->
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>