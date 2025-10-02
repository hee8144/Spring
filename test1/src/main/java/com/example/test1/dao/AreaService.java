package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;
import com.example.test1.model.Area;



@Service
public class AreaService {

	
	@Autowired
	AreaMapper AreaMapper;
	
	public HashMap<String, Object> getAreaList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> list = AreaMapper.areaList(map);
		int cnt = AreaMapper.areaCount(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> list = AreaMapper.selectSiList(map);
		
		
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getGuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> Gulist = AreaMapper.selectGuList(map);
		
		resultMap.put("Gu", Gulist);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getDongList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> Donglist = AreaMapper.selectDongList(map);
		
		resultMap.put("Dong", Donglist);
		resultMap.put("result", "success");
		return resultMap;
	}
}
