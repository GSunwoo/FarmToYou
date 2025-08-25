<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	/* 모달이 모든 것 위에 오도록 강제 */
#reviewModal{ z-index: 999999 !important; }
/* 혹시 내부 겹침 방지 */
#reviewModal .modal-content{ position: relative; z-index: 1; }
/* 우측 패널이 투명해도 배경 글자 안 비치도록 */
#reviewModal .modal-right{ background:#fff; }
/* 닫기 버튼도 최상위로 */
#reviewModal .modal-close{ z-index: 2; }
</style>

<div id="reviewModal" class="modal" hidden>
	<div class="modal-dialog">
		<div class="modal-content">
			<button type="button" class="modal-close">x</button>
			<div class="modal-body">
				<div class="modal-left">
					<!-- 부모인 리뷰페이지에서 review-cards로 지정하고 js를 이용해서 이미지값을 받아옴  -->
					<img class="modal-image" alt="리뷰 이미지" />
				</div>
				<div class="modal-right">
					<div class="review-author">
						<span class="author modal-author"></span>
						<time class="review-date modal-date"></time>
					</div>
					<div class="rating modal-rating"></div>
					<div class="review-content modal-content-text">
					</div>
					<div class="modal-actions">
						<button type="button" class="like-btn" 
								data-review-id="${review.review_id }" 
								data-liked="${review.review_liked}"
								data-likes= "${review.review_like }"
								data-prod-id="${review.prod_id }">
							<span class="heart">❤️</span>
							<span class="like-count">${review.review_like}</span>
						</button>
						<a class="prod-link" href="#">상세보기</a>
					</div>
					<div class="evaluation modal-evaluation"></div>
				</div>
			</div>		
		</div>
	</div>
</div>