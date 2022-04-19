<%@page import="study.StudyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// hidden 속성으로 받아온 데이터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// 폼 데이터 저장
String pass = request.getParameter("pass");

// num에 해당하는 글의 pass가 일치한 경우 글을 삭제하는 메서드 deleteStudy() 호출
// 리턴타입 : int(deleteCount) / 파라미터 : num, pass
StudyDAO studyDAO = new StudyDAO();
int deleteCount = studyDAO.deleteStudy(num, pass);

// 삭제 성공 시 "삭제 성공" 출력 후, study_search.jsp 로 이동
//		실패 시 "삭제 실패" 출력 후, 이전 페이지로 이동
if(deleteCount > 0) {
	%>
	<script>
		alert("삭제 성공");
		location.href='study_search.jsp';
	</script>
	<%
} else {
	%>
	<script>
		alert("삭제 실패");
		history.back();
	</script>
	<%
}
%>