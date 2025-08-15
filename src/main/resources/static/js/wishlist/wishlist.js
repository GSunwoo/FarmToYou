console.log("wishlist.js loaded!");

document.addEventListener("DOMContentLoaded", function() {
    const cartBody = document.getElementById("cart-body");
	
	console.log("cartBody 객체 : ", cartBody);
	
    const totalAmountEl = document.getElementById("total-amount");

    // 확인: 페이지 로드 시 모든 wish_id 출력
    document.querySelectorAll("#cart-body tr").forEach(row => {
        console.log("Loaded row wish_id:", row.dataset.wishId, "prod_id:", row.dataset.prodId);
    });

    function updateTotalPrice() {
        let total = 0;
        document.querySelectorAll("#cart-body tr").forEach(row => {
            const priceEl = row.querySelector(".price");
            const qty = parseInt(row.querySelector(".qty-input").value, 10);
            const unitPrice = parseInt(priceEl.dataset.price, 10);
            const rowTotal = unitPrice * qty;
            priceEl.textContent = rowTotal.toLocaleString() + "원";
            total += rowTotal;
        });
        totalAmountEl.textContent = total.toLocaleString();
    }

    updateTotalPrice();

    cartBody.addEventListener("click", function(e) {
        if (!e.target.classList.contains("qty-btn")) return;

        const row = e.target.closest("tr");
        const wishId = row.dataset.wishId;
        const prodId = row.dataset.prodId;
        const qtyInput = row.querySelector(".qty-input");
        let qty = parseInt(qtyInput.value, 10);
        const delta = parseInt(e.target.dataset.delta, 10);

        console.log("[수량 변경 요청] wish_id:", wishId, "prod_id:", prodId, "변경 전 수량:", qty);

        if (delta === -1 && qty <= 1) return;

        const newQty = qty + delta;

        fetch(`/wishlist/updateQty.do`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `prod_qty=${newQty}&wish_id=${wishId}`
        })
        .then(res => res.text())
        .then(result => {
            console.log("[서버 응답]", result);
            if (result === "success") {
                qtyInput.value = newQty;
                updateTotalPrice();
            } else if (result === "login") {
                alert("로그인이 필요합니다.");
            } else {
                alert("수량 변경 실패");
            }
        })
        .catch(err => console.error("AJAX 오류:", err));
    });

    cartBody.addEventListener("click", function(e) {
        if (!e.target.classList.contains("delete-btn")) return;

        if (!confirm("정말 삭제하시겠습니까?")) return;

        const row = e.target.closest("tr");
        const wishId = row.dataset.wishId;
        const prodId = row.dataset.prodId;

        console.log("[삭제 요청] wish_id:", wishId, "prod_id:", prodId);

        fetch(`/wishlist/delete.do`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `prod_id=${prodId}&wish_id=${wishId}`
        })
        .then(res => res.text())
        .then(result => {
            console.log("[서버 응답]", result);
            if (result === "success") {
                row.remove();
				alert("삭제되었습니다.")
                updateTotalPrice();
				
                if (!document.querySelector("#cart-body tr")) {
                    document.querySelector(".cart-container").innerHTML = "<div style='text-align:center;padding:20px;'>장바구니에 상품이 없습니다.</div>";
                }
            } else if (result === "login") {
                alert("로그인이 필요합니다.");
            } else {
                alert("삭제 실패");
            }
        })
        .catch(err => console.error("AJAX 오류:", err));
    });
});
