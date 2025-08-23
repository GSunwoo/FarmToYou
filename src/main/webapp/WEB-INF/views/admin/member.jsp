<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 목록</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      padding: 40px;
      background: #f8f9fa;
    }
    .admin-topbar { margin-bottom: 16px; }
    /* .admin-topbar h1 { margin: 0; font-size: 40px; } */
    h2 { text-align: left; margin: 16px 0 12px; }
    /* 타입 필터 탭 */
    .type-tabs { display:flex; gap:8px; margin: 8px 0 18px; }
    .type-tabs a {
      display:inline-block; padding:8px 12px; border:1px solid #ddd;
      background:#fff; text-decoration:none; color:#333; border-radius:8px;
      font-size:14px;
    }
    .type-tabs a.active { background:#4CAF50; color:#fff; border-color:#4CAF50; }

    table { width: 100%; border-collapse: collapse; background: #fff; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    th { background: #f1f1f1; }

    .switch { position: relative; display: inline-block; width: 50px; height: 25px; }
    .switch input { display: none; }
    .slider {
      position: absolute; cursor: pointer; inset: 0;
      background-color: #ccc; transition: .4s; border-radius: 25px;
    }
    .slider:before {
      position: absolute; content: ""; height: 18px; width: 18px; left: 4px; bottom: 3.5px;
      background-color: white; transition: .4s; border-radius: 50%;
    }
    input:checked + .slider { background-color: #4CAF50; }
    input:checked + .slider:before { transform: translateX(24px); }

    .pagination { margin-top: 20px; text-align: center; }
    .pagination a {
      padding: 8px 12px; margin: 0 5px; text-decoration: none; border: 1px solid #ddd; color: #333;
    }
    .pagination a.active { background-color: #4CAF50; color: white; }

    #alertBox {
      position: fixed; top: 20px; right: 20px; background: #4CAF50; color: white;
      padding: 10px 16px; border-radius: 5px; font-weight: bold; box-shadow: 0 4px 10px rgba(0,0,0,0.15);
      display: none;
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
      <h2>회원 목록</h2>
		<!-- 회원 타입 필터 탭 (ALL/BUYER/SELLER) -->
		<div class="type-tabs">
        <a href="?user_type=ALL" class="${param.user_type eq 'ALL' || empty param.user_type ? 'active' : ''}">전체</a>
        <a href="?user_type=BUYER" class="${param.user_type eq 'BUYER' ? 'active' : ''}">구매자</a>
        <a href="?user_type=SELLER" class="${param.user_type eq 'SELLER' ? 'active' : ''}">판매자</a>
      </div>
      <table>
        <thead>
          <tr>
            <th>아이디</th>
            <th>회원</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>계정상태</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="user" items="${memberList}">
            <tr data-user-id="${user.member_id}">
              <td>${user.user_id}</td>
              <td>${user.user_type}</td>
              <td>${user.name}</td>
              <td>${user.phone_num}</td>
              <!-- 이메일: id@domain (JSP에서 합치기) -->
              <td><c:out value="${user.emailid}"/>@<c:out value="${user.emaildomain}"/></td>
              <td>
                <label class="switch" title="ON: 활성 / OFF: 비활성">
                  <!-- enable 컬럼(Y/N, 혹은 1/0/boolean)을 모두 지원하도록 조건 OR 처리 -->
                  <input type="checkbox" class="status-toggle"
                         ${ (user.enable == '1' or user.enable == 1) ? 'checked' : '' }>
                  <span class="slider"></span>
                </label>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      
      <!-- 페이징: 현재 user_type 파라미터 유지 -->
      <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPage}">
          <a href="?page=${i}&user_type=${empty param.user_type ? 'ALL' : param.user_type}"
             class="${i == nowPage ? 'active' : ''}">${i}</a>
        </c:forEach>
      </div>
    </main>
  </div>

  <div id="alertBox">상태가 변경되었습니다.</div>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
    	document.querySelectorAll('.status-toggle').forEach(toggle => {
    		  toggle.addEventListener('change', async function () {
    		    const row = this.closest('tr');
    		    const userId = row.dataset.userId;

    		    // enable: 1(활성), 0(비활성)
    		    const enable = this.checked ? 1 : 0;

    		    const res = await fetch('/admin/member/able.do?memberId='+userId+'&enable='+enable, {
    		      method: 'POST'
    		    });

    		    if (res.ok) {
    		      showAlert(this.checked ? "계정이 활성화되었습니다." : "계정이 비활성화되었습니다.");
    		    } else {
    		      alert("변경 실패. 다시 시도하세요.");
    		      this.checked = !this.checked;
    		    }
    		  });
    		});


      function showAlert(message) {
        const box = document.getElementById('alertBox');
        box.textContent = message;
        box.style.display = 'block';
        setTimeout(() => box.style.display = 'none', 1800);
      }
    });
  </script>
</body>
</html>
