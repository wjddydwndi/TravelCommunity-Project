package com.tour.model.bulletin.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.tour.model.bulletin.domain.BulletinMember;



public interface BulletinMemberService {
	public List selectAll();
	public BulletinMember select(int member_id);
	public void insert(BulletinMember member);
	public int update(BulletinMember member);
	public void delete(int member_id);
	public BulletinMember loginCheck(BulletinMember member);
	public List selectAllAdmin();
	public BulletinMember check(BulletinMember member,int passKey);
	public String getID(BulletinMember member);
	public int resetPass(BulletinMember member);
}
