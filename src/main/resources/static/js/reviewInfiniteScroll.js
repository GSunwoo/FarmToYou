/**
무한스크롤 js
 */

(() => {
	const listEl = document.getElementById('review-grid-lists');
	const sentinel = document.getElementById('sentinel');
	if (!listEl || !sentinel) return;
	
	let page = 1;
	const pageSize = 20;
	let loading = false;
	let hasMore = true;
	
	async function fetchList(pageNum) {
		const res = await fetch(`/guest/review/restApi/list?pageNum=${pageNum}`);
		if(!res.ok) throw new Error(`목록 로드 실패: ${res.status}`);
		return res.json();
	}
	
	function createCard(item) {
		//div 에 클래스 이름 부여
		const card = document.createElement('div');
		card.className = 'review-cards'
		card.dataset.reviewId = item.review_id;
		card.dataset.star = item.star || 0;
		card.dataset.likes = item.review_like || 0;
		card.dataset.evaluation = item.evaluation || '';
		card.dataset.content = (item.content || '').trim();
		
		const imgs = document.createElement('div');
		imgs.className = 'review-imgs';
		const img = document.createElement('img');
		// 이미지URL이 비어있는지 확인하는 조건문 (item.image)
		if(item.image) img.src = item.image;
		img.alt = '업로드한 리뷰 이미지';
		imgs.appendChild(img);
		
		const bottomContent = document.createElement('div');
		bottomContent.className = 'review-bottom-content';
		const contentEl = document.createElement('div');
		contentEl.className = 'review-content';
		contentEl.textContent = item.content || '';
		bottomContent.appendChild(contentEl);
		const titleEl = document.createElement('div');
		titleEl.className = 'review-title';
		titleEl.textContent = item.title || '';
		bottomContent.appendChild(titleEl);
		
		const rating = document.createElement('div');
		rating.className = 'bottom-rating';
		const starNum = Number(item.star) || 0;
		for (let i=1; i<=5; i++) {
			const iTag = document.createElement('i');
			iTag.className = i <= starNum ? 'fa-solid fa-star' : 'fa-regular fa-star';
			rating.appendChild(iTag);
		}
		
		const authorWrap = document.createElement('div');
		authorWrap.className = 'review-bottom-author';
		const authorSpan = document.createElement('span');
		authorSpan.className = 'author';
		authorSpan.textContent = item.name || (item.member_id ? `회원 ${item.member_id}` : '');
		const time = document.createElement('time');
		time.className = 'review-date';
		if (item.postdate) time.setAttribute('datetime', item.postdate);
		time.textContent = item.postdate || '';
		authorWrap.append(authorSpan, time);
		
		card.append(imgs, bottomContent, rating, authorWrap);
		return card;
	}
	
	function appendItem(items) {
		const frag = document.createDocumentFragment();
		items.forEach(item => frag.appendChild(createCard(item)));
		listEl.insertBefore(frag, sentinel);
		
	}
	
	async function loadMore() {
		if (loading || !hasMore) return;
		loading = true;
		try {
			const items = await fetchList(page, pageSize);
			if (!Array.isArray(items) || items.length === 0) {
				hasMore = false;
			}
			else {
				appendItem(items)
				if(items.length < pageSize) hasMore = false;
				page += 1;
			}
		}
		catch (e) {
			console.error(e);
			hasMore = false;
		}
		finally {
			loading = false;
		}
	}
	
	const io = new IntersectionObserver(entries => {
		entries.forEach(e => { if (e.isIntersecting) loadMore(); });
	}, {rootMargin: '200px 0px'});
	
	io.observe(sentinel);
	
	if(!listEl.querySelector('.review-cards')) loadMore();
})();