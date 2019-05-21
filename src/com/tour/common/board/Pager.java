package com.tour.common.board;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
@Component
public class Pager {
	private int currentPage=1;																	// 현재 Page
	private int totalRecord;																		// 총 Record 수
	private int pageSize=10;																		// Page 당 보여질 Record 수
	private int totalPage;																			// 총 Page 수
	private int blockSize=10;
	private int firstPage;																			// PageBlock 에서 첫 페이지
	private int lastPage;																			// PageBlock 에서 마지막 페이지
	private int curPos;
	private int num;
	
	// 호출시 마다, Paging 처리 변수들의 계산을 한다.
	public void init(HttpServletRequest request, int totalRecord) {
		// 사용자가 Page 번호를 누르면 그 누른 번호의 값으로 대체!!!
		// 사용자가 Page 번호를 눌렀을 경우 get 방식으로 Data 가 넘어오기 때문에 request 를 갖는다.
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		this.totalRecord = totalRecord;
		totalPage = (int)Math.ceil((float)totalRecord/pageSize);		
		firstPage=currentPage-(currentPage-1)%blockSize;
		lastPage=firstPage+(blockSize-1);
		curPos = (currentPage-1)*pageSize;
		num = totalRecord-curPos;
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
