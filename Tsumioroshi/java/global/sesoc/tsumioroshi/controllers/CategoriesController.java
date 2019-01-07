package global.sesoc.tsumioroshi.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.CategoriesRepository;
import global.sesoc.tsumioroshi.util.HexConverter;
import global.sesoc.tsumioroshi.vo.FirstCategory;
import global.sesoc.tsumioroshi.vo.SecondCategory;

@Controller
public class CategoriesController { 
	@Autowired
	CategoriesRepository repository;

	HexConverter converter = new HexConverter();

	@RequestMapping(value = "categories", method = RequestMethod.GET)
	public String categoriesMenu() {

		return "category/createCategory";
	}

	@RequestMapping(value = "selectAllFirst", method = RequestMethod.POST)
	public @ResponseBody List<FirstCategory> selectAllFirst() {
		List<FirstCategory> list = repository.selectAllFirst();

		return list;
	}

	@RequestMapping(value = "selectByNameFirst", method = RequestMethod.POST)
	public @ResponseBody FirstCategory selectByNameFirst(FirstCategory first) {
		FirstCategory result = repository.selectByNameFirst(first);

		return result;
	}

	@RequestMapping(value = "createFirst", method = RequestMethod.POST)
	public @ResponseBody int createFirst(FirstCategory first) {
		FirstCategory firstResult = repository.selectLastFirst();
		if (firstResult == null) {
			first.setFc_code("0000");
		} else {
			String lastcode = converter.hexToDec(firstResult.getFc_code());
			String nextcode = converter.decToHex(converter.codeAdder(lastcode));
			first.setFc_code(nextcode);
		}
		int result = repository.insertFirst(first);

		return result;
	}
	
	@RequestMapping(value = "selectByNameSecond", method = RequestMethod.POST)
	public @ResponseBody SecondCategory selectByNameSecond(SecondCategory second) {
		SecondCategory result = repository.selectByNameSecond(second);

		return result;
	}
	
	@RequestMapping(value = "createSecond", method = RequestMethod.POST)
	public @ResponseBody int createSecond(SecondCategory second) {
		SecondCategory secondResult = repository.selectLastSecond(second);
		if (secondResult == null) {
			second.setSc_code("0000");
		} else {
			String lastcode = converter.hexToDec(secondResult.getSc_code());
			String nextcode = converter.decToHex(converter.codeAdder(lastcode));
			second.setSc_code(nextcode);
		}
		int result = repository.insertSecond(second);

		return result;
	}
	
	@RequestMapping(value = "selectSecond", method = RequestMethod.POST)
	public @ResponseBody List<SecondCategory> selectSecond() {
		List<SecondCategory> list = repository.selectSecond();

		return list;
	}
	
	@RequestMapping(value = "selectByFcCodeSecond", method = RequestMethod.POST)
	public @ResponseBody List<SecondCategory> selectByFcCodeSecond(SecondCategory second){
		List<SecondCategory> list = repository.selectByFcCodeSecond(second);
		
		
		return list;
	}
	
	@RequestMapping(value="deleteFirst", method=RequestMethod.POST)
	public @ResponseBody int deleteFirst(FirstCategory first) {
		//int init = repository.initSecond(first);
		
		int result = repository.deleteFirst(first);
		
		return result;
	}
	
	@RequestMapping(value="deleteSecond", method=RequestMethod.POST)
	public @ResponseBody int deleteSecond(SecondCategory second) {
		int result = repository.deleteSecond(second);
		
		return result;
	}
	
	@RequestMapping(value="getCategory", method=RequestMethod.POST)
	public @ResponseBody List<String> getCategory(String number){
		String firstCode = number.substring(0, 4);
		String secondCode = number.substring(4, 8);
		Map<String, String> map = new HashMap<>();
		map.put("fc_code", firstCode);
		map.put("sc_code", secondCode);
		String first = repository.selectByCodeFirst(firstCode);
		System.out.println("First , " + first);
		String second = repository.selectByCodeSecond(map);
		
		List<String> list = new ArrayList<String>();
		list.add(first);
		list.add(second);
		
		return list;
	}
}
