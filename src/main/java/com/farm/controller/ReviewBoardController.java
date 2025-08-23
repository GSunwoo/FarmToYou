package com.farm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.farm.config.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.dto.ReviewImgDTO;
import com.farm.service.ReviewBoardService;
import com.farm.service.ReviewCarouselService;
import com.farm.service.ReviewImgService;
import com.farm.service.ReviewLikeService;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import utils.UploadUtils;

@Controller
public class ReviewBoardController {


	@Autowired
	ReviewBoardService dao;

	@Autowired
	ReviewImgService Imgdao;
	
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private ReviewLikeService reviewLikeService;
	
	//목록
	@GetMapping("/guest/review/list.do")
	// HttpServletRequest : 사용자가 웹 페이지에서 서버에게 요청한 내용을 다 들고 있는 객체
	public String list(Model model, HttpServletRequest req, ReviewBoardDTO reviewboardDTO, PageDTO pageDTO,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		
		pageDTO.setStart(1);
		pageDTO.setEnd(20);
		ArrayList<ReviewBoardDTO> lists = dao.listPage(pageDTO);

		for(int i = 0 ; i < lists.size() ; i ++) {
			ReviewBoardDTO review = lists.get(i);
			review.setReview_like(dao.countLike(review.getReview_id()));
			if(userDetails!=null) {
				Long logindata = userDetails.getMemberDTO().getMember_id();
				review.setReview_liked(dao.existsLike(review.getReview_id(), logindata)==1 ? true : false);
				System.out.println(review.isReview_liked() + "memberId : " + logindata);				
			}
			else {
				review.setReview_liked(false);
			}
		}
		model.addAttribute("reviewList", lists);
		return "review/reviewPage";
	}

	//무한스크롤
	@RequestMapping("/guest/review/restApi.do")
	@ResponseBody
	public List<JSONObject> newList(PageDTO pageDTO, HttpServletRequest req, ReviewBoardDTO reviewboardDTO,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		int pageSize = 20;
		int pageNum = req.getParameter("pageNum") == null ? 1 : Integer.parseInt(req.getParameter("pageNum"));

		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		pageDTO.setStart(start);
		pageDTO.setEnd(end);

		List<JSONObject> list = new ArrayList<>();
		List<ReviewBoardDTO> selectReviewList = dao.listPage(pageDTO);
		for(int i = 0 ; i < selectReviewList.size() ; i ++) {
			ReviewBoardDTO review = selectReviewList.get(i);
			review.setReview_like(dao.countLike(review.getReview_id()));
			if(userDetails!=null) {
				Long logindata = userDetails.getMemberDTO().getMember_id();
				review.setReview_liked(dao.existsLike(review.getReview_id(), logindata)==1 ? true : false);
				System.out.println(review.isReview_liked() + "memberId : " + logindata);				
			}
			else {
				review.setReview_liked(false);
			}
		}

		for (ReviewBoardDTO review : selectReviewList) {
			Map<String, Object> reviewMap = objectMapper.convertValue(review, Map.class);
			JSONObject reviewJSON = new JSONObject(reviewMap);
			list.add(reviewJSON);
		}
		Map<String, Object> maps = new HashMap<String, Object>();

		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		
		return list;

	}

	// 열람
	@GetMapping("/guest/review/view.do")
	// DTO를 사용해서 model이라는 공간에 넘겨줌
	public String view(@RequestParam("review_id") Long reviewId, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		
		//글 상세
		ReviewBoardDTO dto = dao.selectView(reviewId);
		model.addAttribute("reviewboardDTO", dto);
		
		return "review/reviewPage";
	}
	
