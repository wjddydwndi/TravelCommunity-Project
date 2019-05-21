<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	BulletinMember member = (BulletinMember)request.getSession().getAttribute("member");
	String member_level=null;
	int member_level_id = 7;
	String id = null;

	if(member!=null){
		member_level_id = member.getMemberLevel().getMember_level_id();
		id = member.getId();
		
		if(member_level_id == 2){
			/* 		out.print("<script>");
					out.print("alert('관리자 "+member.getMember_name()+" 접속!');");
					out.print("</script>"); */
					member_level="관리자";
				}else if(member_level_id == 1){
			/* 		out.print("<script>");
					out.print("alert('manager "+member.getMember_name()+" 접속!');");
					out.print("</script>"); */
					member_level="manager";
				}else if(member_level_id == 0){
			/* 		out.print("<script>");
					out.print("alert('환영합니다~ "+member.getMember_name()+" 님!');");
					out.print("</script>"); */
					member_level="일반 회원";
				}
	}else{
		member_level="손님";
	}
%>