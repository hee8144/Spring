package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;
import com.example.test1.model.User;

@Mapper
public interface StudentMapper {
	
	Student stuInfo(HashMap<String, Object> map);
	
	
}
