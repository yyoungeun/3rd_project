<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="context" value="${pageContext.request.contextPath }" />    
     
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    
    <!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/bootstrap/css/bootstrap.min.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/animate/animate.css">
	<!--===============================================================================================-->	
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/css-hamburgers/hamburgers.min.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/animsition/css/animsition.min.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/select2/select2.min.css">
	<!--===============================================================================================-->	
		<link rel="stylesheet" type="text/css" href="${context}/resources/vendors/daterangepicker/daterangepicker.css">
	<!--===============================================================================================-->
		<link rel="stylesheet" type="text/css" href="${context}/resources/css/util.css">
		<link rel="stylesheet" type="text/css" href="${context}/resources/css/main.css">
	<!--===============================================================================================-->
    
    <title>비밀번호 찾기</title>

    <!-- 부트스트랩 -->
    <link href="${context}/resources/css/bootstrap.min.css" rel="stylesheet">
 
  </head>

<body>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">

				<form class="login100-form validate-form" name="findForm" id="findForm" action="${context}/user/find_passwd.do" method="post">
					<a class="login100-form-title p-b-33" href="${context}/main/main.do">
		            	<img src="${context}/resources/img/logo3.png" style="max-width: 100%; height: auto;" />
		            </a>

					<div class="wrap-input100 validate-input" data-validate = "Valid id is required: ex@abc.xyz">
						<input class="input100" type="text" name="rid" id="rid" placeholder=이메일주소>
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>
				</form>
				
					<div class="container-login100-form-btn m-t-20">
						<button class="login100-form-btn" id="findPasswd">
							이메일로 비밀번호 찾기
						</button>
					</div>

					<div class="text-center p-t-45 p-b-4">
						<a href="${context}/login/login.jsp" class="txt2 hov1">
							로그인
						</a>
					</div>

					<div class="text-center">
						<a href="${context}/user/join.jsp" class="txt2 hov1">
							회원가입
						</a>
					</div>
				
			</div>
		</div>
	</div>

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    
    <!-- jQuery validate -->
	<script src="${context}/resources/js/jquery.validate.js"></script>
    
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${context}/resources/js/bootstrap.min.js"></script>   
    
    <script type="text/javascript">
        
        function find_passwd() {
        
        	var frm = document.loginForm;
        	
        	// validation
        	frm.submit();
        	
        }
        
        $("#findPasswd").on("click", function(){
        	
        	//alert("signIn");
        	
			// validation
			if($("#findForm").valid() == false) return; // validation이 false이면 수행 안 함
			
			//ajax
			$.ajax({
				type : "POST",
				url : "${context}/user/find_passwd.do",
				dataType : "html",
				data : {
					"rid" : $("#rid").val()
				},
				success : function(data) {
					
					var jData = JSON.parse(data); // String 데이터를 json으로 파싱
					
					if(null != jData) { // 데이터가 있으먼
						
						if (jData.msgId == "30") { // 아이디가 있으면

							alert(jData.msgMsg);
							location.href="${context}/login/login.jsp"; // 로그인 화면으로 이동
						}	
					
						else if (jData.msgId == "10") { // 아이디가 없음
							$("#rid").focus();
							alert(jData.msgMsg);
											
						}
					
					}
				},
				complete : function(data) { 

				},
				error : function(xhr, status, error) {
					alert("error:" + error);
				}
			});
			//--ajax  
			
        	//do_login();
        	
        });
        
		// form validate
		$("#findForm").validate({
			rules: {
				rid: {
					required: true,
					minlength: 2,
					maxlength: 320
				}
			},
			messages: {
				rid: {
					required: "이메일을 입력하시오.",
					minlength: $.validator.format("{0}자 이상 입력하시오"),
					maxlength: $.validator.format("{0}자 내로 입력하시오")
				}
			},
			errorPlacement : function(error, element) {
			     //do nothing
			},
		    invalidHandler : function(form, validator) {
		    	
			     var errors = validator.numberOfInvalids();
			     
				     if (errors) {
				    	 
					      alert(validator.errorList[0].message);
					      validator.errorList[0].element.focus();
			     	 }
			}

		});
        
    	$(document).ready(function(){
    		//alert("ready");	
    	});
    
    
    </script>

</body>
</html>