package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {
	
	//리스트 
	List<Area> areaList(HashMap<String, Object> map);
	
	//리스트 개수
	int areaCount(HashMap<String, Object> map);
	
	//시/도 리시트
	
	List<Area> selectSiList(HashMap<String, Object> map);
}
