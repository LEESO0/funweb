<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// login.jsp에서 받아온 데이터 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");

// MemberBean 객체에 id와 pass 저장
MemberBean member = new MemberBean();
member.setId(id);
member.setPass(pass);

MemberDAO memberDAO = new MemberDAO();

// 입력된 id와 pass에 해당하는 유저가 있는지 확인하는 checkUser() 메서드 호출
// 파라미터 : member / 리턴타입 : boolean(isLoginSuccess)
boolean isLoginSuccess = memberDAO.checkUser(member);

// 입력된 id와 pass에 해당하는 유저가 있으면 session 객체에 id를 저장 후, main.jsp 로 이동
//									  없으면 "아이디 또는 패스워드 틀림" 출력 후, 이전 페이지로 이동
if(isLoginSuccess) {
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");
} else {
	%>
	<script>
		alert("아이디 또는 패스워드 틀림!");
		history.back();
	</script>
	<%
}
%>
