package com.farm.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.config.CustomUserDetails;
import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;
import com.farm.dto.OrderDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IMemberFormService;
import com.farm.service.IMemberService;
import com.farm.service.IMypageService;
import com.farm.service.IOrderService;
import com.farm.service.ReviewBoardService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MypageBuyerController {
	
	@Value("${board.pageSize}")
	private int pageSize;
	
	@Value("${board.blockPage}")
	private int blockPage;
	
	@Value("${board.bestSize}")
	private int bestSize;
	
	@Autowired
	IMypageService mypageDAO;
	@Autowired
	IMemberService memDAO;
	@Autowired
	IOrderService orderDAO;
	@Autowired
	ReviewBoardService reviewDAO;
	
	@Autowired
	IMemberFormService mFDao;
	
	@GetMapping("/mypage.do")
	public String mypageMapper(@AuthenticationPrincipal CustomUserDetails userDetails) {
		MemberDTO member = userDetails.getMemberDTO();
		if(member.getUser_type().equals("ROLE_BUYER")) {
			return "redirect:/buyer/mypage.do";
		}
		else if(member.getUser_type().equals("ROLE_ADMIN")) {
			return "redirect:/admin/mypage.do";
		}
		else {
			return "redirect:/seller/mypage.do";
		}
	}
	
	@GetMapping("/buyer/mypage.do")
	public String buyerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		if(userDetails!=null) {
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			/**************************************************/
			int orderCnt = mypageDAO.getOrderCnt(member_id);
			int reviewCnt = mypageDAO.getReviewCnt(member_id);
			int inquiryCnt = mypageDAO.getInquiryCnt(member_id);
			model.addAttribute("orderCnt", orderCnt);
			model.addAttribute("reviewCnt", reviewCnt);
			model.addAttribute("inquiryCnt_buyer", inquiryCnt);
			/**************************************************/
			
			int pageNum = (req.getParameter("pageNum") == null
					|| req.getParameter("pageNum").equals(""))
					? 1 : Integer.parseInt(req.getParameter("pageNum"));
			
			parameterDTO.setStart((pageNum - 1) * pageSize + 1);
		    parameterDTO.setEnd(pageNum * pageSize);
			
			List<OrderDTO> orders = orderDAO.selectBuyerOrdersAll(parameterDTO, member_id);
			
			for(int i=0;i<orders.size();i++) {
				Long purc_id = orders.get(i).getPurc_id();
				Integer isWritten = reviewDAO.existReview(purc_id);
				orders.get(i).setIsWritten(isWritten);
//				System.out.println(isWritten);
			}
			
			model.addAttribute("orders", orders);
			model.addAttribute("member", member);
		}
		return "buyer/myPageList";
	}
	
	
	@GetMapping("/buyer/address/list.do")
	public String buyerAddress(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		List<AddressDTO> addressList = memDAO.selectAddress(member_id);
		
		model.addAttribute("addressList", addressList);
		model.addAttribute("member", member);
		
		return "buyer/delivery-destination";
	}
	
	@PostMapping("/buyer/address/write.do")
	public ResponseEntity<AddressDTO> addAddress(@RequestBody AddressDTO addressDTO,
				@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		addressDTO.setMember_id(member_id);
		int result = memDAO.insertAddress(addressDTO);
		
		return ResponseEntity.ok(addressDTO);
	}
	
	@PostMapping("/buyer/address/update.do")
	public ResponseEntity<Long> updateAddress(@RequestParam("addr_id") Long addr_id,
			@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		// 멤버의 모든 address 전체 main 0으로 변경
		int resultZero = memDAO.updateMainToZero(member_id);
		// 메인 지정
		int resultMain = memDAO.updateMain(addr_id);
		
		return ResponseEntity.ok(addr_id);
	}
	
	@PostMapping("/buyer/address/delete.do")
	public String deleteAddress(@RequestParam("addr_id") Long addr_id) {
		
		int result = memDAO.deleteAddress(addr_id);
		
		return "redirect:/buyer/address/list.do";
	}
	

	
	@GetMapping("/buyer/editForm.do")
    public String editForm(@AuthenticationPrincipal CustomUserDetails ud,
    		MemberDTO memberDTO, Model model) {
		if(ud != null) {
			memberDTO = ud.getMemberDTO();
		}
		
		model.addAttribute("memberDTO", memberDTO);
		
        return "buyer/editForm";
    }
	@PostMapping("/buyer/editBuyerMemberInfo.do")
	public String editBuyerMemberInfo(MemberDTO memberDTO,
			@AuthenticationPrincipal CustomUserDetails ud) {
		memberDTO.setMember_id(ud.getMemberDTO().getMember_id());
		String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder()
				.encode(memberDTO.getUser_pw());
		memberDTO.setUser_pw(passwd.replace("{bcrypt}", ""));
		
		int result = mFDao.updateMember(memberDTO);
		if(result > 0) {
			return "redirect:/buyer/editForm.do";
		}
		else {
			return "error";
		}
	}
	
	@GetMapping("/buyer/reviewManagement")
    public String reviewManagement1(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		Long member_id = userDetails.getMemberDTO().getMember_id();
		List<ReviewBoardDTO> myReviewList = reviewDAO.selectReviewByMember(member_id);
		
		model.addAttribute("myReviewList", myReviewList);
		
        return "buyer/reviewManagement";
    }
	
}
