package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.BoardController;
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
		int cnt = BoardMapper.boardCnt(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
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
	
	public HashMap<String, Object> deleteBoardList(HashMap<String, Object> map) {
		 //TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = BoardMapper.removeBoardList(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> insertBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int board = BoardMapper.insertBoard(map);
		System.out.println(map);
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getBoardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		BoardMapper.updateCnt(map);
		Board user = BoardMapper.boardInfo(map);
		List<Comment> CommentList = BoardMapper.selectCommentList(map);
		List<Board> fileList = BoardMapper.selectFileList(map);
		
		resultMap.put("fileList", fileList);
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
	
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		 //TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = BoardMapper.insertComment(map);
			resultMap.put("result", "success");
			resultMap.put("msg", "댓글이 등록되었습니다");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.print(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("msg", "서버 오류가 발생했습니다. 다시 시도해주세요");
		}

		return resultMap;
	}
	
	public HashMap<String, Object> updateCnt(HashMap<String, Object> map) {
		 //TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = BoardMapper.updateCnt(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	public void addBoardImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		int cnt = BoardMapper.insertBoardImg(map);
	}
}


