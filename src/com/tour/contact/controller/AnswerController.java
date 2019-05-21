package com.tour.contact.controller;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tour.exception.DataNotFoundException;
import com.tour.exception.DeleteException;
import com.tour.exception.RegistException;
import com.tour.exception.UpdateException;
import com.tour.model.domain.Answer;
import com.tour.model.service.AnswerService;
import com.tour.model.service.QnABoardService;

@Controller
public class AnswerController {
	@Autowired
	private AnswerService answerService;
	@Autowired
	private QnABoardService qnaBoardService;
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;

	
	// 답변글 정보 등록하기!!
	// ========================================================================
	@RequestMapping(value = "/Answer", method = RequestMethod.POST)
	@ResponseBody
	public String registAnswer(Answer answer) {
		System.out.println("AnswerController : registAnswer() 호출!!");
		System.out.println("AnswerController : registAnswer() : qnaBoard_id : " + answer.getQnaBoard_id());
		System.out.println("AnswerController : registAnswer() : answer_content : " + answer.getAnswer_content());
		System.out.println("AnswerController : registAnswer() : answer_writer : " + answer.getAnswer_writer());

		if (answer.getAnswer_content().equals("")) {
			return "{\"result\":0}";
		}
		System.out.println("answerService : "+answerService.getClass().getCanonicalName());
		answerService.insert(answer);//답변 등록
		
		return "{\"result\":1}";
	}
	// ========================================================================

	// 답변글 정보 가져오기
	// ========================================================================
	@RequestMapping(value = "/Answer", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public Answer getAnswer(int qnaBoard_id) {
		System.out.println("AnswerController : getAnswer() 호출!!");
		System.out.println("AnswerController : getAnswer() : qnaboard_id : " + qnaBoard_id);

		Answer answer = answerService.select(qnaBoard_id);

		return answer;
	}
	// ========================================================================

	// 답변글 정보 수정하기
	// ========================================================================
	@RequestMapping(value = "/doUpdateAnswer", method = RequestMethod.POST)
	@ResponseBody
	public String updateAnswer(Answer answer) {
		System.out.println("AnswerController : updateAnswer() 호출!!");
		String allresult = "";
		int result = answerService.update(answer);

		return "{\"result\":1}";
	}
	// ========================================================================

	// 답변글 정보 삭제하기
	// ========================================================================
	@RequestMapping(value = "/doDeleteAnswer", method = RequestMethod.POST)
	@ResponseBody
	public String deleteAnswer(Answer answer) {
		System.out.println("AnswerController : deleteAnswer() 호출!!");
		answerService.delete(answer);
	

		return "{\"result\":1}";
	}
	// ========================================================================

	// 예외처리!!
	// ================================================
	// 답변글 등록 Exception 처리
	@ExceptionHandler(RegistException.class)
	@ResponseBody
	public String answerRegistFail(RegistException e) {
		
		return "{\"result\":0}";
	}

	
	 // 답변글 수정, 게시글 답변 상태 Exception 처리
	 @ExceptionHandler(UpdateException.class)
	 @ResponseBody
	 public String answerUpdateFail(UpdateException e) {
		
		 return "{\"result\":0}"; 
	 }
	 

	// 답변글 삭제 Exception 처리
	@ExceptionHandler(DeleteException.class)
	@ResponseBody
	public String answerDeleteFail(DeleteException e) {
		
		return "{\"result\":0}";
	}

	// 답변글 조회 Exception 처리
	@ExceptionHandler(DataNotFoundException.class)
	public ModelAndView answerSelectFail(DataNotFoundException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorPage");
		mav.addObject("error", e);

		return mav;
	}
	// ================================================
}
