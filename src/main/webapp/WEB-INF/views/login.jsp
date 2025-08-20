<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- 필요한 스타일 -->
  <link rel="stylesheet" href="/css/mainpage.css">
  <link rel="stylesheet" href="/css/login.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <script src="/js/loginForm.js"></script>
</head>

<body class="simple-page">

  <%@ include file="./common/header.jsp" %>

  <div class="login-page-wrapper">
    <div class="login-container">
      <div class="logo">Login</div>
      
      <c:if test="${param.error != null}">
        <p>Login Error!<br />${errorMsg}</p>
      </c:if>

      <form action="/myLoginAction.do" method="post" >
        <input type="text" id="id" name="my_id" placeholder="아이디를 입력해 주세요" required
        value=""
        >
        <input type="password" id="pw" name="my_pass" placeholder="비밀번호를 입력해 주세요" required
        >
<!--         value="A123123!" -->

        <div class="login-options">
          <a href="/guest/findPw.do">비밀번호를 잊어버리셨나요?</a>
        </div>

        <button type="submit" class="login-btn">로그인</button>
      </form>

      <!-- <div class="divider"><span>or</span></div>
      <button class="signup-btn">회원가입</button> -->
    </div>
  </div>

</body>
</html>
