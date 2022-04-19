<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// URL 파라미터로 받아온 데이터 저장
String num = request.getParameter("num");
String pageNum = request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study/study_delete.jsp</title>
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
		<div id="sub_img"><img src="../images/company/sub_back_r.png"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="study_search.jsp">Study Search</a></li>
				<li><a href="study_write.jsp">Study Write</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Study Delete</h1>
			<form action="study_deletePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="page" value="<%=pageNum%>">
				<table id="notice">
					<tr>
						<th>패스워드</th>
						<td><input type="password" name="pass"  required="required"></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글삭제" class="btn">
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