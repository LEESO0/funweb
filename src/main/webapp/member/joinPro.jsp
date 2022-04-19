<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// join.jsp 에서 받아온 폼 데이터를 MemberBean 객체에 저장
MemberBean member = new MemberBean();
member.setId(request.getParameter("id"));
member.setPass(request.getParameter("pass"));
member.setName(request.getParameter("name"));
member.setEmail(request.getParameter("email"));
member.setAddress(request.getParameter("address1")  + request.getParameter("address3") + ", " + request.getParameter("address2")); // 도로명 주소(참고 항목), 상세주소
member.setPhone(request.getParameter("phone"));
member.setMobile(request.getParameter("mobile"));

MemberDAO memberDAO = new MemberDAO();

// 회원가입 작업을 위해 insertMember() 메서드 호출
// 파라미터 : member(MemberBean) / 리턴타입 : int(insertCount)
int insertCount = memberDAO.insertMember(member);

// 회원가입 성공 시 joinSucess.jsp로 이동
// 			실패 시 "회원가입 실패" 출력 후, 이전페이지로 이동
if(insertCount > 0) {
	response.sendRedirect("joinSucess.jsp");
} else {
	%>
	<script>
		alert("회원 가입 실패!");
		history.back();
	</script>
	<%
}
%>