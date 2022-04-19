<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// notice_write.jsp에서 받아온 데이터를 BoardBean 객체에 저장
BoardBean boardBean = new BoardBean();
boardBean.setName(request.getParameter("name"));
boardBean.setPass(request.getParameter("pass"));
boardBean.setSubject(request.getParameter("subject"));
boardBean.setContent(request.getParameter("content"));

// BoardDAO 객체 생성
// 받아온 데이터가 들어간 BoardBean 객체를 insert하는 insertBoard() 메서드 호출
// 파라미터 : boardBean / 리턴타입 : int(insertCount)
BoardDAO boardDAO = new BoardDAO();
int insertCount = boardDAO.insertBoard(boardBean);

// insert 작업 성공 시 글 목록(notice.jsp)로 돌아감
// 			   실패 시 "글쓰기 실패" 출력 후, 이전 페이지로 이동
if(insertCount > 0) {
	response.sendRedirect("notice.jsp");
} else {
%>
	<script>
		alert("글쓰기 실패");
		history.back();
	</script>
	<%
}
%>
