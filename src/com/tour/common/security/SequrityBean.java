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
			
			//�ؽ�ȭ ��ų �����͸� ����Ʈȭ.
			md.update(pass.getBytes());
			
			//��ȣȭ�� ����Ʈ�� ��ȯ ����.
			byte[] data = md.digest();
			
			for(int i = 0; i<data.length; i++) {
				sb.append(Integer.toString((data[i]&0xff)+0x100,16).substring(1));
			}
			
			System.out.println("SequrityPass/��ȣȭ�� Pass�� ���̴�?="+sb.toString().length());
			System.out.println("SequrityPass/��ȣȭ�� Pass="+sb.toString());
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return sb.toString();
	}
}
