<%@page import="study.StudyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="study.StudyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// PSOT 방식 한글 처리
request.setCharacterEncoding("UTF-8");
// -------------- 페이징 처리 --------------------------------------------------
//현재 페이지 값 저장 변수 선언
//페이지의 초기값 1
int pageNum = 1;

//현재 페이지가 저장된 page 파라미터를 가져와서 pageNum에 저장
//page 파라미터 존재할 경우에만 저장
if(request.getParameter("page") != null){
	pageNum = Integer.parseInt(request.getParameter("page"));
}

int listLimit = 10;	// 한 페이지에 표시할 목록 갯수
int pageLimit = 10;	// 한 페이지에 표시할 페이지 갯수

//StudyDAO 객체 생성 후 전체 페이지 계산하는 selectStudyListCount() 메서드 호출
//파라미터 : 없음 , 리턴타입 : int(listCount)
StudyDAO studyDAO = new StudyDAO();
int listCount = studyDAO.selectStudyListCount();

//현재 페이지에서 표시할 전체 페이지 수 계산
int maxPage = (int)Math.ceil((double)listCount / listLimit);

//시작페이지 계산
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

//끝페이지 계산
int endPage = startPage + pageLimit - 1;

//4. 만약, 끝 페이지가 현재 페이지에서 표시할 최대 페이지 수보다 클 경우
//끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
endPage = maxPage;
}
// -----------------------------------------------------------------------------
// 모든 스터디 목록 조회 후 출력하는 selectStudyList() 메서드 호출
// 리턴타입 : ArrayList<StudyBean>(studyList) / 파라미터 : pageNum, listLimit
ArrayList<StudyBean> studyList = studyDAO.selectStudyList(pageNum, listLimit);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study/study_search.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
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
			<h1>Study Search</h1>
			<form action="study_search_checked.jsp" method="post">
				<table id="notice">
					<tr>
						<td colspan="2" class="select">
							<input type="radio" id="selectContactType" name="contactType" value="온라인"><label for="selectContactType">온라인</label>
							<input type="radio" id="selectContactType1" name="contactType" value="오프라인"><label for="selectContactType1">오프라인</label>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="select">
							<input type="radio" id="selectStudyType" name="studyType" value=수능><label for="selectStudyType">수능</label>
							<input type="radio" id="selectStudyType1" name="studyType" value="공무원"><label for="selectStudyType1">공무원</label>
							<input type="radio" id="selectStudyType2" name="studyType" value="면접"><label for="selectStudyType2">면접</label>
							<input type="radio" id="selectStudyType3" name="studyType" value="자격증"><label for="selectStudyType3">자격증</label>
							<input type="radio" id="selectStudyType4" name="studyType" value="어학"><label for="selectStudyType4">어학</label>
							<input type="radio" id="selectStudyType5" name="studyType" value="독서"><label for="selectStudyType5">독서</label>
						</td>
					</tr>
					<tr>
						<td width="335px">주 
							<select name="times" class="select1">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
							</select> 회
						</td>
						<td  width="335px" class="select">
							<input type="radio" id="selectWeek" name="week" value="평일"><label for="selectWeek">평일</label>
							<input type="radio" id="selectWeek2" name="week" value="주말"><label for="selectWeek2">주말</label>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="select">
							<input type="radio" id="selectSpace" name="space" value="서울"><label for="selectSpace">서울</label>
							<input type="radio" id="selectSpace1" name="space" value="인천"><label for="selectSpace1">인천</label>
							<input type="radio" id="selectSpace2" name="space" value="경기도"><label for="selectSpace2">경기도</label>
							<input type="radio" id="selectSpace3" name="space" value="강원도"><label for="selectSpace3">강원도</label>
							<input type="radio" id="selectSpace4" name="space" value="충청도"><label for="selectSpace4">충청도</label>
							<input type="radio" id="selectSpace5" name="space" value="대전"><label for="selectSpace5">대전</label>
							<input type="radio" id="selectSpace6" name="space" value="세종"><label for="selectSpace6">세종</label><br>
							<input type="radio" id="selectSpace7" name="space" value="경상도"><label for="selectSpace7">경상도</label>
							<input type="radio" id="selectSpace8" name="space" value="대구"><label for="selectSpace8">대구</label>
							<input type="radio" id="selectSpace9" name="space" value="전라도"><label for="selectSpace9">전라도</label>
							<input type="radio" id="selectSpace10" name="space" value="광주"><label for="selectSpace10">광주</label>
							<input type="radio" id="selectSpace11" name="space" value="울산"><label for="selectSpace11">울산</label>
							<input type="radio" id="selectSpace12" name="space" value="부산"><label for="selectSpace12">부산</label>
							<input type="radio" id="selectSpace13" name="space" value="제주"><label for="selectSpace12">제주</label>
						</td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="검색" class="btn">
					<input type="reset" value="초기화" class="btn">
				</div>
			</form>
			<div id="hr_line"><hr></div>
			<h1>Study List</h1>
			<table id="notice1">
				<tr>
					<th width="50px">글번호</th>
					<th width="300px">제목</th>
					<th width="270px">타입</th>
					<th width="50px">좋아요</th> 
				</tr>
				<%for(StudyBean studyBean : studyList) {%>
				<tr onclick="location.href='study_content.jsp?num=<%=studyBean.getNum()%>&page=<%=pageNum%>'">
					<td><%=studyBean.getNum() %></td>
					<td><%=studyBean.getSubject() %></td>
					<td>
						<span class="type"><%=studyBean.getContactType() %></span> <span class="type"><%=studyBean.getStudyType() %></span> <span class="type"><%=studyBean.getSpace() %></span> 
						<span class="type"><%=studyBean.getWeek() %></span> <span class="type">주 <%=studyBean.getTimes() %>회</span>
					</td>
					<td><%=studyBean.getLikeCount() %></td>
				</tr>
				<%
				}
				%>
			</table>
			<div id="page_control">
				<!-- 
				현재 페이지 번호(pageNum)이 1보다 클 경우에만 Prev 링크 동작
				=> 클릭 시 현재 페이지번호 - 1 값을 page 파라미터로 전달
				 -->
				<%if(pageNum > 1) {%>
					<a href="study_search.jsp?page=<%=pageNum-1 %>">Prev</a>
				<%} else { %>
					Prev&nbsp;				
				<%} %>
				<!-- 페이지 번호 목록은 시작페이지(startPage)부터 끝 페이지(endPage) -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;[<%=i %>]&nbsp;&nbsp;
					<%} else { %>
						<a href="study_search.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				<!-- 
				현재 페이지 번호(pageNum)이 끝 페이지 번호보다 작을 때만 Next 링크 동작
				=> 클릭 시 현재 페이지번호 + 1 값을 page 파라미터로 전달
				 -->
				<%if(pageNum < maxPage) {	// 다음 페이지가 존재할 경우%>
					<a href="study_search.jsp?page=<%=pageNum + 1 %>">Next</a>
				<%} else { // 다음 페이지가 존재하지 않을 경우%>
					&nbsp;Next
				<%} %>

			</div>
		</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
