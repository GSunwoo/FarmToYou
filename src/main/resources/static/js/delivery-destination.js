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
  function openPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        const addr = data.roadAddress || data.jibunAddress || "";
        const zip  = data.zonecode || "";
        const mzip = $('#m_zip');
        const a1   = $('#m_addr1');
        const a2   = $('#m_addr2');

        if (mzip) mzip.value = zip;
        if (a1)   a1.value   = addr;
        if (a2)   a2.focus();
      }
    }).open();
  }

  // 우편번호 찾기 버튼
  $('#btnPost')?.addEventListener('click', (e) => {
    e.preventDefault();
    openPostcode();
  });

  // 적용(저장) 버튼
  $('#saveAddr')?.addEventListener('click', () => {
    const recv = $('#m_recv')?.value?.trim();
    const phone= $('#m_phone')?.value?.trim();
    const zip  = $('#m_zip')?.value?.trim();
    const a1   = $('#m_addr1')?.value?.trim();
    const a2   = $('#m_addr2')?.value?.trim();

    if (!recv || !phone || !zip || !a1) {
      alert('받는분/연락처/주소를 입력하세요.');
      return;
    }

    const recvName = $('#recvName');
    const addrText = $('#addrText');
    const addrPhone= $('#addrPhone');

    if (recvName) recvName.textContent = recv;
    if (addrText) addrText.textContent = `${a1}${a2 ? ' ' + a2 : ''}`;
    if (addrPhone) addrPhone.textContent = `휴대폰 : ${phone}`;

    closeM('#modalAddr');
  });
})();
