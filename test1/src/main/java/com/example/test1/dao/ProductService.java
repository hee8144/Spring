package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {
	
	@Autowired
	ProductMapper ProductMapper;

	public  HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Product> list = ProductMapper.selectProductList(map);
			List<Menu> menuList = ProductMapper.selectMenuList(map);
			
			resultMap.put("list", list);
			resultMap.put("menuList", menuList);
		
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());	
		}
		
		return resultMap;
	}

	public  HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Menu> menuList = ProductMapper.selectAddMenuList(map);
		
			resultMap.put("menuList", menuList);
		
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());	
		}
		
		return resultMap;
	}
	
}
