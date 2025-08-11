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
});