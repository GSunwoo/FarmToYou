<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/Productpage.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="/js/wishlist/wishlist.js"></script>
<style>
/* 장바구니 스타일 커스텀 */
.cart-container {
	max-width: 900px;
	margin: 40px auto;
	padding: 10px;
}

.cart-table {
	width: 100%;
	border-collapse: collapse;
}

.cart-table th, .cart-table td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

.cart-qty-box {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 5px;
}

.qty-btn, .delete-btn {
	background: #eee;
	border: 1px solid #ccc;
	padding: 5px 10px;
	cursor: pointer;
}

.qty-input {
	width: 40px;
	text-align: center;
	border: none;
	background: transparent;
}

.delete-btn {
	color: #fff;
	background: #d9534f;
	border-color: #d43f3a;
}

.delete-btn:hover {
	background: #c9302c;
}

.total-price {
	text-align: right;
	font-size: 18px;
	font-weight: bold;
	padding: 15px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<div class="cart-container">
		<h2>🛒 장바구니</h2>

		<c:choose>
			<c:when test="${not empty wishlist}">
				<table class="cart-table">
					<thead>
						<tr>
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody id="cart-body">
						<c:forEach var="row" items="${wishlist}">
							<tr data-prod-id="${row.prod_id}" data-wish-id="${row.wish_id}">
								<td><a
									href="${pageContext.request.contextPath}/guest/Detailpage.do?prod_id=${row.prod_id}">
										${row.prod_name} </a></td>
								<td>
									<div class="cart-qty-box">
										<button type="button" class="qty-btn" data-delta="-1">-</button>
										<input type="text" class="qty-input" value="${row.prod_qty}"
											readonly>
										<button type="button" class="qty-btn" data-delta="1">+</button>
									</div>
								</td>
								<td class="price" data-price="${row.prod_price}"><fmt:formatNumber
										value="${row.prod_price * row.prod_qty}" />원</td>
								<td>
									<button type="button" class="delete-btn">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="total-price">
					총 합계: <span id="total-amount"></span>원
				</div>
			</c:when>
			<c:otherwise>
				<div style="text-align: center; padding: 20px;">장바구니에 상품이
					없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>

</body>
</html>
