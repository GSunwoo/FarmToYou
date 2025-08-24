// === Phone helpers: split inputs -> hidden (#phone_num) ===
/*function updateHiddenPhone() {
  const p2 = document.getElementById('phone2');
  const p3 = document.getElementById('phone3');
  const hidden = document.getElementById('phone_num');
  const v2 = (p2?.value || '').replace(/\D/g, '').slice(0, 4);
  const v3 = (p3?.value || '').replace(/\D/g, '').slice(0, 4);
  if (p2 && p2.value !== v2) p2.value = v2;
  if (p3 && p3.value !== v3) p3.value = v3;
  if (hidden) hidden.value = (v2 && v3) ? `010-${v2}-${v3}` : '';
}

document.addEventListener('DOMContentLoaded', () => {
  const p2 = document.getElementById('phone2');
  const p3 = document.getElementById('phone3');
  if (p2) p2.addEventListener('input', () => { 
      updateHiddenPhone(); 
      if (p2.value.length === 4) p3?.focus(); 
  });
  if (p3) p3.addEventListener('input', updateHiddenPhone);
});*/

const totalPrice = document.getElementById("total_price").value;
  function openTossPage() {
	  const ids = CART.map(item => item.id);
	  const qtys = CART.map(item => item.qty);
	  const wishList = window.wishList || [];

	  // 쿼리스트링 만들기
	  const queryStringId = ids.map(id => `prod_id=${id}`).join("&");
	  const queryStringQty = qtys.map(qty => `qty=${qty}`).join("&");
	  const queryStringWL = wishList.map(id => `wish_id=${id}`).join("&");
	  const orderName = (window.orderName || "").trim();
	  window.open(
	    "/buyer/pay/checkout.do?orderName="+orderName+"&totalPrice="+totalPrice+"&"+queryStringId+"&"+queryStringQty+"&"+queryStringWL, 
	    "_blank",
	    "width=600,height=800,top=300,left=500,scrollbars=yes,resizable=yes"
	  );
}

// 1) 검색창 드롭다운 표시/숨김
document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.querySelector('.search-box input');
  const dropdown = document.getElementById('search-dropdown');
  if (searchInput && dropdown) {
    searchInput.addEventListener('focus', () => (dropdown.style.display = 'block'));
    searchInput.addEventListener('blur', () => setTimeout(() => (dropdown.style.display = 'none'), 200));
  }
});

// 2) 구매 섹션 모달/이벤트
document.addEventListener('DOMContentLoaded', () => {
  const $ = (s, el = document) => el.querySelector(s);
  const $$ = (s, el = document) => Array.from(el.querySelectorAll(s));
  const openM = (id) => $(id)?.classList.add('on');
  const closeM = (id) => $(id)?.classList.remove('on');

  // 모달 닫기/배경 클릭
  $$('#modalAddr [data-close], #modalReq [data-close]').forEach((b) => {
    b.addEventListener('click', (e) => closeM(e.currentTarget.getAttribute('data-close')));
  });
  $$('#modalAddr, #modalReq').forEach((m) =>
    m.addEventListener('click', (e) => {
      if (e.target === m) closeM('#' + m.id);
    })
  );

  // 열기 버튼
  $('#btnAddrEdit')?.addEventListener('click', () => openM('#modalAddr'));
  // ✅ 모달 열 때 hidden 값에서 phone2/phone3 미리 채움
  /*$('#btnAddrEdit')?.addEventListener('click', () => {
    const cur = $('#phone_num')?.value || '';
    const m = cur.match(/^010-(\d{0,4})-(\d{0,4})$/);
    if (m) {
      if ($('#phone2')) $('#phone2').value = m[1];
      if ($('#phone3')) $('#phone3').value = m[2];
    }
    updateHiddenPhone();
  });*/

  $('#btnReqEdit')?.addEventListener('click', () => openM('#modalReq'));

  // 요청사항 기타 입력
  $('#reqSel')?.addEventListener('change', (e) => {
    if (!$('#reqEtc')) return;
    $('#reqEtc').style.display = e.target.value === 'etc' ? 'block' : 'none';
  });

  // 배송지 저장(검증 + 카드 즉시 갱신)
  $('#saveAddr')?.addEventListener('click', () => {
    /*const recv = $('#m_recv')?.value?.trim();*/
    /*const phone = $('#phone_num')?.value?.trim();            // ✅ 변경*/
    const zip = $('#m_zip')?.value?.trim();
    const a1 = $('#m_addr1')?.value?.trim();
    const a2 = $('#m_addr2')?.value?.trim();
    if (!recv || !phone || !zip || !a1) {
      alert('주소를 입력하세요.');
      return;
    }
    if ($('#recvName')) $('#recvName').textContent = recv;
    if ($('#addrText')) $('#addrText').textContent = `${a1} ${a2 || ''}`;
    /*if ($('#addrPhone')) $('#addrPhone').textContent = `휴대폰 : ${phone}`; // ✅ 카드 표시 갱신*/
    closeM('#modalAddr');
  });

  // 요청사항 저장
  $('#saveReq')?.addEventListener('click', () => {
    let v = $('#reqSel')?.value;
    if (v === 'etc') v = $('#reqEtc')?.value?.trim();
    if (!v) {
      alert('요청사항을 입력하세요.');
      return;
    }
    if ($('#reqText')) $('#reqText').textContent = v;
    if ($('#delivery_msg')) $('#delivery_msg').value = v;
    closeM('#modalReq');
  });

  // 결제 버튼
  $('#btnPay')?.addEventListener('click', () => {
    if (!$('#agreeAll')?.checked) {
      alert('약관에 동의해 주세요.');
      return;
    }
	openTossPage();
  });
});

