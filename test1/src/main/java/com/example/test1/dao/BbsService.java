package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;


@Service
public class BbsService {

	@Autowired
	BbsMapper BbsMapper;
	
	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		List<Bbs> list = BbsMapper.boardList(map);
		int cnt =BbsMapper.countBbs(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = BbsMapper.insertBbs(map); 
		System.out.println(map);
		resultMap.put("bbsNo", map.get("bbsNo"));
		resultMap.put("result", "success");
		
		return resultMap;
	}
	public HashMap<String, Object> removeBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		int cnt = BbsMapper.deleteBbs(map); 

		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> getBbsInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		Bbs info = BbsMapper.bbsInfo(map);

		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> updateInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		int cnt= BbsMapper.updateBbs(map);

		resultMap.put("result", "success");
		
		return resultMap;
	}

	public HashMap<String, Object> addImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		int cnt= BbsMapper.insertBbsImg(map);

		resultMap.put("result", "success");
		
		return resultMap;
	}

	
}
