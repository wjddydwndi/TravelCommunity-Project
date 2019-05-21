package com.tour.model.gallery.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.gallery.domain.Gallery_image;

@Repository
public class MybatisGallery_imageDAO implements Gallery_imageDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public int insert(Gallery_image gallery_image) {
		return sessionTemplate.insert("Gallery_image.insert", gallery_image);
	}

	public int delete(int gallery_image_id) {
		return sessionTemplate.delete("Gallery_image.delete", gallery_image_id);
	}

	public int update(Gallery_image gallery_image) {
		return sessionTemplate.update("Gallery_image.update", gallery_image);
	}

	public List selectAll() {
		return sessionTemplate.selectList("Gallery_image.selectAll");
	}

	public List select(int gallery_id) {
		return sessionTemplate.selectList("Gallery_image.select", gallery_id);
	}

	
	//수정하기 기존파일 삭제
	public int deleteFile(Gallery_image gallery_image) {
		return sessionTemplate.delete("Gallery_image.deleteFile", gallery_image);
	}
	
	
	public int deleteAll(int gallery_id) {
		return sessionTemplate.delete("Gallery_image.deleteAll", gallery_id);
	}
	
	public int updateFile(Gallery_image gallery_image) {
		return sessionTemplate.insert("Gallery_image.updateFile", gallery_image);
	}

	@Override
	public Gallery_image getGallery_id(int gallery_image_id) {
		return sessionTemplate.selectOne("Gallery_image.getGallery_id", gallery_image_id);
	}

}
