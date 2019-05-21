package com.tour.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.bulletin.repository.BulletinBoardDAO;
import com.tour.model.domain.QnABoard;
import com.tour.model.gallery.domain.Gallery;
import com.tour.model.gallery.repository.GalleryDAO;
import com.tour.model.repository.QnABoardDAO;
import com.tour.model.review.domain.Review;
import com.tour.model.review.repository.ReviewDAO;

/*
 * 마이페이지 내가 작성한 게시글 가져오기 관련 각 게시판 DAO 를 통해 모두 가져옴 (박현호 : 190503)
 */
@Service
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired
	private QnABoardDAO qnaBoardDAO;					// 고객센터 게시판 게시글 가져오기
	@Autowired	
	private BulletinBoardDAO bulletinBoardDAO;		// 자유게시판 게시글 가져오기
	@Autowired
	private GalleryDAO galleryDAO; //갤러리 게시글 가져오기
	@Autowired
	private ReviewDAO reviewDAO; //리뷰 게시글 가져오기
	
	// ***아래 다음 게시판 항목의 DAO 를 추가 하세요
	//==============================
	// 여행 후기 게시판 게시글 가져오기
	// 갤러리 게시판 게시글 가져오기
	//==============================

	@Override
	public List selectAll(int member_id) {
		List myBoards = new ArrayList();
		
		List<QnABoard> qnaBoardList = qnaBoardDAO.getMyQnaBoards(member_id);
		List<BulletinBoard> bulletinBoardList = bulletinBoardDAO.getMyBulletinBoards(member_id);
		List<Gallery> galleryList=galleryDAO.getMyGallery(member_id);
		List<Review> reviewList=reviewDAO.getMyReview(member_id);
		
		// ***아래 다음 게시판 항목의 DAO 작업을 수행하세요
		//==============================
		// 여행 후기 게시판 게시글 가져오기
		// 갤러리 게시판 게시글 가져오기
		//==============================
		
		
		myBoards.add(qnaBoardList);
		myBoards.add(bulletinBoardList);
		myBoards.add(galleryList);
		myBoards.add(reviewList);
		
		return myBoards;
	}

}
