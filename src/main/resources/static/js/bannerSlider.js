/*
메인 슬라이더 기능 배너 Script
*/
document.addEventListener('DOMContentLoaded', () => {
	const slides = document.querySelectorAll('.banner-slide');
	const prevBtn = document.querySelector('.prev-btn');
	const nextBtn = document.querySelector('.next-btn');

	let currentIndex = 0;

	function showSlide(index) {
		slides.forEach((slide) => slide.classList.remove('active'));
		slides[index].classList.add('active');
	}

	prevBtn.addEventListener('click', () => {
		currentIndex = (currentIndex === 0) ? slides.length - 1 : currentIndex - 1;
		showSlide(currentIndex);
	});

	nextBtn.addEventListener('click', () => {
		currentIndex = (currentIndex === slides.length - 1) ? 0 : currentIndex + 1;
		showSlide(currentIndex);
	});

	//✅ 자동 넘김 기능 (원하면 사용)
	setInterval(() => {
		nextBtn.click();
	}, 5000);
});
