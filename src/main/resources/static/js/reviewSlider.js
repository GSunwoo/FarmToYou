document.addEventListener('DOMContentLoaded', () => {
  	document.querySelectorAll('.slide-track').forEach(track =>{
	  if (!track) return;
	  
	  if(track.dataset.cloned === 'true') return;
	  
	  const cards = Array.from(track.children);
	  if (cards.length === 0) return;
	  
	  if(cards.length < 12) {
		  track.append(...cards.map(c => c.cloneNode(true)));
	  }
	  		  
	  if (!track.classList.contains('slide-track-left') &&
	      !track.classList.contains('slide-track-right')) {
	    track.classList.add('slide-track-left'); 
	  }
	
	  // 호버 일시정지
	  const slider = track.closest('.review-slider') || track.parentElement;
	  if (slider) {
	    slider.addEventListener('mouseenter', () => track.style.animationPlayState = 'paused');
	    slider.addEventListener('mouseleave', () => track.style.animationPlayState = 'running');
	  }
	  
	  track.dataset.cloned = 'true';
  })
});
