<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세설명페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/Detailpage.css">
<!-- 돋보기 외부 css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="/js/Detailpage.js"></script>
<script src="/js/wishlist/addwishlist.js"></script>
<script>const params = new URLSearchParams(window.location.search);</script>
</head>
<body>
	<%@ include file="./common/header.jsp"%>

	<div class="dp-wrap">
		<c:if test="${not empty main}">
			<div class="dp-left">
				<div class="dp-mainimg">
					<img src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${main.prod_id}/${main.filename}"
						alt="${main.filename}" />
				</div>
			</div>
		</c:if>


		<div class="dp-right">
    <!-- 상품명 -->
    <h2 class="dp-tit">${productDTO.prod_name }</h2>

    <!-- 가격/배송비 -->
    <ul class="dp-info">
        <li>
            <span class="lb">정가</span>
            <span>
                <fmt:formatNumber value="${productDTO.prod_price }" type="number" />
                <c:if test="${not empty productDTO.prod_price }">원</c:if>
            </span>
        </li>
        <li>
            <span class="lb">배송비</span>
            <span class="val">무료</span>
        </li>
    </ul>

    <!-- 수량 -->
    <div class="dp-qty">
        <button type="button" class="qty-btn" data-delta="-1">-</button>
        <input id="qty" type="text" value="1" readonly>
        <button type="button" class="qty-btn" data-delta="1">+</button>
    </div>

    <!-- 액션 버튼 -->
    <div class="dp-actions">
        <form id="cart_form">
            <input type="hidden" name="prod_id" value="${productDTO.prod_id }">
            <input type="hidden" id="qtyInput" name="prod_qty" value="1">

            <button type="submit" class="btn-outline" id="wishlist-add-btn">장바구니 담기</button>
            <a id="order" class="btn-solid">바로결제</a>
            <a href="/buyer/inquiryForm.do?prod_name=${productDTO.prod_name}&prod_id=${productDTO.prod_id}" 
               class="btn-outline">상품문의쓰기</a>
        </form>
    </div>
</div>
     
		<section class="dp-detail">
			<div class="dp-tabwrap">
				<!-- 좌측 사이드 레이블 -->
				<aside class="dp-tab-aside" data-label="상품 상세">
					<ul class="dp-tabmenu">
						<li><span class="tab-label is-active">설명</span></li>
					</ul>
					
				</aside>


 
				<!-- 우측 내용 -->
				<div class="dp-tabcontent">
					<div class="tab-panel is-active">
						<p>${productDTO.prod_content}</p>
						<%-- 필요하면 더미 문단 추가해서 줄수 맞춰보기 --%>
						<c:if test="${not empty imglist}">
							<c:forEach var="img" items="${imglist}">
								<div class="dp-left">
									<div class="dp-mainimg">
										<img src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${img.prod_id}/${img.filename}"
											alt="${img.filename}" />
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</section>
	</div>
	<script>
		const prodId = params.get("prod_id");
		
		document.getElementById("order").addEventListener("click", function(e){
			e.preventDefault();
			const qty = document.getElementById("qty").value;
			window.location.href = '/buyer/purchase/direct.do?prod_id='+prodId+'&qty='+qty; 
		});
		
		const member_id = ${member_id};
	</script>
	
	
	<div class="review-list">
  <h3>리뷰</h3>
  <c:forEach var="review" items="${revlist}">
    <div class="review-item" data-review-id="${review.review_id}">
      
      <!-- 상단 -->
      <div class="review-header">
        <span class="review-title">${review.title}</span>
        <span class="review-star">
          <c:forEach begin="1" end="${review.star}" var="i">★</c:forEach>
          <c:forEach begin="1" end="${5 - review.star}" var="i">☆</c:forEach>
        </span>
      </div>
      
      <!-- 작성자/작성일 -->
      <div class="review-meta">
        작성자: ${review.name} &nbsp;|&nbsp;
        작성일: ${review.postdate}
      </div>
      
      <!-- 본문 -->
      <div class="review-content">
        ${review.content}
      </div>
      
      <!-- 파일 이미지 -->
      <c:if test="${not empty review.filename}">
        <div>
          <img src="${pageContext.request.contextPath}/uploads/reviewimg/${review.review_id }/${review.filename}" width="500px" alt="리뷰 이미지">
        </div>
      </c:if>
      
      <!-- 하단 (좋아요, 평가) -->
      <div class="review-footer">
        <span>평가: ${review.evaluation}</span>
        <button type="button" class="like-btn ${review.review_liked ? 'active' : ''}"
                data-review-id="${review.review_id}"
                data-liked="${review.review_liked}"
                data-likes="${review.review_like}">
          <span class="heart">❤️</span>
          <span class="like-count">${review.review_like}</span>
        </button>
      </div>
    </div>
  </c:forEach>
</div>
</body>
</html>