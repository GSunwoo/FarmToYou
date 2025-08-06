/* 검색창 JavaScript */
document.addEventListener('DOMContentLoaded',() =>{
	const searchInput = document.querySelector('.search-box input');
	const dropdown = document.getElementById('search-dropdown');

      searchInput.addEventListener('focus', () => {
		dropdown.style.display = 'block';
      });

      searchInput.addEventListener('blur', () => {
		setTimeout(() => {
			dropdown.style.display = 'none';
		}, 200);
      });
});