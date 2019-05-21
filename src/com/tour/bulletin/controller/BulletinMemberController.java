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
	private SequrityBean sequrityBean;// ȸ������ / ��й�ȣ ����.
	
	private int passKey;//����Ű
	private int passKey3;//����Ű ������

	// ======== ȸ������ Page ���� Method ��ȣ�� (190509 -
	// ��ȣ��)====================================
	// ���̵�,�̸��� �ߺ� üũ
	@RequestMapping(value = "/members/check", method = RequestMethod.GET)
	@ResponseBody
	public String check(BulletinMember member) {
		System.out.println("Member=" + member);
		passKey = (int) (Math.random() * 10000);// 10000������ ������ �������� ����.
		BulletinMember result = memberService.check(member, passKey);
		String checkResult = "0";

		if (result == null) {
			checkResult = "0";
		} else {
			checkResult = "1";
		}
		return checkResult;
	}

	// ========������ȣ üũ���� Method ��ȣ�� (190509)==========================
	@RequestMapping(value = "/members/passKey/{passKey2}", method = RequestMethod.GET)
	@ResponseBody
	public String passKeyCheck(@PathVariable("passKey2") int passKey2) {
		passKey3 = passKey2;// �̸��� �ʱ�ȭ�� ���Ͽ�, ������ ��Ƴ���.
		System.out.println("BulletinMemberController / �Ѿ�� ������ȣ��? =" + passKey2);
		String result = null;
		if (passKey2 == passKey) {
			result = "1";
			passKey = (int) (Math.random() * 10000);// �̸��� ���� ��, �ٽ� ������ȣ ����
		} else {
			result = "0";
			passKey = (int) (Math.random() * 10000);// ������ȣ�� �ٽ� �޵���, ����
		}
		return result;
	}

	// �ð��ʰ� ���� ���, ������ȣ �ʱ�ȭ / ��ȣ�� (190509)
	@RequestMapping(value = "/members/resetKey", method = RequestMethod.GET)
	@ResponseBody
	public String passKeyReset() {
		passKey = (int) (Math.random() * 10000);// ������ȣ�� �ٽ� �޵���, ����
		System.out.println("BulletinCocntroller/������ȣ �ʱ�ȭ �Ϸ� /" + passKey);
		String result = "0";
		if (passKey3 != passKey) {
			result = "1";
		} else {
			result = "0";
		}
		return result;
	}
	// =========================================================================

	// �α��� üũ
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(BulletinMember member, HttpServletRequest request) {
		System.out.println("�α��� ��û�� ���̵� : " + member.getId());
		System.out.println("�α��� ��û�� ��й�ȣ : " + member.getPass());
		String sequrityPass = sequrityBean.textToHash(member.getPass());
		System.out.println("�α��� ��û�� ��й�ȣ ��ȣȭ : "+sequrityPass);
		member.setPass(sequrityPass);
		
		BulletinMember obj = memberService.loginCheck(member);
		// ���ǿ� ���
		request.getSession().setAttribute("member", obj);

		return "redirect:/chimper/chimper/index.jsp";
	}

	// ���� ������ ��û
	@RequestMapping(value = "/member/main", method = RequestMethod.GET)
	public String requestMain(HttpServletRequest request) {
		return "redirect:/board/list";
	}

	// ȸ������
	@RequestMapping(value = "/members/insert", method = RequestMethod.POST)
	public String insert(BulletinMember member) {
		System.out.println("�Ѿ��  Pass==" + member.getPass());
		// ��й�ȣ ��ȣȭ
		String sequrityPass = sequrityBean.textToHash(member.getPass());
		System.out.println("��ȣȭ �� Pass==" + sequrityPass);
		member.setPass(sequrityPass);

		memberService.insert(member);
		System.out.println("ȸ������ Controller   insert���");

		return "redirect:/chimper/chimper/index.jsp";
	}

	// =========================== ������ ȸ������ Page ���� Method (190501 -
	// ����ȣ)====================================
	// ȸ�� �Ѹ� ��������
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	@ResponseBody
	public String select2(@RequestParam("member_id") int member_id) {
		System.out.println("MemberController : select2() ȣ��!");
		System.out.println("MemberController : select2() : ȭ�鿡 ��� ȸ���� ������ : " + member_id);
		BulletinMember member = memberService.select(member_id);
		System.out.println("MemberController : select2() : ������ member ��ü : " + member);
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

	// ȸ�� ��ü ��� ��������
	@RequestMapping(value = "/members", method = RequestMethod.GET)
	public ModelAndView selectAll() {
		System.out.println("MemberController : selectAll() ȣ��!");
		List<BulletinMember> memberList = memberService.selectAllAdmin();
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberList", memberList);
		mav.setViewName("chimper/chimper/admin/memberManage");

		return mav;
	}

	// ������ ȸ������ ����!!
	@RequestMapping(value = "/editMember", method = RequestMethod.POST)
	public String updateMember(BulletinMember member) {
		int result = memberService.update(member);

		return "redirect:/members";
	}
	// ========================================================================================

	// =========================== ���������� ���� Method (190501 -
	// ����ȣ)====================================
	@RequestMapping(value = "/editMyInfo", method = RequestMethod.POST)
	public String updateMyInfo(BulletinMember member, HttpServletRequest request) {
		int result = memberService.update(member);
		BulletinMember editedMember = memberService.select(member.getMember_id());
		request.getSession().setAttribute("member", editedMember);

		return "redirect:/myBoards?member_id=" + member.getMember_id();
	}
	// ========================================================================================

	// =========================== ���� ã�� ���� Method (190519 -
	// ����ȣ)====================================
	// ���̵� ã�� Method
	@RequestMapping(value = "/findAccount/findID", method = RequestMethod.GET)
	@ResponseBody
	public String getID(BulletinMember member) {
		System.out.println("BulletinMemberController : getID() ȣ��!!");
		// System.out.println("BulletinMemberController : getID() : member_name :
		// "+member.getMember_name());
		// System.out.println("BulletinMemberController : getID() : email :
		// "+member.getEmail());

		String id = memberService.getID(member);
		System.out.println("BulletinMemberController : getID() : ã�� id : " + id);

		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"id\":\"" + id + "\"");
		sb.append("}");

		System.out.println("BulletinMemberController : getID() : ���� ID ã���û�� ���� JSON : " + sb.toString());
		return sb.toString();
	}

	// ��й�ȣ �ʱ�ȭ Method
	@RequestMapping(value = "/findAccount/resetPass", method = RequestMethod.POST)
	@ResponseBody
	public String resetPass(BulletinMember member) {
		System.out.println("BulletinMemberController : resetPass() ȣ��!!");
		System.out.println("BulletinMemberController : resetPass() : id : " + member.getId());
		System.out.println("BulletinMemberController : resetPass() : email : " + member.getEmail());
		int result = memberService.resetPass(member);

		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"resultCode\":\"" + result + "\"");
		sb.append("}");

		System.out.println("BulletinMemberController : resetPass() : ��й�ȣ �ʱ�ȭ ��û�� ���� JSON : " + sb.toString());
		return sb.toString();
	}

	// ======================================================================================

	// ����ó��
	// ================================================================
	// �α��� ����
	@ExceptionHandler(DataNotFoundException.class)
	public ModelAndView loginFail(DataNotFoundException e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("error", e);
		mav.setViewName("error/errorPage");
		return mav;
	}

	// ȸ������ ���� ����
	@ExceptionHandler(UpdateException.class)
	public ModelAndView loginFail(UpdateException e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("error", e);
		mav.setViewName("error/errorPage");
		return mav;
	}
	// ================================================================
}
