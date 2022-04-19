<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체를 비운 후, main.jsp로 이동
session.invalidate();
response.sendRedirect("../main/main.jsp");
%>
<!-- <script> -->
<!-- 	alert("로그아웃 완료"); -->
<!-- 	location.href= "../main/main.jsp"; -->
<!-- </script> -->