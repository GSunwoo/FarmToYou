<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세설명페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Detailpage.css">
<!-- 돋보기 외부 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	
	<div class="dp-wrap">
		<c:if test="${productDTO.prodimg_id}!= null">
		<div class="dp-left">
			<div class="dp-mainimg">
				<img src="${productDTO.prodimg_id }" alt="${productDTO.prodimg_id }" />
			</div>
		</div>
		</c:if>
		
		<div class="dp-right">
			<h2 class="dp-tit">${productDTO.prod_name }</h2>
		</div>
		
		<ul class="dp-info">
			<li>
				<span class="lb">정가</span>
				<span class="val strike">
					<fmt:formatNumber value="${productDTO.prod_price }" type="number" />
					<c:if test="${not empty productDTO.prod_price }">원</c:if>
				</span>
			</li>
			<%-- <li>
				<span class="lb">판매가</span>
				<span class="val strong">
					<fmt:formatNumber value="${salePrice }" type="number" />원
				</span>
			</li> --%>
			<li>
				<span class="lb">배송비</span>
				<span class="val">무료</span>
			</li>
		</ul>
		
		<div class="dp-qty">
			<button type="button" class="qty-btn" data-delta="-1">-</button>
			<input id="qty" type="text" value="1" readonly>
			<button type="button" class="qty-btn" data-delta="1">+</button>
		</div>
		
		<!-- 백엔드 연결 시 name, value, 액션경로 세팅 -->
		<div class="dp-actions">
			<form methon="post" action="#">
				<input type="hidden" name="" value="${productDTO.prod_id }">
				<input type="hidden" id="qtyInput" name="" value="1">
				<button type="submit" class="btn-outline">장바구니</button>
				<!-- 장바구니로 가는 경로 세팅 -->
				<a href="#" class="btn-soild">바로결제</a>
			</form>
		</div>
		
		<div>
			<ul>
				<li>
					<p>${productDTO.prod_content }</p>				
				</li>
			</ul>
		</div>
		
	</div>
</body>
</html>