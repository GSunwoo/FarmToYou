<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문목록/배송조회</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<div class="sub-content">
		<div class="side-bar">
			<%@ include file="../common/header2.jsp"%>
		</div>
		<div class="mypage-cont">
			<div class="mypage-info">
				<div class="mypage-zone-tit">
					<h3>주문목록/배송조회</h3>
				</div>
				<div class="mypage-info-content">
					<span class="pick-list-num"> " 주문목록 / 배송조회 내역 총 " <strong>0</strong>
						" 건 "
					</span>
					<div class="mypage-table-type">
						<table>
							<colgroup>
								  <col style="width:15%;">
				                  <col style="width:20%;">
				                  <col>
				                  <col style="width:15%;">
				                  <col style="width:15%;">
				                  <col style="width:15%;">
							</colgroup>
							<thead>
								<tr>
									<th>날짜/주문번호</th>
									<th>상품 사진</th>
									<th>상품명</th>
									<th>상품금액/수량</th>
									<th>주문상태</th>
									<th>리뷰</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${not empty orders }">
									<c:forEach var="o" items="${orders }">
										<tr>
											<td><time>
													<fmt:formatDate value="${o.order_date }"
														pattern="yyyy-MM-dd"></fmt:formatDate>
												</time><br /> #<c:out value="${o.order_id }" /></td>
											<td style="text-align: center;"><a
												href="${pageContext.request.contextPath}/Detailpage?prod_id=${o.prod_id}">
													<img src="${o.img}" alt="${o.product_name}" class="thumb"
													loading="lazy" decoding="async">
											</a></td>
											<td><a
												href="${pageContext.request.contextPath}/Detailpage?prod_id=${o.prod_id}">
													<c:out value="${o.product_name }" />
											</a></td>
											<td><fmt:formatNumber value="${o.price }"
													pattern="#,###" />원 / <c:out value="${o.qty }" />개</td>
											<td><c:out value="${o.status }"></c:out></td>
											<td>
												<a class="btn-sm" href="">리뷰작성</a>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6"><p>조회내역이 없습니다.</p></td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
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
</body>
</html>