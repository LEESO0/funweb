<%@page import="study.StudyBean"%>
<%@page import="study.StudyDAO"%>
<%@page import="news.NewsBean"%>
<%@page import="news.NewsDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// Best Study List에 좋아요가 높은 순으로 3개의 레코드만 출력하는 selectBestStudyList() 출력
// 리턴타입 : ArrayList<StudyBean> (bestStudyList) / 파라미터 : 없음
StudyDAO studyDAO = new StudyDAO();
ArrayList<StudyBean> bestStudyList = studyDAO.selectBestStudyList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$("#hosting h3 a").css({
			textDecoration : "none",
			color : "#625348"
		});
		$("#hosting h3 a").hover(function() {
			$(this).css("color","orange");
		}, function() {
			$(this).css("color","#625348");
		});
	});
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->
		  
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img src="../images/main_r.png"></div>
		<!-- 본문 내용 -->
		<article id="front">
			<h1>Best Study List</h1>
		  	<div id="solution">
		  	<%
		  	for(StudyBean studyBean : bestStudyList) {
		  	%>
		  		<div id="hosting">
		  			<div>	
		  				<span class="type"><%=studyBean.getContactType() %></span> <span class="type"><%=studyBean.getStudyType() %></span> <span class="type"><%=studyBean.getSpace() %></span> 
						<span class="type"><%=studyBean.getWeek() %></span> <span class="type">주 <%=studyBean.getTimes() %>회</span>
					</div>
		  			<h3><a href="../study/study_content.jsp?num=<%=studyBean.getNum()%>"><%=studyBean.getSubject() %></a></h3>
					<p><%=studyBean.getIntroduction() %></p>
		  		</div>
		  	<%} %>
		  	</div>
		  	<div class="clear"></div>
			<div id="sec_news">
				<h3>Review</h3>
				<table>
					<%
					// NewsDAO 객체의 selectRecentNewsList() 메서드 호출
					// 최근 5개의 public news 게시물 조회
					// 리턴타입 : ArrayList<NewsBean> / 파라미터 : 없음
					NewsDAO newsDAO = new NewsDAO();
					ArrayList<NewsBean> newsList = newsDAO.selectRecentNewsList();
					
					for(NewsBean newsBean : newsList) {
					%>
					<!-- 게시물 행 클릭 시 notice_content.jsp 페이지로 이동(해당 게시물 표시) -->
						<tr>
							<td width="320" class="contxt"><a href="../center/news_content.jsp?num=<%=newsBean.getNum() %>&page=1"><%=newsBean.getSubject() %></a></td>
							<td width="80"><%=newsBean.getName() %></td>
							<td width="80"><%=newsBean.getDate() %></td>
						</tr>
					<%} %>
				</table>
			</div>
			
			<div id="news_notice">
		  		<h3>Notice</h3>
				<table>
					<%
					BoardDAO boardDAO = new BoardDAO();
					ArrayList<BoardBean> boardList = boardDAO.selectRecentBoardList();
					
					for(BoardBean boardBean : boardList) {
					%>
					<!-- 게시물 행 클릭 시 notice_content.jsp 페이지로 이동(해당 게시물 표시) -->
						<tr>
							<td width="320" class="contxt"><a href="../center/notice_content.jsp?num=<%=boardBean.getNum() %>&page=1"><%=boardBean.getSubject() %></a></td>
							<td width="80"><%=boardBean.getName() %></td>
							<td width="80"><%=boardBean.getDate() %></td>
						</tr>
					<%} %>
				</table>
		  	</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<%-- jsp:include 액션태그의 page 속성으로 포함할 페이지 지정 --%>
		<jsp:include page="../inc/bottom.jsp"/>
		<%-- include 디렉티브의 file 속성으로 포함할 페이지 지정 --%>
<%-- 		<%@ include file="../inc/bottom.jsp" %> --%>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>