<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 test</title>
</head>
<body>
	<form action="/memberForm/buyer/regist.do" method="post">
		<input type="text" name="user_type" value="ROLE_BUYER" /><br />
		<input type="text" name="user_id" /><br />
		<input type="password" name="user_pw" /><br />
		<input type="text" name="name" /><br />
		<input type="text" name="phone_num" /><br />
		<input type="text" name="email"/><br />
		<input type="text" name="zipcode" /><br />
		<input type="text" name="addr1" /><br />
		<input type="text" name="addr2" /><br />
		<input type="submit" value="가입하기" />
	</form>
</body>
</html>