	//게시물 좋아요
	@PostMapping("/buyer/review/restapilike.do")
	@ResponseBody
	public Map<String, Object> toggleLike(@RequestParam Long reviewId,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		
		//상위클래스 -> Map, 하위클래스 -> HashMap
		Map<String, Object> map = new HashMap<String, Object>();
		
		//비로그인 처리
		//userDetails객체 자체가 null인지 확인
		//|| : OR연산자 - 둘 중 하나라도 true면 전체가 true
		//userDetails.getMemberDTO() == null -> 의미 : 로그인하지 않았거나 사용자 정보가 없는 상태
		if (userDetails == null || userDetails.getMemberDTO() == null) {
            map.put("success", false);
            map.put("message", "로그인이 필요합니다.");
            //로그인이 필요한 기능의 결과값들을 null로 설정
            map.put("liked", null);
            map.put("count", null);
            return map;
        }
		
		Long memberId = userDetails.getMemberDTO().getMember_id();
		
		try {
			//2) 토글 실행 (true=좋아요 추가, false=좋아요 취소)
            boolean liked = reviewLikeService.toggleLike(reviewId, memberId);

            //3) 현재 좋아요 수 재조회
            int count = reviewLikeService.countLike(reviewId);

            //요청 처리가 성공했음을 나타냄 success : true
            map.put("success", true);
            //boolean 변수로 현재 좋아요 상태
            map.put("liked", liked);
            //해당 게시물 총 좋아요 개수
            map.put("count", count);
            map.put("message", liked ? "좋아요가 추가되었습니다." : "좋아요가 취소되었습니다.");
            return map;
            
          //DataIntegrityViolationException -> Spring Framework에서 발생하는 예외로, 데이터베이스
          //의 데이터 무결성 제약조건이 위반되었을 때 던져지는 예외입니다.
          //Spring Framework는 자바 기반의 엔터프라이즈 애플리케이션 개발을 위한 오픈소스 프레임 워크
        } catch (DataIntegrityViolationException e) {
            //PK(복합키) 제약 등으로 인한 중복 처리 안전망
            int count = reviewLikeService.countLike(reviewId);
            //요청 처리가 실패 success : false
            map.put("success", false);
            map.put("liked", null);
            map.put("count", count);
            map.put("message", "처리 중 충돌이 발생했습니다. 다시 시도해 주세요.");
            return map;

        } catch (Exception e) {
            map.put("success", false);
            map.put("liked", null);
            map.put("count", null);
            map.put("message", "알 수 없는 오류가 발생했습니다.");
		}
		return map;
				
	}
	
	//좋아요삽입
	@PostMapping("/buyer/review/likeinsert.do")
	@ResponseBody
	//ResponseEntity : 본문 없는 응답을 돌려주겠다는 의미
	public int insert(
			@RequestParam("review_id") Long review_Id,
			//스프링 시큐리티에서 로그인한 사용자 정보를 주입받음
			@AuthenticationPrincipal CustomUserDetails user
	) {
		
		System.out.println("인서트 들어옴?");
		 Long member_Id = user.getMemberDTO().getMember_id();
		 //DAO를 통해 DB에서 (review_Id, member_Id) 조건으로 좋아요를 삽입
		 int result = dao.insertLike(review_Id, member_Id);
		 if(result > 0) {
			 return 200;
		 }
		 else {
			 return 0;
		 }
	}
	
	//좋아요삭제
	@PostMapping("/buyer/review/likedelete.do")
	@ResponseBody
	public ResponseEntity<Void> delete(
			@RequestParam("review_id") Long review_Id,
			@AuthenticationPrincipal CustomUserDetails user
	) {
		System.out.println("딜리트 들어옴?");
		 Long member_Id = user.getMemberDTO().getMember_id();
		 //DAO를 통해 DB에서 (review_Id, member_Id) 조건으로 좋아요를 삭제
		 int inserted = dao.deleteLike(review_Id, member_Id);
		 
		 return ResponseEntity.ok().build();
	}
	//쓰기
	@GetMapping("/buyer/review/write.do")
	public String reviewWrite(@AuthenticationPrincipal CustomUserDetails userDetails,
			Model model, @RequestParam("prod_id") Long prod_id, @RequestParam("purc_id") Long purc_id) {

		Long member_id = userDetails.getMemberDTO().getMember_id();
		model.addAttribute("member_id", member_id);
		model.addAttribute("prod_id", prod_id);
		model.addAttribute("purc_id", purc_id);
		return "review/reviewUpdate";
	}

