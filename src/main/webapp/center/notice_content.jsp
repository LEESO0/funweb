<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// URL 파라미터로 받아온 page와 num 저장
int pageNum = Integer.parseInt(request.getParameter("page"));	// 페이지 번호의 경우 URL 파라미터 전달용이므로 굳이 정수형으로 변환 불필요
int num = Integer.parseInt(request.getParameter("num")); 

BoardDAO boardDAO = new BoardDAO();

// boardDAO 객체의 updateReadCount() 메서드 호출하여 게시물 조회수 증가
// 리턴타입 : 없음 / 파라미터 : num
boardDAO.updateReadCount(num);

// 글 번호에 해당하는 게시물을 나타내기 위해 selectBoard() 메서드 호출
// 리턴타입 : board(BoardBean) / 파라미터 : num
BoardBean board = boardDAO.selectBoard(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<th>글번호</th>
					<td><%=board.getNum() %></td>
					<th>글쓴이</th>
					<td><%=board.getName() %></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=board.getDate() %></td>
					<th>조회수</th>
					<td><%=board.getReadcount() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=board.getSubject() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=board.getContent() %></td>
				</tr>
			</table>
			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='notice_update.jsp?num=<%=num%>&page=<%=pageNum %>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='notice_delete.jsp?num=<%=num%>&page=<%=pageNum %>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?page=<%=pageNum%>'">
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


