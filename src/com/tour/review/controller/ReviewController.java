package com.tour.review.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tour.common.board.Pager;
import com.tour.common.board.ReviewPager;
import com.tour.common.file.FileManager;
import com.tour.model.review.domain.Image;
import com.tour.model.review.domain.Path;
import com.tour.model.review.domain.Review;
import com.tour.model.review.domain.Review_comment;
import com.tour.model.review.service.ReviewService;
import com.tour.model.review.service.Review_commentService;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private Review_commentService review_commentService;
	
	@Autowired
	private FileManager fileManager;
	
	//review 상세 페이지 요청
	@RequestMapping(value="/review/detail", method=RequestMethod.GET)
	public ModelAndView reviewSelect(@RequestParam("review_id") int review_id, HttpServletRequest request) {
		System.out.println("상세페이지 요청위해 넘어온 값 : "+review_id);
		ReviewPager pager = new ReviewPager();
		Review review = reviewService.select(review_id);
		List<Review_comment> review_commentList = review_commentService.selectByReviewId(review_id);
		pager.init(request, review_commentList, 10, 10);
		System.out.println("review_commentList : "+review_commentList.size());
		reviewService.updateHit(review_id);
		System.out.println("상세페이지로 요청하려는 제목 : "+review.getReview_title());
		ModelAndView mav = new ModelAndView();
		mav.addObject("pager", pager);
		mav.addObject("review_commentList", review_commentList);
		mav.addObject("review", review);
		mav.setViewName("chimper/chimper/review/detail");
		return mav;
	}
	
	//review 수정 페이지 요청
	@RequestMapping(value="/review/edit", method=RequestMethod.GET)
	public ModelAndView reviewEdit(@RequestParam("review_id") int review_id) {
		System.out.println("수정페이지 요청위해 넘어온 값 : "+review_id);
		Review review = reviewService.select(review_id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("review", review);
		mav.setViewName("chimper/chimper/review/edit");
		return mav;
	}
	
	//review update
	@RequestMapping(value="/review/update", method=RequestMethod.POST)
	public ModelAndView reviewEdit(Review review, Image image, Path path,HttpServletRequest request) {
		System.out.println("글수정 요청 컨트롤러 접근");
		System.out.println("컨트롤러// 리뷰 아이디 : "+review.getReview_id());
		System.out.println("컨트롤러// 이미지 아이디 : "+image.getImage_id());
		ModelAndView mav = new ModelAndView();
		String filePath = request.getServletContext().getRealPath("/chimper/chimper/uploadFile/");
		reviewService.update(review, image, path, filePath);
		mav.setViewName("redirect:/review/list");
		return mav;
	}
	
	//review insert
	@RequestMapping(value="/review/write",method=RequestMethod.POST)
	public ModelAndView insert(Review review, Image image, Path path,HttpServletRequest request) {
		System.out.println("insert 컨트롤러 접근//path : "+path);
		System.out.println("insert 컨트롤러 접근//path.getPath_name() : "+path.getPath_name());
		System.out.println("insert 컨트롤러 접근//path.getSelectedPath() : "+path.getSelectedPath());
		//Member member=(Member)request.getSession().getAttribute("member");
		ModelAndView mav=new ModelAndView();
		String filePath = request.getServletContext().getRealPath("/chimper/chimper/uploadFile/");
		reviewService.insert(review,image,path,filePath);
		mav.setViewName("redirect:/review/list");
		return mav;
	}
	//review list
	@RequestMapping(value="/review/list",method=RequestMethod.GET)
	public ModelAndView selectAll(HttpServletRequest request) {
		System.out.println("목록 페이지 접근");
		List<Integer> commentCountArray = new ArrayList<Integer>();
		ReviewPager pager = new ReviewPager();
		List<Review> reviewList=reviewService.selectAll();
		for(int i=0; i<reviewList.size(); i++) {
			int review_id = reviewList.get(i).getReview_id();
			List<Review_comment> review_comment = review_commentService.selectByReviewId(review_id);
			int commentCount = review_comment.size();
			commentCountArray.add(commentCount);
		}
		pager.init(request, reviewList, 10, 10);
		ModelAndView mav=new ModelAndView();			
		mav.setViewName("chimper/chimper/review/index");
		mav.addObject("pager", pager);
		mav.addObject("reviewList", reviewList);
		mav.addObject("commentCountArray", commentCountArray);
		return mav;
	}
	
	//review delete
	@RequestMapping(value="/review/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("review_id") int review_id, HttpServletRequest request) {
		System.out.println(review_id+"번 게시글 삭제 컨트롤러 접근");
		String path = request.getServletContext().getRealPath("/chimper/chimper/uploadFile/");
		reviewService.delete(review_id, path);
		return "redirect:/review/list";
	}
}
