// 공용 JS: isBuyer / isSeller 플래그로 액션 분기
document.addEventListener('DOMContentLoaded', () => {
  const $  = (s, el=document) => el.querySelector(s);
  const $$ = (s, el=document) => Array.from(el.querySelectorAll(s));

  // 문의 작성 (구매자 전용)
  const btnWrite = $('#btnWrite');
  if (btnWrite && window.isBuyer) {
    btnWrite.addEventListener('click', () => {
      location.href = `${window.INQUIRY_PATHS.write}`;
    });
  }

  // 테이블 액션 위임(수정/삭제/답변)
  document.addEventListener('click', (ev) => {
    const editBtn   = ev.target.closest('.btnEdit');
    const delBtn    = ev.target.closest('.btnDel');
    const answerBtn = ev.target.closest('.btnAnswer');

    if (editBtn) {
      if (!window.isBuyer) return;
      const id = editBtn.dataset.id;
      location.href = `${window.INQUIRY_PATHS.edit}?inquiry_id=${encodeURIComponent(id)}`;
      return;
    }

    if (delBtn) {
      if (!window.isBuyer) return;
      const id = delBtn.dataset.id;
      // 본인 글만 삭제 가능: 서버에서도 검증하지만, UI에서도 가드
      const row = delBtn.closest('tr');
      const isOwner = row?.dataset.owner === 'true';
      if (!isOwner) {
        alert('본인 글만 삭제할 수 있습니다.');
        return;
      }
      if (confirm('해당 문의를 삭제하시겠습니까?')) {
        const delForm = $('#delForm');
        $('#delId').value = id;
        delForm.submit(); // POST /buyer/inquiry/delete.do
      }
      return;
    }

    if (answerBtn) {
      if (!window.isSeller) return;
      const id = answerBtn.dataset.id;
      location.href = `${window.INQUIRY_PATHS.answer}?inquiry_id=${encodeURIComponent(id)}`;
      return;
    }
  });
});
