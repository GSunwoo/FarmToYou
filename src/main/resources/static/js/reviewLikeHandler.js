/*
좋아요 버튼 (활성화/비활성화) 자바스크립트
*/

document.querySelectorAll('.like-btn').forEach(btn => { //문서에서 .like-btn요소들을 찾고
	btn.addEventListener('click', async () => { // 클릭 이벤트리스너를 붙인다 (비동기함수)
		//data-reivew-id 속성에서 리뷰ID(문자열)을 읽는다
		const reviewId = btn.dataset.reviewId;
		// 현재 좋아요 상태
		const liked = btn.dataset.liked === 'true';
		console.log(btn.dataset.liked);
		
		const url = liked
			? '/buyer/review/likedelete.do?review_id='+reviewId
			: '/buyer/review/likeinsert.do?review_id='+reviewId;
		
		//컨트롤러 경로
		const res = await fetch(url, {
			/*
			post = reviewLikeService.toggleLike(reviewId, memberId) 이렇게 자동으로 판단하기때문에 POST로 넘기면
			서버는 이미 눌린 상태인지 판단을 하여 insert or delete를 자동으로 수행
			: 토글방식
			*/ 
			method: 'POST',
			//컨트롤러가 @RequestParam 으로 받기 때문에 맟춤 (폼 방식)으로 보냄
			headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
			body: new URLSearchParams({ review_id:reviewId }) //member_id 는 시큐리티에서 생성에서 처리
		});
	})
})