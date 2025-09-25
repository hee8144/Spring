package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;


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
	//public HashMap<String, Object> removeBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
	//	Board board = BoardMapper.board(map);
		
	//	resultMap.remove("list", board);
	//	return resultMap;
	//}
}
