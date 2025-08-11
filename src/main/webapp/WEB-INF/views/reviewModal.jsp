<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="reviewModal" class="modal" hidden>
	<div class="modal-dialog">
		<div class="modal-content">
			<button type="button" class="modal-close">x</button>
			<div class="modal-body">
				<div class="modal-left">
					<!-- 부모인 리뷰페이지에서 review-cards로 지정하고 js를 이용해서 이미지값을 받아옴  -->
					<img class="modal-image" alt="" />
				</div>
				<div class="modal-right">
					<div class="review-author">
						<span class="author modal-author"></span>
						<time class="review-date modal-date" datetime=""></time>
					</div>
					<div class="rating modal-rating"></div>
					<div class="review-content modal-content-text"></div>
					<div class="modal-actions">
						<button type="button" class="like-btn" data-like-url-base=
						"${pageContext.request.contextPath}/reviews" data-review-id="" >
							<span class="heart">♥</span>
							<span class="like-count">0</span>
						</button>
					</div>
					<input type="hidden" class="modal-review-id" value="">
				</div>
			</div>		
		</div>
	</div>
</div>