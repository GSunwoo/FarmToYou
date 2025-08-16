<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문목록/배송조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<div class="sub-content">
		<div class="side-bar">
			<%@ include file="../common/header2.jsp" %>
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
								<col style="width: 15%;">
								<col style="width: 100px;">
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
		                			<c:forEach var="o" items="${orders }">
		                				<tr>
		                					<td>
												<time><fmt:formatDate value="${o.order_date }" pattern="yyyy-MM-dd"></fmt:formatDate></time><br />
												#<c:out value="${o.order_id }" />             					
		                					</td>
		                					<td style="text-align:center;">
		                						<a href="${pageContext.request.contextPath}/Detailpage?prod_id=${o.prod_id}">
		                							<img src="${o.img}" alt="${o.product_name}" class="thumb" loading="lazy" decoding="async">
		                						</a>
		                					</td>
		                					<td>
		                						<a href="${pageContext.request.contextPath}/Detailpage?prod_id=${o.prod_id}">
		                							<c:out value="${o.product_name }" />
		                						</a>
		                					</td>
		                					<td>
		                						<fmt:formatNumber value="${o.price }" pattern="#,###" />원 / <c:out value="${o.qty }" />개
		                					</td>
		                					<td>
		                						<c:out value="${o.status }"></c:out>
		                					</td>
		                					<td>
		                						<!-- 나중에 리뷰페이지작성 경로 따오기  -->
												<a class="btn-sm" href="">리뷰작성</a>
		                					</td>
		                				</tr>
		                			</c:forEach>
		                		</c:when>	
		                		<c:otherwise>
		                			<tr><td colspan="6"><p>조회내역이 없습니다.</p></td></tr>
		                		</c:otherwise>
                			</c:choose>
                		</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>