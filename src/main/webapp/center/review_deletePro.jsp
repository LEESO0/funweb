<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// hidden 속성으로 받아온 파라미터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// 폼 파라미터 저장
String pass = request.getParameter("pass");

// 비밀번호가 일치할 경우 num에 해당하는 레코드를 삭제하는 deleteNews() 메서드 호출
// 리턴타입 : int(deleteCount) / 파라미터 : num, pass
NewsDAO dao = new NewsDAO();
int deleteCount = dao.deleteNews(num, pass);

// 삭제 성공 시 "삭제 성공" 출력 후 review.jsp로 이동
//		실패 시 "삭제 실패" 출력 후 이전페이지로 이동
if(deleteCount > 0) {	// 삭제 성공
	response.sendRedirect("review.jsp?page=" + pageNum);
} else {
%>
	<script>
		alert("삭제 실패");
		history.back();
	</script>
<%} %>
