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

            <form>
                <label for="userId">사용자 이메일 주소</label>
                <input type="text" name="userId" id="userId" placeholder="회원가입 시 등록한 이메일 계정을 입력 해주세요.">

                <button type="submit" class="mypw-btn">비밀번호 초기화</button>

                <div class="divider"><span>or</span></div>

                <div class="mypw-footer">
                    <button type="button" onclick="location.href='/login.do'">로그인</button>
                    <button type="button" onclick="location.href='/memberForm/buyer.do'">회원가입</button>
                </div>
            </form>
        </div>
</body>
</html>