 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function () {
		$("*").css("fontFamily","Times New Roman");
		$(".company_hr").css("width","900px");
		$(".text").css({
			margin:"10px 0",
			textAlign:"center",
			width:"971px"
		});
		$("div h1").css("margin","30px");
		$("div i").css({
			fontSize:"40px",
		});
		$("div p").css("margin", "30px");
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
		<div id="company_img"><div id="company_text">Welcome to STUDY</div>
			<img src="../images/company/company_img.jpg">
		</div>
		<!-- 본문 내용 -->
		<div class="text">
			<img src="../images/company/company_text.PNG"><br>
			<h1><i>"5가지 타입을 선택해 원하는 스터디를 찾으세요!"</i></h1>
			<hr class="company_hr">
			<p>
				비/대면 방식, 스터디분야, 장소, 시간 등을 선택할 수 있으며,
				인원 수와 벌금 등의 조건은 스터디 소개를 통해 홍보할 수 있습니다!
			</p>
		</div>
			<img src="../images/company/company_img2.png"><br>
		<div class="text">
			<h1><i>"다양한 사람들과 함께 목표를 이뤄보세요!"</i></h1>
			<hr class="company_hr">
			<p>
				혼자서는 어려운 공부, 사람들과 함께 어려움을 해쳐나갈 수 있습니다!<br>
				스터디를 통해 마음에 맞는 친구도 만들어 봅시다!
			</p>
		</div>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


