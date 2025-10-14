package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class ProductController {
	
	@Autowired
	ProductService ProductService;


	@RequestMapping("/product.do") 
    public String product(Model model) throws Exception{
        return "/product";
    }
	
	@RequestMapping("/product/add.do") 
    public String productAdd(Model model) throws Exception{
        return "/product-add";
    }
	@RequestMapping("/product/view.do") 
    public String productView(HttpServletRequest request, Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("foodNo", map.get("foodNo"));
        return "/product-view";
    }
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = ProductService.getProductList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/product/menulist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String menuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = ProductService.getMenuList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = ProductService.addFood(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/product/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("foodNo") int foodNo, HttpServletRequest request,HttpServletResponse response, Model model)
	{
		String url = null;
		String path="c:\\img";
		try {

			//String uploadpath = request.getServletContext().getRealPath(path);
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("uploadpath : " + uploadpath);
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
			if(!multi.isEmpty())
			{
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
				multi.transferTo(file);
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("filename", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("foodNo", foodNo);
				map.put("orgName", originFilename);
				map.put("size",size);
				map.put("ext", extName);
				
				// insert 쿼리 실행
			    ProductService.addFoodImg(map);
				
				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				
				return "redirect:list.do";
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}

	private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}
	
	@RequestMapping(value = "/product/Info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = ProductService.selectProduct(map);
				
		return new Gson().toJson(resultMap);
	}
}
