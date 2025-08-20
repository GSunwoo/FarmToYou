<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>문의 상세 보기</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: #f8f9fa;
    }

    .view-container {
      max-width: 800px;
      margin: auto;
      background: #fff;
      padding: 30px;
      border: 1px solid #ddd;
      border-radius: 10px;
    }

    h2 {
      margin-bottom: 20px;
    }

    .view-row {
      display: flex;
      margin-bottom: 15px;
    }

    .view-label {
      width: 150px;
      font-weight: bold;
      color: #333;
    }

    .view-value {
      flex: 1;
      color: #555;
    }

    .back-btn {
      display: inline-block;
      margin-top: 30px;
      padding: 8px 16px;
      background: #4CAF50;
      color: white;
      text-decoration: none;
      border-radius: 5px;
    }

    .back-btn:hover {
      background: #45a049;
    }
  </style>
</head>
<body>

  <div class="view-container">
    <h2>문의 상세 보기</h2>

    <div class="view-row">
      <div class="view-label">문의번호</div>
      <div class="view-value">${inquiry.inquiry_id}</div>
    </div>

    <div class="view-row">
      <div class="view-label">상품번호</div>
      <div class="view-value">${inquiry.prod_id}</div>
    </div>

    <div class="view-row">
      <div class="view-label">제목</div>
      <div class="view-value">${inquiry.title}</div>
    </div>

    <div class="view-row">
      <div class="view-label">내용</div>
      <div class="view-value">${inquiry.content}</div>
    </div>

    <div class="view-row">
      <div class="view-label">작성자 ID</div>
      <div class="view-value">${inquiry.user_id}</div>
    </div>
	
		<p>
		<a href="/admin/inquiry/delete.do?prod_id=${inquiry.prod_id}">삭제</a>
	</p>
    <a href="/admin/inquiry/list.do" class="back-btn">← 목록으로</a>
  </div>

</body>
</html>
