package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.AreaController;
import com.example.test1.controller.StuController;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

    private final AreaController areaController;

    private final StuController stuController;
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

    MemberService(StuController stuController, AreaController areaController) {
        this.stuController = stuController;
        this.areaController = areaController;
    }
	public HashMap<String , Object> login(HashMap<String , Object> map){
		
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		Member member = memberMapper.memberLogin(map);
		
		String message = member != null ? "로그인성공" : "로그인실패!";
		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	public HashMap<String , Object> check(HashMap<String , Object> map){
		
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		Member member = memberMapper.memberCheck(map);
		
		String message = member != null ? "이미사용중인아이디 입니다" : "사용 가능한 아이디 입니다.";
		String result = member != null ? "success" : "fail";
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		//세션정보 삭제하는 방법은
		// 1개씩 키값을 이용해 삭제하거나, 전체를 한번에 삭제
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		
//		session.removeAttribute("sessionId");//1개씩 삭제
		
		session.invalidate();//세션정보 전체 삭제
		
		resultMap.put("msg", message);
		
		return resultMap;
	}
	
	public HashMap<String, Object> addmember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
	
		int member = memberMapper.addmember(map);
		List<Member> fileList = memberMapper.insertUserImg(map);
		
		if(member < 1 ) {
			resultMap.put("result", "success");
			resultMap.put("fileList", fileList);
			
		}else {
			resultMap.put("result", "fail");
			
		}
		
		return resultMap;
	}
	
}
