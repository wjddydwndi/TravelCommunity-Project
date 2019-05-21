package com.tour.bulletin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.management.AttributeValueExp;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tour.common.board.Pager;
import com.tour.exception.DeleteFailException;
import com.tour.exception.EditFailException;
import com.tour.exception.RegistFailException;
import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.bulletin.domain.BulletinComment;

import com.tour.model.bulletin.domain.Head;
import com.tour.model.bulletin.domain.BulletinMember;

import com.tour.model.bulletin.service.BulletinBoardService;
import com.tour.model.bulletin.service.BulletinCommentService;

@Controller
public class BulletinBoardController {
	@Autowired
	@Qualifier("bulletinBoardServiceImpl")
	private BulletinBoardService bulletinBoardService;

	@Autowired
	@Qualifier("bulletinCommentServiceImpl")
	private BulletinCommentService bulletinCommentService;

	@RequestMapping(value = "/board/list", method = RequestMethod.GET)
	public ModelAndView boardSelectAll(HttpServletRequest request) {

		List<BulletinBoard> bulletinBoardList = bulletinBoardService.selectAll();

		ModelAndView mav = new ModelAndView("chimper/chimper/bulletin/list");
		mav.addObject("bulletinBoardList", bulletinBoardList);
		//System.out.println("¢¬n¡¤I ¨¡aAIAo A¡Ë¡¾U");
		List<Integer> commentCountArray = new ArrayList<Integer>();
		Pager pager = new Pager();
		pager.init(request, bulletinBoardList.size());
		for(int i=0; i<bulletinBoardList.size(); i++) {
			int bulletin_board_id = bulletinBoardList.get(i).getBulletin_board_id();
			List<BulletinComment> bulletinComment = bulletinCommentService.selectByBoard(bulletin_board_id);
			int commentCount = bulletinComment.size();
			commentCountArray.add(commentCount);
		}
		mav.addObject("pager", pager);
		mav.addObject("commentCountArray", commentCountArray);

		return mav;
	}

	@RequestMapping(value = "/board/detail", method = RequestMethod.GET)
	public ModelAndView boardSelect(@RequestParam("bulletin_board_id") int bulletin_board_id) {
		BulletinBoard bulletinBoard = bulletinBoardService.select(bulletin_board_id);

		ModelAndView mav = new ModelAndView("chimper/chimper/bulletin/detail");
		mav.addObject("bulletinBoard", bulletinBoard);
		return mav;
	}

	@RequestMapping(value = "/board/edit", method = RequestMethod.GET)
	public ModelAndView boardEdit(@RequestParam("bulletin_board_id") int bulletin_board_id) {
		System.out.println(123);
		BulletinBoard bulletinBoard = bulletinBoardService.select(bulletin_board_id);
		ModelAndView mav = new ModelAndView("chimper/chimper/bulletin/edit");
		mav.addObject("bulletinBoard", bulletinBoard);
		return mav;
	}

	@RequestMapping(value = "/board/regist", method = RequestMethod.POST)
	public ModelAndView boardInsert(BulletinBoard bulletinBoard) {
		System.out.println(bulletinBoard.getHead().getName());
		bulletinBoardService.insert(bulletinBoard);

		ModelAndView mav = new ModelAndView("redirect:/board/list");
		return mav;
	}

	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public ModelAndView boardDelete(int bulletin_board_id) {
		bulletinBoardService.delete(bulletin_board_id);
		ModelAndView mav = new ModelAndView("redirect:/board/list");
		return mav;
	}

	@RequestMapping(value = "/board/update", method = RequestMethod.POST)
	public ModelAndView boardUpdate(BulletinBoard bulletinBoard) {

		bulletinBoardService.update(bulletinBoard);
		ModelAndView mav = new ModelAndView("redirect:/board/list");
		return mav;
	}
	// -----------------------------------------boardImage--------------------------------------------------------

	// -----------------------------------------boardComment-----------------------------------------------------

	@RequestMapping(value = "/bulletinComments", method = RequestMethod.GET)
	@ResponseBody
	public List commentSelectAll() {
		List<BulletinComment> list = bulletinCommentService.selectAll();
		// System.out.println(list.get(0).getBulletin_comment_id());
		return list;
	}

	@RequestMapping(value = "/bulletinComments/{bulletin_board_id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject commentSelectAllByBoardId(@PathVariable("bulletin_board_id") int bulletin_board_id, HttpServletRequest request) {
		List<BulletinComment> list = bulletinCommentService.selectByBoard(bulletin_board_id);
		Pager pager = new Pager();
		pager.init(request, list.size());
		JSONObject jsonObject =new JSONObject();
		jsonObject.put("list", list);
		jsonObject.put("pager", pager);
		return jsonObject;
	}

	@RequestMapping(value = "/bulletinComments", method = RequestMethod.PUT)
	@ResponseBody
	public String commentUpdate(BulletinComment bulletinComment) {
		// System.out.println(11);
		bulletinCommentService.update(bulletinComment);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultCode", 1);
		return jsonObject.toString();
	}

	@RequestMapping(value = "/bulletinComments", method = RequestMethod.POST)
	@ResponseBody
	public String commentInsert(BulletinComment bulletinComment) {
		bulletinCommentService.insert(bulletinComment);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultCode", 1);
		return jsonObject.toString();

	}

	@RequestMapping(value = "/bulletinComments/{bulletin_comment_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public String commentDelete(@PathVariable("bulletin_comment_id") int bulletin_comment_id) {
		bulletinCommentService.delete(bulletin_comment_id);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultCode", 1);
		return jsonObject.toString();

	}

	@ExceptionHandler(RegistFailException.class)
	public ModelAndView registException(RegistFailException e) {

		ModelAndView mav = new ModelAndView("error/errorPage");
		mav.addObject("err", e);
		return mav;
	}

	@ExceptionHandler(EditFailException.class)
	public ModelAndView registException(EditFailException e) {

		ModelAndView mav = new ModelAndView("error/errorPage");
		mav.addObject("err", e);
		return mav;
	}

	@ExceptionHandler(DeleteFailException.class)
	public ModelAndView deleteException(DeleteFailException e) {

		ModelAndView mav = new ModelAndView("error/errorPage");
		mav.addObject("err", e);
		return mav;
	}
	/*
	 * @ExceptionHandler(EditFailException.class)
	 * 
	 * @ResponseBody public String editException(EditFailException e) { JSONObject
	 * jsonObject = new JSONObject(); jsonObject.put("resultCode", 0); return
	 * jsonObject.toString(); }
	 */
}
