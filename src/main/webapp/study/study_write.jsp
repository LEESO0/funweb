<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study/study_write.jsp</title>
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
			<h1>Study Write</h1>
			<form action="study_writePro.jsp" method="post">
				<table id="notice">
					<tr>
						<th>작성자(아이디)</th>
						<td><input type="text" name="id" required="required"></td>
						</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
				</table>
				<table id="notice">
					<tr>
						<th width="60">온/오프</th>
						<td colspan="2" class="select">
							<input type="radio" id="selectContactType" name="contactType" value="온라인"><label for="selectContactType">온라인</label>
							<input type="radio" id="selectContactType1" name="contactType" value="오프라인"><label for="selectContactType1">오프라인</label>
						</td>
					</tr>
					<tr>
						<th>분야</th>
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
						<th>횟수</th>
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
						<td class="select">
							<input type="radio" id="selectWeek" name="week" value="평일"><label for="selectWeek">평일</label>
							<input type="radio" id="selectWeek2" name="week" value="주말"><label for="selectWeek2">주말</label>
						</td>
					</tr>
					<tr>
						<th>지역</th>
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
					<tr>
						<th>제목</th>
						<td colspan="2"><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<th>소개</th>
						<td colspan="2"><textarea rows="10" cols="20" name="introduction" required="required"></textarea></td>
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