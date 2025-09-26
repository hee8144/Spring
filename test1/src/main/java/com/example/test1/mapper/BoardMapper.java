package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Student;

@Mapper
public interface BoardMapper {
	//게시글 삭제
	int removeBoard(HashMap<String, Object> map);
	// 게시글 목록
	List<Board> boardList(HashMap<String, Object> map);
	// 게시글 등록
	int insertBoard(HashMap<String, Object> map);
	
	Board boardInfo(HashMap<String, Object> map);
}
