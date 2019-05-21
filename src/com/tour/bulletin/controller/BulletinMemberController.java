package com.tour.bulletin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tour.common.security.SequrityBean;
import com.tour.exception.DataNotFoundException;
import com.tour.exception.UpdateException;
import com.tour.model.bulletin.domain.BulletinMember;
import com.tour.model.bulletin.service.BulletinMemberService;

@Controller
public class BulletinMemberController {
	@Autowired
	@Qualifier("bulletinMemberServiceImpl")
	private BulletinMemberService memberService;

	@Autowired
	private SequrityBean sequrityBean;// 회원가입 / 비밀번호 보안.
	
	private int passKey;//인증키
	private int passKey3;//인증키 보관용

	// ======== 회원가입 Page 관련 Method 정호진 (190509 -
	// 정호진)====================================
	// 아이디,이메일 중복 체크
	@RequestMapping(value = "/members/check", method = RequestMethod.GET)
	@ResponseBody
	public String check(BulletinMember member) {
		System.out.println("Member=" + member);
		passKey = (int) (Math.random() * 10000);// 10000까지의 숫자중 랜덤으로 얻어옴.
		BulletinMember result = memberService.check(member, passKey);
		String checkResult = "0";

		if (result == null) {
			checkResult = "0";
		} else {
			checkResult = "1";
		}
		return checkResult;
	}

	// ========인증번호 체크관련 Method 정호진 (190509)==========================
	@RequestMapping(value = "/members/passKey/{passKey2}", method = RequestMethod.GET)
	@ResponseBody
	public String passKeyCheck(@PathVariable("passKey2") int passKey2) {
		passKey3 = passKey2;// 이메일 초기화를 위하여, 변수에 담아놓음.
		System.out.println("BulletinMemberController / 넘어온 인증번호는? =" + passKey2);
		String result = null;
		if (passKey2 == passKey) {
			result = "1";
			passKey = (int) (Math.random() * 10000);// 이메일 인증 후, 다시 인증번호 변경
		} else {
			result = "0";
			passKey = (int) (Math.random() * 10000);// 인증번호를 다시 받도록, 변경
		}
		return result;
	}

	// 시간초과 됐을 경우, 인증번호 초기화 / 정호진 (190509)
	@RequestMapping(value = "/members/resetKey", method = RequestMethod.GET)
	@ResponseBody
	public String passKeyReset() {
		passKey = (int) (Math.random() * 10000);// 인증번호를 다시 받도록, 변경
		System.out.println("BulletinCocntroller/인증번호 초기화 완료 /" + passKey);
		String result = "0";
		if (passKey3 != passKey) {
			result = "1";
		} else {
			result = "0";
		}
		return result;
	}
	// =========================================================================

	// 로그인 체크
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(BulletinMember member, HttpServletRequest request) {
		System.out.println("로그인 요청한 아이디 : " + member.getId());
		System.out.println("로그인 요청한 비밀번호 : " + member.getPass());
		String sequrityPass = sequrityBean.textToHash(member.getPass());
		System.out.println("로그인 요청한 비밀번호 암호화 : "+sequrityPass);
		member.setPass(sequrityPass);
		
		BulletinMember obj = memberService.loginCheck(member);
		// 세션에 담기
		request.getSession().setAttribute("member", obj);

		return "redirect:/chimper/chimper/index.jsp";
	}

	// 메인 페이지 요청
	@RequestMapping(value = "/member/main", method = RequestMethod.GET)
	public String requestMain(HttpServletRequest request) {
		return "redirect:/board/list";
	}

	// 회원가입
	@RequestMapping(value = "/members/insert", method = RequestMethod.POST)
	public String insert(BulletinMember member) {
		System.out.println("넘어온  Pass==" + member.getPass());
		// 비밀번호 암호화
		String sequrityPass = sequrityBean.textToHash(member.getPass());
		System.out.println("암호화 된 Pass==" + sequrityPass);
		member.setPass(sequrityPass);

		memberService.insert(member);
		System.out.println("회원가입 Controller   insert통과");

		return "redirect:/chimper/chimper/index.jsp";
	}

