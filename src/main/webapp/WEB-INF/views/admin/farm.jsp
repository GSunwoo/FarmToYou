<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>농장 목록</title>
  <style>
    /* 기본 레이아웃 스타일 */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: #f0f2f5;
    }

    /* 표 스타일 */
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
      background: #f7f7f7;
    }

    /* 상세보기 버튼 스타일 */
    .view-btn {
      padding: 4px 10px;
      background: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    /* 모달창 배경 레이어 */
    .modal {
      display: none;
      position: fixed;
      z-index: 10;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.4);
    }

    /* 모달창 본문 */
    .modal-content {
      background-color: #fff;
      margin: 10% auto;
      padding: 30px;
      border: 1px solid #888;
      width: 600px;
      border-radius: 10px;
    }

    /* 모달 헤더 (닫기 버튼 포함) */
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    /* 닫기 버튼 스타일 */
    .close {
      color: #aaa;
      font-size: 28px;
      cursor: pointer;
    }

    /* 모달 본문 행 스타일 */
    .modal-row {
      margin-bottom: 10px;
    }

    .modal-label {
      font-weight: bold;
      display: inline-block;
      width: 120px;
    }

    .modal-value {
      display: inline-block;
      color: #444;
    }
    
  </style>
</head>
<body>
<header class="admin-topbar">
    <div class="topbar-inner">
      <h1>환영합니다 관리자님</h1>
    </div>
  </header>

  <div class="admin-wrap">
    <!-- 좌측 사이드바: 네가 가진 mypage.jsp 그대로 include -->
    <aside class="admin-sidebar">
      <jsp:include page="/WEB-INF/views/admin/mypage.jsp"/>
    </aside>
  <h2>농장 목록</h2>

  <!-- 농장 목록 테이블 -->
  <table>
  
    <thead>
      <tr>
        <th>회원ID</th>
        <th>대표자명</th>
        <th>브랜드명</th>
        <th>상세보기</th>
      </tr>
    </thead>
    <tbody>
  <tr>
    <td>farmuser01</td>
    <td>홍길동</td>
    <td>햇살농장</td>
    <td><button class="view-btn" onclick="openModal(1)">보기</button></td>
  </tr>
  <tr>
    <td>farmuser02</td>
    <td>이영희</td>
    <td>맑은들농장</td>
    <td><button class="view-btn" onclick="openModal(2)">보기</button></td>
  </tr>
</tbody>
    
    <tbody>
      <!-- 반복문으로 농장 리스트 출력 -->
      <c:forEach var="farm" items="${farmList}">
        <tr>
          <td>${farm.member_id}</td>
          <td>${farm.owner_name}</td>
          <td>${farm.brand_name}</td>
          <!-- 상세보기 버튼: 클릭 시 모달창 열기 -->
          <td><button class="view-btn" onclick="openModal(${farm.farm_id})">보기</button></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 상세 정보 모달 -->
  <div id="farmModal" class="modal">
    <div class="modal-content">
      <div class="modal-header">
        <h3>농장 상세 정보</h3>
        <span class="close" onclick="closeModal()">&times;</span>
      </div>

      <!-- 모달 내 상세 항목 출력 -->
      <div class="modal-body">
        <div class="modal-row"><span class="modal-label">회원ID:</span> <span id="modal-member_id" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">농장ID:</span> <span id="modal-farm_id" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">대표자명:</span> <span id="modal-owner_name" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">브랜드명:</span> <span id="modal-brand_name" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">우편번호:</span> <span id="modal-com_zip" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">기본주소:</span> <span id="modal-com_addr1" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">상세주소:</span> <span id="modal-com_addr2" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">담당자:</span> <span id="modal-entryman" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">은행명:</span> <span id="modal-bank" class="modal-value"></span></div>
        <div class="modal-row"><span class="modal-label">계좌번호:</span> <span id="modal-account" class="modal-value"></span></div>
      </div>
    </div>
  </div>

  <script>
    // JSP에서 farmList를 JavaScript 객체로 변환
    /* const farmMap = {
      <c:forEach var="farm" items="${farmList}">
        ${farm.farm_id}: {
          member_id: '${farm.member_id}',
          farm_id: '${farm.farm_id}',
          owner_name: '${farm.owner_name}',
          brand_name: '${farm.brand_name}',
          com_zip: '${farm.com_zip}',
          com_addr1: '${farm.com_addr1}',
          com_addr2: '${farm.com_addr2}',
          entryman: '${farm.entryman}',
          bank: '${farm.bank}',
          account: '${farm.account}'
        },
      </c:forEach>
    }; */
    
    const farmMap = {
    	    // 더미 데이터 
    	    1: {
    	      member_id: 'farmuser01',
    	      farm_id: '1',
    	      owner_name: '홍길동',
    	      brand_name: '햇살농장',
    	      com_zip: '12345',
    	      com_addr1: '서울특별시 강남구',
    	      com_addr2: '테헤란로 123',
    	      entryman: '김사원',
    	      bank: '국민은행',
    	      account: '123-4567-8901'
    	    },
    	    2: {
    	      member_id: 'farmuser02',
    	      farm_id: '2',
    	      owner_name: '이영희',
    	      brand_name: '맑은들농장',
    	      com_zip: '54321',
    	      com_addr1: '부산광역시 해운대구',
    	      com_addr2: '센텀서로 45',
    	      entryman: '이대리',
    	      bank: '신한은행',
    	      account: '987-6543-2100'
    	    }
    	    <c:forEach var="farm" items="${farmList}">
    	    ,${farm.farm_id}: {
    	      member_id: '${farm.member_id}',
    	      farm_id: '${farm.farm_id}',
    	      owner_name: '${farm.owner_name}',
    	      brand_name: '${farm.brand_name}',
    	      com_zip: '${farm.com_zip}',
    	      com_addr1: '${farm.com_addr1}',
    	      com_addr2: '${farm.com_addr2}',
    	      entryman: '${farm.entryman}',
    	      bank: '${farm.bank}',
    	      account: '${farm.account}'
    	    }
    	    </c:forEach>
    	  };

    // 모달 열기 함수
    function openModal(farmId) {
      const data = farmMap[farmId];
      if (!data) return;

      // 모달 내부 값 채우기
      document.getElementById("modal-member_id").innerText = data.member_id;
      document.getElementById("modal-farm_id").innerText = data.farm_id;
      document.getElementById("modal-owner_name").innerText = data.owner_name;
      document.getElementById("modal-brand_name").innerText = data.brand_name;
      document.getElementById("modal-com_zip").innerText = data.com_zip;
      document.getElementById("modal-com_addr1").innerText = data.com_addr1;
      document.getElementById("modal-com_addr2").innerText = data.com_addr2;
      document.getElementById("modal-entryman").innerText = data.entryman;
      document.getElementById("modal-bank").innerText = data.bank;
      document.getElementById("modal-account").innerText = data.account;

      // 모달 표시
      document.getElementById("farmModal").style.display = "block";
    }

    // 모달 닫기 함수
    function closeModal() {
      document.getElementById("farmModal").style.display = "none";
    }

  </script>

</body>
</html>
