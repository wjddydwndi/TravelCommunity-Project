/*
 * package com.tour.bulletin.controller;
 * 
 * import java.util.List;
 * 
 * import javax.servlet.http.HttpServletRequest;
 * 
 * import org.json.simple.JSONObject; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.beans.factory.annotation.Qualifier; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.ResponseBody; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * import com.tour.common.board.Pager; import
 * com.tour.model.bulletin.domain.BulletinComment; import
 * com.tour.model.bulletin.service.BulletinBoardService; import
 * com.tour.model.bulletin.service.BulletinCommentService;
 * 
 * @RestController public class RestBulletinBoardController {
 * 
 * @Autowired
 * 
 * @Qualifier("bulletinBoardServiceImpl") private BulletinBoardService
 * bulletinBoardService;
 * 
 * @Autowired
 * 
 * @Qualifier("bulletinCommentServiceImpl") private BulletinCommentService
 * bulletinCommentService; //
 * -----------------------------------------boardComment------------------------
 * -----------------------------
 * 
 * @RequestMapping(value = "/bulletinComments", method = RequestMethod.GET)
 * public List commentSelectAll() { List<BulletinComment> list =
 * bulletinCommentService.selectAll(); //
 * System.out.println(list.get(0).getBulletin_comment_id()); return list; }
 * 
 * @RequestMapping(value = "/bulletinComments/{bulletin_board_id}", method =
 * RequestMethod.GET) public JSONObject
 * commentSelectAllByBoardId(@PathVariable("bulletin_board_id") int
 * bulletin_board_id, HttpServletRequest request) { List<BulletinComment> list =
 * bulletinCommentService.selectByBoard(bulletin_board_id); Pager pager = new
 * Pager(); pager.init(request, list.size()); JSONObject jsonObject =new
 * JSONObject(); jsonObject.put("list", list); jsonObject.put("pager", pager);
 * return jsonObject; }
 * 
 * @RequestMapping(value = "/bulletinComments", method = RequestMethod.PUT)
 * public String commentUpdate(BulletinComment bulletinComment) { //
 * System.out.println(11); bulletinCommentService.update(bulletinComment);
 * JSONObject jsonObject = new JSONObject(); jsonObject.put("resultCode", 1);
 * return jsonObject.toString(); }
 * 
 * @RequestMapping(value = "/bulletinComments", method = RequestMethod.POST)
 * public String commentInsert(BulletinComment bulletinComment) {
 * bulletinCommentService.insert(bulletinComment); JSONObject jsonObject = new
 * JSONObject(); jsonObject.put("resultCode", 1); return jsonObject.toString();
 * 
 * }
 * 
 * @RequestMapping(value = "/bulletinComments/{bulletin_comment_id}", method =
 * RequestMethod.DELETE) public String
 * commentDelete(@PathVariable("bulletin_comment_id") int bulletin_comment_id) {
 * bulletinCommentService.delete(bulletin_comment_id); JSONObject jsonObject =
 * new JSONObject(); jsonObject.put("resultCode", 1); return
 * jsonObject.toString();
 * 
 * }
 * 
 * }
 */