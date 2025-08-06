/**
마이페이지리스트 달력 이벤트
 */
document.addEventListener('DOMContentLoaded', () => {
	// 시작일 달력 초기화
	const startPicker = flatpickr('#picker', {
		dateFormat: "Y-m-d"
	});

	// 종료일 달력 초기화 (id pickerEnd)
	const endPicker = flatpickr('#pickerEnd', {
		dateFormat: "Y-m-d"
	});

	// 기간 버튼 클릭 이벤트
	document.querySelectorAll('.date-check-list button').forEach(button => {
		button.addEventListener('click', () => {
			const days = parseInt(button.dataset.value);
			const today = new Date();
			const startDate = new Date(today);
			startDate.setDate(today.getDate() - days);

			// 달력 날짜 변경
			startPicker.setDate(startDate, true);
			endPicker.setDate(today, true);

			// 버튼 active 클래스 토글
			document.querySelectorAll('.date-check-list button').forEach(btn => btn.classList.remove('active'));
			button.classList.add('active');
		});
	});
});