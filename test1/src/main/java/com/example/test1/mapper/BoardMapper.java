package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.Student;

@Mapper
public interface BoardMapper {
	//게시글 삭제
	int removeBoard(HashMap<String, Object> map);
	
	//게시글 리스트 삭제
	
	int removeBoardList(HashMap<String, Object> map);
	// 게시글 목록
	List<Board> boardList(HashMap<String, Object> map);
	
	//게시글 전체 개수
	
	int boardCnt(HashMap<String, Object> map);
	// 게시글 등록
	int insertBoard(HashMap<String, Object> map);
	
	Board boardInfo(HashMap<String, Object> map);
	
	//조회수 증가
	
	int updateCnt(HashMap<String, Object> map);
	
	//댓글 목록
	
	List<Comment> selectCommentList(HashMap<String, Object> map);
	
	//댓글 삭제
	int removeComment(HashMap<String, Object> map);
	
	//댓글 작성
	
	int insertComment(HashMap<String, Object> map);
	//첨부파일 업로드
	int insertBoardImg(HashMap<String, Object> map);
	
	//첨부파일 목록
	List<Board> selectFileList(HashMap<String, Object> map);
	
}
