package com.tour.model.bulletin.repository;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinMember;

public interface BulletinMemberDAO {
	public List selectAll();
	public BulletinMember select(int member_id);
	public int insert(BulletinMember member);
	public int update(BulletinMember member);
	public int delete(int member_id);
	public BulletinMember loginCheck(BulletinMember member);
	public List selectAllAdmin();
	public List selectMember(String searchText);
	public BulletinMember checkId(BulletinMember member);
	public BulletinMember checkEmail(BulletinMember member);
	public String getID(BulletinMember member);
	public int resetPass(BulletinMember member);
}
