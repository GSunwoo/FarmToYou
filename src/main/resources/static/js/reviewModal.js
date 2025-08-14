/**
팝업창 (reviewModal.js ) 자바스크립트
 */

document.addEventListener('DOMContentLoaded', () => {
  const modal = document.getElementById('reviewModal');
  //reviewModal 요소가 페이지에 없다면 스크립트가 종료
  if(!modal) return;
  
  const modalImage = modal.querySelector('.modal-image');
  const modalAuthor = modal.querySelector('.modal-author');
  const modalDate = modal.querySelector('.modal-date');
  const modalRating = modal.querySelector('.modal-rating');
  const modalContent = modal.querySelector('.modal-content-text');
  const likeBtn = modal.querySelector('.like-btn');
  const likeCount = modal.querySelector('.like-count');
  const modalEvaluation = modal.querySelector('.modal-evaluation');
  const closeBtn = modal.querySelector('.modal-close');

  
  // 카드클릭 -> 모달 열기
	  document.addEventListener('click', (ev) => { 
		const card = ev.target.closest('.review-cards');
		if(!card) return;
		
		//?. (옵셔널체이닝) : 혹시 img가 없어도 에러 안나고 undefined가 된다. trim(): 앞뒤 공백 제거.
		const imgSrc = card.querySelector('img')?.src || ''; // 클릭된 카드 내부의 첫번째 img 에서 URL을 읽는다.
		const author = card.querySelector('.author')?.textContent.trim() || ''; //.author에서 작성자명 텍스트만 추출
		// 기계가 읽는 날짜 (reviewPage 참조) \\ '' : 값이 없을때 빈 문자열 대입
		const dateIso = card.querySelector('.review-date')?.getAttribute('datetime') || '';
		// 사람용 날짜 (reviewPage 참조)
		const dateHuman = card.querySelector('.review-date')?.textContent.trim();
		const star = Number(card.dataset.star || 0); 
		const content = card.dataset.content?.trim() || '';// review-title인 요소를 찾아 안에있는 내용을 가져온다
		const likes = Number(card.dataset.likes  || 0); // 카드의 요소 data-likes 사용자 정의 속성 값을 가져와 숫자로 변환
		const reviewId = card.dataset.reviewId || ''; // data-review-id 사용자 정의 속성 값을 가져온다.
		const evaluation = card.dataset.evaluation || ''; 
		
		if(modalImage) modalImage.src = imgSrc; //이미지
		if(modalAuthor) modalAuthor.textContent = author; //작성자
		if(modalDate){
			if(dateIso) modalDate.setAttribute('datetime', dateIso);
			modalDate.textContent = dateHuman || dateIso || ''; //사람용 설정
		}
		if(modalContent) modalContent.textContent = content; // 카드에서 가져온 리뷰내용
		if(likeCount) likeCount.textContent = likes; // 좋아요 수 표시
		if(likeBtn) likeBtn.dataset.reviewId = reviewId; //버튼을 어떤 리뷰를 눌렀는지 기록
		if(modalEvaluation) modalEvaluation.textContent = evaluation;
		
		if(modalRating){
			modalRating.innerHTML = ''; //별점요소의 기존 HTML 내용을 모두 지운다.
			for(let i=1; i<=5; i++){
				const iTag = document.createElement('i');
				iTag.className = i<= star ? 'fa-solid fa-star' : 'fa-regular fa-star';
				modalRating.appendChild(iTag);
			}
		}
		
		modal.removeAttribute('hidden'); //요소에서 'hidden'을 제거 => 화면 표시
	});
	
  closeBtn?.addEventListener('click', () => modal.setAttribute('hidden', ''));
  modal.addEventListener('click', (e) => { if (e.target === modal) modal.setAttribute('hidden', ''); }); //모달 배경 클릭으로 닫기
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape') modal.setAttribute('hidden', ''); }); //ESC 키로 닫기
  
  likeBtn?.addEventListener('click', () => {
	const reviewId = likeBtn.dataset.reviewId; //현재 모달이 보고 있는 리뷰의 ID
	const baseUrl = likeBtn.dataset.likeUrlBase; // 좋아요 요청을 보낼 기본 URL
	if(!reviewId || !baseUrl) return;
	
	fetch(`${baseUrl}/${reviewId}/like`, { method: 'POST'}) // fetch(HTTP 요청을 보내는 내장 함수) baseUrl = /reviews
	//이 리뷰의 좋아요 수를 1증가 시켜달라는 의미.
		.then(res => res.json())
		.then(data => { 
			if (typeof data.review_like !== 'undefined' && likeCount){
				likeCount.textContent = data.review_like;
			} 
		})//화면에 바로 새로운 좋아요 수 반영
		.catch(err => console.error('좋아요 요청 실패', err));
  });
});