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
.qty-btn, .pay-btn {
	background: #2563eb;
	border: 1px solid #ccc;
	padding: 5px 10px;
	cursor: pointer;
	
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
.pay-btn {
	color: #fff;
	background: #c9b9b9;
	border: 1px solid #ccc;
	padding: 5px 10px;
	cursor: pointer;
	
}


.delete-btn:hover {
	background: #c9302c;
}

.pay-btn:hover {
	background: #2059d6;
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
							<th style="width:50px;">선택</th>
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody id="cart-body">
						<c:forEach var="row" items="${wishlist}">
							<tr data-prod-id="${row.prod_id}" data-wish-id="${row.wish_id}">
								 <td>
        							<input type="checkbox" class="select-item" />
      							</td>
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
									<button type="button"  class="delete-btn">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="total-price">
					총 합계: <span id="total-amount"></span>원
					<div>
						<button id="wishlist" type="button" class="pay-btn" disabled>결제하기</button>
					</div>					
				</div>
			</c:when>
			<c:otherwise>
				<div style="text-align: center; padding: 20px;">장바구니에 상품이
					없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>
	<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  const cartBody = document.getElementById('cart-body');
  const totalEl = document.getElementById('total-amount');
  const payBtn = document.getElementById('wishlist'); // ← 버튼 id 변경

  function getRowQty(row) {
    return parseInt(row.querySelector('.qty-input').value, 10) || 0;
  }
  function getRowUnitPrice(row) {
    return parseInt(row.querySelector('.price').dataset.price, 10) || 0;
  }
  function formatNumber(n) { return n.toLocaleString('ko-KR'); }

  function recalcRowPrice(row) {
    const unit = getRowUnitPrice(row);
    const qty = getRowQty(row);
    row.querySelector('.price').textContent = formatNumber(unit * qty) + '원';
  }

  function computeSelectedTotal() {
    let sum = 0, anyChecked = false;
    cartBody.querySelectorAll('tr').forEach(row => {
      const cb = row.querySelector('.select-item');
      if (cb && cb.checked) {
        anyChecked = true;
        sum += getRowUnitPrice(row) * getRowQty(row);
      }
    });
    totalEl.textContent = formatNumber(sum);
    if (payBtn) payBtn.disabled = !anyChecked;
  }


  // 체크 선택 합계
  cartBody.addEventListener('change', (e) => {
    if (e.target.classList.contains('select-item')) computeSelectedTotal();
  });

  // 초기 상태
  totalEl.textContent = '0';
  if (payBtn) payBtn.disabled = true;

  // 결제: 선택된 항목만 prod_id/qty 반복 파라미터로 전송
  if (payBtn) {
    payBtn.addEventListener('click', () => {
      const selectedRows = [...cartBody.querySelectorAll('tr')].filter(r => {
        const cb = r.querySelector('.select-item');
        return cb && cb.checked;
      });
      if (selectedRows.length === 0) {
        alert('결제할 상품을 선택해주세요.');
        return;
      }

      const qs = new URLSearchParams();
      selectedRows.forEach(row => {
        const wishId = row.dataset.wishId;      // <tr data-prod-id="...">
        qs.append('wishlist', wishId);
      });

      window.location.href = ctx + '/buyer/purchase/wishlist.do?' + qs.toString();
    });
  }
})();
</script>

</body>
</html>
