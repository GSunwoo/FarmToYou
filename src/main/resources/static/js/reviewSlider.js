/*
리뷰 슬라이더 기능 script
*/
window.addEventListener('DOMContentLoaded', () => {
	const track = document.querySelector('.slide-track-horizontal');
	if(!track) return;
	
	const cards = Array.from(track.children);
	if(cards.length === 0) return;
	
	track.append(...cards.map(c => c.cloneNode(true)));
	
	track.addEventListener('mouseenter', () => track.style.animationPlayState = 'paused');
	track.addEventListener('mouseleave', () => track.style.animationPlayState = 'running');
});