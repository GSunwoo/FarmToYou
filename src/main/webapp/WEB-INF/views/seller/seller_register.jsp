<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="/css/seller_register.css">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/seller_register.js" defer></script>
</head>

<body>
  <div class="form-wrapper">
    <h2>판매자 회원가입</h2>
    <p>가입을 통해 더 다양한 서비스를 만나보세요!</p>

    <form id="registerForm" method="post" action="/memberForm/seller.regist.do">
	  <input type="text" name="user_type" value="ROLE_SELLER" hidden="hidden" />
      <div class="form-line">
        <label for="userid">아이디</label>
        <div class="form-group row-group">
          <input type="text" id="userid" name="user_id" placeholder="아이디 입력 (7자리 이상)" required />
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
          <input type="text" id="emailId" name="emailid" placeholder="이메일 주소" required /> @
          <input type="text" id="emailDomain" name="emaildomain" readonly required />
          <select id="domainSelect" onchange="handleDomainSelect(this)">
            <option value="">도메인 선택</option>
            <option value="self">직접입력</option>
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
          </select>
          <input type="hidden" id="email" name="email" value="" />
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
          <input type="hidden" id="phone_num" name="phone_num" value="" />
        </div>
      </div>

      <div class="form-line">
        <label>사업자등록번호</label>
        <div class="row-group">
          <input type="text" id="bizNum" name="farm_id" maxlength="10" placeholder="숫자만 입력">
          <button type="button" onclick="verifyBizNum()">인증하기</button>
        </div>
      </div>

      <div class="form-line">
        <label>대표자명</label>
        <div class="form-group">
          <input type="text" id="ceoName" name="owner_name" readonly>
        </div>
      </div>

      <div class="form-line">
        <label>상호</label>
        <div class="form-group">
          <input type="text" id="companyName" name="brand_name" readonly>
        </div>
      </div>

      <div class="form-line">
        <label>사업장 주소</label>
        <div class="form-group">
          <input type="text" id="zipcode" name="com_zip" class="half-width" readonly placeholder="우편번호">
          <input type="text" id="address" name="com_addr1" readonly placeholder="기본주소">
          <input type="text" id="detailAddress" name="com_addr2" readonly placeholder="상세주소">
        </div>
      </div>

      <div class="form-line">
        <label>예금주</label>
        <div class="form-group">
          <input type="text" id="managerName" name="entryman" placeholder="담당자 이름">
        </div>
      </div>

      <div class="form-line">
        <label>정산 계좌</label>
        <div class="form-group account-group">
          <input type="text" id="accountNumber" name="account" placeholder="계좌번호 입력">
          <select id="bankSelect" name="bank">
            <option value="">은행 선택</option>
            <option value="신한">신한</option>
            <option value="국민">국민</option>
            <option value="농협">농협</option>
            <option value="하나">하나</option>
            <option value="우리">우리</option>
            <option value="기업">기업</option>
          </select>
        </div>
      </div>

      <button type="submit" class="submit-btn" id="submitBtn" disabled>가입하기</button>
    </form>
  </div>
</body>
</html>
