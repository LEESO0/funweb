<%@page import="org.apache.catalina.filters.RequestDumperFilter"%>
<%@page import="study.StudyBean"%>
<%@page import="study.StudyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// URL 파라미터로 받아온 데이터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

StudyDAO studyDAO = new StudyDAO();

// num에 해당하는 레코드를 출력하는 selectStudy() 메서드 호출
// 리턴타입 : StudyBean / 파라미터 : num
StudyBean studyBean = studyDAO.selectStudy(num);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study/study_content.jsp</title>
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
			<h1>Study Content</h1>
			<table id="notice">
				<tr>
					<th>글번호</th>
					<td><%=num %></td>
					<th>글쓴이</th>
					<td><%=studyBean.getId() %></td>
					<th>좋아요</th>
					<td><%=studyBean.getLikeCount() %></td>
				</tr>
				<tr>
					<td colspan="2"><%=studyBean.getContactType() %></td>
					<td><%=studyBean.getStudyType() %></td>
					<td>주 <%=studyBean.getTimes() %>회</td>
					<td><%=studyBean.getWeek() %></td>
					<td><%=studyBean.getSpace() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5"><%=studyBean.getSubject() %></td>
				</tr>
				<tr>
					<th>소개</th>
					<td colspan="5"><%=studyBean.getIntroduction() %></td>
				</tr>
			</table>
			<!-- 좋아요 이미지 클릭 시 좋아요 수 증가 -->
			<a id="like" href="study_likeCount_update.jsp?num=<%=num%>&page=<%=pageNum%>"><img src="../images/like.png"></a>
			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='study_update.jsp?num=<%=studyBean.getNum()%>&page=<%=pageNum %>'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href='study_delete.jsp?num=<%=studyBean.getNum()%>&page=<%=pageNum %>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='study_search.jsp'">
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

