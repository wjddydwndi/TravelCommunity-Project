package com.tour.model.domain;


// DB 의 Answer Table 과 대응되는 DTO
public class Answer {
	private int answer_id;
	private int qnaBoard_id;
	private String answer_content;
	private String answer_regdate;
	private String answer_writer;
	
	public int getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(int answer_id) {
		this.answer_id = answer_id;
	}
	public int getQnaBoard_id() {
		return qnaBoard_id;
	}
	public void setQnaBoard_id(int qnaBoard_id) {
		this.qnaBoard_id = qnaBoard_id;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public String getAnswer_regdate() {
		return answer_regdate;
	}
	public void setAnswer_regdate(String answer_regdate) {
		this.answer_regdate = answer_regdate;
	}
	public String getAnswer_writer() {
		return answer_writer;
	}
	public void setAnswer_writer(String answer_writer) {
		this.answer_writer = answer_writer;
	}	
}
