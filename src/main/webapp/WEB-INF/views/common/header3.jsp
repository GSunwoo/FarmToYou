<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sub-content">
  <div class="side-bar">
    <!-- 사이드바 전체를 감싸는 카드 형태 박스 -->
    <div class="sidebar-card">
      <div class="sub-menu-box">
        <h2>판매자 마이페이지</h2>
        <ul class="sub-menu-mypage">
       	    <li><a href="${pageContext.request.contextPath}/sellerManagement">주문상태</a></li>
			<li><a href="${pageContext.request.contextPath}/productRegistration">상품판매등록</a></li>
			<li><a href="${pageContext.request.contextPath}/seller/monitoring">모니터링</a></li>
			<li><a href="${pageContext.request.contextPath}/sellerUpdateForm">판매자 정보 변경</a></li>
			<li><a href="${pageContext.request.contextPath}/reviewManagement">리뷰</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
