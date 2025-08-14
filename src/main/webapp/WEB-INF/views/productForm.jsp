<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 등록 폼</title>
</head>
<body>
  <h2>상품 등록</h2>
  <form action="/seller/write.do" method="post">
    <label for="prod_id">상품 ID:</label>
    <input type="text" id="prod_id" name="prod_id"><br><br>

    <label for="member_id">판매자 회원번호:</label>
    <input type="text" id="member_id" name="member_id"><br><br>

    <label for="prod_name">상품명:</label>
    <input type="text" id="prod_name" name="prod_name"><br><br>

    <label for="prod_category">카테고리:</label>
    <input type="text" id="prod_category" name="prod_category"><br><br>

    <label for="prod_price">가격:</label>
    <input type="number" id="prod_price" name="prod_price"><br><br>

    <label for="prod_quantity">재고 수량:</label>
    <input type="number" id="prod_quantity" name="prod_quantity"><br><br>

    <label for="prod_image">상품 이미지 경로:</label>
    <input type="text" id="prod_image" name="prod_image"><br><br>

    <label for="prod_status">판매 상태:</label>
    <input type="text" id="prod_status" name="prod_status"><br><br>

    <label for="prod_reg_date">등록일:</label>
    <input type="date" id="prod_reg_date" name="prod_reg_date"><br><br>

    <input type="submit" value="등록">
  </form>
</body>
</html>
