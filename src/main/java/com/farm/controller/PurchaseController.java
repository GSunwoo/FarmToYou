package com.farm.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.dto.WishlistDTO;
import com.farm.service.IPurchaseService;

@Controller
public class PurchaseController {
	/*
	const CART = window.CART || [
    	{ id: 202, name: '크라운 참크래커 40개(개별포장)', qty: 1, price:12000 },
    	{ id: 101, name: '오리온 뉴퍽지 75g', qty: 3, eta: '2025-08-13' },
  	];
	 */
	
	@Autowired
	IPurchaseService purDAO;
	
	@GetMapping("/buyer/purchase/direct.do")
	// 파라미터로 prod_id 현재상품 qty 몇개사는지
	public String purchaseDirect(@RequestParam("prod_id") String prod_id, @RequestParam("qty") int qty, Model model) {
		WishlistDTO prod = purDAO.selectProduct(prod_id);
		prod.setProd_id(prod_id);
		prod.setProd_qty(qty);
		List<WishlistDTO> cart = new ArrayList<>();
		cart.add(prod);
		
		model.addAttribute("cart",cart);
		
		return "order_page";
	}
	
	@GetMapping("/buyer/purchase/wishlist.do")
	public String purchaseWishlist(@RequestParam("wishlist") List<Long> wishlist, Model model) {
		
		List<WishlistDTO> cart = purDAO.selectProducts(wishlist);
		
		model.addAttribute("cart",cart);
		return "order_page";
	}
}
