<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/review_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img src="../images/company/sub_back_r.png"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="review.jsp">Review</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Review Write</h1>
			<form action="review_writePro.jsp" method="post">
				<table id="notice">
					<tr>
						<th>글쓴이</th>
						<td><input type="text" name="name" required="required"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="20" name="content" required="required"></textarea></td>
					</tr>

				</table>

				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>