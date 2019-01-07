package global.sesoc.tsumioroshi.controllers;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.CategoriesRepository;
import global.sesoc.tsumioroshi.dao.LogRepository;
import global.sesoc.tsumioroshi.dao.ProductRepository;
import global.sesoc.tsumioroshi.util.HexConverter;
import global.sesoc.tsumioroshi.vo.Release_Log;
import global.sesoc.tsumioroshi.vo.Stock_Log;

@Controller
public class LogController {
	
	@Autowired
	LogRepository l_Repository;
	HexConverter hexc = new HexConverter(); 
	
	@Autowired
	CategoriesRepository c_Repository;
	
	@RequestMapping(value = "/release_Log_Form_1", method = RequestMethod.GET)
	public String release_Log() {		
		return "log/release_Log_Form_1";
	}
	
	@RequestMapping(value = "/stock_Log_Form_1", method = RequestMethod.GET)
	public String stock_Log() {		
		return "log/stock_Log_Form_1";
	}
	
	@ResponseBody
	@RequestMapping(value="release_Log_Form_1", method=RequestMethod.POST)
	public String insert_Release_Log_1(@RequestBody Release_Log log, Model model) {
		int result = l_Repository.insert_Release_Log_1(log);
		
		return result+"";
	}
	
	@ResponseBody
	@RequestMapping(value="/stock_Log_Form_1", method=RequestMethod.POST)
	public String insert_Stock_Log_1(@RequestBody Stock_Log log, Model model) {
		
		List<Stock_Log> list1 = l_Repository.searchStockByName(log.getProduct_Name());
		if(list1.size() != 0) {
			log.setProduct_Number(list1.get(0).getProduct_Number());
		}else {
			List<Stock_Log> list2 = l_Repository.lastStockNumber(log.getProduct_Number());
			String num;
			String addnum;
			String nextnum;
			if(list2.size() != 0) {
				num =  list2.get(0).getProduct_Number().substring(8, 12);
				System.out.println(num);
				addnum = hexc.codeAdder(num);
				System.out.println(addnum);
				nextnum = hexc.decToHex(addnum);
				String pnum = log.getProduct_Number() + nextnum;
				System.out.println(pnum);
				log.setProduct_Number(pnum);
			}else {
				String pnum = log.getProduct_Number() + "0000";
				log.setProduct_Number(pnum);
			}
		}
		
		int result = l_Repository.insert_Stock_Log_1(log);
		
		return result+"";
	}
	
	@RequestMapping(value="/select_Every_Release_Log", method=RequestMethod.GET)
	public String open_Select_Every_Release_Log() {
		
		return "log/select_Every_Release_Log";
	}
	
	@RequestMapping(value="select_Every_Stock_Log", method=RequestMethod.GET)
	public String open_Select_Every_Stock_Log() {
		
		return "log/select_Every_Stock_Log";
	}
	
	@RequestMapping(value = "/select_Release_Log_By_Num", method = RequestMethod.GET)
	public String select_Release_Log_By_Num(int order_Number, Model model) {
		
		Release_Log r_Log = l_Repository.select_Release_Log_By_Num(order_Number);		
		model.addAttribute("r_Log", r_Log);
		
		return "log/select_Release_Log";
	}
	
	@RequestMapping(value = "/select_Stock_Log_By_Num", method = RequestMethod.GET)
	public String select_Stock_Log_By_Num(int order_Number, Model model) {
		
		Stock_Log s_Log = l_Repository.select_Stock_Log_By_Num(order_Number);		
		model.addAttribute("s_Log", s_Log);
		
		return "log/select_Stock_Log";
	}
	
	@RequestMapping(value = "/select_Release_Log", method = RequestMethod.GET)
	public String select_Release_Log_By_P_Num() {
		
		return "log/select_Release_Log";
	}
	
	@RequestMapping(value = "/select_Stock_Log", method = RequestMethod.GET)
	public String select_Stock_Log_By_P_Num() {
		
		return "log/select_Stock_Log";
	}
	
	@ResponseBody
	@RequestMapping(value="/select_Every_Release_Log", method=RequestMethod.POST)//here
	public List<Release_Log> select_Every_Release_Log() {
		
		List<Release_Log> list = l_Repository.select_Every_Release_Log();
		

		return list;
	}
	@ResponseBody
	@RequestMapping(value="/select_Every_Stock_Log", method=RequestMethod.POST)//here
	public List<Stock_Log> select_Every_Stock_Log() {
		
		List<Stock_Log> list = l_Repository.select_Every_Stock_Log();
		
		return list;
	}
	
	@RequestMapping(value="checkpro", method=RequestMethod.GET)
	public String checkpro() {
		
		return "log/checkpro";
	}
}
