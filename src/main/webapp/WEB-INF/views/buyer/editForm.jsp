<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
<link rel="stylesheet" href="/css/buyer_register.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/buyer_edit.js" defer></script>
</head>
<body>
  <div class="form-wrapper">
    <h2>회원정보 변경</h2>
    <p>변경하실 비밀번호와 전화번호를 입력해주세요</p>
	
    <form id="registerForm" method="post" action="/buyer/editBuyerMemberInfo.do">
	  <input type="text" name="user_type" value="ROLE_BUYER" hidden="hidden" />
      <!-- 1. 아이디 -->
      <div class="form-line">
        <label for="userid">아이디</label>
        <div class="form-group row-group">
          <input type="text" id="userid" name="user_id" value="${memberDTO.user_id}" readonly/>
        </div>
      </div>

      <!-- 2. 비밀번호 -->
      <div class="form-line">            
        <label for="password">비밀번호</label>
        <div class="form-group">
          <input type="password" id="password" name="user_pw" placeholder="새 비밀번호 입력" required value=""/>
          <p id="pwFormatMsg" class="warning-text" style="display:none;">
            첫 글자 대문자, 특수기호 포함, 7자리 이상이어야 합니다.
          </p>
        </div>
      </div>

      <!-- 3. 비밀번호 확인 -->
      <div class="form-line">
        <label for="password2">비밀번호 확인</label>
        <div class="form-group">
          <input type="password" id="password2" placeholder="비밀번호 재입력" required value=""/>
          <p id="pwMismatchMsg" class="warning-text" style="display: none;">비밀번호가 틀립니다. 다시입력하세요.</p>
        </div>
      </div>

      <!-- 4. 이메일 -->
      <div class="form-line">
        <label for="emailId">이메일</label>
        <div class="form-group email-group">
          <input type="text" id="emailId" name="emailid" placeholder="이메일 주소" required 
          value="${memberDTO.emailid }" /> @
          <input type="text" id="emailDomain" name="emaildomain"  required value="${memberDTO.emaildomain}" />
<!--           <input type="hidden" id="email" name="email" value="" /> -->
        </div>
      </div>

      <!-- 5. 이름 -->
      <div class="form-line">
        <label for="name">이름</label>
        <div class="form-group">
          <input type="text" id="name" name="name" value="${memberDTO.name}" readonly/>
        </div>
      </div>

      <!-- 6. 전화번호 -->
      <div class="form-line">
        <label for="phone2">전화번호</label>
        <div class="form-group row-group phone-row">
          <input type="text" value="010" id="phone1" readonly />
        <input type="text" id="phone2" maxlength="4" required 
               value="${fn:substring(memberDTO.phone_num, 3, 7)}"/>
        <input type="text" id="phone3" maxlength="4" required 
               value="${fn:substring(memberDTO.phone_num, 7, 11)}"/>
          <input type="hidden" id="phone_num" name="phone_num" value="${memberDTO.phone_num }" />
        </div>
      </div>

      <button type="button" class="submit-btn" onclick="history.back();">이전</button>
      <!-- 가입 버튼 -->
      <button type="submit" class="submit-btn" id="submitBtn">회원정보수정</button>
    </form>
  </div>
</body>
</html>