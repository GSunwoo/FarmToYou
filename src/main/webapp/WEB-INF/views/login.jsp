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
  <link rel="stylesheet" href="/css/header.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body class="simple-page">

  <%@ include file="./common/header.jsp" %>

  <div class="login-page-wrapper">
    <div class="login-container">
      <div class="logo">Login</div>
      <c:if test="${param.error != null}">
        <p>Login Error!<br />${errorMsg}</p>
      </c:if>

      <div class="tabs">
        <div class="tab active">관리자</div>
        <div class="tab">판매 회원</div>
        <div class="tab">일반 회원</div>
      </div>

      <form>
        <input type="text" name="my_id" placeholder="아이디를 입력해 주세요" required>
        <input type="password" name="my_pass" placeholder="비밀번호를 입력해 주세요" required>

        <div class="login-options">
          <label><input type="checkbox">기억하기</label>
          <a href="findPw.html">비밀번호를 잊어버리셨나요?</a>
        </div>

        <button type="submit" class="login-btn">로그인</button>
      </form>

      <div class="divider"><span>or</span></div>
      <button class="signup-btn">회원가입</button>
    </div>
  </div>

</body>
</html>
