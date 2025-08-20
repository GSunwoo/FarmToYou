<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="admin-menu">
		<li><a href="/admin/product/list.do">상품관리</a></li>
		<li><a href="/admin/farm/list.do">농장관리</a></li>
		<li>회원관리
			<ul class="sub-depth1">
				<a href="/admin/member/list.do">-구매자 관리</a><br>
				<a href="/admin/member/list.do">-판매자 관리</a>
			</ul>
		</li>
		<li><a href="/admin/review/list.do">리뷰관리</a></li>
		<li><a href="/admin/inquiry/list.do">문의관리</a></li>
		<li><a href="/admin/onetoone/list.do">1:1문의</a></li>
	</ul>
</body>
</html>