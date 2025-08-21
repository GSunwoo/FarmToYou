<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>문의관리</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: #f8f9fa;
    }

    h2 {
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }

    th {
      background: #f1f1f1;
    }

    a.title-link {
      color: #007BFF;
      text-decoration: none;
    }

    a.title-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <h2>문의관리</h2>

  <table>
    <thead>
      <tr>
        <th>번호</th>
        <th>상품번호</th>
        <th>제목</th>
        <th>작성자ID</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="inq" items="${inquiryList}">
        <tr>
          <td>${inq.inquiry_id}</td>
          <td>${inq.prod_id}</td>
          <td>
            <a href="/admin/inquiry/view.do?inquiry_id=${inq.inquiry_id}" class="title-link">
              <c:out value="${inq.title}" />
            </a>
          </td>
          <td>${inq.user_id}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</body>
</html>
