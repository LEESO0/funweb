<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// check_id.jsp 에서 받아온 id 저장
String id = request.getParameter("id");

// 받아온 id 값이 유효한지 확인하는 checkId() 메서드 호출
// 파라미터 : id / 리턴타입 : boolean(isDuplicate)
MemberDAO memberDAO = new MemberDAO();
boolean isDuplicate = memberDAO.checkId(id);

// isDuplicate와 id를 가지고 check_id.jsp 로 이동
response.sendRedirect("check_id.jsp?id=" + id + "&duplicate="+ isDuplicate);
%>