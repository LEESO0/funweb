<%@page import="news.NewsDAO"%>
<%@page import="news.NewsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// 폼 파라미터 안의 데이터를 변수에 저장
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// NewsBean 객체 생성 후 데이터 저장
NewsBean bean = new NewsBean();
bean.setName(name);
bean.setPass(pass);
bean.setSubject(subject);
bean.setContent(content);

// NewsDAO 객체 생성
// 입력받은 폼 데이터를 news_board 테이블에 insert하는 insertBoard() 메서드 호출
// 파라미터 : NewsBean(bean) , 리턴타입 : int(insertCount)
NewsDAO dao = new NewsDAO();
int insertCount = dao.insertBoard(bean);

// insert 성공 시(insertCount > 0) review.jsp로 이동
// 실패 시 "글쓰기 실패" 띄우고, 이전페이지로 이동
if(insertCount > 0) {
	response.sendRedirect("review.jsp");
} else {
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}
%>