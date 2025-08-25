<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>새 배송지 추가</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainpage.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPageMain.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/delivery-destination.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <!-- 다음(카카오) 우편번호 API -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/delivery-destination.js" defer></script>
  
</head>
<body>
<%@ include file="../common/header.jsp" %>

  <div class="mypage-wrapper">
    <div class="sub-content">
      <%@ include file="../common/header2.jsp" %>
      <div class="delivery-container">
			<section class="order-wrap">
			  <div class="order-grid">
			    <div class="order-right">
			      <h2 class="weekly-title">배송지 관리</h2>
			      
			       <section class="card" id="mainAddrCard">
				        <div class="card-hd">
				          <strong>메인 배송지</strong>
				        </div>
				        <div class="card-bd">
				          <div class="addr-text" id="mainAddrBox">
				            <!-- 서버 렌더 기준으로 첫 진입 시 메인 주소가 있으면 보여줌 -->
				            <c:choose>
				              <c:when test="${not empty addressList}">
				                <c:forEach var="a" items="${addressList}">
				                  <c:if test="${a.main == 1}"> 
				                    (<c:out value="${a.zipcode}"/>) 
				                    <c:out value="${a.addr1}"/><br/>
				                    <c:if test="${not empty a.addr2}"><c:out value="${a.addr2}"/></c:if>
				                  </c:if>
				                </c:forEach>
				              </c:when>
				              <c:otherwise>메인 배송지가 아직 설정되지 않았습니다.</c:otherwise>
				            </c:choose>
				          </div>
				        </div>
				      </section>
			
				      <section class="card">
				        <div class="card-hd">
				        <div class="title-area">
				          <strong>배송지 목록</strong> <span class="bar">|</span>
				        </div>
				          <!-- 나중에 구현 --> 
				          <div class="btn-group">
				          <button type="button" class="btn-sm solid" id="btnAddrNew" style="margin-left:8px">새 배송지 추가</button>
				          <button type="button" class="btn-sm ghost" id="btnAddrDelete">삭제</button>
				          </div>
				        </div>
				        
				        <div class="card-bd">
						    <div id="addrListBox" style="margin-top:10px;">
						    <c:choose>
						      <c:when test="${not empty addressList}">
						        <c:forEach var="addr" items="${addressList}">
						          <label class="addr-item" for="addrPick-${addr.addr_id}">
						            <div>
						              (<c:out value="${addr.zipcode}"/>) 
						              <c:out value="${addr.addr1}"/> <br />
						              <c:if test="${not empty addr.addr2}"> <c:out value="${addr.addr2}"/></c:if>
						            </div>
							            <input type="radio"
							                   name="addrPick"
							                   id="addrPick-${addr.addr_id}"
							                   value="${addr.addr_id}"
							                   <c:if test="${addr.main == 1}">checked</c:if> />
						          </label>
						        </c:forEach>
						      </c:when>
						
						      <c:otherwise>
						        <div style="color:#888;">등록된 배송지가 없습니다.</div>
						      </c:otherwise>
						    </c:choose>
						  </div>
						
						  <button type="button" class="btn-sm ghost" id="btnSetMain" style="margin-top:8px;">메인 배송지 설정</button>
						</div>
				      </section>
				    </div>
				  </div>
				</section>
		
			<div class="modal" id="modalAddrNew" aria-hidden="true">
				<div class="panel" role="dialog" aria-modal="true">
					<div class="panel-hd">새 배송지 추가</div>
					<div class="panel-bd">
						<div class="row">
							<input class="input-lg" id="n_zip" name="zipcode" placeholder="우편번호" style="max-width:140px" readonly/>
							<button class="btn-sm ghost" id="btnPostNew" type="button">우편번호 찾기</button>
							
							<!-- ✅ 라디오 버튼 추가 -->
						    <label style="margin-left:12px;">
						        <input type="radio" name="mainFlag" value="1" /> 메인 배송지 추가
						    </label>
						    <label style="margin-left:8px;">
						        <input type="radio" name="mainFlag" value="0" checked /> 선택안함
						    </label>
						</div>
						<input class="input-lg" id="n_addr1" name="addr1" placeholder="기본주소" readonly>
						<input class="input-lg" id="n_addr2" name="addr2" placeholder="상세주소">
					</div>
					<div class="panel-ft">
						<button type="button" class="btn-sm ghost" data-close="#modalAddrNew">취소</button>
						<button type="button" class="btn-sm solid" id="saveAddrNew">저장</button>
					</div>
				</div>
			
			</div>
		</div>
		</div>
	</div>
</body>
</html>
