package com.tour.model.bulletin.domain;

public class BulletinMember {
	private int member_id;
	private String id;
	private String pass;
	private String member_name;
	private String email;
	private MemberLevel memberLevel;
	private int member_level_id;
	
	
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public MemberLevel getMemberLevel() {
		return memberLevel;
	}
	public void setMemberLevel(MemberLevel memberLevel) {
		this.memberLevel = memberLevel;
	}
	public int getMember_level_id() {
		return member_level_id;
	}
	public void setMember_level_id(int member_level_id) {
		this.member_level_id = member_level_id;
	}
	
	
	
	
	

	
}
