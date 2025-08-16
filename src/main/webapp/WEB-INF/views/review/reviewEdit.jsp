<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 수정</title>
</head>
<body>

  <h2>리뷰 수정</h2>

  <form action="${pageContext.request.contextPath}/review/update.do"
        method="post" enctype="multipart/form-data">

    <!-- 내부 처리 값 -->
    <input type="hidden" id="review_id" name="review_id" value="${review.review_id}">
    <input type="hidden" id="review_like" name="review_like" value="${review.review_like}">
    <input type="hidden" id="reviewimg_id" name="reviewimg_id" value="${reviewImage.reviewimg_id}">
    <input type="hidden" id="idx" name="idx" value="${reviewImage.idx}">

    <!-- 작성자 -->
    <div>
      <label for="member_id">회원 ID</label>
      <input type="text" id="member_id" name="member_id" value="${review.member_id}" readonly>
    </div>

    <!-- 작성자명 -->
    <div>
      <label for="name">작성자명</label>
      <input type="text" id="name" name="name" value="${review.name}" readonly>
    </div>

    <!-- 상품 ID -->
    <div>
      <label for="prod_id">상품 ID</label>
      <input type="text" id="prod_id" name="prod_id" value="${review.prod_id}" readonly>
    </div>

    <!-- 작성일 -->
    <div>
      <label for="postdate">작성일</label>
      <input type="date" id="postdate" name="postdate" value="${review.postdate}" readonly>
    </div>

    <!-- 제목 -->
    <div>
      <label for="title">제목</label>
      <input type="text" id="title" name="title" value="${review.title}" required>
    </div>

    <!-- 내용 -->
    <div>
      <label for="content">내용</label><br>
      <textarea id="content" name="content" rows="6" cols="60" required>${review.content}</textarea>
    </div>

    <!-- 별점 -->
    <div>
      <label for="star">별점 (1~5)</label>
      <input type="number" id="star" name="star" min="1" max="5" value="${review.star}" required>
    </div>

    <!-- 평가 -->
    <div>
      <label for="evaluation">평가</label>
      <input type="text" id="evaluation" name="evaluation" value="${review.evaluation}">
    </div>

    <!-- 기존 이미지 파일명 -->
    <div>
      <label for="filename">기존 파일명</label>
      <input type="text" id="filename" name="filename" value="${reviewImage.filename}" readonly>
    </div>

    <!-- 새 이미지 업로드 -->
    <div>
      <label for="uploadFile">이미지 변경</label>
      <input type="file" id="uploadFile" name="uploadFile" accept="image/* " multiple >
    </div>

    <!-- 버튼 -->
    <div>
      <button type="submit">리뷰 수정</button>
      <button type="button" onclick="history.back()">취소</button>
    </div>

  </form>

</body>
</html>
