<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/myPageMain.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mainpage.css" />
<style>
/* 페이지 래퍼 */
.review-write-page {
	max-width: 780px;
	margin: 40px auto;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .05);
	overflow: hidden;
}

.review-write-header {
	padding: 18px 22px;
	border-bottom: 1px solid #e9ecef;
	font-size: 18px;
	font-weight: 600;
}

/* 표형 폼 레이아웃 */
.form-table {
	display: grid;
	grid-template-columns: 180px 1fr;
	align-items: stretch;
}

.form-row {
	display: contents; /* 각 라벨/필드가 grid 셀에 그대로 들어가도록 */
}

.form-label {
	background: #f1f3f5;
	border-right: 1px solid #e9ecef;
	border-bottom: 1px solid #e9ecef;
	padding: 14px 16px;
	font-weight: 600;
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

.form-field {
	border-bottom: 1px solid #e9ecef;
	padding: 12px 16px;
	display: flex;
	align-items: center;
	gap: 10px;
}

/* 인풋 공통 */
.form-field input[type="text"], 
	.form-field input[type="file"], .form-field textarea, .form-field select
	{
	width: 100%;
	border: 1px solid #ced4da;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
	outline: none;
	background: #fff;
}
.form-field input[type="number"]
{
	width: 15%;
	border: 1px solid #ced4da;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
	outline: none;
	background: #fff;
}

/*  .form-star {
	border-bottom: 1px solid #e9ecef;
	padding: 12px 16px;
	display: flex;
	align-items: center;
	gap: 10px;
}  */

/* 인풋 공통 */
/* .form-star input[type="text"], .form-star input[type="number"],
	.form-star input[type="file"], .form-star textarea, .form-star select
	{
	width: 100%;
	border: 1px solid #ced4da;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
	outline: none;
	background: #fff;
} */

.form-field textarea {
	min-height: 140px;
	resize: vertical;
}

.form-field input[readonly] {
	background: #f8f9fa;
	color: #495057;
}

/* 버튼 영역 */
.form-actions {
	display: flex;
	justify-content: flex-start;
	gap: 10px;
	padding: 16px;
}

.btn {
	padding: 10px 16px;
	font-size: 14px;
	border: 1px solid transparent;
	border-radius: 8px;
	cursor: pointer;
}

.btn-primary {
	background: #2d7ef7;
	color: #fff;
}

.btn-secondary {
	background: #e9ecef;
	color: #212529;
}

.review-write-page {
	margin-top: 140px;
} /* 헤더 높이에 맞춰 수치만 조절 */

/* 모바일 대응 */
@media ( max-width :640px) {
	.form-table {
		grid-template-columns: 1fr;
	}
	.form-label {
		border-right: none;
	}
}
</style>
</head>
<body class="simple-page">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="review-write-page">
		<div class="review-write-header">리뷰 작성</div>

		<!-- 필요 가정: 세션에 로그인 사용자 정보가 있음 -->
		<!-- sessionScope.member_id, sessionScope.name  -->
		<!-- prod_id는 쿼리스트링 ?prod_id=... 로 전달된다고 가정 -->

		<form id="review" action="/buyer/review/write.do" method="post"
			enctype="multipart/form-data">

			<!-- 내부/자동 값 -->
			<input type="hidden" id="review_id" name="review_id" value="">
			<input type="hidden" id="review_like" name="review_like" value="0">

		

			<!-- 상품 ID (쿼리스트링에서 받기) -->
			<%--  <div class="form-row">
        <div class="form-label">상품 ID</div>
        <div class="form-field">
    <input type="text" id="prod_id" name="prod_id"
           value="${prod_id}" ><br><br>
          </div> --%>
			<!-- readonly 리뷰작성때매 일부러 빼놨음 나중에 추가해야됨 -->
			
			
					<input type="hidden" id="prod_id" name="prod_id" value="${prod_id}" /> <!-- 상품id -->
					<input type="hidden" id="purc_id" name="purc_id" value="${purc_id}" /> <!-- 구매id -->
					
			<!-- 제목 -->
			<div class="form-table">
				<div class="form-label">제목</div>
				<div class="form-field">
					<input type="text" id="title" name="title" required maxlength="100"><br>
					<br>
				</div>
			</div>
			<!-- <div class="form-row">
				<div class="form-label">제목</div>
				<div class="form-field">
					<input type="text" id="title" name="title" required maxlength="100"><br>
					<br>
				</div>
			</div> -->

			<!-- 내용 -->
			<div class="form-table">
				<div class="form-label">내용</div>
				<div class="form-field">
					<textarea id="content" name="content" rows="6" cols="60" required></textarea>
					<br>
					<br>
				</div>
			</div>
			
			
			<!-- <div class="form-row">
				<div class="form-label">내용</div>
				<div class="form-field">
					<textarea id="content" name="content" rows="6" cols="60" required></textarea>
					<br>
					<br>
				</div>
			</div> -->

			<!-- 별점 -->
			<div class="form-table">
				<div class="form-label">별점 (1~5)</div>
				<div class="form-field">
					<input type="number" id="star" name="star" min="1" max="5" required><br>
					<br>
				</div>
			</div>
			
			
			<!-- <div class="form-row">
				<div class="form-label">별점 (1~5)</div>
				<div class="form-field">
					<input type="number" id="star" name="star" min="1" max="5" required><br>
					<br>
				</div>
			</div> -->

			<!-- 평가 (자유 텍스트; 필요 시 select로 변경 가능) -->
			<div class="form-table">
				<div class="form-label">평가</div>
				<div class="form-field">
					<input type="text" id="evaluation" name="evaluation" maxlength="50"
						placeholder="예: 아주 좋아요"><br>
					<br>
				</div>
			</div>
			
			<!-- <div class="form-row">
				<div class="form-label">평가</div>
				<div class="form-field">
					<input type="text" id="evaluation" name="evaluation" maxlength="50"
						placeholder="예: 아주 좋아요"><br>
					<br>
				</div>
			</div> -->

			<!-- 내부에서 설정할 값 -->
			<input type="hidden" id="reviewimg_id" name="reviewimg_id"> <input
				type="hidden" id="idx" name="idx">

			<!-- 실제 이미지 업로드 -->
			<div class="form-table">
				<div class="form-label">이미지</div>
				<div class="form-field">
					<input type="file" id="insertImg" name="uploadFile" 
					accept="image/*" multiple required><br>
					<br>
				</div>
			</div>
			
			<!-- <div class="form-row">
				<div class="form-label">이미지</div>
				<div class="form-field">
					<input type="file" id="insertImg" name="uploadFile"
						accept="image/*" multiple required><br>
					<br>
				</div>
			</div> -->

			<!-- <div class="form-row"> -->
				<!-- <div class="form-label" style="border-bottom: none;"> -->
					<div class="form-field" style="border-bottom: none;">
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-secondary"
								onclick="history.back()">취소</button>
						</div>
					</div>
				<!-- </div> -->
			<!-- </div> -->
		</form>
	</div>
</body>
</html>