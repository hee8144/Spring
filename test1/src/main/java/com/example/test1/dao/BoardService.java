package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;


@Service
public class BoardService {


	
	@Autowired
	BoardMapper BoardMapper;

	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Board> list = BoardMapper.boardList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	public HashMap<String, Object> removeBoardList(HashMap<String, Object> map) {
		 //TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = BoardMapper.removeBoard(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> insertBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int board = BoardMapper.insertBoard(map);
		
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getBoardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Board user = BoardMapper.boardInfo(map);
		List<Comment> CommentList = BoardMapper.selectCommentList(map);
		resultMap.put("info", user);
		resultMap.put("commentList", CommentList);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> removeComment(HashMap<String, Object> map) {
		 //TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = BoardMapper.removeComment(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
}
