package com.tour.common.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class MemberSessionAspect {

	/*
	 * @Pointcut("execution(public * com.tour.controller.MemberController..*(..))")
	 * public void checkAccount() { //회원 계정인지 아닌지 여부 확인 }
	 * 
	 * @Pointcut("execution(public * com.tour.controller.RestReviewController..*(..))"
	 * ) public void checkRestAccount() { //회원 계정인지 아닌지 여부 확인 }
	 */

	//세션체크를 피하는 URL배열
	String[] exceptList = {
		"/member/login",
		"/client/index",
		"/review/delete",
		"/review/list",
		"/review/detail"
	};
	
	//
	@Around("checkAccount()")
	public String loginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		HttpServletRequest request = null;
		String viewName = null; 
		Object[] objArray =  joinPoint.getArgs();
		String requestURL = null;
		int count = 0; //제외명단에 존재하는 URL인 경우 카운트 증가
		for(Object obj:objArray) {
			if(obj instanceof HttpServletRequest) {
				request = (HttpServletRequest)obj;
				requestURL=request.getRequestURL().toString();
				System.out.println("지금 요청의 URL은 "+requestURL+"끝나는 URL : "+requestURL.endsWith("/member/login"));
			
				for(int i=0; i<exceptList.length; i++) {
					if(requestURL.endsWith(exceptList[i])) { //제외명단 발견
						count++;
					}
				}
			}
		}
		if(request != null && count < 1) { //request객체를 받은 메서드만 조사하기
			
			if(request.getSession().getAttribute("member") == null) { //member세션이 존재하지 않는다면,
				System.out.println("세션이 존재하지 않음");
				viewName = "client/login/error";
			}else {//member 세션이 있다면 진행방향 그대로!!
				viewName = (String)joinPoint.proceed();
				String methodName = joinPoint.getSignature().getName();
				System.out.println("로그인 필요 // 원래 진행하려고 했던 메서드 : "+methodName);
			}
			
		}else {
			viewName = (String)joinPoint.proceed();
			String methodName = joinPoint.getSignature().getName();
			System.out.println("로그인 불 필요 // 원래 진행하려고 했던 메서드 : "+methodName);
		}
		count = 0;
		return viewName;
	}
}
