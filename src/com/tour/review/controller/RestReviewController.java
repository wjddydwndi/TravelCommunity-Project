package com.tour.review.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tour.common.board.ReviewPager;
import com.tour.exception.DeleteFailException;
import com.tour.exception.RegistFailException;
import com.tour.model.review.domain.Good;
import com.tour.model.review.domain.Review;
import com.tour.model.review.domain.Review_comment;
import com.tour.model.review.service.GoodService;
import com.tour.model.review.service.ReviewService;
import com.tour.model.review.service.Review_commentService;

@RestController
public class RestReviewController {
	
	@Autowired
	private Review_commentService review_commentService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private GoodService goodService;
	

/////////////////////////////////////main화면 조회/////////////////////////////////////	
	//좋아요 순으로 게시글 가져오기(5건)
	
	@RequestMapping(value="/reviews/good", method=RequestMethod.GET)
	public JSONObject selectByGood() {
		System.out.println("좋아요로 게시 글 가져오기 컨트롤러 동작");
		JSONObject jsonObject = new JSONObject();
		List reviewList = reviewService.selectByGood();
		jsonObject.put("reviewList", reviewList);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}
	 
	
	
/////////////////////////////////////review 관련/////////////////////////////////////
	//좋아요 insert
	@RequestMapping(value="/review/good", method=RequestMethod.POST)
	public JSONObject goodInsert(Good good) {
		System.out.println("좋아요를 누른 member_id : "+good.getMember().getMember_id());
		System.out.println("좋아요를 누른 review_id : "+good.getReview().getReview_id());
		JSONObject jsonObject = new JSONObject();
		goodService.insert(good);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}
	
	//해당 게시물의 좋아요 가져오기
	@RequestMapping(value="/review/good/{review_id}", method = RequestMethod.GET)
	public List goodselect(@PathVariable("review_id") int review_id) {
		System.out.println(review_id+"번 글의 좋아요수 전체 가져오기");
		List<Good> list = goodService.selectByReviewId(review_id);
		return list;
	}
	
	//해당 게시물의 해당 유저의 좋아요 삭제시키기
	@RequestMapping(value="/review/good/{good_id}", method = RequestMethod.DELETE)
	public JSONObject goodDelete(@PathVariable("good_id") int good_id) {
		System.out.println(good_id+"좋아요 삭제하기");
		JSONObject jsonObject = new JSONObject();
		goodService.delete(good_id);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}

///////////////////////////////////review_comment관련////////////////////////////
	//댓글 등록
	@RequestMapping(value="/review_comments", method=RequestMethod.POST)
	public JSONObject insert(Review_comment review_comment) {
		System.out.println("댓글등록을 한 review id : "+review_comment.getReview().getReview_id());
		JSONObject jsonObject = new JSONObject();
		review_commentService.insert(review_comment);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}
	
	//이 글의 댓글 목록 전체가져오기
	@RequestMapping(value="/review_comments/{review_id}", method = RequestMethod.GET)
	public JSONObject commentSelectAll(@PathVariable("review_id") int review_id, HttpServletRequest request) {
		System.out.println("댓글을 요청한 글 review_id : "+review_id);
		JSONObject jsonObject = new JSONObject();
		ReviewPager pager = new ReviewPager();
		List<Review_comment> review_commentList = review_commentService.selectByReviewId(review_id);
		pager.init(request, review_commentList, 10, 10);
		jsonObject.put("review_commentList", review_commentList);
		jsonObject.put("pager", pager);
		return jsonObject;
	}
	
	
	//댓글 한 건 가져오기
	@RequestMapping(value="/review_comment/{review_comment_id}", method=RequestMethod.GET)
	public JSONObject commentSelect(@PathVariable("review_comment_id") int review_comment_id) {
		System.out.println("댓글 한 건 가져오기 위한 id : "+review_comment_id);
		JSONObject jsonObject = new JSONObject();
		Review_comment review_comment = review_commentService.select(review_comment_id);
		jsonObject.put("review_comment_id", review_comment.getReview_comment_id());
		jsonObject.put("member_id", review_comment.getMember().getMember_id());
		jsonObject.put("review_comment_content", review_comment.getReview_comment_content());
		jsonObject.put("review_id", review_comment.getReview().getReview_id());
		jsonObject.put("review_comment_regdate", review_comment.getReview_comment_regdate());
		return jsonObject;
	}
	
	//댓글 삭제
	@RequestMapping(value="/review_comments/{review_comment_id}", method=RequestMethod.DELETE)
	public JSONObject commentDelete(@PathVariable("review_comment_id") int review_comment_id) {
		System.out.println("댓글을 삭제하기 위해 넘겨 받은 id : "+review_comment_id);
		JSONObject jsonObject = new JSONObject();
		review_commentService.delete(review_comment_id);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}
	
	//댓글 수정
	@RequestMapping(value="/review_comments", method=RequestMethod.PUT)
	public JSONObject commentEdit(Review_comment review_comment) {
		System.out.println("댓글 수정하기 위해 넘겨받은 코멘트 id : "+review_comment.getReview_comment_id());
		System.out.println("댓글 수정하기 위해 넘겨받은 코멘트 id : "+review_comment.getReview_comment_content());
		JSONObject jsonObject = new JSONObject();
		review_commentService.update(review_comment);
		jsonObject.put("resultCode", 1);
		return jsonObject;
	}
	
	///////////////////////////////////review관련////////////////////////////
	

	
	
	///////////////////////CRUD 실패 처리////////////////////////////
	
	//등록 실패
	@ExceptionHandler(RegistFailException.class)
	public JSONObject registFail(RegistFailException e) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultCode", e.getMessage());
		return jsonObject;
	}
	
	//삭제 실패
	@ExceptionHandler(DeleteFailException.class)
	public JSONObject deleteFail(DeleteFailException e) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultCode", e.getMessage());
		return jsonObject;
	}
	
}


