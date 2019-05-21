package com.tour.model.gallery.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.tour.common.file.FileManager;
import com.tour.exception.DeleteFailException;
import com.tour.exception.RegistFailException;
import com.tour.exception.SelectFailException;
import com.tour.exception.UpdateFailException;
import com.tour.model.bulletin.domain.BulletinMember;
import com.tour.model.bulletin.repository.BulletinMemberDAO;
import com.tour.model.gallery.domain.Gallery;
import com.tour.model.gallery.domain.Gallery_comment;
import com.tour.model.gallery.domain.Gallery_image;
import com.tour.model.gallery.repository.GalleryDAO;
import com.tour.model.gallery.repository.Gallery_commentDAO;
import com.tour.model.gallery.repository.Gallery_imageDAO;

@Service
public class GalleryServiceImpl implements GalleryService {
	@Autowired
	private GalleryDAO galleryDAO;
	@Autowired
	private Gallery_commentDAO gallery_commentDAO;
	@Autowired
	private Gallery_imageDAO gallery_imageDAO;

	@Autowired
	private BulletinMemberDAO bulletinMemberDAO;

	@Autowired
	FileManager fileManager;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Transactional(value = "transactionManager") // @Annotaion 트랜잭션 처리
	public void insert(Gallery gallery, Gallery_image gallery_image, String path) throws RegistFailException {
		System.out.println("Service insert");
		MultipartFile[] file = gallery_image.getMyFile();

//////////////////////////////////////// T E S T///////
		for (int i = 0; i < file.length; i++) {
			System.out.println("Service file" + file[i]);
		}
///////////////////////////////////////////////////////

		String[] filenameList = new String[file.length];
		File originFile = null;

////////////////////////////////////////////////////////////////////////
		int result = galleryDAO.insert(gallery);

		gallery_image.setGallery(gallery);
///////////////////////////////////////////////////////////////////////
		int result2 = 0; // gallery_imageDAO 의 결과값을 담을 변수

		for (int i = 0; i < file.length; i++) {
			filenameList[i] = file[i].getOriginalFilename();
			String filename = filenameList[i];
			originFile = new File(path + "/" + filename);

			try {
				file[i].transferTo(originFile);
				filename = fileManager.getFilename(originFile, path);

				if (filename != null) {
					gallery_image.setFilename(filename);
//////////////////////////////////////////////////////////////////////////////////
					result2 = gallery_imageDAO.insert(gallery_image);
//////////////////////////////////////////////////////////////////////////////////

				}
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		if (result == 0) {
			throw new RegistFailException("갤러리 등록에 실패하였습니다.");
		}
		if (result2 == 0) {
			throw new RegistFailException("사진 등록에 실패하였습니다.");
		}
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Transactional(value = "transactionManager") // @Annotaion 트랜잭션 처리
	public void delete(int gallery_id, String path) throws DeleteFailException {

		List imageList = gallery_imageDAO.select(gallery_id);
		int result = 0;// 업로드 파일 삭제 관련
		int result2 = 0;

		for (int i = 0; i < imageList.size(); i++) {
			Gallery_image image = (Gallery_image) imageList.get(i);
			String filename = image.getFilename();
			File file = new File(path + "/" + filename);

			if (file.delete()) {
				result = 1;
			} else {
				result = 0;
			}
		}
		if (result == 1) {
// 해당 글에 대한 이미지 삭제
			result2 = gallery_imageDAO.deleteAll(gallery_id);
		}

		int result1 = 0;
		List list = gallery_commentDAO.selectAll(gallery_id);
// 해당 글에 대한 댓글삭제
		if (list.size() != 0) {
			result1 = gallery_commentDAO.deleteAll(gallery_id);
		} else {
			result1 = 1;
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 해당 글 삭제
		int result3 = galleryDAO.delete(gallery_id);

		if (result == 0) {
			System.out.println("GalleryServiceImpl------업로드파일 삭제 실패.");
			throw new DeleteFailException("게시글을 삭제하는데 실패하였습니다.");
		}
		if (result1 == 0) {
			System.out.println("GalleryServiceImpl------댓글삭제 실패");
			throw new DeleteFailException("게시글을 삭제하는데 실패하였습니다.");
		}
		if (result2 == 0) {
			System.out.println("GalleryServiceImpl------이미지 삭제 실패");
			throw new DeleteFailException("게시글을 삭제하는데 실패하였습니다.");
		}
		if (result3 == 0) {
			System.out.println("GalleryServiceImpl------게시글 삭제 실패");
			throw new DeleteFailException("게시글을 삭제하는데 실패하였습니다.");
		}
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void updateHit(int gallery_id) {
		int result = galleryDAO.updateHit(gallery_id);
		if (result == 0) {
			throw new UpdateFailException("조회수 증가 실패");
		}
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 전체 게시물 목록 가져오기
	public List selectAll() throws SelectFailException {

		System.out.println("Service selectAll");
		List galleryList = galleryDAO.selectAll();
		System.out.println("Service DAO통과 ");

		if (galleryList == null) {
			throw new SelectFailException("전체 게시물 목록을 불러오는데 실패하였습니다.");
		}
		return galleryList;
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 이미지 파일이름 가져오기
	public List selectImage(int gallery_id) throws SelectFailException {

		List galleryImage = gallery_imageDAO.select(gallery_id);

		if (galleryImage == null) {
			throw new SelectFailException("해당 이미지를 불러오는데 실패하였습니다.");
		}

		return galleryImage;
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 해당 게시물 가져오기
	public Gallery select(int gallery_id) throws SelectFailException {
		Gallery gallery = galleryDAO.select(gallery_id);
		if (gallery == null) {
			throw new SelectFailException("해당 게시물을 가져오는데 실패하였습니다.");
		}
		return gallery;
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 전체 댓글을 가져온다
	public List selectComments(int gallery_id) {
		List gallery_comment = gallery_commentDAO.selectAll(gallery_id);
		System.out.println("Service selectComments" + gallery_id);
		if (gallery_comment == null) {
			throw new SelectFailException("해당 게시물의 댓글을 가져오는데 실패하였습니다.");
		}
		return gallery_comment;
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 댓글 등록
	public void insertConmments(Gallery_comment gallery_comment) {
		int result = gallery_commentDAO.insert(gallery_comment);
		if (result == 0) {
			throw new RegistFailException("댓글 등록 실패");
		}
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//댓글 수정
	public void updateComment(Gallery_comment gallery_comment) throws UpdateFailException {
		System.out.println("SERVICE / UPDATECOMMENT=" + gallery_comment.getContent());
		int result = gallery_commentDAO.update(gallery_comment);
		System.out.println("댓글 수정 update=" + result);

		if (result == 0) {
			throw new UpdateFailException("댓글 수정 실패하였습니다.");
		}
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//댓글 삭제
	public void deleteComment(int comment_id) throws DeleteFailException {
		int result = gallery_commentDAO.delete(comment_id);

		if (result == 0) {
			throw new DeleteFailException("댓글 삭제에 실패하였습니다.");
		}
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 게시물 수정
	@Transactional(value = "transactionManager") // @Annotaion 트랜잭션 처리
	public void update(Gallery gallery, Gallery_image gallery_image, String path) {

		System.out.println("Service//path = = =" + path);
		System.out.println("Service// myFile[]===" + gallery_image.getMyFile().length);
		System.out.println("//Service // gallery_id===" + gallery.getGallery_id());

		int deleteResult = 0; // 기존 파일 삭제할 경우 업로드된 파일 삭제
		int result1 = 0;// 기존 파일 삭제할 경우 DB에서 삭제
		int result2 = 0; // 새로 추가된 이미지 결과값
		int result3 = 0; // 기존 이미지 변경사항의 결과값.

		if (gallery_image.getDeleteFile() != null) {
			for (int k = 0; k < gallery_image.getDeleteFile().length; k++) {
				String delFile = gallery_image.getDeleteFile()[k];
				System.out.println("====GalleryService==== ");
				System.out.println("Service 삭제할 파일 명 ="+delFile);

				String delFile2 = fileManager.separateFile(gallery_image.getDeleteFile()[k]);
				File newFile = new File(path+"/"+delFile2);
				if (newFile.delete()) {
					System.out.println("delete 통과~!!");
					deleteResult = 1;
					gallery_image.setFilename(delFile2);
					result1 = gallery_imageDAO.deleteFile(gallery_image);
				} else {
					deleteResult = 0;
				}
			}
		}else {
			result1=1;
			
		}


// 새로 추가된 이미지 처리
		MultipartFile[] file = gallery_image.getMyFile();// 새로 선택한 파일 목록

		String[] filenameList = new String[file.length];// 기존에 있던 파일이름 담을 배열

		File originFile = null;// 파일 업로드를 위한 파일 생성

		if (file.length >= 1) {
			for (int i = 0; i < file.length; i++) {
				filenameList[i] = file[i].getOriginalFilename();

				originFile = new File(path + "/" + filenameList[i]);

				try {
					file[i].transferTo(originFile);
					String filename = fileManager.getFilename(originFile, path);

					if (filename != null) {
						gallery_image.setFilename(filename);
						gallery_image.setGallery(gallery);

						result2 = gallery_imageDAO.updateFile(gallery_image);
					}

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else {
			result2 = 1;
			System.out.println("GalleryServiceImpl / result2 ==" + result2);

		}

// 게시판 내용 변경 처리
		result3 = galleryDAO.update(gallery);

		System.out.println("Gallery-Service//게시물 수정에 대한 결과값은??" + result1);
		System.out.println("Gallery-Service//새로운 사진 추가에 대한 결과값은??" + result2);
		System.out.println("Gallery-Service//기존 사진 변경에 대한 결과값은??" + result3);

		if (result1 == 0) {
			throw new UpdateFailException("기존 게시물 수정에 실패하였습니다.");
		}
		if (result2 == 0) {
			throw new RegistFailException("새로운 사진 추가에 실패하였습니다.");
		}
		if (result3 == 0) {
			throw new UpdateFailException("기존 사진 변경에 실패하였습니다.");
		}

	}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// 게시판 index.jsp 검색처리 
	public List search(String searchType, String searchText) throws SelectFailException {
		List galleryList = new ArrayList();

		List memberList = new ArrayList();// 작성자 검색

		System.out.println("GalleryService / search / index =" + searchType + "/ data=" + searchText);

		if (searchType.equals("1")) {
			System.out.println("전체 검색");
			galleryList = galleryDAO.selectAll();

		} else if (searchType.equals("2")) {
			System.out.println("글제목 검색");
			galleryList = galleryDAO.searchTitle(searchText);

		} else if (searchType.equals("3")) {
			System.out.println("작성자 검색");
			memberList = bulletinMemberDAO.selectMember(searchText);

			for (int i = 0; i < memberList.size(); i++) {
				BulletinMember one = (BulletinMember) memberList.get(i);
				Gallery gallery = new Gallery();
				gallery.setMember(one);

				galleryList = galleryDAO.searchWriter(gallery);
			}
			System.out.println("Gallery Service/ 최종 /galleryList.size==" + galleryList.size());
		}

		if (galleryList == null) {
			throw new SelectFailException("검색을 다시 시도해주세요.");
		}
		return galleryList;
	}

//메인페이지
	public List mainSelectAll() {

		List galleryList = galleryDAO.mainSelectAll();

		return galleryList;
	}

	public Gallery_image getGallery_id(int gallery_image_id) throws SelectFailException {

		Gallery_image gallery_image = gallery_imageDAO.getGallery_id(gallery_image_id);
		if (gallery_image == null) {
			throw new SelectFailException("메인 화면에 이미지를 불러오는데 실패하였습니다.");
		}
		return gallery_image;
	}
}
