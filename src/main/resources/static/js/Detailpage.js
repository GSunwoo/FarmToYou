document.addEventListener("DOMContentLoaded", () =>{
	const qty = document.getElementById("qty");
	const qtyInput = document.getElementById("qtyInput");

	document.querySelectorAll(".qty-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			let v = parseInt(qty.value, 10) || 1;
			v = Math.max(1, v + parseInt(btn.dataset.delta, 10));
			qty.value = v;
			qtyInput.value = v;
		});
	});
	
	const toBool = v => /^(1|true|y|yes)$/i.test((v ?? '').toString().trim());
	let busyBtn = null;
	
	if (typeof LOGIN_MEMBER_ID !== "undefined" && LOGIN_MEMBER_ID === 0) {
	    document.querySelectorAll('.like-btn').forEach(btn => {
	      btn.disabled = true;                 // 버튼 클릭 막기
	      btn.title = "로그인 후 이용 가능합니다"; // 툴팁
	    });
	    return; // 이후 로직 안 타게 함
	  }
	
	document.addEventListener('click', async (e) => {
	    const btn = e.target.closest('.like-btn');
	    if (!btn) return;
	    if (busyBtn === btn) return;

	    const reviewId = btn.dataset.reviewId;
	    if (!reviewId) return;

	    let liked = toBool(btn.dataset.liked);
	    let likes = parseInt(btn.dataset.likes || '0', 10) || 0;

	    const url = liked 
	      ? '/buyer/review/likedelete.do'
	      : '/buyer/review/likeinsert.do';

	    busyBtn = btn;
	    try {
	      const res = await fetch(url, {
	        method: 'POST',
	        credentials: 'same-origin',
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	        body: new URLSearchParams({ review_id: reviewId })
	      });
	      if (!res.ok) return;

	      // 눈속임 토글
	      liked = !liked;
	      likes = liked ? likes + 1 : Math.max(0, likes - 1);

	      btn.dataset.liked = liked ? 'true' : 'false';
	      btn.dataset.likes = String(likes);
	      btn.classList.toggle('active', liked);

	      const countEl = btn.querySelector('.like-count');
	      if (countEl) countEl.textContent = likes;
	    } catch (err) {
	      console.error('[like] 요청 실패:', err);
	    } finally {
	      busyBtn = null;
	    }
	  });
	
	
});