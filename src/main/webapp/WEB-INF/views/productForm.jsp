<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 등록 폼</title>
</head>
<body>
  <h2>상품 등록</h2>
  <form action="/seller/write.do" method="post">

    <label for="prod_name">상품명:</label>
    <input type="text" id="prod_name" name="prod_name"><br><br>

    <label for="prod_price">가격:</label>
    <input type="number" id="prod_price" name="prod_price"><br><br>

    <label for="prod_stock">재고:</label>
    <input type="number" id="prod_stock" name="prod_stock"><br><br>

     <label for="prod_cate">카테고리</label>
      <select id="prod_cate" name="prod_cate">
        <option value="">선택하세요</option>
        <option value="fruit">과일</option>
        <option value="vegetable">채소</option>
      </select>

    <label for="member_id">판매자 일련번호:</label>
    <input type="text" id="member_id" name="member_id"><br><br>

    <label for="prod_content">상품 설명:</label><br>
    <textarea id="prod_content" name="prod_content" rows="4" cols="50"></textarea><br><br>

    <label for="filename">파일명:</label>
    <input type="text" id="filename" name="filename"><br><br>

    <input type="submit" value="상품 등록">
  </form>
</body>
</html>
