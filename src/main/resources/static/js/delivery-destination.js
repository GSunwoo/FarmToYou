// order_page.js
(() => {
  const $  = (s, el=document) => el.querySelector(s);
  const $$ = (s, el=document) => Array.from(el.querySelectorAll(s));

  const openM  = sel => $(sel)?.classList.add('on');
  const closeM = sel => $(sel)?.classList.remove('on');

  // 모달 열기
  $('#btnAddrEdit')?.addEventListener('click', () => openM('#modalAddr'));

  // 모달 닫기
  $$('#modalAddr [data-close]')?.forEach(btn => {
    btn.addEventListener('click', e => {
      const targetSel = e.currentTarget.getAttribute('data-close');
      closeM(targetSel);
    });
  });
  $('#modalAddr')?.addEventListener('click', e => {
    if (e.target === $('#modalAddr')) closeM('#modalAddr');
  });

  // 다음 우편번호 API
  function openPostcode(edit) {
    new daum.Postcode({
      oncomplete: function(data) {
        const addr = data.roadAddress || data.jibunAddress || "";
        const zip  = data.zonecode || "";
        const mzip = edit ? $('#m_zip') : $('#n_zip');
        const a1   = edit ? $('#m_addr1') : $('#n_addr1');
        const a2   = edit ? $('#m_addr2') : $('#n_addr2');

        if (mzip) mzip.value = zip;
        if (a1)   a1.value   = addr;
        if (a2)   a2.focus();
      }
    }).open();
  }

  // 우편번호 찾기 버튼
  $('#btnPost')?.addEventListener('click', (e) => {
    e.preventDefault();
    openPostcode(true);
  });

  // 적용(저장) 버튼
  $('#saveAddr')?.addEventListener('click', async () => {
    const recv = $('#m_recv')?.value?.trim();
    const zip  = $('#m_zip')?.value?.trim();
    const a1   = $('#m_addr1')?.value?.trim();
    const a2   = $('#m_addr2')?.value?.trim();

    if (!recv || !zip || !a1) {
      alert('받는분/주소를 입력하세요.');
      return;
    }
	
	// 백엔드 DTO 필드명 일치
	const deliveryData = {
	      name: recv,
	      zipcode: zip,
	      addr1: a1,
	      addr2: a2 
	    };
	try{
		const response = await fetch('/buyer/api/delivery/updateAddress', {
			method: 'POST',
			headers: {'Content-Type': 'application/json'},
			body: JSON.stringify(deliveryData)
		});
		
		if(response.ok) {
		  const result = await response.json();
		
	      const recvNameEl = $('#recvName');
	      const addrTextEl = $('#addrText');
	
	      if (recvNameEl) recvNameEl.textContent = result.name || recv;
		  if (addrTextEl) addrTextEl.textContent =
		   `(${result.zipcode || zip}) ${result.addr1 || a1}${result.addr2 ? ' ' + result.addr2 : ''}`;
		
		  alert('배송지 정보가 성공적으로 변경되었습니다.');
	      closeM('#modalAddr');
		}
	}
	catch (err) {
		console.error(err)
		alert('배송지 변경 실패');
	}
  });

  // =========== 새 배송지 추가 모달 =============================//
  $('#btnAddrNew')?.addEventListener('click', () => openM('#modalAddrNew'));

  $$('#modalAddrNew [data-close]')?.forEach(btn => {
    btn.addEventListener('click', e => {
      const targetSel = e.currentTarget.getAttribute('data-close');
      closeM(targetSel);
    });
  });
  $('#modalAddrNew')?.addEventListener('click', e => {
    if (e.target === $('#modalAddrNew')) closeM('#modalAddrNew');
  });
	  
  $('#btnPostNew')?.addEventListener('click', e => {
	e.preventDefault();
	openPostcode(false);
  });

  $('#saveAddrNew')?.addEventListener('click', async () => {
    const recv = $('#n_recv')?.value?.trim();
    const zip  = $('#n_zip')?.value?.trim();
    const a1   = $('#n_addr1')?.value?.trim();
    const a2   = $('#n_addr2')?.value?.trim();

    if (!recv || !zip || !a1) {
      alert('받는분/주소를 입력하세요.');
      return;
    }
		
	const deliveryData = {
	      name: recv,
	      zipcode: zip,
	      addr1: a1,
	      addr2: a2 
	    };
	try{
		const response = await fetch('/buyer/api/delivery/addAddress', {
			method: 'POST',
			headers: {'Content-Type': 'application/json'},
			body: JSON.stringify(deliveryData)
		});
			
		if(response.ok) {
		  const result = await response.json();
			
	      const recvNameEl = $('#recvName');
	      const addrTextEl = $('#addrText');
			
		  if (recvNameEl) recvNameEl.textContent = result.name || recv;
		  if (addrTextEl) addrTextEl.textContent =
		   `(${result.zipcode || zip}) ${result.addr1 || a1}${result.addr2 ? ' ' + result.addr2 : ''}`;
			
		  alert('배송지 정보가 성공적으로 추가되었습니다.');
	      closeM('#modalAddrNew');
		}
	}
	catch (err) {
		console.error(err)
		alert('배송지 추가 실패');
	}
  });
  
})();
