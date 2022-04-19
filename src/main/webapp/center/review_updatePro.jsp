<%@page import="news.NewsDAO"%>
<%@page import="news.NewsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// hidden 타입으로 받아온 파라미터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// NewsBean 객체를 생성한 후 폼 파라미터로 가져온 데이터 저장
NewsBean bean = new NewsBean();
bean.setNum(num);
bean.setName(request.getParameter("name"));
bean.setPass(request.getParameter("pass"));
bean.setSubject(request.getParameter("subject"));
bean.setContent(request.getParameter("content"));

// NewsDAO 객체를 생성한 후 정보를 update하는 updateNews() 메서드 호출
// 비밀번호가 일치하는 경우에만 update 진행
// 리턴타입 : int(updateCount) / 파라미터 : bean(NewsBean)
NewsDAO dao = new NewsDAO();
int updateCount = dao.updateNews(bean);

// update 성공 시 review_content.jsp로 이동
// 		  실패 시 "수정 실패" 출력 후 이전페이지로 이동
if(updateCount > 0) {	// 수정 성공
	response.sendRedirect("review_content.jsp?num=" + num + "&page=" + pageNum);
} else {
%>
	<script>
		alert("수정 실패");
		history.back();
	</script>
<%} %>