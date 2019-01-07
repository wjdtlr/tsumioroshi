package global.sesoc.tsumioroshi.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.ProductRepository;
import global.sesoc.tsumioroshi.dao.ShelfRepository;
import global.sesoc.tsumioroshi.vo.Product;
import global.sesoc.tsumioroshi.vo.Shelf;

@Controller
public class ShelfController {
	
	@Autowired
	ShelfRepository s_Repository;
	
	@Autowired
	ProductRepository p_Repository;

	
	// 占쏙옙占쏙옙 占싹놂옙 占쏙옙회 + 占쌔댐옙 占쏙옙占쌥울옙 占쌍댐옙 占쏙옙품占쏙옙 占쏙옙회
	@RequestMapping(value = "/select_Shelf", method = RequestMethod.GET)
	public String select_Shelf(String shelf_Name, Model model) {
		
		Shelf shelf = s_Repository.select_Shelf(shelf_Name);		
		model.addAttribute("shelf", shelf);
		
		List<Product> list = p_Repository.select_Shelf_Product(shelf_Name);
		model.addAttribute("list", list);
		
		return "shelf/select_Shelf";
	}
	
	// 占쏙옙占� 占쏙옙占쏙옙 占쏙옙회
	@RequestMapping(value="/select_Every_Shelves", method=RequestMethod.GET)
	public String select_Every_Shelves(Model model) {
		
		List<Shelf> list = s_Repository.select_Every_Shelves();
		
		model.addAttribute("list", list);
		
		return "shelf/select_Every_Shelves";
	}
	
	@RequestMapping(value="/select_Every_Shelves", method=RequestMethod.POST)
	public @ResponseBody List<Shelf> select_Every_Shelves() {
		
		List<Shelf> list = s_Repository.select_Every_Shelves();
		
		return list;
	}
	
	@RequestMapping(value="selectAllShelves", method=RequestMethod.POST)
	public @ResponseBody List<Shelf> selectAll() {
		
		List<Shelf> list = s_Repository.select_Every_Shelves();
		
		return list;
	}
	
	
	@RequestMapping(value="selectShelf", method=RequestMethod.POST)
	public @ResponseBody int selectShelf(String shelf_Name) {
		Shelf result = s_Repository.select_Shelf(shelf_Name);
		
		if(result == null) {
			return 0;
		}else {
			return 1;
		}
	}
	
	
	@RequestMapping(value="insertSelves", method=RequestMethod.POST)
	public @ResponseBody int insertSelves(Shelf shelf) {
		
		int result = s_Repository.insertSelves(shelf);
		
		return result;
	}
	
	@RequestMapping(value="updateShelves", method=RequestMethod.POST)
	public @ResponseBody int updateShelves(String data) {
		
		String data2 = "{\"data\":"+data+"}";
		int result = 0;
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(data2);
			JSONArray shelfArray = (JSONArray) jsonObject.get("data");
			
			for(int i=0; i<shelfArray.size(); i++) {
				Shelf shelf = new Shelf();
				JSONObject tempObj = (JSONObject) shelfArray.get(i);
				shelf.setShelf_Name((String)tempObj.get("shelf_Name"));
				shelf.setShelf_Size((String)tempObj.get("shelf_Size"));
				shelf.setShelf_Location((String)tempObj.get("shelf_Location"));
				shelf.setShelf_Condition((String)tempObj.get("shelf_Condition"));
				/*String name = tempObj.get("shelf_Name");*/
				
				result = s_Repository.updateShelves(shelf);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	@RequestMapping(value="deleteBox", method=RequestMethod.POST)
	public @ResponseBody int deleteBox(String shelfname) {
		int result = s_Repository.deleteBox(shelfname);
		
		return result;
	}
}
