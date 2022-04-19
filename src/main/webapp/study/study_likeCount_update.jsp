<%@page import="study.StudyDAO"%>
<%@page import="study.StudyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// URL 파라미터로 받아온 데이터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

StudyDAO studyDAO = new StudyDAO();

//num에 해당하는 레코드의 좋아요 수를 증가시키는 updateLikeCount() 메서드 호출
//리턴타입 : void / 파라미터 : num
int updateLikeCount = studyDAO.updateLikeCount(num);

// 좋아요 증가 성공 시 study_content.jsp로 이동(num과 pageNum 같이 이동)
//		  	   실패 시 "좋아요 증가 실패" 출력 후 이전페이지로 이동
if(updateLikeCount > 0) {
	response.sendRedirect("study_content.jsp?num=" + num + "&page=" + pageNum);
} else {
%>
	<script>
		alert("좋아요 증가 실패");
		history.back();
	</script>
<%}%>