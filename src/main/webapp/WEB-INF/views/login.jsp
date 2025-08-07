<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>로그인 페이지</title>
</head>
<body>
<!-- 로그인 및 회원가입 메뉴 -->
	<div class="top-util">
        <ul style="font-size: 1em;">
            <li><a href="login.html">로그인</a></li>
            <li>|</li>
            <li><a href="#">회원가입</a></li>
            <li>|</li>
            <li><a href="#">마이페이지</a></li>
            <li>|</li>
            <li><a href="#">장바구니</a></li>
            <li>|</li>
            <li><a href="#">1:1문의</a></li>
        </ul>
    </div>

    <div class="search-logo-line">
        <div class="search-box">
            <input type="text" placeholder="과일 전문 쇼핑몰" style="border-bottom: #888;">
            <button type="button"><i class="fas fa-search"></i></button>

            <div id="search-dropdown" class="custom-search-dropdown">
                <div class="recent-keywords">
                    <strong>최근검색어</strong>
                    <ul>
                        <li>1. 사과</li>
                        <li>2. 바나나</li>
                        <li>3. 레몬</li>
                    </ul>
                </div>
            </div>
        </div>
        <a href="mainpage.html" class="logo-section">
            <img src="./images/shopping mall-Photoroom.png" style="transform:scaleX(2);">
        </a>



        



        <div class="category-bar">
            <ul class="category-menu">
                <li style="font-size: 1.3em;">상품</li>
                <li style="font-size: 1.3em;">추천상품</li>
                <li style="font-size: 1.3em;">추천리뷰</li>
                <li style="font-size: 1.3em;">이달의추천</li>
                <li style="font-size: 1.3em;">1:1문의</li>
                <li style="font-size: 1.3em;">하나더추가</li>
            </ul>
        </div>
	<div class="login-container">
            <div class="logo">Login</div>

            <div class="tabs">
                <div class="tab">관리자</div>
                <div class="tab">판매 회원</div>
                <div class="tab">일반 회원</div>
            </div>

            <form>
                <input type="text" id="" name="my_id" placeholder="아이디를 입력해 주세요" required>
                <input type="password" id="" name="my_pass" placeholder="비밀번호를 입력해 주세요" required>

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