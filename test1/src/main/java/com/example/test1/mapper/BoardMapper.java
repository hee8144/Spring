package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Student;

@Mapper
public interface BoardMapper {
	//Board board(HashMap<String, Object> map);
	List<Board> boardList(HashMap<String, Object> map);
}
