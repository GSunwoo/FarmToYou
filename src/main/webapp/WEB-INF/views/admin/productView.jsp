<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li>상품번호 : ${product.prod_id }</li>
		<li>상품명 : ${product.prod_date }</li>
		<li>상품등록일 : ${product.prod_id }</li>
		<li>상품가격 : ${product.prod_price }</li>
		<li>상품재고 : ${product.prod_stock }</li>
		<li>품목 : ${product.prod_cate }</li>
		<li>상품설명 : ${product.prod_content }</li>
	</ul>
	<a href="/admin/product/delete.do?prod_id=${product.prod_id}">삭제</a>
</body>
</html>