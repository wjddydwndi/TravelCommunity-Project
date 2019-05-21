package com.tour.common.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

public class ReviewPager {
	private int currentPage; // 현재 페이지
	private int totalRecord; // 총 게시물 수(분할할 대상이 있어야함, 초기값은 알 수가없음)
	private int pageSize; // 페이지당 보여질 레코드 수
	private int totalPage; // 총 페이지 수
	private int blockSize;
	private int firstPage;
	private int lastPage;
	private int curPos;
	private int num;

	public void init(HttpServletRequest request, List list, int pageSize, int blockSize) {
		currentPage = 1;
		if(request.getParameter("currentPage")!= null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		totalRecord = list.size();
		this.pageSize = pageSize;
		totalPage = (int)Math.ceil((float)totalRecord/pageSize);
		this.blockSize = blockSize;
		firstPage = currentPage - (currentPage - 1)%blockSize;
		lastPage = firstPage + (blockSize-1);
		curPos = (currentPage-1)*pageSize;
		num = totalRecord - curPos;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurPos() {
		return curPos;
	}

	public void setCurPos(int curPos) {
		this.curPos = curPos;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

}
