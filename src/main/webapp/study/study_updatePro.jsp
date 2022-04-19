<%@page import="study.StudyDAO"%>
<%@page import="study.StudyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// hidden 속성으로 받아온 데이터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// study_update.jsp에서 받아온 폼 데이터 중 pass 저장
String pass = request.getParameter("pass");

StudyBean studyBean = new StudyBean();

// study_update.jsp 에서 받아온 폼 데이터와 num을 StudyBean 객체에 저장
studyBean.setNum(num);
studyBean.setSubject(request.getParameter("subject"));
studyBean.setIntroduction(request.getParameter("introduction"));
studyBean.setContactType(request.getParameter("contactType"));
studyBean.setStudyType(request.getParameter("studyType"));
studyBean.setSpace(request.getParameter("space"));
studyBean.setWeek(request.getParameter("week"));
studyBean.setTimes(Integer.parseInt(request.getParameter("times")));

// 데이터를 수정하는 updateStudy() 메서드 호출
// 리턴타입 : int(updateCount) / 파라미터 : studyBean, pass
StudyDAO studyDAO = new StudyDAO();
int updateCount = studyDAO.updateStudy(studyBean, pass);

//수정 성공 시 "수정 성공" 출력 후, study_content.jsp 로 이동 (num과 page 같이 넘김)
//	   실패 시 "수정 실패" 출력 후, 이전 페이지로 이동
if(updateCount > 0) {
 	%>
	<script>
 		alert("수정 성공");
		location.href='study_content.jsp?num=<%=num%>&page=<%=pageNum%>';
 	</script>
	<%
} else {
	%>
	<script>
		alert("수정 실패");
		history.back();
 	</script>
	<%
}
%>
