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

import com.example.test1.dao.StudentService;
import com.google.gson.Gson;


@Controller
public class	 StuController {
	
	@Autowired
	StudentService StudentService;	

	@RequestMapping("/stu-list.do") 
    public String login(Model model) throws Exception{

        return "/stu-list";
    }
	
	@RequestMapping("/stu-view.do") 
    public String stuview(HttpServletRequest request,Model model , @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-view";
    }
	
	@RequestMapping("/stu-edit.do") 
    public String stuedit(HttpServletRequest request,Model model , @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-edit";
    }


	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = StudentService.stuInfo(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = StudentService.getStuList(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	
	@ResponseBody
	public String removeStu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = StudentService.removeStu(map);
				
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = StudentService.stu(map);
				
		return new Gson().toJson(resultMap);
	}
	
@RequestMapping(value = "/stu-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	
	@ResponseBody
	public String updateStu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = StudentService.updateStu(map);
				
		return new Gson().toJson(resultMap);
	}
	
}
