<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="./src/main/resources/static/css/buyer_register.css">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="./src/main/resources/static/js/buyer_register.js" defer></script>
</head>

<body>
  <div class="form-wrapper">
    <h2>일반 회원가입</h2>
    <p>가입을 통해 더 다양한 서비스를 만나보세요!</p>

    <form id="registerForm" method="post" action="registerBuyer.do">

      <div class="form-line">
        <label for="user_id">아이디</label>
        <div class="form-group row-group">
          <input type="text" id="user_id" name="user_id" placeholder="아이디 입력 (7자리 이상)" required />
          <button type="button" onclick="checkDuplicateId()">중복 확인</button>
        </div>
      </div>

      <div class="form-line">
        <label for="password">비밀번호</label>
        <div class="form-group">
          <input type="password" id="password" name="user_pw" placeholder="맨 앞 대문자, 특수문자 포함, 7자리 이상" required />
        </div>
      </div>

      <div class="form-line">
        <label for="password2">비밀번호 확인</label>
        <div class="form-group">
          <input type="password" id="password2" placeholder="비밀번호 재입력" required />
          <p id="pwMismatchMsg" class="warning-text" style="display: none;">비밀번호가 틀립니다. 다시입력하세요.</p>
        </div>
      </div>

      <div class="form-line">
        <label for="emailId">이메일</label>
        <div class="form-group email-group">
          <input type="text" id="emailId" placeholder="이메일 주소" required /> @
          <input type="text" id="emailDomain" readonly required />
          <input type="text" id="email" name="email" value="" hidden />
          <select id="domainSelect" onchange="handleDomainSelect(this)">
            <option value="">도메인 선택</option>
            <option value="self">직접입력</option>
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
            <option value="gmail.com">gmail.com</option>
          </select>
        </div>
      </div>

      <div class="form-line">
        <label for="name">이름</label>
        <div class="form-group">
          <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required />
        </div>
      </div>

      <div class="form-line">
        <label for="phone2">전화번호</label>
        <div class="form-group row-group phone-row">
          <input type="text" value="010" readonly />
          <input type="text" id="phone2" maxlength="4" required />
          <input type="text" id="phone3" maxlength="4" required />
          <input type="text" id="phone_num" name="phone_num" value="" hidden />
        </div>
      </div>

      <div class="form-line">
        <label for="address">주소</label>
        <div class="form-group">
          <div class="row-group left" style="width: 100%;">
            <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly class="half-width" />
            <button type="button" onclick="execDaumPostcode()">주소 찾기</button>
          </div>
          <div style="width: 100%;">
            <input type="text" id="address" name="addr1" placeholder="기본 주소" readonly required style="width: 100%;" />
          </div>
          <div style="width: 100%;">
            <input type="text" id="detailAddress" name="addr2" placeholder="상세 주소를 입력하세요" required style="width: 100%;" />
          </div>
        </div>
      </div>

      <button type="submit" class="submit-btn" id="submitBtn" disabled>가입하기</button>
    </form>
  </div>
</body>
</html>
