/*
리뷰 슬라이더 기능 script
*/
window.addEventListener('DOMContentLoaded', () => {
	const leftTrack = document.querySelector('.slide-track-left');
	const leftCards = Array.from(leftTrack.children);

	leftCards.forEach(card => {
		const clone = card.cloneNode(true);
		leftTrack.appendChild(clone);
	});

	const rightTrack = document.querySelector('.slide-track-right');
	const rightCards = Array.from(rightTrack.children);

	rightCards.forEach(card => {
		const clone = card.cloneNode(true);
		rightTrack.appendChild(clone);
	});
});