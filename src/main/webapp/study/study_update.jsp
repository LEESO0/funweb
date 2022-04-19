<%@page import="study.StudyDAO"%>
<%@page import="study.StudyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// URL 파라미터로 받아온 데이터 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

// num에 해당하는 레코드를 출력하는 selectStudy() 메서드 호출
// 리턴타입 : StudyBean / 파라미터 : num
StudyDAO studyDAO = new StudyDAO();
StudyBean studyBean = studyDAO.selectStudy(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study/study_update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"><img src="../images/company/sub_back_r.png"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="study_search.jsp">Study Search</a></li>
				<li><a href="study_write.jsp">Study Write</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Study Update</h1>
			<form action="study_updatePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="page" value="<%=pageNum%>">
				<table id="notice">
					<tr>
						<th width="60">온/오프</th>
						<td colspan="2">
							<input type="radio" id="selectContactType" name="contactType" value="온라인" 
								   <%if(studyBean.getContactType().equals("온라인")) {%> checked="checked" <%} %>><label for="selectContactType">온라인</label>
							<input type="radio" id="selectContactType1" name="contactType" value="오프라인" 
								   <%if(studyBean.getContactType().equals("오프라인")) {%> checked="checked" <%} %>><label for="selectContactType1">오프라인</label>
						</td>
					</tr>
					<tr>
						<th>분야</th>
						<td colspan="2">
							<input type="radio" id="selectStudyType" name="studyType" value="수능" 
								   <%if(studyBean.getStudyType().equals("수능")) {%> checked="checked" <%} %>><label for="selectStudyType">수능</label>
							<input type="radio" id="selectStudyType1" name="studyType" value="공무원" 
								   <%if(studyBean.getStudyType().equals("공무원")) {%> checked="checked" <%} %>><label for="selectStudyType1">공무원</label>
							<input type="radio" id="selectStudyType2" name="studyType" value="면접" 
								   <%if(studyBean.getStudyType().equals("면접")) {%> checked="checked" <%} %>><label for="selectStudyType2">면접</label>
						<input type="radio" id="selectStudyType3" name="studyType" value="자격증" 
								   <%if(studyBean.getStudyType().equals("자격증")) {%> checked="checked" <%} %>><label for="selectStudyType3">자격증</label>
							<input type="radio" id="selectStudyType4" name="studyType" value="어학" 
								   <%if(studyBean.getStudyType().equals("어학")) {%> checked="checked" <%} %>><label for="selectStudyType4">어학</label>
								<input type="radio" id="selectStudyType5" name="studyType" value="독서" 
								   <%if(studyBean.getStudyType().equals("독서")) {%> checked="checked" <%} %>><label for="selectStudyType5">독서</label>
						</td>
					</tr>
					<tr>
						<th>횟수</th>
						<td width="335px">주
							<select name="times" class="select1">
								<option value="1" <%if(studyBean.getTimes() == 1) {%> selected="selected" <%} %>>1</option>
								<option value="2" <%if(studyBean.getTimes() == 2) {%> selected="selected" <%} %>>2</option>
								<option value="3" <%if(studyBean.getTimes() == 3) {%> selected="selected" <%} %>>3</option>
								<option value="4" <%if(studyBean.getTimes() == 4) {%> selected="selected" <%} %>>4</option>
								<option value="5" <%if(studyBean.getTimes() == 5) {%> selected="selected" <%} %>>5</option>
								<option value="6" <%if(studyBean.getTimes() == 6) {%> selected="selected" <%} %>>6</option>
								<option value="7" <%if(studyBean.getTimes() == 7) {%> selected="selected" <%} %>>7</option>
							</select> 회
						</td>
						<td  width="335px" class="select">
							<input type="radio" id="selectWeek" name="week" value="평일" 
								   <%if(studyBean.getWeek().equals("평일")) {%> checked="checked" <%} %>><label for="selectWeek">평일</label>
							<input type="radio" id="selectWeek2" name="week" value="주말" 
								   <%if(studyBean.getWeek().equals("주말")) {%> checked="checked" <%} %>><label for="selectWeek2">주말</label>
						</td>
					</tr>
					<tr>
						<th>지역</th>
						<td colspan="2" class="select">
							<input type="radio" id="selectSpace" name="space" value="서울" 
								  	<%if(studyBean.getSpace().equals("서울")) {%> checked="checked" <%} %>><label for="selectSpace">서울</label>
							<input type="radio" id="selectSpace1" name="space" value="인천" 
								  	<%if(studyBean.getSpace().equals("인천")) {%> checked="checked" <%} %>><label for="selectSpace1">인천</label>
							<input type="radio" id="selectSpace2" name="space" value="경기도" 
									<%if(studyBean.getSpace().equals("경기도")) {%> checked="checked" <%} %>><label for="selectSpace2">경기도</label>
							<input type="radio" id="selectSpace3" name="space" value="강원도" 
									<%if(studyBean.getSpace().equals("강원도")) {%> checked="checked" <%} %>><label for="selectSpace3">강원도</label>
							<input type="radio" id="selectSpace4" name="space" value="충청도" 
									<%if(studyBean.getSpace().equals("충청도")) {%> checked="checked" <%} %>><label for="selectSpace4">충청도</label>
							<input type="radio" id="selectSpace5" name="space" value="대전"
									<%if(studyBean.getSpace().equals("대전")) {%> checked="checked" <%} %>><label for="selectSpace5">대전</label>
							<input type="radio" id="selectSpace6" name="space" value="세종" 
									<%if(studyBean.getSpace().equals("세종")) {%> checked="checked" <%} %>><label for="selectSpace6">세종</label><br>
							<input type="radio" id="selectSpace7" name="space" value="경상도" 
									<%if(studyBean.getSpace().equals("경상도")) {%> checked="checked" <%} %>><label for="selectSpace7">경상도</label>
							<input type="radio" id="selectSpace8" name="space" value="대구" 
									<%if(studyBean.getSpace().equals("대구")) {%> checked="checked" <%} %>><label for="selectSpace8">대구</label>
							<input type="radio" id="selectSpace9" name="space" value="전라도" 
									<%if(studyBean.getSpace().equals("전라도")) {%> checked="checked" <%} %>><label for="selectSpace9">전라도</label>
							<input type="radio" id="selectSpace10" name="space" value="광주" 
									<%if(studyBean.getSpace().equals("광주")) {%> checked="checked" <%} %>><label for="selectSpace10">광주</label>
							<input type="radio" id="selectSpace11" name="space" value="울산" 
									<%if(studyBean.getSpace().equals("울산")) {%> checked="checked" <%} %>><label for="selectSpace11">울산</label>
							<input type="radio" id="selectSpace12" name="space" value="부산" 
									<%if(studyBean.getSpace().equals("부산")) {%> checked="checked" <%} %>><label for="selectSpace12">부산</label>
							<input type="radio" id="selectSpace13" name="space" value="제주" 
									<%if(studyBean.getSpace().equals("제주")) {%> checked="checked" <%} %>><label for="selectSpace12">제주</label>
						</td>
					</tr>
					<tr>
						<th class="select1">제목</th>
						<td colspan="2"><input type="text" name="subject" value="<%=studyBean.getSubject()%>" ></td>
					</tr>
					<tr>
						<th class="select1">소개</th>
						<td colspan="2"><textarea rows="10" cols="20" name="introduction"><%=studyBean.getIntroduction() %></textarea></td>
					</tr>
					<tr>
						<th class="select1">비밀번호</th>
						<td colspan="2"><input type="password" name="pass"></td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>

