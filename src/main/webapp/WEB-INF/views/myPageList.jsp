<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문목록/배송조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<!-- flatpickr CSS -->
<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
	<div class="sub-content">
		<div class="side-bar">
			<div class="sub-menu-box">
				<h2>마이페이지</h2>
				<ul class="sub-menu-mypage">
					<li>쇼핑정보
						<ul class="sub-depth1">
							<li><a href="#">주문목록</a></li>
						</ul>
					</li>
					<li>고객센터
						<ul class="sub-depth2">
							<li><a href="#">상품문의</a></li>
						</ul>
					</li>
					<li>회원정보
						<ul class="sub-depth3">
							<li><a href="#">회원정보 변경</a></li>
							<li><a href="#">회원 탈퇴</a></li>
							<li><a href="#">배송지 관리</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<div class="mypage-cont">
			<div class="mypage-info">
				<div class="mypage-zone-tit">
					<h3>주문목록/배송조회</h3>
				</div>
				<div class="data-check-box">
					<form method="get" name="DateSearch">
						<h3>조회기간</h3>
						<div class="date-check-list" data-target-name="wDate[]">
							<button type="button" data-value="0">오늘</button>
							<button type="button" data-value="7">7일</button>
							<button type="button" data-value="15">15일</button>
							<button type="button" data-value="30">1개월</button>
							<button type="button" data-value="90">3개월</button>
						</div>

						<div class="date-check-calendar">
							<input type="text" id="picker" name="wDate[]"
								class="js-datepicker" value="2025-08-04"> ~ <input
								type="text" id="pickerEnd" name="wDate[]" class="js-datepicker"
								value="2025-08-04">
							<button type="button" class="btn-date-check">
								<em>조회</em>
							</button>
						</div>
					</form>
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
								<col style="width: 15;">
								<col style="width: 15;">
								<col style="width: 15;">
							</colgroup>
							<thead>
								<th>날짜/주문번호</th>
								<th>배송지</th>
								<th>상품명/옵션</th>
								<th>상품금액/수량</th>
								<th>주문상태</th>
								<th>확인/리뷰</th>
							</thead>
							<tbody>
								<tr>
									<td colspan="6">
										<p>조회내역이 없습니다.</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>