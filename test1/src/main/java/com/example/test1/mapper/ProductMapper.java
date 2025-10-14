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
	
	//음식 추가
	
	int addFood(HashMap<String, Object> map);
	
	//음식 이미지 추가
	
	int insertFoodImg(HashMap<String, Object> map);
	
	//제품 상세정보
	
	Product selectProduct(HashMap<String, Object> map);
	
	//제품 이미지 
	
	List<Product> selectProductImg(HashMap<String, Object> map);
}
