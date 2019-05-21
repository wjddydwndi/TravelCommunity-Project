package com.tour.model.bulletin.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.bulletin.domain.BulletinMember;

@Repository
public class MybatisBulletinMemberDAO implements BulletinMemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("BulletinMember.selectAll");
	}

	
	
	
	@Override
	public BulletinMember select(int member_id) {
		
		return sqlSessionTemplate.selectOne("BulletinMember.select",member_id);
	}
	
	
	

	@Override
	public int insert(BulletinMember member) {
		
		return sqlSessionTemplate.insert("BulletinMember.insert", member);
	}

	
	
	
	@Override
	public int update(BulletinMember member) {
		int result = sqlSessionTemplate.update("BulletinMember.update", member);
		return result;
	}

	
	
	
	@Override
	public int delete(int member_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	@Override
	public BulletinMember loginCheck(BulletinMember member) {
		
		return sqlSessionTemplate.selectOne("BulletinMember.login",member);
	}




	@Override
	public List selectAllAdmin() {
		return sqlSessionTemplate.selectList("BulletinMember.selectAllAdmin");
	}


	//작성자 검색
	public List selectMember(String searchText) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("BulletinMember.selectMember", "%"+searchText+"%");
	}




	@Override
	public BulletinMember checkId(BulletinMember member) {
		return sqlSessionTemplate.selectOne("BulletinMember.checkId", member);
	}




	@Override
	public BulletinMember checkEmail(BulletinMember member) {
	      return sqlSessionTemplate.selectOne("BulletinMember.checkEmail", member);
	}



	//================= 계정 찾기 관련 (190519 : 박현호) ======================
	// 아이디 찾기
	@Override
	public String getID(BulletinMember member) {
		System.out.println("MybatisBulletinMemberDAO : getID() : member_name : "+member.getMember_name());
		System.out.println("MybatisBulletinMemberDAO : getID() : email : "+member.getEmail());
		String id = sqlSessionTemplate.selectOne("BulletinMember.findUserID", member);
		return id;
	}
	
	// 비밀번호 초기화
	@Override
	public int resetPass(BulletinMember member) {
		System.out.println("MybatisBulletinMemberDAO : resetPass() : id : "+member.getId());
		System.out.println("MybatisBulletinMemberDAO : resetPass() : email : "+member.getEmail());
		int result=0;
		String pass = sqlSessionTemplate.selectOne("BulletinMember.findPass", member);
		if(pass != null) {
			result = sqlSessionTemplate.update("BulletinMember.updatePass", member);
		}
		return result;
	}
	//=========================================================
}
