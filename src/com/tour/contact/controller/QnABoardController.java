package com.tour.contact.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tour.common.board.Pager;
import com.tour.exception.DataNotFoundException;
import com.tour.exception.DeleteException;
import com.tour.exception.RegistException;
import com.tour.exception.UpdateException;
import com.tour.model.bulletin.domain.BulletinMember;

import com.tour.model.domain.QnABoard;
import com.tour.model.service.QnABoardPrivacyPassService;
import com.tour.model.service.QnABoardService;

@Controller
public class QnABoardController {
	@Autowired
	private QnABoardService boardService;
	@Autowired
	private QnABoardPrivacyPassService qnaBoard_privacy_pass_service;
	
	int count;
	
	
	// DB 에 등록되어있는 모든 게시글 가져오기
	//===========================================================
	@RequestMapping(value="/qnaBoards", method=RequestMethod.GET)
	public ModelAndView selectAll() {
		System.out.println("QnABoardController : selectAll() 호출!!");
		List<QnABoard> qnaBoardList = boardService.selectAll();
		System.out.println("가져온 게시글 전체 개수 : "+qnaBoardList.size());
		
		Pager pager = new Pager();
		
		Object[] object = {qnaBoardList, pager};
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chimper/chimper/contact/contact");
		mav.addObject("objects", object);
		
		return mav;
	}
	//===========================================================
	
	
	// 글 1건 등록하기!!!
	//===========================================================
	@RequestMapping(value="/qnaBoards", method=RequestMethod.POST)
	public ModelAndView insert(QnABoard qnaBoard) {
		System.out.println("QnABoardController : insert() 호출!!");
		System.out.println("QnABoardController : insert() : qnaboard_privacy_id : "+qnaBoard.getQnaBoard_privacy_id());
		System.out.println("QnABoardController : insert() : member : "+qnaBoard.getMember_id());
		
		ModelAndView mav = new ModelAndView();
		if(qnaBoard.getQnaBoard_privacy_id().equals("2")) {
			int result = boardService.insert(qnaBoard);
			mav.setViewName("redirect:/qnaBoards");
		}else {
			System.out.println("QnABoardController : insert() : 비공개 설정 글입니다. 비밀번호 설정 Page 로 이동합니다.");
			mav.setViewName("chimper/chimper/contact/setBoardPass");
			mav.addObject("qnaBoard", qnaBoard);
		}
		
		return mav;
	}
	//===========================================================
	
	
	
	
	
	// 글 1건에 대한 정보 가져오기
	//===========================================================
	@RequestMapping(value="/qnaBoard", method=RequestMethod.GET)
	public ModelAndView select(int qnaBoard_id, HttpServletRequest request) {
		System.out.println("QnABoardControlle`r : select() 호출!!");
		QnABoard qnaBoard = boardService.select(qnaBoard_id);
		ModelAndView mav = new ModelAndView();
		System.out.println("QnABoardController : select() : qnaBoard_privacy_id : "+qnaBoard.getQnaBoard_privacy_id());
		
		// 회원일 경우 게시글 상세보기 처리
		//===================================================
		if(request.getSession().getAttribute("member")!=null) {
			BulletinMember member = (BulletinMember)request.getSession().getAttribute("member");
			
			if(qnaBoard.getQnaBoard_privacy_id().equals("1")) {
				if(member.getMemberLevel().getMember_level_id()==0) {
					if(!qnaBoard.getQnaBoard_writer().equals(member.getId())) {
						mav.setViewName("chimper/chimper/contact/confirmBoardPass");
						mav.addObject("qnaBoard", qnaBoard);
					}else {
						mav.setViewName("chimper/chimper/contact/detail");
						mav.addObject("qnaBoard", qnaBoard);
					}
				}else {
					mav.setViewName("chimper/chimper/contact/detail");
					mav.addObject("qnaBoard", qnaBoard);
				}
			}else {
				mav.setViewName("chimper/chimper/contact/detail");
				mav.addObject("qnaBoard", qnaBoard);
			}
		//===================================================	
			
		// 회원이 아닐경우 글 상세보기 처리
		//===================================================
		}else {
			if(qnaBoard.getQnaBoard_privacy_id().equals("1")) {
				mav.setViewName("chimper/chimper/contact/confirmBoardPass");
				mav.addObject("qnaBoard", qnaBoard);
			}else {
				mav.setViewName("chimper/chimper/contact/detail");
				mav.addObject("qnaBoard", qnaBoard);
			}
		}
		//===================================================
		return mav;
	}
	//===========================================================
		
	
	
	
	
