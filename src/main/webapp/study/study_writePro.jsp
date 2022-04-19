<%@page import="study.StudyDAO"%>
<%@page import="study.StudyBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// study_write.jsp에서 받아온 폼 데이터 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String contactType = request.getParameter("contactType");
String studyType = request.getParameter("studyType");
int times = Integer.parseInt(request.getParameter("times"));
String week = request.getParameter("week");
String space = request.getParameter("space");
String subject = request.getParameter("subject");
String introduction = request.getParameter("introduction");

// id와 pass를 MemberBean 객체에 저장
MemberBean memberBean = new MemberBean();
memberBean.setId(id);
memberBean.setPass(pass);

// 입력받은 id와 pass에 해당하는 유저가 있는지 확인 하는 checkLogin() 메서드 호출
// 파라미터 : id, pass / 리턴타입 : boolean(isCheckLogin)
MemberDAO memberDAO = new MemberDAO();
boolean isCheckLogin = memberDAO.checkLogin(id, pass);

// 입력받은 id와 pass에 해당하는 유저가 없는 경우 "없는 회원입니다." 출력 후, 이전페이지로 이동
if(!isCheckLogin) {
 	%>
	<script>
 		alert("없는 회원입니다.");
		history.back();
	</script>
	<%
}
// 존재하는지 확인됨!
// study_write.jsp에서 입력받은 데이터를 studyBean 객체에 저장
StudyBean studyBean = new StudyBean();
studyBean.setId(id);
studyBean.setSubject(subject);
studyBean.setIntroduction(introduction);
studyBean.setContactType(contactType);
studyBean.setStudyType(studyType);
studyBean.setSpace(space);
studyBean.setWeek(week);
studyBean.setTimes(times);

// 입력받은 데이터를 insert하는 insertStudy() 메서드 호출
// 파라미터 : studyBean / 리턴타입 : int(insertCount)
StudyDAO studyDAO = new StudyDAO();
int insertCount = studyDAO.insertStudy(studyBean);

// 글 작성 성공 시 study_search.jsp 로 이동
//		   실패 시 "글쓰기 실패" 출력 후, 이전페이지로 이동
if(insertCount > 0) {
	response.sendRedirect("study_search.jsp");
} else {%>
	<script>
		alert("글쓰기 실패");
 		history.back();
 	</script>
<%} %>
%>