package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	//로그인
	Member memberLogin(HashMap<String , Object> map);
	//중복체크
	Member memberCheck(HashMap<String , Object> map);
	//회원가입
	int addmember(HashMap<String , Object> map);
	//유저사진
	List<Member> insertUserImg(HashMap<String , Object> map); 
}
