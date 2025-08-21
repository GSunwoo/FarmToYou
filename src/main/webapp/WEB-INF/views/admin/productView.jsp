<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>

<style>
/* 엑셀처럼 격자무늬 표 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
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
    
	<h2>상품 상세 정보</h2>
	<table>
		<tbody>
			<tr>
				<th>상품번호</th>
				<td>${product.prod_id}</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td>${product.prod_name}</td>
			</tr>
			<tr>
				<th>상품등록일</th>
				<%-- <td><fmt:formatDate value="${product.prod_date}" pattern="yyyy-MM-dd" /></td> --%>
			</tr>
			<tr>
				<th>상품가격</th>
				<td>${product.prod_price}</td>
			</tr>
			<tr>
				<th>상품재고</th>
				<td>${product.prod_stock}</td>
			</tr>
			<tr>
				<th>품목</th>
				<td>${product.prod_cate}</td>
			</tr>
			<tr>
				<th>상품설명</th>
				<td>${product.prod_content}</td>
			</tr>
		</tbody>
	</table>

	<p>
		<a href="/admin/product/delete.do?prod_id=${product.prod_id}">삭제</a>
	</p>
	</div>
</body>
</html>