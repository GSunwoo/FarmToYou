<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<aside class="mypage-sidebar"> 
    <div class="sub-menu-box">
        <h2>마이페이지</h2>
        <ul class="sub-menu-mypage">
            <li>MY 주문
                <ul class="sub-depth1">
                    <li><a href="${pageContext.request.contextPath}/seller/sellerManagement">-주문상태</a></li>
                </ul>
            </li>
            <li>MY 상품
                <ul class="sub-depth2">
                    <li><a href="${pageContext.request.contextPath}/seller/write.do">-상품판매등록</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/mylist.do">-나의상품목록</a></li>
                    <li><a href="${pageContext.request.contextPath}/seller/monitoring">-모니터링</a></li>
                </ul>
            </li>
            <li>MY 회원정보
                <ul class="sub-depth3">
                    <li><a href="${pageContext.request.contextPath}/seller/sellerUpdateForm">-판매자 정보 변경</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/sellermember-info">-회원정보 변경</a></li>
                </ul>
            </li>
            <li>리뷰
            	<ul class="sub-depth4">
            		<li><a href="${pageContext.request.contextPath}/seller/reviewManagement">-리뷰</a></li>
            	</ul>
            </li>
        </ul>
    </div>
</aside>
