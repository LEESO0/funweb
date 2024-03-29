<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL 사용을 위한 taglib 디렉티브 설정 필요 -->
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%
String id = (String)session.getAttribute("sId");	// Object -> String 강제 형변환 필요
// => 만약, EL 과 JSTL 사용 시 불필요
%>
<header>
  <!-- login join -->
  <div id="login">
  	<!-- 세션 아이디("sId") 유무에 따라 서로 다른 링크 표시 -->
  	<!-- 세션 아이디가 null 이면 미로그인, 아니면 로그인 상태 -->
	  <%if(id == null) {%>
	  	<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
	  <%} else { %>
	  	<a href="../member/member_info.jsp"><%=id %>님</a> | <a href="../member/logout.jsp">logout</a> 
	  	<!-- 만약, 세션 아이디가 "admin"일 경우 "관리자페이지"(/admin/admin.jsp) 링크 표시 -->
	  	<%if(id.equals("admin")) { %>
	  	| <a href="../admin/admin.jsp">관리자페이지</a>
	  	<%} %>
	  <%} %>
	  
	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- EL과 JSTL을 사용하여 동일한 작업 구현 -->
	<!-- if~else 문 대신 c:choose, c:when, c:otherwise 태그 활용 -->
	<!-- EL 사용하여 세션 객체에 접근하기 위해서는 sessionScope.속성명 으로 접근 필요 -->
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${empty sessionScope.sId }"> --%>
<!-- 			<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a> -->
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 			<a href="#">${sessionScope.sId }님</a> | <a href="../member/logout.jsp">logout</a> --%>
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
	<!-- -------------------------------------------------------------------------------------------------- -->
  </div>
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><a href="../main/main.jsp">STUDY</a></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">HOME</a></li>
  		<li><a href="../company/welcome.jsp">COMPANY</a></li>
  		<li><a href="../study/study_search.jsp">SEARCH</a></li>
  		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
  		<li><a href="../contact_us/contact_us.jsp">CONTACT US</a></li>
  	</ul>
  </nav>
</header>