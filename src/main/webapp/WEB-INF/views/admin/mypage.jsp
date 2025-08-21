<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- <ul class="admin-menu"> -->
	<!-- 상단 카테고리 바 -->
	<div class="category-bar">
		<ul class="category-menu">
			<li><a
				href="${pageContext.request.contextPath}/admin/product/list.do">상품관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/farm/request/list.do">농장관리</a></li>

			<!-- 회원관리 + 드롭다운 -->
			<%-- <li class="has-submenu"><a href="">회원관리</a>
				<ul class="submenu">
					<li><a
						href="${pageContext.request.contextPath}/admin/member/list.do">구매자
							관리</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/member/list.do">판매자
							관리</a></li>
				</ul></li> --%>
			<li><a
				href="${pageContext.request.contextPath}/admin/member/list.do">회원관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/review/list.do">리뷰관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/inquiry/list.do">문의관리</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/onetoone/list.do">1:1문의</a></li>
		</ul>
	</div>
	<style>
.category-bar {
	background-color: #f9fcfd;
	border-top: 1px solid #eee;
	border-bottom: 1px solid #eee;
}

.category-menu {
	display: flex;
	justify-content: center;
	padding: 10px 0;
	list-style: none;
	margin: 0;
}

.category-menu>li {
	position: relative;
	margin: 0 20px;
}

.category-menu>li>a {
	text-decoration: none;
	font-weight: 500;
	color: #333;
	padding: 8px 12px;
}

.category-menu>li:hover>a {
	color: #4CAF50;
}

.category-menu>li {
	position: relative;
	margin: 0 20px;
	padding-bottom: 10px; /* ⬅︎ hover 영역 확장용 */
}

.submenu {
	display: none;
	position: absolute;
	top: 100%; /* ⬅︎ 부모 아래로 딱 붙게 */
	left: 0;
	background-color: #fff;
	border: 1px solid #ddd;
	list-style: none;
	padding: 0;
	min-width: 120px;
	z-index: 1000;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.submenu li a {
	display: block;
	padding: 8px 12px;
	color: #333;
	text-decoration: none;
}

.submenu li a:hover {
	background-color: #f0f0f0;
}

.has-submenu:hover .submenu {
	display: block;
}
</style>
	<%-- <li><a
			href="${pageContext.request.contextPath}/admin/product/list.do">상품관리</a></li>
		<li><a
			href="${pageContext.request.contextPath}/admin/farm/request/list.do">농장관리</a></li>
		<li>회원관리
			<ul class="sub-depth1">
				<a href="${pageContext.request.contextPath}/admin/member/list.do">-구매자
					관리</a>
				<br>
				<a href="${pageContext.request.contextPath}/admin/member/list.do">-판매자
					관리</a>
			</ul>
		</li>
		<li><a
			href="${pageContext.request.contextPath}/admin/review/list.do">리뷰관리</a></li>
		<li><a
			href="${pageContext.request.contextPath}/admin/inquiry/list.do">문의관리</a></li>
		<li><a
			href="${pageContext.request.contextPath}/admin/onetoone/list.do">1:1문의</a></li> --%>
</body>
</html>