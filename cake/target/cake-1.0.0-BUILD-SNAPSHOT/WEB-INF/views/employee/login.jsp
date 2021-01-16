<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/employee.css"> 
</head>
<body>
	
	<c:if test="${result == 0 }">
		<script>alert("ユーザIDの入力に誤りがあるか登録されていません。");</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script>alert("パスワードの入力に誤りがあるか登録されていません。");</script>
	</c:if>
	
	<div class="loginContainer">
		
		<div class="wrap">
			<div class="loginForm">
				
				<div class="loginWrap">
					<div class="logo">
						<img src="${pageContext.request.contextPath}/resources/images/common/logo.png" alt="logo" />
					</div>
					<form action="login.do" method="post">
						<table>
							<tr>
								<td>
									<span><img src="${pageContext.request.contextPath}/resources/images/common/login_icon.png" alt="login_icon" /></span>
									<input type="text" name="e_id"
												placeholder="ユーザーID" autocomplete="on" required />
								</td>
							</tr>
							<tr>
								<td>
									<span><img src="${pageContext.request.contextPath}/resources/images/common/pwd_icon.png" alt="login_icon" /></span>
									<input type="PASSWORD" name="e_pwd" 
												placeholder="パスワード" required />
								</td>
							</tr>
							<tr>
								<td><input type="submit" value="ログイン" class="img_btn" onClick="nullChk()" /></td>
							</tr>
						</table>
					</form>
					
				</div><!-- loginWrap -->
				
			</div><!-- loginForm -->
		</div><!-- wrap -->
	</div> <!-- container -->
	
	<script>
		// null chk
		let nullChk = function() {
			let id = document.querySelector('input[name=e_id]').value;
			let pwd = document.querySelector('input[name=e_pwd]').value;
			if(id == '') 
				alert('ユーザIDを入力してください。');
			else if(pwd == '')
				alert('パスワードIDを入力してください。');
			else
				submit();
		}
	</script>
	
</body>
</html>