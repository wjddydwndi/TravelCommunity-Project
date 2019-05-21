package com.tour.common.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

@Component
public class SequrityBean {

	public String textToHash(String pass) {
		StringBuilder sb = new StringBuilder();
		
		
		try {
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//해시화 시킬 데이터를 바이트화.
			md.update(pass.getBytes());
			
			//암호화된 바이트를 반환 받음.
			byte[] data = md.digest();
			
			for(int i = 0; i<data.length; i++) {
				sb.append(Integer.toString((data[i]&0xff)+0x100,16).substring(1));
			}
			
			System.out.println("SequrityPass/암호화된 Pass의 길이는?="+sb.toString().length());
			System.out.println("SequrityPass/암호화된 Pass="+sb.toString());
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return sb.toString();
	}
}
