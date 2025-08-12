<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

	<div class="top-util">
    <ul>
    <sec:authorize access="isAuthenticated()">
    <li><span>${ memberName }님 환영합니다.</span></li>
	</sec:authorize>
    <sec:authorize access="isAnonymous()">
        <li><a href="/login.do">로그인</a></li> 
        <li>|</li>
        <li><a href="/memberForm/buyer.do">회원가입</a></li>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
        <li><a href="/myLogout.do">로그아웃</a></li> 
        <li>|</li>
        <li><a href="/mypage.do">마이페이지</a></li>
        <li>|</li>
        <li><a href="/mypage.do">판매자 마이페이지</a></li>
	</sec:authorize>
        <li>|</li>
        <li><a href="#">장바구니</a></li>
        <li>|</li>
        <li><a href="#">-</a></li>
    </ul>
</div>

<div class="search-logo-line">
    <div class="search-box">
        <input type="text" placeholder="과일 전문 쇼핑몰">
        <button type="button">
            <i class="fas fa-search"></i>
        </button>
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

    <a href="/" class="logo-section">
        <img src="${pageContext.request.contextPath}/images/shopping_mall-Photoroom.png" alt="로고 이미지" style="transform: scaleX(2);">
    </a>

    <div class="category-bar">
        <ul class="category-menu">
            <li><a href="/guest/productList.do">상품</a></li>
            <li><a href="/guest/review/list.do">리뷰</a></li>
            <li>-</li>
            <li>-</li>
            <li>-</li>
            <li>-</li>
        </ul>
    </div>
</div>
