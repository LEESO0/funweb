<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// member_info.jsp 에서 받아온 폼 데이터를 MemberBean 객체에 저장
MemberBean memberBean = new MemberBean();
memberBean.setId(request.getParameter("id"));
memberBean.setPass(request.getParameter("pass"));
memberBean.setName(request.getParameter("name"));
memberBean.setEmail(request.getParameter("email"));
memberBean.setAddress(request.getParameter("address"));
memberBean.setPhone(request.getParameter("phone"));
memberBean.setMobile(request.getParameter("mobile"));

// 입력받은 데이터로 유저 정보를 수정하는 updateMember() 메서드 호출
// 파라미터 : MemberBean(memberBean) / 리턴타입 : int(updateCount)
MemberDAO memberDAO = new MemberDAO();
int updateCount = memberDAO.updateMember(memberBean);

// 유저 정보 수정 성공 시 "수정 완료" 출력 후, member_info.jsp 로 이동
// 				  실패 시 "수정 실패" 출력 후, 이전 페이지로 이동
if(updateCount > 0) {
	%>
	<script>
		alert("수정 완료");
		location.href='member_info.jsp';
	</script>
	<%
// 	response.sendRedirect("member_info.jsp");
} else {
	%>
	<script>
		alert("정보수정 실패");
		history.back();
	</script>
	<%
}
%>

