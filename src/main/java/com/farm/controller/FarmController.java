package com.farm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.config.CustomUserDetails;
import com.farm.dto.FarmDTO;
import com.farm.service.IFarmService;

@Controller
public class FarmController {
	
	@Autowired
	IFarmService famDao;
	
	@GetMapping("/seller/sellerUpdateForm")
    public String sellerUpdateForm(@AuthenticationPrincipal CustomUserDetails ud,
    		FarmDTO farmDTO, Model model) {
    	Long member_id = ud.getMemberDTO().getMember_id();
    	farmDTO = famDao.selectFarmInfo(member_id);
    	if(farmDTO !=null) {
    		farmDTO = famDao.selectFarmInfo(member_id);
    		model.addAttribute("farmDTO", farmDTO);
    	}
        return "seller/sellerUpdateForm";
    }
    @PostMapping("seller/farmRegiOrUpdate")
    public String farmRegiOrUpdate(@AuthenticationPrincipal CustomUserDetails ud, 
    		FarmDTO farmDTO) {
    	Long member_id = ud.getMemberDTO().getMember_id();
    	System.out.println("여기까지 오나?"+ farmDTO.getFarm_id());
    	farmDTO.setMember_id(member_id);
    	
    	famDao.deleteFarm(member_id);
    	int insResult = famDao.insertFarm(farmDTO);
    	
    	if(insResult > 0) {    		
    		return "redirect:/mypage.do";
    	}
    	else {
    		return "redirect:/";
    	}
    }
}
