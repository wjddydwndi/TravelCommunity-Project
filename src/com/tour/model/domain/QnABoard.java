package com.tour.model.domain;


// DB 의 QnABoard Table 과 대응되는 DTO
public class QnABoard {
	private int qnaBoard_id;
	private int member_id;
	private String qnaBoard_title;
	private String qnaBoard_writer;
	private String qnaBoard_content;
	private String qnaBoard_regdate;
	private int qnaBoard_hit;
	private String answerState;
	private String qnaBoard_type_id;
	private String qnaBoard_privacy_id;
	
	
	
	public int getQnaBoard_id() {
		return qnaBoard_id;
	}
	public void setQnaBoard_id(int qnaBoard_id) {
		this.qnaBoard_id = qnaBoard_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getQnaBoard_title() {
		return qnaBoard_title;
	}
	public void setQnaBoard_title(String qnaBoard_title) {
		this.qnaBoard_title = qnaBoard_title;
	}
	public String getQnaBoard_writer() {
		return qnaBoard_writer;
	}
	public void setQnaBoard_writer(String qnaBoard_writer) {
		this.qnaBoard_writer = qnaBoard_writer;
	}
	public String getQnaBoard_content() {
		return qnaBoard_content;
	}
	public void setQnaBoard_content(String qnaBoard_content) {
		this.qnaBoard_content = qnaBoard_content;
	}
	public String getQnaBoard_regdate() {
		return qnaBoard_regdate;
	}
	public void setQnaBoard_regdate(String qnaBoard_regdate) {
		this.qnaBoard_regdate = qnaBoard_regdate;
	}
	public int getQnaBoard_hit() {
		return qnaBoard_hit;
	}
	public void setQnaBoard_hit(int qnaBoard_hit) {
		this.qnaBoard_hit = qnaBoard_hit;
	}
	public String getAnswerState() {
		return answerState;
	}
	public void setAnswerState(String answerState) {
		this.answerState = answerState;
	}
	public String getQnaBoard_type_id() {
		return qnaBoard_type_id;
	}
	public void setQnaBoard_type_id(String qnaBoard_type_id) {
		this.qnaBoard_type_id = qnaBoard_type_id;
	}
	public String getQnaBoard_privacy_id() {
		return qnaBoard_privacy_id;
	}
	public void setQnaBoard_privacy_id(String qnaBoard_privacy_id) {
		this.qnaBoard_privacy_id = qnaBoard_privacy_id;
	}
	
	
	
	

}
