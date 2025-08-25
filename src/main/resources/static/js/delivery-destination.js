// delivery-destination.js
(() => {
	const $ = (s, el = document) => el.querySelector(s);
	const $$ = (s, el = document) => Array.from(el.querySelectorAll(s));

	const openM = sel => $(sel)?.classList.add('on');
	const closeM = sel => $(sel)?.classList.remove('on');

	// ===== 다음(카카오) 우편번호 API =====
	function openPostcode(edit) {
		new daum.Postcode({
			oncomplete: function(data) {
				const addr = data.roadAddress || data.jibunAddress || "";
				const zip = data.zonecode || "";
				const mzip = edit ? $('#m_zip') : $('#n_zip');
				const a1 = edit ? $('#m_addr1') : $('#n_addr1');
				const a2 = edit ? $('#m_addr2') : $('#n_addr2');

				if (mzip) mzip.value = zip;
				if (a1) a1.value = addr;
				if (a2) a2.focus();
			}
		}).open();
	}

	// ===== ✅ 메인박스 갱신 유틸 (신규) =====
	function setMainBoxText(text) {
		const box = document.querySelector('#mainAddrBox');
		if (box) {
			const clean = (text || '').trim();
			box.textContent = clean || '메인 배송지가 아직 설정되지 않았습니다.';
		}
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
		const zip = $('#n_zip')?.value?.trim();
		const a1 = $('#n_addr1')?.value?.trim();
		const a2 = $('#n_addr2')?.value?.trim();
		const main = document.querySelector('input[name="mainFlag"]:checked')?.value || "0";

		if (!zip || !a1) {
			alert('받는분/주소를 입력하세요.');
			return;
		}

		/*const deliveryData = { zipcode: zip, addr1: a1, addr2: a2, main: 0 };*/
		const deliveryData = { zipcode: zip, addr1: a1, addr2: a2, main: Number(main) };

		try {
			const response = await fetch('/buyer/address/write.do', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(deliveryData)
			});
			if (!response.ok) throw new Error();

			await response.json();
			closeM('#modalAddrNew');
			
			if (Number(main) === 1) {
			    // 메인 배송지 박스에만 적용
			    setMainBoxText(`(${zip}) ${a1} ${a2 || ''}`);
			    alert('메인 배송지가 성공적으로 추가되었습니다.');
			} else {
			    // 일반 배송지 → 목록 갱신
			    await loadAddrList();
			    alert('배송지 정보가 성공적으로 추가되었습니다.');
			}
		} catch (err) {
			console.error(err);
			alert('배송지 추가 실패');
		}
	});
	/*      alert('배송지 정보가 성공적으로 추가되었습니다.');
		  closeM('#modalAddrNew');
	
		  // 목록만 새로고침 (메인박스는 변경하지 않음: main:0로 저장)
		  await loadAddrList();
		} catch (err) {
		  console.error(err);
		  alert('배송지 추가 실패');
		}
	  });*/

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

			// 새 목록 기준으로 메인 박스 동기화
			const picked = document.querySelector('input[name="addrPick"]:checked');
			const label = picked?.closest('label');
			const txt = label?.querySelector('div')?.textContent || '';
			setMainBoxText(txt);
		} catch (e) {
			console.error(e);
			const box = document.querySelector('#addrListBox');
			if (box) box.innerHTML = '<div style="color:#888;">주소를 불러오지 못했습니다.</div>';
			// 실패 시 메인 박스는 건드리지 않음
		}
	}

	// ===== 메인 배송지 설정 =====
	document.addEventListener('DOMContentLoaded', () => {
		// 진입 시 목록 표시 & 메인 박스 동기화
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
					headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
					body: new URLSearchParams({ addr_id: String(addr_id) })
				});
				if (!res.ok) throw new Error();

				await res.json(); // 서버는 Long 반환 → 값만 읽고 성공 처리

				// 상단 메인박스 즉시 갱신
				const label = picked.closest('label');
				const txt = label?.querySelector('div')?.textContent?.trim();
				setMainBoxText(txt);

				alert('메인 배송지가 설정되었습니다.');

				// 서버 기준 체크표시 반영 위해 목록 재로딩
				await loadAddrList();
			} catch (err) {
				console.error(err);
				alert('메인 배송지 설정에 실패했습니다.');
			}
		});

		$('#btnAddrDelete')?.addEventListener('click', async () => {
			const picked = document.querySelector('input[name="addrPick"]:checked');
			if (!picked) {
				alert('삭제할 배송지를 선택하세요');
				return;
			}
			if (!confirm('선택한 배송지를 삭제하시겠습니까?')) return;

			const addr_id = Number(picked.value);

			try {
				const res = await fetch('/buyer/address/delete.do', {
					method: 'POST',
					headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
					body: new URLSearchParams({ addr_id: String(addr_id) })
				})
				if (!res.ok) throw new Error();

				alert('배송지가 삭제되었습니다.');
				await loadAddrList();
			}
			catch (err) {
				console.error(err);
				alert('배송지 삭제에 실패했습니다.')
			}
		});
	});
})();
