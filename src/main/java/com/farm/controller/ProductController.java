package com.farm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ProductImgDTO;
import com.farm.service.IProductImgService;
import com.farm.service.IProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import jakarta.transaction.Transactional;
import utils.PagingUtil;
import utils.UploadUtils;



@Controller
public class ProductController {
	
	@Value("${board.pageSize}")
	private int pageSize;
	
	@Value("${board.blockPage}")
	private int blockPage;
	
	@Value("${board.bestSize}")
	private int bestSize;
	
	@Autowired
	IProductService proDao;
	
	@Autowired
	IProductImgService imgDao;
	
	@GetMapping("/seller/write.do")
	public String sellerWrite() {

		return "productForm";
	}
	@PostMapping("/seller/write.do")
	public String sellerWrite2(
			@AuthenticationPrincipal CustomUserDetails userDetails,
			@RequestParam("main_idx") int main_idx,
			@RequestParam("image") List<MultipartFile> files,
			ProductDTO productDTO) {
		productDTO.setMember_id(userDetails.getMemberDTO().getMember_id());
		int prodResult = proDao.productWrite(productDTO);
		Long prod_id = productDTO.getProd_id();
		
		if(!files.isEmpty()) {
			insertImg(prod_id, main_idx, files);			
		}
		
		

		return "redirect:/guest/Detailpage.do?prod_id="+prod_id;
	}
	

	public void insertImg(Long prod_id, int main_idx,
			List<MultipartFile> files) {
		
		try {
			
			String uploadDir = ResourceUtils.getFile(
					"classpath:static/uploads/prodimg/prod_id/").toPath().toString();
			System.out.println("저장경로 : " + uploadDir);
			File dir = new File(uploadDir, String.valueOf(prod_id));
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			
			long i = 1;
			for(MultipartFile file : files) {
				if (!file.isEmpty()) {
					continue;
				}
	
				String savedFileName =
						UploadUtils.getNewFileName(file.getOriginalFilename());
				File dest = new File(dir, savedFileName);
				file.transferTo(dest);
				
				ProductImgDTO productImgDTO = new ProductImgDTO();
				
				productImgDTO.setFilename(savedFileName);
				productImgDTO.setIdx(i);
				productImgDTO.setProd_id(prod_id);
				if(i == main_idx) {
					productImgDTO.setMain("main");
				}
				
				int insertResult = imgDao.insertImg(productImgDTO);
				
				if(insertResult == 1) {
					System.out.printf("전체 파일 %d 중 %d번째 파일업로드 성공", files.size(), i);
				}
				else {
					System.err.printf("전체 파일 %d 중 %d번째 파일업로드 실패", files.size(), i);
				}
				i++;
			}
			
		}
		catch (Exception e) {
			System.out.println("이미지 업로드 실패 : ");
			e.printStackTrace();
		}
		
		

	}
	
	
	
	
	
	@GetMapping("/guest/productList.do")
	public String productList(HttpServletRequest req,
			ProductDTO productDTO, Model model,
			ParameterDTO parameterDTO) {
		
		
		
		int pageNum = (req.getParameter("pageNum") == null
				|| req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		
		parameterDTO.setStart((pageNum - 1) * pageSize + 1);
	    parameterDTO.setEnd(pageNum * pageSize);
		
	    
	    if(parameterDTO.getSearchWord() != null && 
	    		!parameterDTO.getSearchWord().trim().equals("")) {
	    	parameterDTO.setSearchWords(Arrays.asList(parameterDTO.getSearchWord().trim().split(" ")));
	    }
		
		
		int totalCount = proDao.getTotalCount(parameterDTO);
		System.out.println("totalcount" + totalCount);
		ArrayList<ProductDTO> lists = proDao.selectProduct(parameterDTO);
		//베스트상품 불러오기
		parameterDTO.setEnd(bestSize);
		ArrayList<ProductDTO> bests = proDao.selectBestProd(parameterDTO);
		model.addAttribute("bests", bests);
		//베스트상품 끝
		
		
		 Map<String, Object> paramMap = new HashMap<>();
		 	paramMap.put("totalCount", totalCount);
		    paramMap.put("pageSize", pageSize);
		    paramMap.put("pageNum", pageNum);
		    
		model.addAttribute("paramMap", paramMap);
		
		
		model.addAttribute("lists", lists);
		if(lists.isEmpty()) {			
			System.out.println("리스트 빔?");
		}
		
		String pagingImg = PagingUtil.pagingImg(
				totalCount, pageSize, blockPage, pageNum, 
				req.getContextPath()+"/list.do?");
		
		return "Productpage";
	}
	
	@GetMapping("/guest/Detailpage.do")
	public String productView(ProductDTO productDTO, Model model,
			@RequestParam("prod_id") Long prod_id,
			ProductImgDTO productImgDTO) {
		
		productDTO = proDao.selectProductView(prod_id);
		productDTO.setProd_content(productDTO.getProd_content()
				.replace("\r\n", "<br/>"));
		
		model.addAttribute("productDTO", productDTO);
				
		
		// 이미지 불러오기 시작
		ArrayList<ProductImgDTO> imglist = imgDao.selectImg(prod_id);
		model.addAttribute("imglist", imglist);
		
		
		
		return "Detailpage";
	}
	
	
	@GetMapping("/seller/update.do")
	public String productUpdate(
			@AuthenticationPrincipal CustomUserDetails userDetails,
			@RequestParam("prod_id") Long prod_id,
			ProductDTO productDTO, Model model) {
		Long login_id = userDetails.getMemberDTO().getMember_id();
		productDTO = proDao.selectProductView(prod_id);
		Long write_id = productDTO.getMember_id();
		
		
		try {
			
			if(login_id == write_id && login_id != null && write_id != null) {
				model.addAttribute("productDTO", productDTO);
				return "seller/update";
			}
			
			
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("로긴아이디 : " + ((login_id!=null) ? login_id : "null"));
			System.out.println("작성자아이디 : " + ((write_id!=null) ?login_id : "null"));
		}
			
			
		return "redirect:/";
	}
	
	@PostMapping("/seller/update.do")
	public String productUpdate2(ProductDTO productDTO,
			@RequestParam("main_idx") int main_idx,
			@RequestParam("image") List<MultipartFile> files){
		int prod_result = proDao.productUpdate(productDTO);
		Long prod_id = productDTO.getProd_id();
		
		//이미지 전체 삭제 후 삽입
		int img_result = imgDao.deleteImg(prod_id);
		if(img_result == 1) {
			insertImg(prod_id, main_idx, files);
		}
		if(prod_result == 1) {
			System.out.println("상품 수정신청이 들어왔습니다.");
		}
		else {
			System.out.println("상품 수정신청에 실패했습니다. : " + prod_result);
		}
		return "seller/myPageList";
	}
	
	@PostMapping("/seller/delete.do")
	public String delete(@RequestParam("prod_id") Long prod_id){
		int prod_result = proDao.productDelete(prod_id);
		int img_result = imgDao.deleteImg(prod_id);
		if(prod_result == 1 && img_result == 1) {
			System.out.println("상품 삭제가 완료되었습니다 : " + prod_result);
		}
		else {
			System.out.println("상품 삭제에 실패하였습니다. : " + prod_result);
		}
		return "seller/myPageList";
	}
	
	
}
