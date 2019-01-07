package global.sesoc.tsumioroshi.controllers;

import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.tsumioroshi.vo.Members;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "login";
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main() {
		
		return "main";
		
	}
	
	@RequestMapping(value="/WareHouse", method=RequestMethod.GET)
	public String WareHouse() {
		
		return "souji/WareHouse";
		
	}
	
	@RequestMapping(value="/WareHouseView", method=RequestMethod.GET)
	public String View() {
		
		return "souji/WareHouseView";
		
	}
	
}
