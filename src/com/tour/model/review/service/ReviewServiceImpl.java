package com.tour.model.review.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sun.javafx.scene.control.SelectedCellsMap;
import com.tour.exception.EditFailException;
import com.tour.exception.RegistFailException;
import com.tour.common.file.FileManager;
import com.tour.model.review.domain.Image;
import com.tour.model.review.domain.Path;
import com.tour.model.review.domain.Review;
import com.tour.model.review.repository.GoodDAO;
import com.tour.model.review.repository.ImageDAO;
import com.tour.model.review.repository.PathDAO;
import com.tour.model.review.repository.ReviewDAO;
import com.tour.model.review.repository.Review_commentDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	public FileManager fileManager;

	@Autowired
	@Qualifier("mybatisReviewDAO")
	private ReviewDAO reviewDAO;

	@Autowired
	@Qualifier("mybatisImageDAO")
	private ImageDAO imageDAO;

	@Autowired
	@Qualifier("mybatisPathDAO")
	private PathDAO pathDAO;

	@Autowired
	@Qualifier("mybatisGoodDAO")
	private GoodDAO goodDAO;

	@Autowired
	@Qualifier("mybatisReview_commentDAO")
	private Review_commentDAO review_commentDAO;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return reviewDAO.selectAll();
	}

	@Override
	public Review select(int review_id) {
		Review review = reviewDAO.select(review_id);
		return reviewDAO.select(review_id);
	}

	@Override
	public void update(Review review, Image image, Path path,String filePath) {
		System.out.println("날아오는 경로들" + path.getSelectedPath());
		System.out.println("날아오는 filePath"+filePath);
		System.out.println("날아온 글 시퀀스 : "+review.getReview_id());
		
		int deleteResult = 0; //기존 파일을 삭제하는 경우 업로드된 파일 삭제
		int result1 = 0; //기존 파일을 삭제할 경우 DB에서 삭제
		int result2 = 0; //새로 추가된 이미지 결과값
		int result3 = 0; //path삭제 결과
		int result4 = 0; //path삽입 결과
		int result5 = 0; //글 내용 결과
		
		System.out.println("삭제할 파일 : "+image.getDeleteFile());
		
		if(image.getDeleteFile() != null) {
			for(int i=0; i<image.getDeleteFile().size(); i++) {
				String oriFile = image.getDeleteFile().get(i);
				System.out.println("삭제할 파일 :"+oriFile);
				String newFile = fileManager.separateFile(image.getDeleteFile().get(i));
				System.out.println("이름 바꾼 파일 :"+newFile);
				
				File file = new File(filePath+"/"+newFile);
				System.out.println("file : "+file);
				if(file.delete()) {
					deleteResult = 1;
					System.out.println("file.delete()통과");
					image.setFile_name(newFile);
					result1 = imageDAO.deleteFile(image);
					System.out.println("imageDAO.deleteFile()통과");
				}else {
					deleteResult = 0;
				}
			}
		}else {
			result1 = 1;
			result2 = 1;
		}
		
		//새로 추가된 이미지 처리
		List<MultipartFile> myfile = image.getMyfile(); //새로 선택한 파일 목록
		File originFile = null; //파일 업로드를 위한 파일 생성
		System.out.println("myfile : "+myfile);
		System.out.println("myfile 사이즈 : "+myfile.size());

		if(myfile.size() != 0) {
			for (int i = 0; i < myfile.size(); i++) {
				String filename = myfile.get(i).getOriginalFilename();
				originFile = new File(filePath + "/" + filename);
				System.out.println("originFile : "+originFile);
				try {
					myfile.get(i).transferTo(originFile);
					filename = fileManager.getFilename(originFile, filePath);
					if (filename != null) {
						image.setFile_name(filename);
						image.setReview(review);
						result2 = imageDAO.insert(image);
						if (result2 == 0) {
							throw new RegistFailException("이미지등록에 실패하였습니다.");
						}else {
							System.out.println("이미지 등록 : "+result2);
							System.out.println("파일 이름" + image.getFile_name());
						}
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else {
			result2 = 1;
			result1 = 1;
		}
		
		//path 수정
		JSONParser jsonParser = new JSONParser();
		JSONArray jsonArray = null;
		try {
			jsonArray = (JSONArray) jsonParser.parse(path.getSelectedPath());
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		System.out.println("review_id : "+review.getReview_id());
		result3 = pathDAO.deleteByReviewId(review.getReview_id());
		System.out.println("path 삭제 결과 : "+result3);
		
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject = (JSONObject) jsonArray.get(i);
			path.setLati((double) jsonObject.get("lati"));
			path.setLongi((double) jsonObject.get("longi"));
			path.setPath_name((String)jsonObject.get("path_name"));
			path.setReview(review);
			result4 = pathDAO.insert(path);
			System.out.println("path 등록 결과 : "+result4);
			if (result4 == 0) {
				throw new RegistFailException("패스등록에 실패하였습니다.");
			}
		}
		
		//글 수정
		System.out.println("변경할 글의 내용 : "+review.getReview_content());
		System.out.println("변경할 제목의 내용 : "+review.getReview_title());
		
		result5 = reviewDAO.update(review);
		System.out.println("글 변경 결과 : "+result5);
		
	}

	// delete
	@Transactional(value = "transactionManager")
	@Override
	public void delete(int review_id, String path) {
		// 폴더안에있는 이미지들을 먼저 삭제하고나서 DB에서 지우기
		System.out.println("realpath : " + path);
		Review review = reviewDAO.select(review_id);
		List<Image> imageList = review.getImage();
		for (int i = 0; i < imageList.size(); i++) {
			String filename = imageList.get(i).getFile_name();
			File file = new File(path + "/" + filename);
			if (file.delete()) {
				int result1 = imageDAO.deleteByReviewId(review_id);
				System.out.println("이미지 삭제 결과 : " + result1);
			}
		}
		int result2 = pathDAO.deleteByReviewId(review_id);
		System.out.println("path 삭제 결과 : " + result2);
		int result3 = review_commentDAO.deleteByReviewId(review_id);
		System.out.println("댓글 삭제 결과 : " + result3);
		int result4 = goodDAO.deleteByReviewId(review_id);
		System.out.println("좋아요 삭제 결과 : " + result4);
		int result5 = reviewDAO.delete(review_id);
		System.out.println(review_id + "번 게시글 삭제 결과 : " + result5);
	}

	// insert
	@Transactional(value="transactionManager")
	public void insert(Review review, Image image, Path path, String filePath) {
		System.out.println("날아오는 경로들" + path.getSelectedPath());
		System.out.println("날아오는 filePath"+filePath);
		fileManager = new FileManager();
		List<MultipartFile> file = image.getMyfile();

		File originFile = null;

		JSONParser jsonParser = new JSONParser();
		JSONArray jsonArray = null;
		try {
			jsonArray = (JSONArray) jsonParser.parse(path.getSelectedPath());
			System.out.println(jsonArray.toString());
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		int result = reviewDAO.insert(review);
		if (result == 0) {
			throw new RegistFailException("글등록에 실패하였습니다.");
		}
		int result2 = 0;
		int result3 = 0;

		for (int i = 0; i < file.size(); i++) {
			String filename = file.get(i).getOriginalFilename();
			originFile = new File(filePath + "/" + filename);
			try {
				file.get(i).transferTo(originFile);
				filename = fileManager.getFilename(originFile, filePath);
				if (filename != null) {
					image.setFile_name(filename);
					image.setReview(review);
					result2 = imageDAO.insert(image);
					if (result2 == 0) {
						throw new RegistFailException("이미지등록에 실패하였습니다.");
					}

					System.out.println("파일 이름" + image.getFile_name());
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject = (JSONObject) jsonArray.get(i);
			path.setLati((double) jsonObject.get("lati"));
			path.setLongi((double) jsonObject.get("longi"));
			path.setPath_name((String)jsonObject.get("path_name"));
			path.setReview(review);
			result3 = pathDAO.insert(path);
			if (result3 == 0) {
				throw new RegistFailException("패스등록에 실패하였습니다.");
			}
		}
	}

	@Override
	public void updateHit(int review_id) throws EditFailException {
		int result = reviewDAO.updateHit(review_id);
		if (result == 0) {
			throw new EditFailException("조회수 업데이트 실패");
		}
	}

	@Override
	public List selectByGood() {
		System.out.println("좋아요로 글 정보 가져오기 서비스 접근");
		return reviewDAO.selectByGood();
	}
}
