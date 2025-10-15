	package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.test1.controller.AreaController;
import com.example.test1.controller.StuController;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {


	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

	@Autowired
	PasswordEncoder passwordEncoder;
    
	public HashMap<String , Object> login(HashMap<String , Object> map){
		
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		Member member = memberMapper.memberLogin(map);

		
		String message =""; // 로그인 성공실패 여부 메세지
		String result =""; //로그인 성공 실패 여부
				/* 해시적용후 버전*/
		if(member != null ) {
			//아이디가 존재 , 비밀번호 비교전
			//사용자가 보낸 비밀번호 map 에서 꺼낸후 해시화한 값 
			// member 객체 안에있는 password 와 비교
		boolean loginFlg =  passwordEncoder.matches((String) map.get("pwd"), member.getPassword());
		
			if(loginFlg) {
				
				if(member.getCnt() >= 5) {
					message="비밀번호를 5회이상 잘못입력하셧습니다.";
					result="fail";
				}else {
					memberMapper.cntInit(map);
					
					message = "로그인성공";
					result="success";
					session.setAttribute("sessionId", member.getUserId());
					session.setAttribute("sessionName", member.getName());
					session.setAttribute("sessionStatus", member.getStatus());					
				}
				
				if(member.getStatus().equals("A")) {
					resultMap.put("url", "/mgr/member/list.do");
				}else {
					resultMap.put("url", "/main.do");
				}
			}else {
//				로그인 실패시 cnt 1 증가 
				memberMapper.cntIncrease(map);
				message = "패스워드를 확인해주세요.";	
	
			}
		System.out.println(loginFlg);
		
		}else{
			//아이디 존재 x ,
			message ="아이디가 존재하지않습니다.";
			result="fail";
		}
		
		
		
		
				/* 해시적용전 버전*/
//		String message = member != null ? "로그인성공" : "로그인실패!";
//		String idMsg = idCheck !=null ? "패스워드를 확인해주세요." : "아이디가 존재하지않습니다."; 
//		String result = member != null ? "success" : "fail";
		
/*		
		if(member != null && member.getCnt()>=5) {
			message = "비밀번호를 5회이상 잘못 입력하셧습니다.";
			result="fail";
		}
		else if(member != null) {
			//cnt 값 0으로 초기화
			memberMapper.cntInit(map);
			message = "로그인성공";
			result="success";
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
			
			if(member.getStatus().equals("A")) {
				resultMap.put("url", "/mgr/member/list.do");
			}else {
				resultMap.put("url", "/main.do");
			}
		}else {
			Member idCheck = memberMapper.memberCheck(map);
			if(idCheck != null) {
				//로그인 실패시 cnt 1 증가 
				
				if(idCheck.getCnt() >= 5 ) {
					message="비밀번호를 5회이상 잘못입력하셧습니다.";
				}else {
					memberMapper.cntIncrease(map);
					message = "패스워드를 확인해주세요.";					
				}
				
			}else {
				message ="아이디가 존재하지않습니다.";
			}
			result="fail";
			
		}
*/
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
		String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
		map.put("pwd", hashPwd);
		
		int member = memberMapper.addmember(map);
		
		
		if(member < 1 ) {

			resultMap.put("result", "success");
		
			
		}else {
			resultMap.put("result", "fail");
			
		}
		
		return resultMap;
	}
	
	public void addMemberImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = memberMapper.insertUserImg(map);
	}
	public HashMap<String, Object> memberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		try {
			List<Member> memberList= memberMapper.memberList(map);
			resultMap.put("list", memberList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public  HashMap<String, Object> memberCntInit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		try {
			int cnt = memberMapper.cntInit(map);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public  HashMap<String, Object> getMemberCheckList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		try {
			Member member= memberMapper.selectMemberCheck(map);
			if(member != null) {
				resultMap.put("list", member);
				resultMap.put("result", "success");			
			}else {				
				resultMap.put("result", "fail");
			}
				
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public  HashMap<String, Object> updatePwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String , Object> resultMap = new HashMap<String , Object>();
		
		try {
			
			Member member = memberMapper.memberCheck(map);
			
			if(passwordEncoder.matches((String) map.get("pwd"), member.getPassword())) {
				resultMap.put("result", "fail");
				resultMap.put("msg", "비밀번호가 이전과 동일합니다.");
				
			}else {
				String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
				map.put("pwd", hashPwd);
				int pwd = memberMapper.updatePwd(map);
				resultMap.put("result", "success");
				resultMap.put("msg", "수정되었습니다");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
}



