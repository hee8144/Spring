package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.StuController;
import com.example.test1.mapper.StudentMapper;
import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Student;
import com.example.test1.model.User;

@Service
public class StudentService {


	
	@Autowired
	StudentMapper StudentMapper;

	
	
	public HashMap<String, Object> stuInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service =>" + map);
		Student student = StudentMapper.stuInfo(map);
		if(student !=null) {
			System.out.println(student.getStuNo());
			System.out.println(student.getStuName());
			System.out.println(student.getStuDept());
		}
		resultMap.put("info", student);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getStuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Student> list = StudentMapper.stuList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
}
