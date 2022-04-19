<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 전역변수
	var isCheckRetypePass = false;
	var isCheckId = false;
	var isCheckPass = false;
	
	function checkPass(pass) {
		
		var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
		var engUpperRegex = /[A-Z]/;
		var engLowerRegex = /[a-z]/;
		var numRegex = /[0-9]/;
		var specRegex = /[!@#$%]/;
		
		var count = 0;
		
		if(!lengthRegex.exec(pass)) {
			document.getElementById("checkPassResult").innerHTML = "영문,숫자,특수문자 8~16자 필수";
			document.getElementById("checkPassResult").style.color = "red";
			isCheckPass = false;
			
		} else {
			if(engUpperRegex.exec(pass)) count++;
			if(engLowerRegex.exec(pass)) count++;
			if(numRegex.exec(pass)) count++;
			if(specRegex.exec(pass)) count++;
			
			switch (count) {
			case 4:
				document.getElementById("checkPassResult").innerHTML = "사용 가능한 비밀번호(안전)";
				document.getElementById("checkPassResult").style.color = "GREEN";
				isCheckPass = true;
				break;
			case 3:
				document.getElementById("checkPassResult").innerHTML = "사용 가능한 비밀번호(보통)";
				document.getElementById("checkPassResult").style.color = "yellow";
				isCheckPass = true;
				break;
			case 2:
				document.getElementById("checkPassResult").innerHTML = "사용 가능한 비밀번호(위험)";
				document.getElementById("checkPassResult").style.color = "orange";
				isCheckPass = true;
				break;
			default:
				document.getElementById("checkPassResult").innerHTML = "영문,숫자,특수문자 8~16자 필수";
				document.getElementById("checkPassResult").style.color = "red";
				isCheckPass = false;
			}
			
		}
	}
	function checkRetypePass(pass2) {
		var pass = document.fr.pass.value;
		var span = document.getElementById("checkRetypePassResult");
		if(pass2 == pass) {
			span.innerHTML = "패스워드 일치";
			span.style.color = "GREEN";
			isCheckRetypePass = true;
		} else {
			span.innerHTML = "패스워드 불일치";
			span.style.color = "RED";
			isCheckRetypePass = false;
		}
	}
	function openCheckIdWindow() {
		window.open("check_id.jsp","","width=400, height=250");
	}
	function checkSubmit() {
		// 아이디 중복 확인 작업을 통해 아이디를 입력받았고,
		// 정규표현식을 통해 패스워드 규칙이 올바르고(checkPassPesult == true),
		// 패스워드 확인을 통해 두 패스워드가 동일하면 true 리턴, 아니면 false 리턴
// 		if(document.fr.id.value == "") {
// 			alert("아이디 중복 확인 필수");
// 			return false;
// 		} else if (!isCheckPass) {
// 			alert("패스워드 일치 여부 확인 필수");
// 			return false;
// 		}
		if(!isCheckId) {
			alert("아이디 중복 확인 필수");
			document.fr.id.focus();
			return false;
		} else if (!isCheckRetypePass) {
			alert("패스워드 확인 필수");
			document.fr.pass2.focus();
			return false;
		} else if (!isCheckPass) {
			alert("패스워드 규칙 확인 필수");
			document.fr.pass.focus();
			return false;
		}
	}
</script>
<!-- ------------------------------------------ 우편번호 연결 ------------------------------------------------- -->
<script type="text/javascript">
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
// 	            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	            
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            }
	
	            var guideTextBox = document.getElementById("guide");
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';
	
// 	            } else if(data.autoJibunAddress) {
// 	                var expJibunAddr = data.autoJibunAddress;
// 	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
// 	                guideTextBox.style.display = 'block';
	            } else {
	                guideTextBox.innerHTML = '';
	                guideTextBox.style.display = 'none';
	            }
	       	}
    	}).open();
	}
</script>
<!-- -------------------------------------------------------------------------------------------------------- -->
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
		  		<li><a href="join.jsp">Join us</a></li>
		  		<li><a href="login.jsp">Login</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<div>
		  				<label>User Id</label>
		  				<input type="text" name="id" class="id" id="id" required="required" readonly="readonly" placeholder="중복 체크 버튼 클릭">
		  				<input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()"><br>
		  			</div>
		  			<div>
		  				<label>Password</label>
		  				<input type="password" name="pass" id="pass" required="required" placeholder="영문,숫자,특수문자 8~16자" onkeyup="checkPass(this.value)">			
		  				<span id="checkPassResult"></span><br>
		  			</div>
		  			<div>
		  				<label>Retype Password</label>
		  				<input type="password" name="pass2" required="required" onkeyup="checkRetypePass(this.value)">
		  				<span id="checkRetypePassResult"></span><br>
		  			</div>
		  			<div>
		  				<label>Name</label>
		  				<input type="text" name="name" id="name" required="required"><br>
		  			</div>
		  			<div>
		  				<label>E-Mail</label>
		  				<input type="email" name="email" id="email" required="required"><br>
		  			</div>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<div>
			  			<label>Post code</label>
			  			<input type="text" id="sample4_postcode" placeholder="우편번호">
	<!-- 		  			<input type="text" name="post_code" readonly="readonly"  placeholder="검색 버튼 클릭"> -->
			  			<input type="button" id="post_button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<!-- 		  			<input type="button" value="search" class="dup"><br> -->
					</div>
					<div>
			  			<label>Address</label>
			  			<input type="text" name="address1" id="sample4_roadAddress" placeholder="도로명주소" width="50px">
<!-- 						<input type="text" name="address2" id="sample4_jibunAddress" placeholder="지번주소"> -->
						<span id="guide" style="color:#999;display:none"></span><br>
						<label id="blank_addr">&nbsp;</label>
						<input type="text" name="address2" id="sample4_detailAddress" placeholder="상세주소">
						<input type="text" name="address3" id="sample4_extraAddress" placeholder="참고항목"><br>
					</div>
					<div>
		  				<label>Phone Number</label>
		  				<input type="text" name="phone" ><br>
		  			</div>
		  			<div>
		  				<label>Mobile Phone Number</label>
		  				<input type="text" name="mobile" ><br>
		  			</div>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


