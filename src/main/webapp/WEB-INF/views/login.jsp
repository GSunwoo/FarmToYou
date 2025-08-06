<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<link rel="stylesheet" href="/css/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="/js/search.js"></script>
<script src="/js/login.js"></script>
</head>
<body>
	<div class="login-container">
            <div class="logo">Login</div>

            <div class="tabs">
                <div class="tab">관리자</div>
                <div class="tab">판매 회원</div>
                <div class="tab">일반 회원</div>
            </div>

            <form>
                <input type="text" id="" name="" placeholder="아이디를 입력해 주세요" required>
                <input type="password" pw="" name="" placeholder="비밀번호를 입력해 주세요" required>

                <div class="login-options">
                    <label><input type="checkbox">기억하기</label>
                    <a href="findPw.html">비밀번호를 잊어버리셨나요?</a>
                </div>

                <button type="submit" class="login-btn">로그인</button>
            </form>

            <div class="divider"><span>or</span></div>
            <button class="signup-btn">회원가입</button>

        </div>
</body>
</html>