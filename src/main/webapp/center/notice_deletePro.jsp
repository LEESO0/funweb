<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// hidden 속성으로 받아온 데이터(num, page)와, 폼 파라미터 데이터(pass)를 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");
String pass = request.getParameter("pass");

// 글 번호에 해당하는 게시물의 비밀번호가 일치할 경우 게시물을 삭제하는 deleteBoard() 메서드 호출
// 파라미터 : num, pass / 리턴타입 : int(deleteCount)
BoardDAO boardDAO = new BoardDAO();
int deleteCount = boardDAO.deleteBoard(num, pass);

// 글 삭제 성공 시 글 목록(notice.jsp)로 이동 (페이지 수도 같이 넘김)
//		   실패 시 "삭제 실패" 출력 후, 이전 페이지로 이동
if(deleteCount > 0) {
	response.sendRedirect("notice.jsp?page=" + pageNum);
} else {
%>
	<script>
		alert("삭제 실패!");
		history.back();
	</script>
	<%
}
%>