// 3) 다음(카카오) 우편번호 + 배송요약 박스 + 합계 계산
document.addEventListener('DOMContentLoaded', () => {
  const $ = (s, el = document) => el.querySelector(s);
  const $$ = (s, el = document) => Array.from(el.querySelectorAll(s));

  /* ============ 1) 배송지 변경: 다음 우편번호 API 연동 ============ */
  function openPostcode() {
    if (typeof daum === 'undefined' || !daum.Postcode) {
      console.warn('Daum Postcode script is not loaded.');
      return;
    }
	
	document.getElementById('addrSavedList')?.addEventListener('change', (e) => {
	  const r = e.target.closest('input[type="radio"][name="savedAddr"]');
	  if(!r) return;
	  const name = r.dataset.name || '';
	  const zipcode = r.dataset.zipcode || '';
	  const addr1 = r.dataset.addr1 || '';
	  const addr2 = r.dataset.addr2 || '';
	  /*const phone = r.dataset.phone || '';*/
	  /*const {p2, p3} = formatPhoneToParts(phone);*/
	  document.getElementById('m_recv').value = name;
	  document.getElementById('m_zip').value = zipcode;
	  document.getElementById('m_addr1').value = addr1;
	  document.getElementById('m_addr2').value = addr2;
	  /*document.getElementById('phone2').value = p2;
	  document.getElementById('phone3').value = p3;*/
	});

    new daum.Postcode({
      oncomplete: function (data) {
        const addr = data.roadAddress || data.jibunAddress || '';
        if ($('#m_zip')) $('#m_zip').value = data.zonecode || '';
        if ($('#m_addr1')) $('#m_addr1').value = addr;
        $('#m_addr2') && $('#m_addr2').focus();
      },
    }).open();
  }

  $('#btnPost')?.addEventListener('click', (e) => {
    e.preventDefault();
    openPostcode();
  });

  // 적용 시 카드 요약에도 반영 (보조)
  $('#saveAddr')?.addEventListener(
    'click',
    () => {
      const recv = $('#m_recv')?.value?.trim();
      /*const phone = $('#phone_num')?.value?.trim();          // ✅ 변경*/
      const a1 = $('#m_addr1')?.value?.trim();
      const a2 = $('#m_addr2')?.value?.trim();
      if (recv) $('#recvName').textContent = recv;
      /*if (phone) $('#addrPhone').textContent = `휴대폰 : ${phone}`; // ✅ 카드 표시 갱신*/
      if (a1) $('#addrText').textContent = `${a1}${a2 ? ' ' + a2 : ''}`;
    },
    { capture: false }
  );
  
  

  /* ============ 2) 장바구니 기반 배송 박스 자동 생성 ============ */
  

  function formatKoreanETA(iso) {
    if (!iso) return '';
    const d = new Date(iso + 'T00:00:00');
    if (isNaN(d)) return '';
    const yoil = ['일', '월', '화', '수', '목', '금', '토'][d.getDay()];
    const m = d.getMonth() + 1, day = d.getDate();
    return `${yoil}요일 ${m}/${day} 도착 예정`;
  }

  function renderShipBoxes(cart) {
    const sorted = [...cart].sort((a, b) => {
      const ae = a.eta || '', be = b.eta || '';
      if (ae && be && ae !== be) return ae.localeCompare(be);
      if (ae && !be) return -1;
      if (!ae && be) return 1;
      return (a.prod_name || '').localeCompare(b.prod_name || '', 'ko');
    });

    const total = sorted.length;
    const html = sorted.map((it, idx) => `
      <section class="ship-summary">
        <div class="ship-hd">
          배송 ${total}건 중 ${idx + 1}
        </div>
        <div class="ship-bd">
          <div class="ship-ttl">${it.prod_name}</div>
          <div class="ship-sub">수량 ${it.qty}개 / 무료배송</div>
        </div>
      </section>
    `).join('');

    if ($('#shipList')) $('#shipList').innerHTML = html;
  }

  renderShipBoxes(CART);

  // 총 상품가격 계산(옵션)
  function won(n) {
    return (n || 0).toLocaleString('ko-KR') + '원';
  }
  function calcTotals(cart) {
    const sum = cart.reduce((a, b) => a + (b.qty || 0) * (b.price || 0), 0);
    if ($('#sumProducts')) $('#sumProducts').textContent = won(sum);
  }
   function calcTotals(cart) {
      const sum = cart.reduce((a, b) =>
		  a + (Number(b.price) || 0) * (Number(b.qty) || 0), 0
      );
      const formatted = won(sum);
      if ($('#sumProducts')) $('#sumProducts').textContent = formatted;   // 총상품금액
     if ($('#sumPayment'))  $('#sumPayment').textContent  = formatted;   // 총결제금액
     if ($('#total_price')) $('#total_price').value = sum;               // hidden 필요 시
   }
   calcTotals(CART);
});
