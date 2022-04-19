<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// hidden 속성으로 받아온 page와 num 저장
String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));

// notice_update.jsp에서 받아온 데이터를 BoardBean 객체에 저장
BoardBean boardBean = new BoardBean();
boardBean.setNum(num);
boardBean.setName(request.getParameter("name"));
boardBean.setPass(request.getParameter("pass"));
boardBean.setSubject(request.getParameter("subject"));
boardBean.setContent(request.getParameter("content"));

// 받아온 데이터로 글을 수정하는 updateBoard() 메서드 호출
// 파라미터 : boardBean / 리턴타입 : int (updateCount)
BoardDAO boardDAO = new BoardDAO();
int updateCount = boardDAO.updateBoard(boardBean);

//update 작업 성공 시 글 내용(notice_content.jsp)로 돌아감 (num과 page 같이 보냄)
// 실패 시 "글 수정 실패" 출력 후, 이전 페이지로 이동
if(updateCount > 0) {
	response.sendRedirect("notice_content.jsp?num=" + num + "&page=" + pageNum);
} else {
%>
	<script>
		alert("글 수정 실패!");
		history.back();
	</script>
	<%
}
%>