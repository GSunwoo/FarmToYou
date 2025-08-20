document.addEventListener('DOMContentLoaded', () => {
  const path = window.location.pathname; // 예: /admin/product/list.do
  const links = document.querySelectorAll('.admin-menu a');

  links.forEach(a => {
    const href = a.getAttribute('href');
    const base = href.replace(/(\?.*)|(#.*)/, '');
    if (path.startsWith(base)) {
      a.classList.add('active');
    }
  });
});
