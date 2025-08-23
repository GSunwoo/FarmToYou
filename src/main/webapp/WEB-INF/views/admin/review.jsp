<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 관리</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* 기본 레이아웃 스타일 */
body {
	font-family: 'Noto Sans KR', sans-serif;
	padding: 40px;
	background: #f0f2f5;
}

table {
	width: 100%;
	border-collapse: collapse; /* 셀 간 경계선 합치기 */
	background: #fff;
}


th, td {
	border: 1px solid #ddd; /* 격자무늬 테두리 */
	padding: 10px;
	text-align: center;
	background: #fff;
}

thead th {
	background-color: #f0f0f0;
	font-weight: bold;
}

.review-thumb {
	width: 80px;
	height: 80px;
	object-fit: cover;
}

.no-data {
	text-align: center;
	color: #999;
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
			<jsp:include page="/WEB-INF/views/admin/mypage.jsp" />
		</aside>
		<div class="container">
			<h2>리뷰 관리</h2>

			<div class="review-table-container">
				<table>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 15%;">
						<col style="width: 45%;">
						<col style="width: 5%;">
					</colgroup>
					<thead>
						<tr>
							<th>주문번호</th>
							<th>날짜</th>
							<th>상품명</th>
							<th>리뷰제목</th>
							<th>내용</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty reviewList}">
							<c:forEach var="rvs" items="${reviewList}">
								<tr>
									<td><c:out value="${rvs.purc_id}" /></td>
									<td><time>
											<c:out value="${rvs.postdate}" />
										</time></td>
									<td><c:out value="${rvs.prod_name}" /></td>

									<td><c:out value="${rvs.title}" /></td>

									<td class="review-content"><c:out value="${rvs.content}" /></td>
									
									<td><a href="/admin/review/delete.do">삭제</a></td>
								</tr>
							</c:forEach>
						</c:if>

						<c:if test="${empty reviewList}">
							<tr>
								<td colspan="5" class="no-data">리뷰가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>
</body>
</html>