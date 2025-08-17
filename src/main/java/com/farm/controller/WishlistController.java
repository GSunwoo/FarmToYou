package com.farm.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.config.CustomUserDetails;
import com.farm.dto.WishlistDTO;
import com.farm.service.IWishlistService;

@Controller
public class WishlistController {

	@Autowired
	IWishlistService wishDao;
	
	@PostMapping("/wishlist/add.do")
	@ResponseBody
	public int addWishlist(@AuthenticationPrincipal
			CustomUserDetails customUserDetails,
			WishlistDTO wishlistDTO) {
		
		System.out.println("넘어는 옴?");
		
		int result = 0;
		try {
			Long member_id = customUserDetails.getMemberDTO().getMember_id();
			if(member_id != null) {
				wishlistDTO.setMember_id(member_id);
			}
			
			result = wishDao.addWishlist(wishlistDTO);
			
			
		} catch (Exception e) {
			System.out.println("로그인되지 않았습니다.");
			result = -1;
		}
		
		return result;
	}
	
	
	@GetMapping("/wishlist/list.do")
	public String wishlist(@AuthenticationPrincipal CustomUserDetails usesrDetails,
			Model model) {
		Long member_id = usesrDetails.getMemberDTO().getMember_id();
		ArrayList<WishlistDTO> wishlist = wishDao.selectWishlist(member_id);
		model.addAttribute("wishlist", wishlist);
		
		
		return "wishlist/list";
	}
	
	@ResponseBody
	@PostMapping("/wishlist/updateQty.do")
	public String updateWishlist(@RequestParam("prod_qty") Long prod_qty,
			@RequestParam("wish_id") Long wish_id) {
		System.out.println("[updateQty 요청] wish_id=" + wish_id + ", prod_qty=" + prod_qty);
		
		
		int result = wishDao.updateWishlist(prod_qty, wish_id);
		if(result == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	@ResponseBody
	@PostMapping("/wishlist/delete.do")
	public String deleteWishlist(
			@RequestParam("wish_id") Long wish_id) {
	    System.out.println("[delete 요청] wish_id=" + wish_id);
		int result = wishDao.deleteWishlist(wish_id);
		
		if(result == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
}
