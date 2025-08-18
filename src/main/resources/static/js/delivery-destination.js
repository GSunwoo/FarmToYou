// delivery-destination.js
(() => {
  const $  = (s, el=document) => el.querySelector(s);
  const $$ = (s, el=document) => Array.from(el.querySelectorAll(s));

  const openM  = sel => $(sel)?.classList.add('on');
  const closeM = sel => $(sel)?.classList.remove('on');

  // ===== 다음(카카오) 우편번호 API =====
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

  // ===== 새 배송지 추가 모달 =====
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

  // ===== 새 배송지 저장 =====
  $('#saveAddrNew')?.addEventListener('click', async () => {
    const zip  = $('#n_zip')?.value?.trim();
    const a1   = $('#n_addr1')?.value?.trim();
    const a2   = $('#n_addr2')?.value?.trim();

    if (!zip || !a1) {
      alert('받는분/주소를 입력하세요.');
      return;
    }

    const deliveryData = { zipcode: zip, addr1: a1, addr2: a2, main: 1};

    try {
      const response = await fetch('/buyer/address/write.do', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(deliveryData)
      });
      if (!response.ok) throw new Error();

      const result = await response.json();

      const addrTextEl = $('#addrText');
      if (addrTextEl) {
        addrTextEl.textContent =
          `(${result.zipcode || zip}) ${result.addr1 || a1}${result.addr2 ? ' ' + result.addr2 : ''}`;
      }

      alert('배송지 정보가 성공적으로 추가되었습니다.');
      closeM('#modalAddrNew');

      // 목록 새로고침 (서버가 JSP에 목록을 렌더해줘야 함)
      await loadAddrList();
    } catch (err) {
      console.error(err);
      alert('배송지 추가 실패');
    }
  });

  // ===== 주소 목록 부분 갱신: HTML 스니펫 추출 =====
  async function loadAddrList() {
    try {
      const res = await fetch('/buyer/address/list.do', {
        method: 'GET',
        headers: { 'Accept': 'text/html' }
      });
      if (!res.ok) throw new Error();

      const text = await res.text();
      const doc = new DOMParser().parseFromString(text, 'text/html');
      const inner = doc.querySelector('#addrListBox')?.innerHTML || '';

      const box = document.querySelector('#addrListBox');
      if (box) {
        box.innerHTML = inner || '<div style="color:#888;">등록된 배송지가 없습니다.</div>';
      }
    } catch (e) {
      console.error(e);
      const box = document.querySelector('#addrListBox');
      if (box) box.innerHTML = '<div style="color:#888;">주소를 불러오지 못했습니다.</div>';
    }
  }

  // ===== 메인 배송지 설정 =====
  document.addEventListener('DOMContentLoaded', () => {
    // 진입 시 목록 표시
    loadAddrList();

    $('#btnSetMain')?.addEventListener('click', async () => {
      const picked = document.querySelector('input[name="addrPick"]:checked');
      if (!picked) {
        alert('메인으로 설정할 배송지를 선택하세요.');
        return;
      }
      const addr_id = Number(picked.value);

      try {
        const res = await fetch('/buyer/address/update.do', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          // 컨트롤러가 @RequestBody Long addr_id 를 받으므로 숫자만 전송
          body: JSON.stringify(addr_id)
        });
        if (!res.ok) throw new Error();

        // 백엔드는 Long만 반환하므로 값만 읽고 성공으로 간주
        await res.json();

        // 상단 표시 텍스트를 현재 선택된 항목으로 즉시 갱신
        const addrTextEl = $('#addrText');
        const label = picked.closest('label');
        const txt = label?.querySelector('div')?.textContent?.trim();
        if (addrTextEl && txt) addrTextEl.textContent = txt;

        alert('메인 배송지가 설정되었습니다.');

        // 서버 렌더 기준으로 목록 다시 가져와 체크 표시 반영
        await loadAddrList();
      } catch (err) {
        console.error(err);
        alert('메인 배송지 설정에 실패했습니다.');
      }
    });
  });
})();
