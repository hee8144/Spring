package com.example.test1.controller;

import java.util.Random;

public class test {
	public static void main(String[] args) {
		//랜덤한 숫자 6자리(0~9)
		//random(10)
		Random ran = new Random();
		String num="";
		for(int i =0; i<6;i++) {
			num+=ran.nextInt(10);
		}
		System.out.println(num);
	}
}
