/*
좋아요 버튼 (활성화/비활성화) 자바스크립트
*/

document.addEventListener('DOMContentLoaded', () => { // HTML문서 로드 완료후 실행
	const modal = document.getElementById('reviewModal'); //모달요소 가져오기
	if(!modal) return; // 모달이없다면 종료
	
	const likeBtn = modal.querySelector('.like-btn');//좋아요 버튼
	const likeCountEl = modal.querySelector('.like-count'); //좋아요 수
	
	// 좋아요 수 증가/감소 계산 
	const optimisticNext = (wasActive, beforeCnt) => {
		const likedAfter = !wasActive; //상태 반전
		let nextCnt = beforeCnt + (likedAfter ? 1 : -1); // +1 또는 -1
		if(nextCnt < 0) nextCnt = 0; //0 미만 방지
		return {likedAfter, nextCnt}; // 변경된 상태와 수 반환
	};
	
	// 리뷰 그리드 카드 데이터 동기화 (좋아요 상태와 수)
 	const syncGridCard = (reviewId, newCount, liked) => {
		// 리뷰 ID가 특정 값인 카드 하나만 찾아서 가져오기
		const card = document.querySelector(`.review-cards[data-review-id="${reviewId}"]`); // 해당 리뷰 ID 카드 찾기
		if (!card) return;
		card.dataset.likes = String(newCount); // 좋아요 수 갱신
		card.dataset.liked = liked ? 'true' : 'false';
		
		const cardCnt = card.querySelector('.like-count');
	    if (cardCnt) cardCnt.textContent = String(newCount);

	    const heart = card.querySelector('.heart');
	    if (heart) heart.classList.toggle('is-active', liked);
	};
	
	
	//좋아요 버튼 클릭 이벤트
	likeBtn?.addEventListener('click', async () => {
		const reviewId = likeBtn.dataset.reviewId; //리뷰 ID
		const baseUrl = likeBtn.dataset.likeUrlBase; //좋아요 API 기본 URL
		if(!reviewId || !baseUrl) return; // 필수 데이터 없으면 종료
		
		const wasActive = likeBtn.classList.contains('is-active'); // 기존상태
		const beforeCnt = Number(likeCountEl.textContent || 0); //기존 좋아요 수
		const { likedAfter, nextCnt } = optimisticNext(wasActive, beforeCnt); // 변경 상태 계산
		
		likeBtn.classList.toggle('is-active', likedAfter); // 상태 UI변경
		likeCountEl.textContent = String(nextCnt); // 좋아요 수 UI 변경
		
		try {
			// 서버에 POST 요청
			const res = await fetch(`${baseUrl}/${reviewId}/like`, { method: 'POST' });
			if (!res.ok) throw new Error(`HTTP ${res.status}`); //응답 코드 확인
			
			const data = await res.json().catch(() => ({})); //JSON 응답 파싱
			//서버 응답 기반으로 보정
			const liked = typeof data.liked === 'boolean' ? data.liked : likedAfter; //최종상태
			const cnt = typeof data.review_like === 'number' ? data.review_like : nextCnt; // 최종 수
			
			// UI 최종 반영
			likeBtn.classList.toggle('is-active', liked);
			likeCountEl.textContent = String(cnt);
			syncGridCard(reviewId, cnt, liked); //카드 데이터 동기화
		}
		catch (e) {
			//실패시 롤백
			likeBtn.classList.toggle('is-active', wasActive);
			likeCountEl.textContent = String(beforeCnt);
			console.error('좋아요 처리 실패', e);
		}
	})
})