<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<title>마이 페이지 메인</title>
</head>
<body class="simple-page">
	<%@ include file="./common/header.jsp"%>
	<div class="mypage-wrapper">
		<div class="sub-content">
			<%@ include file="./common/header2.jsp"%>
			<!-- 사이드바 -->
			<div class="mypage-main-cont">
				<div class="mypage-main-info">
					<!-- 최근 주문 정보 -->
					<div class="mypage-main-info-cont">
						<h2>
							최근 주문 정보 <span class="order-info-subtext">최근 30일 내에 주문하신
								내역입니다</span>
						</h2>
						<div class="mypage-main-table-type">
							<table>
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 12%;">
									<col>
									<col style="width: 15%;">
									<col style="width: 15%;">
									<col style="width: 15%;">
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
											<c:forEach var="o" items="orders">
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
						</div>
					</div>
					
					<div class="mypage-main-info-cont">
						<h2> 최근 본 상품 </h2>
						<div class="mypage-main-table-type">
							<table>
								<thead>
									<tr>
										<th>최근 본 상품</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty Views }">
											<c:forEach var="v" items="${Views }">
												<tr>
													<td><a
														href="${pageContext.request.contextPath}/Detailpage?prod_id=${v.prod_id}">
															<img src="${rv.img}" alt="${rv.prod_name}"
															class="thumb-sm" loading="lazy" decoding="async"> <span
															class="rv-name"><c:out value="${v.prod_name }"></c:out></span>
													</a></td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="text-align: center"><p>최근 본 상품이 없습니다.</p></td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<!-- .mypage-main-info-cont -->
				</div>
				<!-- .mypage-main-info -->
			</div>
			<!-- .mypage-main-cont -->
		</div>
		<!-- .sub-content -->
	</div>
	<!-- .mypage-wrapper -->
</body>
</html>