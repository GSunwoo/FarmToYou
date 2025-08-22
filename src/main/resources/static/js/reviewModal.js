/**
 * 리뷰 모달 + 좋아요 토글 (하나로 통합)
 * - 카드 클릭 → 모달 열기 + 카드의 liked/likes/ID를 모달 버튼에 동기화
 * - .like-btn 클릭(모달/목록 모두) → 서버 insert/delete + 프론트 눈속임(+1/-1) 반영
 */
document.addEventListener('DOMContentLoaded', () => {
  const modal = document.getElementById('reviewModal');
  if (!modal) return;

  // 모달 내부 엘리먼트
  const modalImage      = modal.querySelector('.modal-image');
  const modalAuthor     = modal.querySelector('.modal-author');
  const modalDate       = modal.querySelector('.modal-date');
  const modalRating     = modal.querySelector('.modal-rating');
  const modalContent    = modal.querySelector('.modal-content-text');
  const modalLikeBtn    = modal.querySelector('.like-btn');
  const modalLikeCount  = modal.querySelector('.like-count');
  const modalEvaluation = modal.querySelector('.modal-evaluation');
  const closeBtn        = modal.querySelector('.modal-close');

  // toBool 함수 : 문자열이나 숫자를 불리언값으로 변환하는 헬퍼 함수
  const toBool = v => /^(1|true|y|yes)$/i.test((v ?? '').toString().trim());

  // ================= 카드 클릭 → 모달 열기 =================
  document.addEventListener('click', (ev) => {
    const card = ev.target.closest('.review-cards');
    if (!card) return;

    // 카드 데이터 읽기
    const imgSrc     = card.querySelector('img')?.src || '';
    const author     = card.querySelector('.author')?.textContent.trim() || '';
    const dateEl     = card.querySelector('.review-date');
    const dateIso    = dateEl?.getAttribute('datetime') || '';
    const dateHuman  = dateEl?.textContent.trim() || '';
    const star       = Number(card.dataset.star || 0);
    const content    = (card.dataset.content || '').trim();
    const likes      = Number(card.dataset.likes || 0);
    const reviewId   = card.dataset.reviewId || '';
    const evaluation = card.dataset.evaluation || '';
    const likedNow   = toBool(card.dataset.liked);

    // 모달에 콘텐츠 반영
    if (modalImage)   modalImage.src = imgSrc;
    if (modalAuthor)  modalAuthor.textContent = author;
    if (modalDate) {
      if (dateIso)    modalDate.setAttribute('datetime', dateIso);
      modalDate.textContent = dateHuman || dateIso || '';
    }
    if (modalContent)    modalContent.textContent = content;
    if (modalEvaluation) modalEvaluation.textContent = evaluation;

    // 모달 좋아요 상태/데이터 동기화
    if (modalLikeBtn) {
      modalLikeBtn.dataset.reviewId = reviewId;
      modalLikeBtn.dataset.liked    = likedNow ? 'true' : 'false';
      modalLikeBtn.dataset.likes    = String(likes);
      modalLikeBtn.classList.toggle('active', likedNow);
    }
    if (modalLikeCount) modalLikeCount.textContent = String(likes);

    // 별점 갱신
    if (modalRating) {
      modalRating.innerHTML = '';
      for (let i = 1; i <= 5; i++) {
        const iTag = document.createElement('i');
        iTag.className = i <= star ? 'fa-solid fa-star' : 'fa-regular fa-star';
        modalRating.appendChild(iTag);
      }
    }

    // 모달 표시
    modal.removeAttribute('hidden');
  });

  // ================ 모달 닫기 ================
  closeBtn?.addEventListener('click', () => modal.setAttribute('hidden', ''));
  modal.addEventListener('click', (e) => {
    if (e.target === modal) modal.setAttribute('hidden', '');
  });
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') modal.setAttribute('hidden', '');
  });

  // ================ 좋아요 클릭(모달/목록 공통) ================
  let busyBtn = null; // 중복 클릭 방지 (버튼별)
  document.addEventListener('click', async (e) => {
    const btn = e.target.closest('.like-btn');
    if (!btn) return;

    if (busyBtn === btn) return; // 같은 버튼 연타 방지
    const reviewId = btn.dataset.reviewId;
    if (!reviewId) return;

    // 현재 상태
    let liked = toBool(btn.dataset.liked);
	// 십진수로 변환하여 숫자 출력
    let likes = parseInt(btn.dataset.likes || '0', 10) || 0;

    // 서버 엔드포인트 (insert/delete 분리)
    const url = liked
      ? '/buyer/review/likedelete.do'
      : '/buyer/review/likeinsert.do';
	
	// 클릭된 버튼이 이미 처리중인 버튼과 같다면 함수 종료. (중복요청 방지)
    busyBtn = btn;
    try {
      const res = await fetch(url, {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ review_id: reviewId })
      });
	  //200이 아니면 종료
      if (!res.ok) return;

      //좋아요 눌렀는지 여부를 반전 (liked == true => 클릭후 false)
      liked = !liked;
	  // true => 좋아요 1 추가 / false => 좋아요 -1 취소 (Math.max(0, likes - 1) = 0 ->최소 0으로 보정)
      likes = liked ? likes + 1 : Math.max(0, likes - 1);

      // 버튼 자신 갱신
      btn.dataset.liked = liked ? 'true' : 'false';
      btn.dataset.likes = String(likes);
      btn.classList.toggle('active', liked);
      const btnCountEl = btn.querySelector('.like-count') || 
                         (btn === modalLikeBtn ? modalLikeCount : null);
      if (btnCountEl) btnCountEl.textContent = String(likes);

      // 모달 버튼을 눌렀다면 → 카드도 자동으로 상태가 바뀌도록 함
      if (btn === modalLikeBtn) {
        const card = document.querySelector(`.review-cards[data-review-id="${reviewId}"]`);
        if (card) {
          card.dataset.liked = liked ? 'true' : 'false';
          card.dataset.likes = String(likes);
          // 만약 카드에도 카운트를 표시하는 엘리먼트가 있으면 여기서 갱신
          // const cardCount = card.querySelector('.like-count');
          // if (cardCount) cardCount.textContent = String(likes);
        }
      }

    } catch (err) {
      console.error('[like] 요청 실패:', err);
    } finally {
      busyBtn = null;
    }
  });
});
