<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 목록 페이지</title>

<style>
/* 기본 레이아웃 스타일 */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: #f0f2f5;
    }
table {
	width: 100%;
	border-collapse: collapse; /* 격자무늬 필수 */
	table-layout: fixed; /* 균등폭(선택) */
	background: #fff;
}

thead th, tbody td {
	border: 1px solid #ddd; /* 격자 테두리 */
	padding: 10px 12px;
	text-align: left;
	word-break: break-all;
}

thead th {
	background: #f7f7f8; /* 헤더 옅은 배경 */
	font-weight: 600;
}

tbody tr:nth-child(even) {
	background: #fafafa; /* 줄무늬(선택) */
}

tbody tr:hover {
	background: #f2f6ff; /* 호버 하이라이트(선택) */
}

/* 페이지네이션(선택) */
.pagination {
	margin-top: 16px;
	display: flex;
	gap: 8px;
}

.pagination a {
	display: inline-block;
	padding: 6px 10px;
	border: 1px solid #ddd;
	text-decoration: none;
	color: #333;
	border-radius: 6px;
}

.pagination a:hover {
	background: #f7f7f8;
}

.pagination a.active {
	background: #4a78ff;
	color: #fff;
	border-color: #4a78ff;
}

.action-btn {
  display:inline-block;
  padding:4px 8px;
  margin:0 2px;
  border:1px solid #ccc;
  border-radius:4px;
  text-decoration:none;
  font-size:13px;
}
.action-btn.edit { background:#e5f1ff; border-color:#4a78ff; color:#1d4ed8; }
.action-btn.delete { background:#ffe5e5; border-color:#f87171; color:#b91c1c; }

</style>

</head>
<body>
<header class="admin-topbar">
    <div class="topbar-inner">
      <h1>환영합니다 관리자님</h1>
    </div>
  </header>

  <div class="admin-wrap">
    <!-- 좌측 사이드바: 네가 가진 mypage.jsp 그대로 include -->
    <aside class="admin-sidebar">
      <jsp:include page="/WEB-INF/views/admin/mypage.jsp"/>
    </aside>
	<h2>상품 목록</h2>

	<table>
		<thead>
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>상품가격</th>
				<th>품목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="product" items="${products}">
				<tr>
					<td>${product.prod_id}</td>
					<td><a
						href="/admin/product/view.do?prod_id=${product.prod_id}">${product.prod_name}</a></td>
					<td>${product.prod_price}</td>
					<td>${product.prod_cate}</td>
					<%-- <td>
					<a href="/admin/product/edit.do?prod_id=${product.prod_id}">수정</a> 
					|
					<a href="/admin/product/delete.do?prod_id=${product.prod_id}">삭제</a>
					</td> --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 페이지네이션 -->
	<div class="pagination">
		<c:set var="totalPages"
			value="${(paramMap.totalCount / paramMap.pageSize) + ((paramMap.totalCount % paramMap.pageSize) > 0 ? 1 : 0)}" />
		<c:forEach var="i" begin="1" end="${totalPages}">
			<a href="?pageNum=${i}"
				class="${i == paramMap.pageNum ? 'active' : ''}">${i}</a>
		</c:forEach>
	</div>
	</div>
</body>
</html>