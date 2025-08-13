package com.farm.controller;




import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.dto.ReviewImgDTO;
import com.farm.service.ReviewBoardService;
import com.farm.service.ReviewImgService;
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
	
	//목록
	@GetMapping("/guest/review/list.do")
	//HttpServletRequest : 사용자가 웹 페이지에서 서버에게 요청한 내용을 다 들고 있는 객체
	public String list(Model model, HttpServletRequest req,
			ReviewBoardDTO reviewboardDTO, PageDTO pageDTO) {
		pageDTO.setStart(1);
		pageDTO.setEnd(20);
		ArrayList<ReviewBoardDTO> lists = dao.listPage(pageDTO);
		model.addAttribute("lists", lists);
		
		//페이지 네비게이션 바를 HTM
		//String pagingImg = com.edu.springboot.utils.PagingUtil.pagingImg(
				//totalCount, pageSize, bloc t.do?");
		//model.addAttribute("pagingImg", pagingImg);

		return "review/reviewPage";
	}
	
	@RequestMapping("/guest/review/restApi.do")
	@ResponseBody
	public List<Map<String,Object>> newList(PageDTO pageDTO, HttpServletRequest req,
			ReviewBoardDTO reviewboardDTO){
		int pageSize = 20;
		int pageNum = req.getParameter("pageNum") == null
				? 1
						: Integer.parseInt(req.getParameter("pageNum"));
		
		int start = (pageNum - 1) * pageSize + 1;
		int end   = pageNum * pageSize;
		pageDTO.setStart(start);
		pageDTO.setEnd(end);
		
		List<Map<String, Object>> list = new ArrayList<>();
		ObjectMapper objectMapper = new ObjectMapper();
		List<ReviewBoardDTO> selectReviewList = dao.listPage(pageDTO);
		
		for(ReviewBoardDTO review : selectReviewList){
		    Map<String, Object> reviewMap = objectMapper.convertValue(review, Map.class);
		    list.add(reviewMap);
		}
		Map<String, Object> maps = new HashMap<String, Object>();
	
		
        
        maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		
		return list;
		
	}
	
	
	//열람
	@GetMapping("/guest/review/view.do")
	//DTO를 사용해서 model이라는 공간에 넘겨줌
	public String view(@RequestParam("review_id") Long reviewId ,Model model) {
		
		ReviewBoardDTO dto = dao.selectView(reviewId);
	    model.addAttribute("reviewboardDTO", dto);
		return "review/reviewPage";
	}
	
	@GetMapping("/buyer/review/write.do")
	   public String reviewWrite(Model model) {
	      return "review/reviewPage";
	   }
	
	
	//쓰기
	@PostMapping("/buyer/review/write.do")
	public String write(ReviewBoardDTO reviewboardDTO, Model model, @AuthenticationPrincipal CustomUserDetails userDetails,
			HttpServletRequest req) {
		
		//memberDTO을 가져옴
		MemberDTO member = userDetails.getMemberDTO();
		// 로그인 된 아이디를 가져옴
		reviewboardDTO.setMember_id(member.getMember_id());
		reviewboardDTO.setProd_id((long) 1);
		int result = dao.write(reviewboardDTO);
		System.out.println("글쓰기결과 : " + result);
		
		return "redirect:/guest/review/list.do";
	}
	
	public int insertImg(Long review_id, HttpServletRequest req,
			 List<MultipartFile> files, ReviewImgDTO reviewimgDTO) {
		 
		//업로드 과정에서 에러가 날 수 있으니 예외처리 시작
		 try {
	         // 물리적 경로 얻어오기
	         String uploadDir = ResourceUtils.getFile(
	        		 "classpath:static/uploads/reviewimg/prod_id").toPath().toString();
	         System.out.println("저장경로 : " + uploadDir);
	         String sep = File.separator;
	         File dir = new File(uploadDir + sep + review_id);
	         if(!dir.exists()) {
				 dir.mkdirs();
			}
	         
	         long i = 1;
	         Collection<Part> parts = req.getParts();
	         for(Part part: parts) {
	            if(!part.getName().equals("ofile")) {
	               continue;
	            }
	            
	            String partHeader = part.getHeader("content-disposition");
	            String[] phArr = partHeader.split("filename=");
	            String originalFileName = phArr[1].trim().replace("\"", "");
	            String saveFile =
	            		UploadUtils.getNewFileName(originalFileName);
	            
	            if(!saveFile.isEmpty()) {
	               part.write(uploadDir+ sep +review_id + sep+ saveFile);
	            }
	            reviewimgDTO.setFilename(saveFile);
	            reviewimgDTO.setIdx(i);
	            reviewimgDTO.setReview_id(review_id);
	            
	            Imgdao.insertImg(reviewimgDTO);
				i++;
	         }
	         
	      }
	      catch(Exception e) {
	         System.out.println("업로드 실패");
	         e.printStackTrace();
	      }
		 
		 int result = 1;
		 return result;
	}
	//수정
	@GetMapping("/buyer/review/edit.do")
	public String boardEditGet(Model model, ReviewBoardDTO reviewboardDTO) {
		//열람에서 사용했던 메서드를 그대로 사용
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
	
	//API 경로
	//@PostMapping("/buyer/review")
	
	
	
}
