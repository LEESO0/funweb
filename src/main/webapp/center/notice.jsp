<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// ---------------------- 페이징 처리 -------------------------------
int pageNum = 1;	// 현재 페이지 번호를 저장할 변수 선언 : 기본값 1 설정

// 현재 페이지 번호가 저장된 page 파라미터에서 값을 가져와서 pageNum 변수에 저장
// => 단, page 파라미터가 존재할 경우에만 가져오기
if(request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page")); 
}
int listLimit = 10;// 한 페이지 당 표시할 목록(게시물) 갯수
int pageLimit = 10;// 한 페이지에서 표시할 페이지 갯수

BoardDAO boardDAO = new BoardDAO();
int listCount = boardDAO.selectListCount();

// 페이징 처리를 위한 계산 작업
// 1. 현재 페이지에서 표시할 전체 페이지 수 계산
// => 총 게시물 수 / 페이지 당 표시할 게시물 수 + 0.9
// int maxPage = (int)((double)listCount / listLimit + 0.9);
int maxPage = (int)Math.ceil((double)listCount / listLimit);

// 2. 현재 페이지에서 보여줄 시작 페이지 번호 계산(1, 11, 21 ,,)
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

// 3. 현재 페이지에서 보여줄 끝 페이지 번호 계산(10, 20, 30 ,,)
int endPage = startPage + pageLimit - 1;

// 4. 만약, 끝 페이지가 현재 페이지에서 표시할 최대 페이지 수보다 클 경우
//    끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
	endPage = maxPage;
}

// -------------------------------------------------------------------
// BoardDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회 작업 요청
// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit)
//    리턴타입 : ArrayList<BoardBean>(boardList)
ArrayList<BoardBean> boardList = boardDAO.selectBoardList(pageNum, listLimit);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
			<h1>Notice</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<!-- 반복문을 사용하여 ArrayList 객체만큼 반복하면서 -->
				<!-- ArrayList 객체 내의 BoardBean 객체를 꺼내서 저장한 후 -->
				<!-- 각 레코드를 tr 태그의 td 태그에 출력하기 -->
				<%
				// 1. ArrayList 크기만큼 일반 for문으로 반복하여 BoardBean 꺼내기 (형변환 필요 -> 지금은 제네릭타입을 써서 필요 x)
// 				for(int i = 0; i < boardList.size(); i++) {
// 					boardBean boardBean = boardList.get(i);
				// 2. 향상된 for문을 사용하여 반복 과정에서 즉시 BoardBean 꺼내기
				// 단점 : 특정 구간만 반복 불가
				for(BoardBean boardBean : boardList) {
				%>
					<tr onclick="location.href='notice_content.jsp?num=<%=boardBean.getNum()%>&page=<%=pageNum %>'">
						<td><%=boardBean.getNum() %></td>
						<td class="left"><%=boardBean.getSubject() %></td>
						<td><%=boardBean.getName() %></td>
						<td><%=boardBean.getDate() %></td>
						<td><%=boardBean.getReadcount() %></td>
					</tr>
				<%} %>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'">
			</div>
			<div id="table_search">
				<form action="notice_search.jsp" method="get">
					<select name="selectSearch">
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<!-- 페이징 처리 -->
			<div class="clear"></div>
			<div id="page_control">
				<!-- 
				현재 페이지 번호(pageNum)이 1보다 클 경우에만 Prev 링크 동작
				=> 클릭 시 현재 페이지번호 - 1 값을 page 파라미터로 전달
				 -->
			 	<%if(pageNum > 1) { // 이전 페이지가 존재할 경우%>
			 		<a href="notice.jsp?page=<%=pageNum-1 %>">Prev</a>
			 	<%} else { // 이전페이지가 존재하지 않을 경우%>
					Prev&nbsp;
			 	<%} %>
			 	<!-- 페이지 번호 목록은 시작페이지(startPage)부터 끝 페이지(endPage) -->
			 	<%for(int i = startPage; i <= endPage; i++) { %>
			 	<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;[<%=i %>]&nbsp;&nbsp;
					<%} else { %>
						<a href="notice.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				<!-- 
				현재 페이지 번호(pageNum)이 끝 페이지 번호보다 작을 때만 Next 링크 동작
				=> 클릭 시 현재 페이지번호 + 1 값을 page 파라미터로 전달
				 -->
				<%if(pageNum < maxPage) {	// 다음 페이지가 존재할 경우%>
					<a href="notice.jsp?page=<%=pageNum + 1 %>">Next</a>
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