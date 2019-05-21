package com.tour.gallery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.tour.exception.DeleteFailException;
import com.tour.exception.RegistFailException;
import com.tour.exception.SelectFailException;
import com.tour.model.bulletin.domain.BulletinMember;
import com.tour.model.gallery.domain.Gallery;
import com.tour.model.gallery.domain.Gallery_comment;
import com.tour.model.gallery.domain.Gallery_image;
import com.tour.model.gallery.service.GalleryService;

@RestController
public class RestGalleryController {
	@Autowired
	private GalleryService galleryService;

	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public String insertComment(Gallery_comment gallery_comment, Gallery gallery, HttpServletRequest request) {
		BulletinMember member = (BulletinMember) request.getSession().getAttribute("member");

		gallery_comment.setMember(member);
		gallery_comment.setGallery(gallery);

		galleryService.insertConmments(gallery_comment);

		return "1";
	}

	@RequestMapping(value = "/comment/{gallery_id}", method = RequestMethod.GET)
	public List selectAllcomment(@PathVariable("gallery_id")int gallery_id) {
		System.out.println("gallery_comment selectAll/ gallery_id=" + gallery_id);
		
		List commentList=galleryService.selectComments(gallery_id);
		
		System.out.println("DB___통과----------selectAllcomment");
		
		return commentList;
	}
	
	@RequestMapping(value = "/comment", method = RequestMethod.PUT)
	public int updateComment(Gallery_comment gallery_comment) {
		System.out.println("Controller / updateComment/  넘어온 파라미터 "+ gallery_comment);
		System.out.println("Controller / updateComment /변경할 댓글 내용 넘어온 파라미터는? "+gallery_comment.getContent()+"/comment_id="+gallery_comment.getComment_id());
		galleryService.updateComment(gallery_comment);
		System.out.println("Controller / Service통과");
		return 1;
	}

	@RequestMapping(value = "/comment/{comment_id}", method = RequestMethod.DELETE)
	public int deleteComment(@PathVariable("comment_id") int comment_id) {
		System.out.println("DeleteComment");
		galleryService.deleteComment(comment_id);
		System.out.println("DeleteComment / DB통과");
		return 1;
	}

	
	
	
	//////////////////   Exception  /////////////////////
	
	@ExceptionHandler(RegistFailException.class)
	public ModelAndView registFailException(RegistFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);

		return mav;
	}
	
	@ExceptionHandler(SelectFailException.class)
	public ModelAndView selectFailException(SelectFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);
		return mav;
	}

	@ExceptionHandler(SelectFailException.class)
	public ModelAndView deleteFailException(DeleteFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);
		return mav;
	}
	

	

}