	// =========================== 관리자 회원관리 Page 관련 Method (190501 -
	// 박현호)====================================
	// 회원 한명 가져오기
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	@ResponseBody
	public String select2(@RequestParam("member_id") int member_id) {
		System.out.println("MemberController : select2() 호출!");
		System.out.println("MemberController : select2() : 화면에 띄울 회원의 고유값 : " + member_id);
		BulletinMember member = memberService.select(member_id);
		System.out.println("MemberController : select2() : 가져온 member 객체 : " + member);
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"member_id\":\"" + member.getMember_id() + "\",");
		sb.append("\"id\":\"" + member.getId() + "\",");
		sb.append("\"pass\":\"" + member.getPass() + "\",");
		sb.append("\"member_name\":\"" + member.getMember_name() + "\",");
		sb.append("\"email\":\"" + member.getEmail() + "\",");
		sb.append("\"member_level_id\":\"" + member.getMemberLevel().getMember_level_id() + "\"");
		sb.append("}");

		return sb.toString();
	}

	// 회원 전체 목록 가져오기
	@RequestMapping(value = "/members", method = RequestMethod.GET)
	public ModelAndView selectAll() {
		System.out.println("MemberController : selectAll() 호출!");
		List<BulletinMember> memberList = memberService.selectAllAdmin();
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberList", memberList);
		mav.setViewName("chimper/chimper/admin/memberManage");

		return mav;
	}

	// 관리자 회원정보 수정!!
	@RequestMapping(value = "/editMember", method = RequestMethod.POST)
	public String updateMember(BulletinMember member) {
		int result = memberService.update(member);

		return "redirect:/members";
	}
	// ========================================================================================

	// =========================== 마이페이지 관련 Method (190501 -
	// 박현호)====================================
	@RequestMapping(value = "/editMyInfo", method = RequestMethod.POST)
	public String updateMyInfo(BulletinMember member, HttpServletRequest request) {
		int result = memberService.update(member);
		BulletinMember editedMember = memberService.select(member.getMember_id());
		request.getSession().setAttribute("member", editedMember);

		return "redirect:/myBoards?member_id=" + member.getMember_id();
	}
	// ========================================================================================

	// =========================== 계정 찾기 관련 Method (190519 -
	// 박현호)====================================
	// 아이디 찾기 Method
	@RequestMapping(value = "/findAccount/findID", method = RequestMethod.GET)
	@ResponseBody
	public String getID(BulletinMember member) {
		System.out.println("BulletinMemberController : getID() 호출!!");
		// System.out.println("BulletinMemberController : getID() : member_name :
		// "+member.getMember_name());
		// System.out.println("BulletinMemberController : getID() : email :
		// "+member.getEmail());

		String id = memberService.getID(member);
		System.out.println("BulletinMemberController : getID() : 찾은 id : " + id);

		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"id\":\"" + id + "\"");
		sb.append("}");

		System.out.println("BulletinMemberController : getID() : 계정 ID 찾기요청에 보낼 JSON : " + sb.toString());
		return sb.toString();
	}

	// 비밀번호 초기화 Method
	@RequestMapping(value = "/findAccount/resetPass", method = RequestMethod.POST)
	@ResponseBody
	public String resetPass(BulletinMember member) {
		System.out.println("BulletinMemberController : resetPass() 호출!!");
		System.out.println("BulletinMemberController : resetPass() : id : " + member.getId());
		System.out.println("BulletinMemberController : resetPass() : email : " + member.getEmail());
		int result = memberService.resetPass(member);

		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"resultCode\":\"" + result + "\"");
		sb.append("}");

		System.out.println("BulletinMemberController : resetPass() : 비밀번호 초기화 요청에 보낼 JSON : " + sb.toString());
		return sb.toString();
	}

	// ======================================================================================

	// 예외처리
	// ================================================================
	// 로그인 실패
	@ExceptionHandler(DataNotFoundException.class)
	public ModelAndView loginFail(DataNotFoundException e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("error", e);
		mav.setViewName("error/errorPage");
		return mav;
	}

	// 회원정보 수정 실패
	@ExceptionHandler(UpdateException.class)
	public ModelAndView loginFail(UpdateException e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("error", e);
		mav.setViewName("error/errorPage");
		return mav;
	}
	// ================================================================
}
