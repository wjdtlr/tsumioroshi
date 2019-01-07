package global.sesoc.tsumioroshi.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.MessageRepository;
import global.sesoc.tsumioroshi.util.CalPages;
import global.sesoc.tsumioroshi.vo.Message;

@Controller
public class MessageController {
	
	@Autowired
	MessageRepository repository;
	
	CalPages calpages = new CalPages();
	
	@RequestMapping(value="listMessage", method=RequestMethod.GET)
	public String listMessage() {
		
		return "message/listMessage";
	}

	@RequestMapping(value="selectTen", method=RequestMethod.POST)
	public @ResponseBody List<Message> selectTenToAll(int currPage, String userto, String id){
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		map1.put("userto", userto);
		map1.put("id", id);
		
		
		int pages = repository.pageCount(map1);
		
		int totalPage = calpages.CalTotalPage(pages);
		
		Map<String, Object> map2 = calpages.CalStartEnd(currPage, totalPage, pages);
		map2.put("userto", userto);
		map2.put("id", id);
		
		
		List<Message> list = repository.selectTen(map2);
		
		
		
		return list;
	}
	
	@RequestMapping(value="pageCount", method=RequestMethod.POST)
	public @ResponseBody int pageCount(String userto, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userto", userto);
		map.put("id", id);
		
		
		
		int pages = repository.pageCount(map);
		
		
		int totalPage = calpages.CalTotalPage(pages);
		
		return totalPage;
	}
	
	@RequestMapping(value="insertMessage", method=RequestMethod.GET)
	public String insertMessage() {
		
		return "message/insertMessage";
	}
	
	@RequestMapping(value="insertMessage", method=RequestMethod.POST)
	public @ResponseBody int insertMessage(Message message){
		int result = repository.insertMessage(message);
		
		return result;
	}
	
	@RequestMapping(value="detailMessage", method=RequestMethod.GET)
	public String detailMessage(@RequestParam(value="mno") int mno) {
		
		
		return "message/detailMessage";
	}
	
	@RequestMapping(value="detailMessage", method = RequestMethod.POST)
	public @ResponseBody Message detailMessage(String message_no) {
		Message message = repository.selectOne(message_no);
		System.out.println(message);
		return message;
	}
	
	@RequestMapping(value="updateMessage", method=RequestMethod.GET)
	public String updateMessage(@RequestParam(value="mno") int mno) {
		 
		return "message/updateMessage";
	}
	
	@RequestMapping(value="updateMessage", method=RequestMethod.POST)
	public @ResponseBody int updateMessage(Message message) {
		int result = repository.updateMessage(message);
		
		return result;
		
	}
	
	@RequestMapping(value="deleteMessage", method=RequestMethod.GET)
	public String deleteMessage(@RequestParam(value="mno")int mno) {
		int result = repository.deleteMessage(mno);
		
		return "message/listMessage";
	}
	
	@RequestMapping(value="confirmMessage", method=RequestMethod.GET)
	public String confirmMessage(@RequestParam(value="mno")int mno) {
		
		return "message/confirmMessage";
	}
	
	@RequestMapping(value="confirmMessage", method=RequestMethod.POST)
	public @ResponseBody int confirmMessage(Message message) {
		System.out.println(message);
		int result = repository.confirmMessage(message);
		
		return result;
	}
	
}
