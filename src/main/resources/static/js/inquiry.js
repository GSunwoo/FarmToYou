document.addEventListener('DOMContentLoaded', () => {
  const $  = (s, el=document) => el.querySelector(s);
  const $$ = (s, el=document) => Array.from(el.querySelectorAll(s));

  // 문의 작성 버튼 (구매자 전용)
  const btnWrite = $('#btnWrite');
  if (btnWrite && window.isBuyer) {
    btnWrite.addEventListener('click', () => {
      location.href = `${window.INQUIRY_PATHS.write}`;
    });
  }

  // 테이블 액션 (수정 / 삭제 / 답변)
  document.addEventListener('click', (ev) => {
    const editBtn   = ev.target.closest('.btnEdit');
    const delBtn    = ev.target.closest('.btnDel');
    const answerBtn = ev.target.closest('.btnAnswer');

    // 수정 버튼
    if (editBtn) {
      if (!window.isBuyer) return;
      const id = editBtn.dataset.id;
      location.href = `${window.INQUIRY_PATHS.edit}?inquiry_id=${encodeURIComponent(id)}`;
      return;
    }

    // 삭제 버튼
    if (delBtn) {
      if (!window.isBuyer) return;
      const id = delBtn.dataset.id;
      const row = delBtn.closest('tr');
      const isOwner = row?.dataset.owner === 'true';
      if (!isOwner) {
        alert('본인 글만 삭제할 수 있습니다.');
        return;
      }
      if (confirm('해당 문의를 삭제하시겠습니까?')) {
        $('#delId').value = id;
        $('#delForm').submit();
      }
      return;
    }

    // 답변 버튼
    if (answerBtn) {
      if (!window.isSeller) return;
      const id = answerBtn.dataset.id;
      const row = answerBtn.closest('tr');
      const comCount = parseInt(row.dataset.comCount, 10);

      // 이미 답변 완료된 상태면 알림 표시
      if (comCount > 0) {
        if (!confirm('이미 답변한 문의입니다. 답변을 수정하시겠습니까?')) {
          return;
        }
      }
      location.href = `${window.INQUIRY_PATHS.answer}?inquiry_id=${encodeURIComponent(id)}`;
      return;
    }
  });
});
