<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="/css/buyer_register.css">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/buyer_register.js" defer></script>
</head>

<body>
  <div class="form-wrapper">
    <h2>회원가입</h2>
    <p>가입을 통해 더 다양한 서비스를 만나보세요!</p>

    <!-- 회원가입 form -->
    <form id="registerForm" method="post" action="/memberForm/buyer.regist.do">
	  <input type="text" name="user_type" value="ROLE_BUYER" hidden="hidden" />
      <!-- 1. 아이디 -->
      <div class="form-line">
        <label for="userid">아이디</label>
        <div class="form-group row-group">
          <input type="text" id="userid" name="user_id" placeholder="아이디 입력 (7자리 이상)" required 
          />
<!--           value="aaaaaaaa" -->
          <button type="button" onclick="checkDuplicateId()">중복 확인</button>
        </div>
      </div>

      <!-- 2. 비밀번호 -->
      <div class="form-line">
        <label for="password">비밀번호</label>
        <div class="form-group">
					<input type="password" id="password" name="user_pw" required
						/>
<!-- 						value="A123123!"  -->
					<p id="pwFormatMsg" class="warning-text" style="display:none;">
            첫 글자 대문자, 특수기호 포함, 7자리 이상이어야 합니다.
          </p>
        </div>
      </div>

      <!-- 3. 비밀번호 확인 -->
      <div class="form-line">
        <label for="password2">비밀번호 확인</label>
        <div class="form-group">
          <input type="password" id="password2" placeholder="비밀번호 재입력" required 
          />
<!--             value="A123123!"  -->
          <p id="pwMismatchMsg" class="warning-text" style="display: none;">비밀번호가 틀립니다. 다시입력하세요.</p>
        </div>
      </div>

      <!-- 4. 이메일 -->
      <div class="form-line">
        <label for="emailId">이메일</label>
        <div class="form-group email-group">
          <input type="text" id="emailId" name="emailid" placeholder="이메일 주소" required 
          /> @
<!--           value="asdfasdf" -->
          <input type="text" id="emailDomain" name="emaildomain" readonly required />
          <select id="domainSelect" onchange="handleDomainSelect(this)">
            <option value="">도메인 선택</option>
            <option value="self">직접입력</option>
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
          </select>
<!--           <input type="hidden" id="email" name="email" value="" /> -->
        </div>
      </div>

      <!-- 5. 이름 -->
      <div class="form-line">
        <label for="name">이름</label>
        <div class="form-group">
          <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required 
          />
           <!-- value="asdfasd" -->
        </div>
      </div>

      <!-- 6. 전화번호 -->
      <div class="form-line">
        <label for="phone2">전화번호</label>
        <div class="form-group row-group phone-row">
          <input type="text" id="phone1" maxlength="3" value=""  required/>
          <input type="text" id="phone2" maxlength="4" required />
          <input type="text" id="phone3" maxlength="4" required />
          <input type="hidden" id="phone_num" name="phone_num" value="" />
        </div>
      </div>

      <!-- 가입 버튼 -->
      <button type="submit" class="submit-btn" id="submitBtn" disabled>가입하기</button>
    </form>
  </div>
</body>
</html>
