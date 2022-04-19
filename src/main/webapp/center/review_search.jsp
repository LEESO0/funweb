<%@page import="news.NewsDAO"%>
<%@page import="news.NewsBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// 폼 파라미터 검색어(keyword)와 검색타입(searchType) 저장
String keyword = request.getParameter("keyword");
String searchType = request.getParameter("searchType");

// 현재 페이지 값 저장 변수 선언
// 페이지의 초기값 1
int pageNum = 1;

// 현재 페이지가 저장된 page 파라미터를 가져와서 pageNum에 저장
// page 파라미터 존재할 경우에만 저장
if(request.getParameter("page") != null){
	pageNum = Integer.parseInt(request.getParameter("page"));
}

int listLimit = 10;	// 한 페이지에 표시할 목록 갯수
int pageLimit = 10;	// 한 페이지에 표시할 페이지 갯수


// NewsDAO 객체 생성 후 전체 페이지 계산하는 selectSearchNewsListCount() 메서드 호출
// 검색타입(searchType) 설정했을 때 검색어(keyword)를 포함하는 경우
// 파라미터 : keyword, searchType / 리턴타입 : int(listCount)
NewsDAO dao = new NewsDAO();
int listCount = dao.selectSearchNewsListCount(keyword, searchType);

// 현재 페이지에서 표시할 전체 페이지 수 계산
int maxPage = (int)Math.ceil((double)listCount / listLimit);

// 시작페이지 계산
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

// 끝페이지 계산
int endPage = startPage + pageLimit - 1;

//4. 만약, 끝 페이지가 현재 페이지에서 표시할 최대 페이지 수보다 클 경우
//끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
endPage = maxPage;
}

// NewsDAO 객체의 selectSearchNewsList() 메서드 호출
// 검색타입(searchType) 설정했을 때 검색어(keyword)를 포함하는 경우
// 리턴타입 : ArrayList<NewsBean>(newsList) / 파라미터 : pageNum, listLimit, keyword, searchType
ArrayList<NewsBean> newsList = dao.selectSearchNewsList(pageNum, listLimit, keyword, searchType);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/review_search.jsp</title>
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
			<h1>Review</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>	
				<%
				for(NewsBean bean : newsList) {
				%>			
					<tr onclick="location.href='review_content.jsp?num=<%=bean.getNum() %>&page=<%=pageNum %>'">
						<td><%=bean.getNum() %></td>
						<td class="left"><%=bean.getSubject() %></td>
						<td><%=bean.getName() %></td>
						<td><%=bean.getDate() %></td>
						<td><%=bean.getReadcount() %></td>
					</tr>
				<%} %>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='review_write.jsp'">
			</div>
			<div id="table_search">
				<form action="review_search.jsp" method="get">
					<select name="searchType">
						<option value="subject" <%if(searchType.equals("subject")) {%> selected="selected" <%} %>>제목</option>
						<option value="name" <%if(searchType.equals("name")) {%> selected="selected" <%} %>>작성자</option>
						<option value="name OR subject" <%if(searchType.equals("name OR subject")) {%> selected="selected" <%} %>>제목 + 작성자</option>
					</select>
					<input type="text" name="keyword" class="input_box" value="<%=keyword %>">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
				<!-- 
				현재 페이지 번호(pageNum)이 1보다 클 경우에만 Prev 링크 동작
				=> 클릭 시 현재 페이지번호 - 1 값을 page 파라미터로 전달
				 -->
				<%if(pageNum > 1) {%>
					<a href="review.jsp?page=<%=pageNum-1 %>">Prev</a>
				<%} else { %>
					Prev&nbsp;				
				<%} %>
				
				<!-- 페이지 번호 목록은 시작페이지(startPage)부터 끝 페이지(endPage) -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;[<%=i %>]&nbsp;&nbsp;
					<%} else { %>
						<a href="review.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				
				<!-- 
				현재 페이지 번호(pageNum)이 끝 페이지 번호보다 작을 때만 Next 링크 동작
				=> 클릭 시 현재 페이지번호 + 1 값을 page 파라미터로 전달
				 -->
				<%if(pageNum < maxPage) {	// 다음 페이지가 존재할 경우%>
					<a href="review.jsp?page=<%=pageNum + 1 %>">Next</a>
				<%} else { // 다음 페이지가 존재하지 않을 경우%>
					&nbsp;Next
				<%} %>

			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>