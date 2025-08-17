<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link
      rel="icon"
      href="https://static.toss.im/icons/png/4x/icon-toss-logo.png"
    />
    <link rel="stylesheet" type="text/css" href="/css/tosspay.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 샘플 프로젝트</title>
  </head>
  <body>
    <div class="result wrapper">
      <div class="box_section">
        <h2 style="padding: 20px 0px 10px 0px">
          <img
            width="35px"
            src="https://static.toss.im/3d-emojis/u1F389_apng.png"
          />
          결제 성공
        </h2>

        <p id="paymentKey"></p>
        <p id="orderId"></p>
        <p id="amount"></p>
        <p><button type="button" class="button" onclick="window.close()">닫기</button></p>
      </div>
    </div>
    <script src="/js/success.js"></script>
    <script>
    // success.jsp 혹은 success.html 안에
    if (window.opener) {
        window.opener.location.href = "/buyer/purchase/complete.do";
    }
</script>
  </body>
</html>