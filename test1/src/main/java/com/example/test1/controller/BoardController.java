package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

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

import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;


@Controller
public class BoardController {

    private final StuController stuController;
	
	@Autowired
	BoardService BoardService;

    BoardController(StuController stuController) {
        this.stuController = stuController;
    }		

	@RequestMapping("/board-list.do") 
    public String login(Model model) throws Exception{

        return "/board-list";
    }
	
	@RequestMapping("/board-add.do") 
    public String add(Model model) throws Exception{

        return "/board-add";
    }

	@RequestMapping("/board-view.do") 
    public String view(HttpServletRequest request, Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("boardNo",map.get("boardNo"));
		
        return "/board-view";
    }
	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.getBoardList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.removeBoardList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/deleteList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectItem").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		resultMap = BoardService.deleteBoardList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addboard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.insertBoard(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String viewboard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.getBoardInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/commnet-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commnetRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.removeComment(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/commnet-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commnetAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = BoardService.addComment(map);
				
		return new Gson().toJson(resultMap);
	}
	
	// controller
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
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
				map.put("boardNo", boardNo);
				map.put("orgName", originFilename);
				map.put("size",size);
				map.put("ext", extName);
				
				
				// insert 쿼리 실행
			    BoardService.addBoardImg(map);
				
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
