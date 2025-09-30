package com.example.test1.model;

import lombok.Data;

@Data
public class Student {
	private String stuNo;
	private String stuName;
	private String stuDept;
	private String stuGrade;
	private String stuGender;
	private String AVGGRADE;
	private String TOTALAVG;
	public String getStuNo() {
		return stuNo;
	}
	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getStuDept() {
		return stuDept;
	}
	public void setStuDept(String stuDept) {
		this.stuDept = stuDept;
	}
	public String getStuGrade() {
		return stuGrade;
	}
	public void setStuGrade(String stuGrade) {
		this.stuGrade = stuGrade;
	}
	public String getStuGender() {
		return stuGender;
	}
	public void setStuGender(String stuGender) {
		this.stuGender = stuGender;
	}
	public String getAVGGRADE() {
		return AVGGRADE;
	}
	public void setAVGGRADE(String aVGGRADE) {
		AVGGRADE = aVGGRADE;
	}
	
	public String TOTALAVG() {
		return TOTALAVG;
	}
	public void TOTALAVG(String TOTALAVG) {
		AVGGRADE = TOTALAVG;
	}
	
	
}
