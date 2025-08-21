document.querySelectorAll('.like-btn').forEach(btn => {
  btn.addEventListener('click', async () => {
    const reviewId = btn.dataset.reviewId;
    let liked = btn.dataset.liked === 'true';
    let likes = parseInt(btn.dataset.likes, 10) || 0;

	console.log(btn.dataset.liked);
	
    // 토글 준비
    const url = liked
      ? '/buyer/review/likedelete.do?review_id=' + reviewId
      : '/buyer/review/likeinsert.do?review_id=' + reviewId;

	  console.log(url);
	  
    // 서버에 insert/delete 요청은 그대로 보냄
    const res = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ review_id: reviewId })
    });

	console.log(res.ok);
	
    if (res.ok) {
      // 성공했으면 프론트 쪽만 토글 반영
      liked = !liked;
      btn.dataset.liked = liked.toString();

      likes = liked ? likes + 1 : likes - 1;
      if (likes < 0) likes = 0;
      btn.dataset.likes = likes;

      // 화면 카운트 갱신
      const countEl = btn.querySelector('.like-count');
      if (countEl) countEl.textContent = likes;

      // 비주얼 (하트 색상 등)
      btn.classList.toggle('active', liked);
    }
  });
});
