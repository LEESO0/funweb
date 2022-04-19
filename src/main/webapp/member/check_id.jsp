<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// => 만약, 새 창을 연 상태일 경우 파라미터 자체가 없으므로 null 값이 리턴되고
// check_id_pro.jsp 페이지를 통해 확인을 한 경우 "true" 또는 "false" 리턴됨
String isDuplicate = request.getParameter("duplicate"); 
String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	function useId(id) {
		window.opener.document.fr.id.value = id;
		
		// 부모창의 전역변수 isCheckId 값을 true 로 변경
		window.opener.isCheckId = true;
		
		window.close();
	}
	function checkedId(id) {
		var divCheckIdResult = document.getElementById("checkIdResult")
		
		var regex = /^[A-Za-z0-9]{4,16}$/;
		if(!regex.exec(id)) {
			divCheckIdResult.innerHTML = "영문,숫자 4~16자 필수";
			divCheckIdResult.style.color = "red";
		} else {
			divCheckIdResult.innerHTML = "";
		}
	}
	
	function checkSubmit() {
		var divCheckIdResult = document.getElementById("checkIdResult");
		var id = document.getElementById("id").value;
		
		var regex = /^[A-Za-z0-9]{4,16}$/;
		if(!regex.exec(id)) {
			divCheckIdResult.innerHTML = "영문,숫자 4~16자 필수";
			divCheckIdResult.style.color = "red";
			return false;
		} else {
			divCheckIdResult.innerHTML = "";
			return true;
		}
	}
</script>
</head>
<body>
	<h1>아이디 중복 체크</h1>
	<form action="check_id_pro.jsp" name="fr" onsubmit="return checkSubmit()">
		<input type="text" name="id" id="id" <%if(id != null) { %> value="<%=id %>" <%} %> required="required" placeholder="영문,숫자 4~16자">
		<input type="submit" value="중복확인"><br>
		
	</form>
	<div id="checkIdResult">
	<!-- 중복체크 결과 표시 위치 -->
	<%if(isDuplicate != null && isDuplicate.equals("true")) { %>
		<br>이미 사용중인 아이디입니다.
	<%} else if (isDuplicate != null && isDuplicate.equals("false")) { %>
		<br>사용가능한 아이디입니다.
		<input type="button" value="ID 사용" onclick="useId('<%=id%>')">
	<%} %>
	</div>
</body>
</html>