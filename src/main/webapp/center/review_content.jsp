<%@page import="news.NewsBean"%>
<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// URL을 통해 받아온 num 값과 page 값 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// 글목록 클릭 시 조회수가 증가하는 updateReadCount() 메서드 호출
// 리턴타입 : 없음 / 파라미터 : num
NewsDAO dao = new NewsDAO();
dao.updateReadCount(num);
// 조회수 증가 메서드 호출이 레코드 출력 메서드보다 먼저와야함!

// NewsDAO 객체의 selectNews() 메서드를 호출해서
// num에 해당하는 레코드를 출력
// 파라미터 : num / 리턴타입 : NewsBean (news)
NewsBean news = dao.selectNews(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/review_content.jsp</title>
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
			<h1>Review Content</h1>
			<table id="notice">
				<tr>
					<th>글번호</th>
					<td><%=news.getNum() %></td>
					<th>글쓴이</th>
					<td><%=news.getName() %></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=news.getDate() %></td>
					<th>조회수</th>
					<td><%=news.getReadcount() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=news.getSubject()%></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=news.getContent() %></td>
				</tr>
			</table>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='review_update.jsp?num=<%=num %>&page=<%=pageNum %>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='review_delete.jsp?num=<%=num %>&page=<%=pageNum %>'">
				<input type="button" value="글목록" class="btn" onclick="location.href='review.jsp?page=<%=pageNum %>'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>