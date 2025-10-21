package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.GeminiService;



@Controller

public class ChatController {
	
	
	@Autowired
	GeminiService geminiService;
	
	@RequestMapping("/chat.do") 
    public String login(Model model) throws Exception{

        return "/chat";
    }
	@RequestMapping(value = "/gemini/chat", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, String> chat(@RequestParam("input") String input) {
	    HashMap<String, String> map = new HashMap<>();
	    String message = geminiService.getContents(input);
	    
	    map.put("message", message); // JSON 객체로 반환
	    return map;
	}
	
	
    
}
	