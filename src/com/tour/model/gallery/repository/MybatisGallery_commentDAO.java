package com.tour.model.gallery.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.gallery.domain.Gallery_comment;

@Repository
public class MybatisGallery_commentDAO implements Gallery_commentDAO {
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public int insert(Gallery_comment gallery_comment) {
		return sessionTemplate.insert("Gallery_comment.insert", gallery_comment);
	}

	public int delete(int gallery_comment_id) {
		return sessionTemplate.delete("Gallery_comment.delete", gallery_comment_id);
	}

	public int update(Gallery_comment gallery_comment) {
		return sessionTemplate.update("Gallery_comment.update", gallery_comment);
	}

	public List selectAll(int gallery_id) {
		return sessionTemplate.selectList("Gallery_comment.selectAll", gallery_id);
	}

	public int deleteAll(int gallery_id) {
		return sessionTemplate.delete("Gallery_comment.deleteAll", gallery_id);
	}

}