	//쓰기
	@PostMapping("/buyer/review/write.do")
	public String write(ReviewBoardDTO reviewboardDTO, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails, HttpServletRequest req) {

		// memberDTO을 가져옴
		MemberDTO member = userDetails.getMemberDTO();
		// 로그인 된 아이디를 가져옴
		reviewboardDTO.setMember_id(member.getMember_id());
		int result = dao.write(reviewboardDTO);
		System.out.println("글쓰기결과 : " + result);

		insertImg(reviewboardDTO.getReview_id(), req);
		return "redirect:/guest/review/list.do";
	}

	//이미지 업로드
	public int insertImg(Long review_id, HttpServletRequest req) {

		// 업로드 과정에서 에러가 날 수 있으니 예외처리 시작
		try {
			// 물리적 경로 얻어오기
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/reviewimg/").toPath().toString();
			System.out.println("저장경로 : " + uploadDir);
			String sep = File.separator;
			File dir = new File(uploadDir + sep + review_id);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			long idx = 1;
			Collection<Part> parts = req.getParts();
			for (Part part : parts) {
				if (!part.getName().equals("uploadFile")) {
					continue;
				}
				ReviewImgDTO reviewimgDTO = new ReviewImgDTO();
				String partHeader = part.getHeader("content-disposition");
				String[] phArr = partHeader.split("filename=");
				String originalFileName = phArr[1].trim().replace("\"", "");
				String saveFile = UploadUtils.getNewFileName(originalFileName);

				if (!saveFile.isEmpty()) {
					part.write(uploadDir + sep + review_id + sep + saveFile);
				}
				reviewimgDTO.setFilename(saveFile);
				reviewimgDTO.setIdx(idx);
				reviewimgDTO.setReview_id(review_id);

				if (idx == 1) {
					reviewimgDTO.setMain("main");
				}

				int Result = Imgdao.insertImg(reviewimgDTO);

				if (Result == 1) {
					System.out.printf("전체 파일 %d 중 %d번째 파일업로드 성공", parts.size(), idx);
				} else {
					System.err.printf("전체 파일 %d 중 %d번째 파일업로드 실패", parts.size(), idx);
				}
				idx++;
			}

		} catch (Exception e) {
			System.out.println("업로드 실패");
			e.printStackTrace();
		}

		int result = 1;
		return result;
	}

	//수정
	@GetMapping("/buyer/review/edit.do")
	public String boardEditGet(Model model, ReviewBoardDTO reviewboardDTO) {
		// 열람에서 사용했던 메서드를 그대로 사용
		reviewboardDTO = dao.selectView(reviewboardDTO.getReview_id());
		model.addAttribute("reviewboardDTO", reviewboardDTO);
		return "seller/reviewPage";
	}

	//수정2 : 사용자가 입력한 내용을 전송하여 update 처리
	@PostMapping("/buyer/review/edit.do")
	public String boardEditPost(ReviewBoardDTO reviewboardDTO, @AuthenticationPrincipal CustomUserDetails userDetails,
			RedirectAttributes redirectAttributes) {

		try {
			MemberDTO member = userDetails.getMemberDTO();

			// 로그인된 사용자 ID 설정
			reviewboardDTO.setMember_id(member.getMember_id());

			// 상품 ID는 폼에서 받아와야 함 (hidden input 등으로)
			// reviewboardDTO.setProd_id(실제값);

			// 수정 실행
			int result = dao.edit(reviewboardDTO);

			if (result > 0) {
				System.out.println("리뷰 수정 성공: " + result);
				redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 수정되었습니다.");
			} else {
				System.out.println("리뷰 수정 실패: " + result);
				redirectAttributes.addFlashAttribute("error", "리뷰 수정에 실패했습니다.");
			}

		} catch (Exception e) {
			System.err.println("리뷰 수정 중 오류 발생: " + e.getMessage());
			redirectAttributes.addFlashAttribute("error", "시스템 오류가 발생했습니다.");
		}

		return "redirect:/guest/review/view.do?review_id=" + reviewboardDTO.getReview_id();
	}

}
