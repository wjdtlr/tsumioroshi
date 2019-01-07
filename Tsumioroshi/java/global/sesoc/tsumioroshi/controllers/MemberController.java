package global.sesoc.tsumioroshi.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.MemberRepositoy;
import global.sesoc.tsumioroshi.vo.Members;

@Controller
public class MemberController {

	@Autowired
	MemberRepositoy repository;
	
	@RequestMapping(value="memberMenu", method=RequestMethod.GET)
	public String membermenu() {
		
		return "member/memberMenu";
	}
	
	@RequestMapping(value="selectAllMembers", method=RequestMethod.POST)
	public @ResponseBody List<Members> selectAllMembers(Members member){
		List<Members> list = repository.selectAllMembers(member);
		
		return list;
	}
	
	@RequestMapping(value="listOffice", method=RequestMethod.POST)
	public @ResponseBody List<Members> listOffice(){
		List<Members> list = repository.listOffice();
		
		return list;
	}
	
	@RequestMapping(value="listWareHouse", method=RequestMethod.POST)
	public @ResponseBody List<Members> listWareHouse(){
		List<Members> list = repository.listWareHouse();
		
		return list;
	}
	
	@RequestMapping(value="deleteMember", method=RequestMethod.POST)
	public @ResponseBody int deleteMember(Members member){
		int result = repository.deleteMember(member);
		
		return result;
	}
	
	@RequestMapping(value="insertMember", method=RequestMethod.GET)
	public String insertMember() {
		
		return "member/insertMember";
	}
	
	@RequestMapping(value="insertMember", method=RequestMethod.POST)
	public @ResponseBody int insertMember(Members member) {
		int result = repository.insertMember(member);
		System.out.println(member);
		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public @ResponseBody String idCheck(Members member) {
		Members check = repository.idCheck(member);
		String result ="";
		if(check == null) {
			result = "true";
			
			return result;
		}else {
			result = "false";
			
			return result;
		}
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Members members, Model model, HttpServletResponse response, HttpSession session) {
		Members m = repository.login(members);
		System.out.println(m);
		if(m != null)
		{
			session.setAttribute("loginId", m.getId());
			session.setAttribute("loginPwd", m.getPassword());
			session.setAttribute("authority",m.getAuthority());
			
		}
		else
		{
			model.addAttribute("message", "아이디나 비밀번호가 일치 하지 않습니다.");
			return "login";
		}
		return "main";
		
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session)
	{
		session.invalidate();
		return"redirect:/";
	}
}
