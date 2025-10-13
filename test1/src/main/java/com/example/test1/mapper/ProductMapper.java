package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	//음식 리스트
	List<Product> selectProductList(HashMap<String, Object> map);
	
	//메뉴 목록
	
	List<Menu> selectMenuList(HashMap<String, Object> map);
	
	//select 메뉴 목록
	List<Menu> selectAddMenuList(HashMap<String, Object> map);
}
