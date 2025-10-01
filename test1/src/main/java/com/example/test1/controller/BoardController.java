package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
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
}
