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

import com.example.test1.dao.BbsService;

import com.google.gson.Gson;




@Controller
public class BbsController {

	@Autowired
	BbsService BbsService;
	
	@RequestMapping("/bbs/list.do") 
    public String login(Model model) throws Exception{

        return "/bbs/list";
    }
	
	@RequestMapping("/bbs/list-add.do") 
    public String add(Model model) throws Exception{

        return "/bbs/list-add";
    }
	
	@RequestMapping("/bbs/list-view.do") 
    public String view(HttpServletRequest request, Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("bbsNum", map.get("bbsNum"));
		
        return "/bbs/list-view";
    }
	
	@RequestMapping("/bbs/list-edit.do") 
    public String edit(HttpServletRequest request, Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("bbsNum", map.get("bbsNum"));
		
        return "/bbs/list-edit";
    }
	
	@RequestMapping(value = "/bbs-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BbsService.getBbsList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BbsService.addBbs(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BbsService.removeBbs(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BbsService.getBbsInfo(map);
				
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/bbs-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String edit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BbsService.updateInfo(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/bbs/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("bbsNo") int bbsNo, HttpServletRequest request,HttpServletResponse response, Model model)
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
				map.put("path", "../img/" + saveFileName);
				map.put("bbsNo", bbsNo);
				map.put("org", originFilename);
				map.put("size", size);
				map.put("etc", extName);
				
				// insert 쿼리 실행
			    BbsService.addImg(map);
				
				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				
				return "redirect:list.do";
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}
	    
	// 현재 시간을 기준으로 파일 이름 생성
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
	
}
