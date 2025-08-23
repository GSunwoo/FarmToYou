<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문목록/배송조회</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageList.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage-wrapper">
		<div class="sub-content">
			<aside class="mypage-sidebar">
				<%@ include file="../common/header2.jsp"%>
			</aside>
			<div class="mypage-cont">
				<div class="mypage-info">
					<div class="mypage-zone-tit">
						<h3>주문목록/배송조회</h3>
					</div>
					<div class="mypage-info-content">
						<div class="mypage-table-type">
							<c:choose>
								<c:when test="${not empty orders}">
									<ul class="order-card-list">
										<c:forEach var="o" items="${orders}">
											<li class="order-card">
												<div class="order-card-head">
													<div class="order-meta">
														<time>
															<fmt:formatDate value="${o.purc_date}"
																pattern="yyyy-MM-dd" />
														</time>
														<span class="order-num">#<c:out
																value="${o.order_num}" /></span>
													</div>
													<span class="badge-state">
														<c:choose>
															<c:when test="${o.purc_state eq 'chk_order'}">주문확인중</c:when>
															<c:when test="${o.purc_state eq 'prepare_order'}">상품준비중</c:when>
															<c:when test="${o.purc_state eq 'deli_order'}">배송중</c:when>
															<c:when test="${o.purc_state eq 'cmpl_order'}">배송완료</c:when>
															<c:otherwise>물건준비중</c:otherwise>
														</c:choose>
													</span>
												</div> 
												<div class="order-body">
													<a class="thumb"
														href="${pageContext.request.contextPath}/guest/Detailpage?prod_id=${o.prod_id}">
														 <img
														src="${pageContext.request.contextPath}/uploads/prodimg/prod_id/${o.prod_id}/${o.filename}"
														alt="${fn:escapeXml(o.prod_name)}">
													</a>

													<div class="order-info">
														<a class="title"
															href="${pageContext.request.contextPath}/guest/Detailpage?prod_id=${o.prod_id}">
															<c:out value="${o.prod_name}" />
														</a>

														<div class="price-line">
															<span class="total-price"> <fmt:formatNumber
																	value="${o.prod_price * o.qty}" pattern="#,###" />원
															</span> <span class="sub-price"> (<fmt:formatNumber
																	value="${o.prod_price}" pattern="#,###" />원 × <c:out
																	value="${o.qty}" />개)
															</span>
														</div>

														<div class="order-actions">
															<c:choose>
																<c:when test="${o.isWritten eq 1}">
																	<a class="btn-sm"
																		href="javascript:void(0)" style="pointer-events:none; opacity:0.8;">
																		작성 완료 </a>
																</c:when>
																<c:when test="${o.purc_state eq 'cmpl_order' }">
																	<a class="btn-sm"
																		href="${pageContext.request.contextPath}/buyer/review/write.do?prod_id=${o.prod_id}&purc_id=${o.purc_id}">
																		리뷰 작성 </a>
																</c:when>
																<c:otherwise>
																	<a class="btn-sm" href="javascript:void(0)" style="pointer-events:none; opacity:0.5;">
																		리뷰 작성
																	</a>
																</c:otherwise>
															</c:choose>
														</div>
													</div>
												</div>
											</li>
										</c:forEach>
									</ul>
								</c:when>
								<c:otherwise>
									<div class="order-empty">
										<p>조회내역이 없습니다.</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<!-- <c:set var="baseUrl" value="${pageContext.request.contextPath}/buyer/myPageList.do"/>
						
						 <div class="pagination-wrap" style="margin-top:16px; text-align:center;">
						  <ul class="pagination" style="display:inline-flex; gap:6px; list-style:none; padding:0;">
						    <c:if test="${hasPrev}">
						      <li><a href="<c:url value='${baseUrl}?page=${prevPage}&size=${size}'/>">이전</a></li>
						    </c:if>
						
						    <c:forEach var="p" begin="${startPage}" end="${endPage}">
						      <li>
						        <c:choose>
						          <c:when test="${p == page}">
						            <span style="font-weight:700; text-decoration:underline;">${p}</span>
						          </c:when>
						          <c:otherwise>
						            <a href="<c:url value='${baseUrl}?page=${p}&size=${size}'/>">${p}</a>
						          </c:otherwise>
						        </c:choose>
						      </li>
						    </c:forEach>
						
						    <c:if test="${hasNext}">
						      <li><a href="<c:url value='${baseUrl}?page=${nextPage}&size=${size}${qs}'/>">다음</a></li>
						    </c:if> 
						  </ul>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>