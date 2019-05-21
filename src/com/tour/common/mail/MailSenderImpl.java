package com.tour.common.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.tour.model.bulletin.domain.BulletinMember;

@Component
public class MailSenderImpl {
	@Autowired
	private JavaMailSenderImpl mailSender;// 회원가입 이메일인증
	
	public void mailSending(BulletinMember member, int passKey) {
		System.out.println("MailSender1==" + mailSender);

		try {
			MimeMessage message = mailSender.createMimeMessage();

			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			System.out.println("messageHelper2==" + messageHelper);

			messageHelper.setFrom("wjddydwndi@gmail.com"); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(member.getEmail()); // 받는사람 이메일
			messageHelper.setSubject("<Travel>인증번호를 확인해주세요."); // 메일제목은 생략이 가능하다
			messageHelper.setText("인증번호 : "+passKey); // 메일 내용

			System.out.println("RestMailController3==" + mailSender);
			mailSender.send(message);
		} catch (MailException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
