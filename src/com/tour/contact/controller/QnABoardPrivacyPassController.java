package com.tour.contact.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.tour.exception.PrivacyRegistFailException;
import com.tour.exception.RegistException;
import com.tour.model.domain.QnABoard;
import com.tour.model.domain.QnABoardPrivacyPass;
import com.tour.model.service.QnABoardPrivacyPassService;
import com.tour.model.service.QnABoardService;

@Controller
public class QnABoardPrivacyPassController {
	@Autowired
	private QnABoardPrivacyPassService qnaBoard_privacy_pass_service;
	@Autowired
	private QnABoardService qnaBoardService;
	
	
	// 비공개글 비밀번호 조회
	//======================================================================================================================
	@RequestMapping(value="/QnABoardPrivacyPass", method=RequestMethod.GET)
	public ModelAndView select(int qnaBoard_id, String privacy_pass) {
		System.out.println("QnABoardPrivacyPassController : select() : 받은 qnaBoard_id : "+qnaBoard_id);
		System.out.println("QnABoardPrivacyPassController : select() : 받은 privacy_pass : "+privacy_pass);
		String pass = qnaBoard_privacy_pass_service.select(qnaBoard_id);
		System.out.println("QnABoardPrivacyPassController : select() : 조회한 게시글 암호 : "+pass);
		QnABoard qnaBoard = qnaBoardService.select(qnaBoard_id);
		ModelAndView mav = new ModelAndView();
		if(pass==null || !pass.equals(privacy_pass)) {
			System.out.println("QnABoardPrivacyPassController : checkPass() : 비밀번호 불일치!!");
			mav.setViewName("chimper/chimper/contact/passUncorrect");
		}else if(pass.equals(privacy_pass)) {
			System.out.println("QnABoardPrivacyPassController : checkPass() : 비밀번호 일치!!");
			mav.setViewName("chimper/chimper/contact/detail");
			mav.addObject("qnaBoard", qnaBoard);
		}
		return mav;
	}
	//======================================================================================================================
	
	
	
	
	
	// 비공개글 비밀번호 설정
	//======================================================================================================================
	@RequestMapping(value="/QnABoardPrivacyPass", method=RequestMethod.POST)
	public String insert(QnABoardPrivacyPass qnaBoard_privacy_pass, HttpServletRequest request) {
		QnABoard qnaBoard = (QnABoard) request.getSession().getAttribute("qnaBoard");															// 세션에 담겨있는 qnaBoard 정보를 꺼냄
		System.out.println("QnABoardPrivacyPassController : insert() : 얻어온 qnaBoard_privacy_pass : "+qnaBoard_privacy_pass);		// qnaBoard 정보 확인
		System.out.println("QnABoardPrivacyPassController : insert() : 얻어온 qnaBoard_privacy_pass 의 qnaBoard_id : "+qnaBoard_privacy_pass.getQnaBoard_id());
		if(qnaBoard_privacy_pass.getQnaBoard_id()!=0) {																										// board_id 가 초기값 0이 아니라면 기존 게시글
			if(qnaBoard_privacy_pass_service.select(qnaBoard_privacy_pass.getQnaBoard_id())==null) {										// 비밀글 비밀번호 정보에 게시글 board_id 로 조회된 결과가 없으면 처음으로 비밀글이 되는글
				System.out.println("QnABoardPrivacyPassController : insert() : 처음 비밀글이 되는 글입니다. 비밀번호 정보를 등록합니다."); 			
				qnaBoard_privacy_pass_service.insert(qnaBoard_privacy_pass);																				// qnaBoard 의 pass 와 qnaBoard 정보를 DB 에 insert
				System.out.println("QnABoardPrivacyPassController : insert() : 비공개글 등록 성공!");
			}else {
				System.out.println("QnABoardPrivacyPassController : insert() : 이미 비밀글이었던 게시글입니다. 기존 비밀번호 정보를 삭제하고 새로운 비밀번호를 설정합니다."); 
				qnaBoard_privacy_pass_service.delete(qnaBoard_privacy_pass.getQnaBoard_id());									
				qnaBoard_privacy_pass_service.insert(qnaBoard_privacy_pass);
				System.out.println("QnABoardPrivacyPassController : insert() : 비밀번호 재설정 완료"); 
			}
		}else {	
			System.out.println("QnABoardPrivacyPassController : insert() : 새로 작성되는 글이면서 비밀글로 설정하는 게시물입니다.");
			qnaBoardService.insert(qnaBoard);				
			qnaBoard_privacy_pass.setQnaBoard_id(qnaBoard.getQnaBoard_id());
			qnaBoard_privacy_pass_service.insert(qnaBoard_privacy_pass);
			System.out.println("QnABoardPrivacyPassController : insert() : 글 등록 및 비밀번호 등록 성공!");
		}
		
		return "redirect:/qnaBoards";
	}
	//======================================================================================================================
	
	
	
	
	
	
	// 예외처리
	//=================================================================
	// 비밀번호 정보 등록 실패 예외처리
	@ExceptionHandler(PrivacyRegistFailException.class)
	public ModelAndView privacyRegistFail(PrivacyRegistFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error", e);
		return mav;
	}
	
	// 글 정보 등록 실패 예외처리
	@ExceptionHandler(RegistException.class)
	public ModelAndView qnaBoardRegistFail(RegistException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error", e);
		return mav;
	}
	//=================================================================
}
