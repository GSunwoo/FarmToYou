<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호찾기 페이지</title>
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/findPw.css">
<!-- 돋보기 외부 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	
	<div class="mypw-container">
            <h2 class="mypw-title">비밀번호찾기</h2>

            <div class="mypw-info-box">
                비밀번호를 분실하셨나요? 사용자 이메일주소를 입력해주세요.<br>
                새로운 비밀번호를 만들기 위해 이메일을 통한 링크를 받게됩니다.
            </div>

            <form action="/guest/findPw.do" method="post">
                <label for="user_id">사용자 계정</label>
                <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력 해 주세요">
                <label for="name">사용자 이름</label>
                <input type="text" id="name" name="name" placeholder="이름를 입력 해 주세요">
                <label for="email">사용자 이메일 주소</label>
                <input type="text" id="email" name="email" placeholder="이메일을 입력 해 주세요">

                <button type="submit" class="mypw-btn">비밀번호 전송</button>

                <div class="divider"><span>or</span></div>

                <div class="mypw-footer">
                    <button type="button" onclick="location.href='/login.do'">로그인</button>
                    <button type="button" onclick="location.href='/memberForm/buyer.do'">회원가입</button>
                </div>
            </form>
        </div>
</body>
</html>