	// 글 1건 조회수 올리기!!
	//===========================================================
	@RequestMapping(value="/upHit", method=RequestMethod.GET)
	public ModelAndView updateHit(int qnaBoard_id, HttpServletRequest request) {
		System.out.println("QnABoardController : updateHit() 호출!!");
		int result = boardService.updateHit(qnaBoard_id);
		//Member member = (Member)request.getSession().getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/qnaBoard?qnaBoard_id="+qnaBoard_id);
		
		return mav;
	}
	//===========================================================
	
	
	
	
	// 글 1건 삭제하기!!
	//===========================================================
	@RequestMapping(value="/qnaBoard/doDelete")
	public String delete(int qnaBoard_id) {
		System.out.println("QnABoardController : delete() 호출!!");
		QnABoard qnaBoard = boardService.select(qnaBoard_id);
		boardService.delete(qnaBoard_id);
		if(qnaBoard.getQnaBoard_privacy_id().equals("1")) {
			qnaBoard_privacy_pass_service.delete(qnaBoard_id);
		}
		
		return "redirect:/qnaBoards";
	}
	//===========================================================
	
	
	
	
	// 글 1건 수정하기!!
	//===========================================================
	@RequestMapping(value="/qnaBoard/doUpdate")
	public ModelAndView update(QnABoard qnaBoard) {
		System.out.println("QnABoardController : update() 호출!!");
		System.out.println("수정 qnaBoard 의 qnaBoard_privacy_id : "+qnaBoard.getQnaBoard_privacy_id());
		boardService.update(qnaBoard);																									// 글 수정!!
		ModelAndView mav = new ModelAndView();
		if(qnaBoard.getQnaBoard_privacy_id().equals("1")) {																		// 수정된 글의 privacy_id 가 1:비공개 라면
			System.out.println("QnABoardController : update() : 비공개 전환 글 입니다.. 비밀번호 등록 정보가 없습니다.. 비밀번호를 등록합니다.");
			mav.setViewName("chimper/chimper/contact/setBoardPass");														// 암호 설정 창으로 이동
			mav.addObject("qnaBoard", qnaBoard);																						// 이동하면서 qnaBoard 정보를 넘김
		}else {
			if(qnaBoard_privacy_pass_service.select(qnaBoard.getQnaBoard_id())!=null) {
				qnaBoard_privacy_pass_service.delete(qnaBoard.getQnaBoard_id());
			}
			mav.setViewName("redirect:/qnaBoard?qnaBoard_id="+qnaBoard.getQnaBoard_id());
		}

		
		return mav;
	}
	//===========================================================
	
	
	
	
	
	
	// 게시글 검색
	//====================================================================
	@RequestMapping(value="/searchQnaBoards", method=RequestMethod.GET)
	public ModelAndView searchQnaBoards(int searchMode, String searchWord) {
		System.out.println("QnABoardController : searchQnaBoards() 호출!!");
		List<QnABoard> qnaBoardList = boardService.searchQnaBoards(searchMode, searchWord);
		
		Pager pager = new Pager();
		
		Object[] object = {qnaBoardList, pager};
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chimper/chimper/contact/contact");
		mav.addObject("objects", object);
		
		return mav;
	}
	//====================================================================
	
	
	
	
	
	
//	// 마이페이지에서 내가 쓴 고객센터 게시물 가져오기!!
//	//====================================================================
//	@RequestMapping(value="/myQnaBoards", method=RequestMethod.GET)
//	public ModelAndView getMyQnaBoards(int member_id) {
//		System.out.println("QnABoardController : getMyQnaBoards() 호출!!");
//		List<QnABoard> qnaBoardList = boardService.getMyQnaBoards(member_id);
//		
//		Pager pager = new Pager();
//		
//		Object[] object = {qnaBoardList, pager};
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("chimper/chimper/myPage/myPageForm");
//		mav.addObject("objects", object);
//		
//		return mav;
//	}
//	//====================================================================
	
	
	
	
	
	
	
	
	
	// 예외 처리!!
	//============================================
	// 글 전체 불러오기 관련 예외처리
	//===========================================================
	@ExceptionHandler(DataNotFoundException.class)
	@ResponseBody
	public ModelAndView loadBoardsException(DataNotFoundException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error",e);
		
		return mav;
	}
	//===========================================================
	
	
	// 글 1건 등록에 관한 예외처리
	//===========================================================
	@ExceptionHandler(RegistException.class)
	@ResponseBody
	public ModelAndView registFailException(RegistException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error",e);
		
		return mav;
	} 
	//===========================================================
	
	
	// 글 1건 삭제에 관한 얘외처리
	//===========================================================
	@ExceptionHandler(DeleteException.class)
	@ResponseBody
	public ModelAndView deleteFailException(DeleteException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error",e);
		
		return mav;
	} 
	//===========================================================

	
	// 글 1건 수정에 관한 얘외처리
	//===========================================================
	@ExceptionHandler(UpdateException.class)
	@ResponseBody
	public ModelAndView updateFailException(UpdateException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error",e);
		
		return mav;
	} 
	//===========================================================
	
	
	//============================================
}
