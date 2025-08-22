package com.farm.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.PurchaseDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IProductService;
import com.farm.service.IPurchaseService;
import com.farm.service.ReviewCarouselService;



@Controller
public class MainController {

    private final PaymentController paymentController;

	@Autowired
	IProductService proDao;
	
	@Autowired
	private final ReviewCarouselService reviewCarouselService;
	
	@Value("${main.bestforweek}")
	private int bestforweek;
	
    MainController(PaymentController paymentController, ReviewCarouselService reviewCarouselService) {
        this.paymentController = paymentController;
        this.reviewCarouselService = reviewCarouselService;
    }
	
	@GetMapping("/")
	public String main(@AuthenticationPrincipal CustomUserDetails userDetails, Model model,
			@RequestParam(name = "reviewPage", required = false, defaultValue = "20") int reviewPage) {
		if(userDetails!=null) {
			MemberDTO member = userDetails.getMemberDTO();
			System.out.println(member.getName());
			model.addAttribute("memberName", member.getName());
			System.out.println(userDetails.getMemberDTO().getUser_id());
			
			// buyer가 아니라면 mypage로 리디렉션
			if(!member.getUser_type().equals("ROLE_BUYER")) {
				return "redirect:/mypage.do";
			}	
		}
		
		//서비스에서 리뷰 데이터 가져오기
	    List<ReviewBoardDTO> reviews = reviewCarouselService.getTopLikedReviews(reviewPage);
	    
	    model.addAttribute("reviewPage", reviews);
		
		Long end = (long)bestforweek;
		ArrayList<ProductDTO> bests = proDao.selectBestProdForLastWeek(end);
		
		model.addAttribute("bests", bests);
		
		return "main";
	}
		
		
		
	@Autowired
	
	IPurchaseService purDao;
	
	
	@GetMapping("/insertPurchase.do")
	public String inspur(PurchaseDTO purchaseDTO) {
	    
	    // 날짜변수 생성 시작
	    LocalDate today = LocalDate.now();
	    LocalDate oMA = today.minusMonths(1);
	    long between = ChronoUnit.DAYS.between(oMA, today);
	    // 날짜변수 생성 종료
	    
	    Random seed = new Random();
	    int successCount = 0;
	    
	    for(int i = 1 ; i <= 300 ; i++) {
	        PurchaseDTO newPurchaseDTO = new PurchaseDTO();
	        
	        long randomDays = ThreadLocalRandom.current().nextLong(between + 1);
	        newPurchaseDTO.setPurc_date(oMA.plusDays(randomDays));
	        newPurchaseDTO.setPurc_request("경비실에 맡겨주세요");
	        
	        int rd = seed.nextInt(7) + 1;
	        Long md = 0L;
	        switch (rd) {
	            case 1: md = 12L; break;
	            case 2: md = 1L; break;
	            case 3: md = 10L; break;
	            case 4: md = 3L; break;
	            case 5: md = 6L; break;
	            case 6: md = 21L; break;
	            case 7: md = 8L; break;
	        }
	        
	        newPurchaseDTO.setMember_id(md);
	        newPurchaseDTO.setProd_id(seed.nextLong(13) + 2);
	        
	        String oN = PaymentController.generateRandomString(Integer.toString(i), 20);
	        newPurchaseDTO.setOrder_num(oN);
	        newPurchaseDTO.setQty(seed.nextInt(11) + 1);
	        
	        // 한 번에 하나씩 INSERT
	        int result = purDao.insertPurchase(newPurchaseDTO);  // 단일 insert 메소드
	        if(result > 0) successCount++;
	    }
	    
	    System.out.printf("%d행 입력에 성공했습니다.", successCount);
	    return "redirect:/";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
