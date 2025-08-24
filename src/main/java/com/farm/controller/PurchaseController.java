package com.farm.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.CustomUserDetails;
import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;
import com.farm.dto.WishlistDTO;
import com.farm.service.IMemberService;
import com.farm.service.IPurchaseService;

@Controller
public class PurchaseController {
	/*
	const CART = window.CART || [
    	{ id: 202, name: '크라운 참크래커 40개(개별포장)', qty: 1, price:12000 },
    	{ id: 101, name: '오리온 뉴퍽지 75g', qty: 3, price:10000 },
  	];
	 */
	
	@Autowired
	IPurchaseService purDAO;
	@Autowired
	IMemberService memDAO;
	
	@GetMapping("/buyer/purchase/direct.do")
	// 파라미터로 prod_id 현재상품 qty 몇개사는지
	public String purchaseDirect(@RequestParam("prod_id") String prod_id, @RequestParam("qty") int qty, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		WishlistDTO prod = purDAO.selectProduct(prod_id);
		prod.setProd_id(prod_id);
		prod.setProd_qty(qty);
		List<WishlistDTO> cart = new ArrayList<>();
		cart.add(prod);
		
		// 주소전달을 위해 현재 사용자 가져오기
		MemberDTO member = userDetails.getMemberDTO();
	    Long member_id = userDetails.getMemberDTO().getMember_id();
		
		// 현재 사용자의 메인 주소 가져오기
		AddressDTO address = memDAO.selectAddressMain(member_id);
		
	    List<AddressDTO> saved = memDAO.selectAddress(member_id);

		
		// 모델 객체로 전달
		model.addAttribute("cart",cart);
		model.addAttribute("addr", address);
		model.addAttribute("savedAddresses", saved);
		return "order_page";
	}
	
	@GetMapping("/buyer/purchase/wishlist.do")
	public String purchaseWishlist(@RequestParam("wishlist") List<Long> wishlist, Model model,
			@AuthenticationPrincipal CustomUserDetails userDetails) {
		// 주소전달을 위해 현재 사용자 가져오기
		MemberDTO member = userDetails.getMemberDTO();
	    Long member_id = userDetails.getMemberDTO().getMember_id();
		
		// 현재 사용자의 메인 주소 가져오기
		AddressDTO address = memDAO.selectAddressMain(member_id);
		
	    List<AddressDTO> saved = memDAO.selectAddress(member_id);

		
		// 구매할 상품 가져오기
		List<WishlistDTO> cart = purDAO.selectProducts(wishlist);
		
		// 모델객체로 전달
		model.addAttribute("cart",cart);
		model.addAttribute("addr", address);
		model.addAttribute("savedAddresses", saved);
		model.addAttribute("wishList", wishlist);
		
		return "order_page";
	}
	
	@GetMapping("/buyer/purchase/complete.do")
	public String purchaseComplete() {
		return "pur_complete";
	}
}
