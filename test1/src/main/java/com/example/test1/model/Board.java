package com.example.test1.model;

import lombok.Data;

@Data
public class Board {
	private String boardNo;
	private String title;
	private String userId;
	private String kind;
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserid() {
		return userId;
	}
	public void setUserid(String userid) {
		this.userId = userid;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	
}
