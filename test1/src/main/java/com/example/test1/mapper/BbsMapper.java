package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;


@Mapper
public interface BbsMapper {
	//리스트
	List<Bbs> boardList(HashMap<String, Object> map);
	
	int countBbs(HashMap<String, Object> map);
	
	//상세정보
	Bbs bbsInfo(HashMap<String, Object> map);
	//추가
	int insertBbs(HashMap<String, Object> map);
	//삭제
	int deleteBbs(HashMap<String, Object> map);
	//수정
	int updateBbs(HashMap<String, Object> map);
	//이미지 
	int insertBbsImg(HashMap<String, Object> map);
	
	
}
