package global.sesoc.tsumioroshi.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.tsumioroshi.dao.LogRepository;
import global.sesoc.tsumioroshi.dao.ProductRepository;
import global.sesoc.tsumioroshi.serial.MySerial;
import global.sesoc.tsumioroshi.vo.Product;
import global.sesoc.tsumioroshi.vo.Release_Log;
import global.sesoc.tsumioroshi.vo.Stock_Log;

@Controller
public class ProductController {
	MySerial serial =null;
	
	private boolean serialSw = false;

	@Autowired
	ProductRepository p_Repository;

	@Autowired
	LogRepository l_Repository;

	@ResponseBody
	@RequestMapping(value = "/release_Log_Form_2", method = RequestMethod.POST)
	public int release_Log_Form_2(String data, HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");
		String data2 = "{\"data\":" + data + "}";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("charge2", loginId);

		int result = 0;
		int result2 = 0;

		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(data2);
			JSONArray productArray = (JSONArray) jsonObject.get("data");

			JSONObject obj = (JSONObject) productArray.get(0);

			for (int i = 0; i < productArray.size(); i++) {
				Product product = new Product();
				JSONObject tempObj = (JSONObject) productArray.get(i);
				System.out.println(tempObj);
				product.setProduct_Name((String) tempObj.get("product_name"));
				product.setProduct_Number((String) tempObj.get("product_number"));
				product.setTag_Number((String) tempObj.get("tag_number"));
				product.setExpiration_Date((String) tempObj.get("expiration_date"));
				product.setProduct_Location((String) tempObj.get("product_location"));
				result += p_Repository.insert_Release_Log_Form_2(product);
				if (result == productArray.size()) {
					map.put("order_Number", (String) tempObj.get("order_number"));
					System.out.println(map);
					result2 = l_Repository.update_Release_Log_Charge2(map);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		/*
		 * List<Product> products = (List<Product>) sendData.get("form_data");
		 * System.out.println(products); for(int i=0; i<products.size();i++) { int
		 * result = p_Repository.insert_Release_Log_Form_2(products.get(i));
		 * 
		 * }
		 * 
		 * Map<String, Object> update_Map = new HashMap<>(); int
		 * order_Number=Integer.parseInt((String)sendData.get("order_Number"));
		 * update_Map.put("order_Number", order_Number); update_Map.put("charge2",
		 * loginId);
		 * 
		 * int result= l_Repository.update_Release_Log_Charge2(update_Map);
		 */
		System.out.println(result2);
		return result2;
	}

	@ResponseBody
	@RequestMapping(value = "/stock_Log_Form_2", method = RequestMethod.POST)
	public int stock_Log_Form_2(String data, HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("charge2", loginId);

		String data2 = "{\"data\":" + data + "}";

		int result = 0;
		int result2 = 0;
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(data2);
			JSONArray productArray = (JSONArray) jsonObject.get("data");

			JSONObject obj = (JSONObject) productArray.get(0);
			map.put("order_Number", (String) obj.get("order_number"));

			for (int i = 0; i < productArray.size(); i++) {
				Product product = new Product();
				JSONObject tempObj = (JSONObject) productArray.get(i);
				product.setProduct_Name((String) tempObj.get("product_name"));
				product.setProduct_Number((String) tempObj.get("product_number"));
				product.setTag_Number((String) tempObj.get("tag_number"));
				product.setExpiration_Date((String) tempObj.get("expiration_date"));
				product.setProduct_Location((String) tempObj.get("product_location"));
				result += p_Repository.insert_Stock_Log_Form_2(product);
			}

			if (result == productArray.size()) {
				result2 = l_Repository.update_Stock_Log_Charge2(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(result2);
		return result2;
	}

	@RequestMapping(value = "/release_Log_Form_2", method = RequestMethod.GET)
	public String open_release_Log_Form_2(String order_Number, Model model) {

		Release_Log r_Log = l_Repository.select_Release_Log_By_Num(Integer.parseInt(order_Number));
		model.addAttribute("r_Log", r_Log);

		return "log/release_Log_Form_2";
	}

	// 占쎌뿯�⑨옙 疫꿸퀡以� 占쎌삂占쎄쉐占쎈뻻 占쎌뵠占쎌읈 嚥≪뮄�젃 占쎈쑓占쎌뵠占쎄숲 �겫�뜄�쑎占쎌긾
	@RequestMapping(value = "/stock_Log_Form_2", method = RequestMethod.GET)
	public String open_Stock_Log_Form_2(@RequestParam(value = "order_Number") int order_Number, Model model) {

		Stock_Log s_Log = l_Repository.select_Stock_Log_By_Num(order_Number);
		model.addAttribute("s_Log", s_Log);

		return "log/stock_Log_Form_2";
	}

	@ResponseBody
	@RequestMapping(value = "/insert_Tag_Number", method = RequestMethod.POST)
	public Map<String, Object> insert_Tag_Number() throws InterruptedException {
		Map<String, Object> return_Map = new HashMap<String, Object>();
		System.out.println("OK");
		if (Thread.getAllStackTraces().keySet().toString().contains("mySerial")) {
			System.out.println("OK2");
			return_Map.put("message", " 占쎌뵠沃섓옙 占쎈쾻嚥≪빘夷뤄옙�뵥 占쎌삂占쎈씜占쎌뵠 占쎌뿳占쎈뮸占쎈빍占쎈뼄.");
			return return_Map;
		}
		// String tag_Number="";
		MySerial serial = new MySerial();
		if (!serial.setMyPort()) {
			return_Map.put("message", "疫꿸퀗由� 占쎈염野껉퀣�뱽 占쎌넇占쎌뵥占쎈퉸 雅뚯눘苑�占쎌뒄.");
			return return_Map;
		}
		serial.openMyPort();
		for (int i = 0; i < 5; i++) {
			Thread.sleep(1000);
			System.out.println(i);
		}
		serial.start();
		while (true) {
			if (!serial.getFinal_RxData().equals("")) {
				// tag_Number=serial.getFinal_RxData();
				return_Map.put("tag_Number", serial.getFinal_RxData());
				break;
			}
		}

		serial.sendCL();

		return return_Map;

	}

	@ResponseBody
	@RequestMapping(value = "/plus_value", method = RequestMethod.POST)
	public List<Product> plus_Selectbox(String product_Number) {

		List<Product> p_list = p_Repository.select_Every_Product_By_Num(product_Number);
		System.out.println(product_Number);
		System.out.println(p_list);

		return p_list;
	}

	@RequestMapping(value = "/select_Every_Product", method = RequestMethod.GET)
	public String open_select_Every_Product() {

		return "log/select_Every_Product";
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public void name(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/event-stream");
		response.setCharacterEncoding("UTF-8");
		PrintWriter printwriter = null;
		while (true) {
			try {
				double randomNumber = Math.random() * 10000;
				printwriter = response.getWriter();
				printwriter.print(
						"data: [next server time check event in" + Math.round(randomNumber / 1000) + " seconds]\n");
				printwriter.print("data: Time: " + Calendar.getInstance().getTime() + "\n\n");
				response.flushBuffer();

				Thread.sleep((long) randomNumber);
			} catch (InterruptedException e) {
				printwriter.close();
				e.printStackTrace();
			}
		}
		// return "home";
	}

	@RequestMapping(value = "productCheck", method = RequestMethod.POST)
	public @ResponseBody List<Product> productCheck(Product product) {
		List<Product> list = p_Repository.productCheck(product);

		return list;
	}

	@RequestMapping(value = "selectProductByName", method = RequestMethod.POST)
	public @ResponseBody List<Product> selctProductByName(Product product) {
		List<Product> list = p_Repository.selectProductByName(product);

		System.out.println(list);
		return list;
	}

	@RequestMapping(value = "releaseRaedyProduct", method = RequestMethod.POST)
	public @ResponseBody int releaseRaedyProduct(String number) {
		int result = p_Repository.releaseRaedyProduct(number);

		return result;
	}

	@RequestMapping(value = "viewShelf", method = RequestMethod.POST)
	public @ResponseBody List<Product> viewShelf(String shelf) {
		List<Product> list = p_Repository.viewShelf(shelf);

		return list;

	}

	@RequestMapping(value = "searchProductName", method = RequestMethod.POST)
	public @ResponseBody List<Product> searchProductName(String pname, String date) {
		System.out.println(pname + " , " + date);
		Map<String, String> map = new HashMap<String, String>();
		map.put("pname", pname);
		if (date.length() != 0) {
			map.put("date", date.substring(2, 10).replace("-", "/"));
		} else {
			map.put("date", date);
		}
		List<Product> list = p_Repository.searchProductName(map);

		return list;
	}

	@RequestMapping(value = "searchProductNumber", method = RequestMethod.POST)
	public @ResponseBody List<Product> searchProductNumber(String pnumber) {
		List<Product> list = p_Repository.searchProductNumber(pnumber);

		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/stream_Stop", method = RequestMethod.POST)
	public String stream_Stop() {
		serialSw = true;
		return "";
	}

	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public String open_Excel() {
		return "excel";
	}

	@ResponseBody
	@RequestMapping(value = "/excel", method = RequestMethod.POST)
	public String Excel() {
		
		Date now = new Date();		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		List<Product> products = p_Repository.select_Product_By_Name();
		System.out.println("1. " + products);

		if (products != null) {
			Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 �뜝�럩逾졾뜝�럡留�
			Sheet sheet1 = xlsxWb.createSheet("firstSheet");

			// 占쎈쉸�맩�뱿 �뜝�럡�꼸占쎈쑏�뜝占� �뜝�럡�맟�뜝�럩�젧
			sheet1.setColumnWidth(0, 10000);
			sheet1.setColumnWidth(9, 10000);
			// *** Style--------------------------------------------------
			// Cell �뜝�럥裕욃뜝�룞�삕�뜝�럩逾� �뜝�럡臾멨뜝�럡�뎽
			CellStyle cellStyle = xlsxWb.createCellStyle();

			// 繞벿우삕 �뛾�룆�뼺占쎈구
			cellStyle.setWrapText(true);

			// Cell �뜝�럡�돰濚밸㉡�삕, 占쎈닱占쏙옙占쎈�� 嶺뚳옙熬곣뫗�뮡�뼨�먯삕
			// cellStyle.setFillForegroundColor(HSSFColor.LIME.index);
			// cellStyle.setFillPattern(CellStyle.BIG_SPOTS);

			Row row = null;
			Cell cell = null;

			row = sheet1.createRow(0);
			cell = row.createCell(0);
			cell.setCellValue("product_Name");
			cell = row.createCell(1);
			cell.setCellValue("product_Number");
			cell = row.createCell(2);
			cell.setCellValue("stock_Amount");
			cell = row.createCell(3);
			cell.setCellValue("Product_Location");
			cell = row.createCell(4);
			cell.setCellValue("Stock_Date");
			cell = row.createCell(5);
			cell.setCellValue("Expiration_Date");
			System.out.println(products);
			for (int i = 0; i < products.size(); i++) {
				row = sheet1.createRow(i + 1);
				cell = row.createCell(0);
				cell.setCellValue(products.get(i).getProduct_Name());
				cell = row.createCell(1);
				cell.setCellValue(products.get(i).getProduct_Number());
				cell = row.createCell(2);
				cell.setCellValue(products.get(i).getQuantity());
				cell = row.createCell(3);
				cell.setCellValue(products.get(i).getProduct_Location());
				cell = row.createCell(4);
				cell.setCellValue(products.get(i).getStock_Date());
				cell = row.createCell(5);
				cell.setCellValue(products.get(i).getExpiration_Date());
			}
			try {
				File xlsFile = new File("D:/在庫情報_"+sdf.format(now)+".xlsx");
				FileOutputStream fileOut = new FileOutputStream(xlsFile);
				xlsxWb.write(fileOut);
				xlsxWb.close();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "OK";
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String open_Search() {
		return "search";
	}

	@ResponseBody
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Map<String, Object> search(@RequestBody Map<String, String> map) {
		System.out.println(map);
		Map<String, Object> result_Map = new HashMap<String, Object>();
		switch (map.get("category")) {
		case "Product":
			List<Product> products = p_Repository.select_Product_By_Name2(map);
			result_Map.put("products", products);

			break;
		case "Stock_Log":
			List<Stock_Log> stock_Logs = l_Repository.search_Stock_Log(map);
			result_Map.put("stock_Logs", stock_Logs);

			break;
		case "Release_Log":
			List<Release_Log> release_Logs = l_Repository.search_Release_Log(map);
			result_Map.put("release_Logs", release_Logs);

			break;
		}
		System.out.println(result_Map);
		return result_Map;
	}
	
	
	@ResponseBody
	   @RequestMapping(value = "/search_Start", method = RequestMethod.POST)
	   public Map<String, Object> search_Start(){
	      
	      Map<String, Object> result_Map=new HashMap<>();
	      
	      if(serial !=null) {
	         result_Map.put("msg", "이미 등록중인 작업이 있습니다.");
	         return result_Map;
	      }
	      
	      if(Thread.getAllStackTraces().keySet().toString().contains("mySerial")) {
	         System.out.println("OK2");
	         result_Map.put("msg", "이미 등록중인 작업이 있습니다.");
	         return result_Map;
	      }
	      //String tag_Number="";
	      
	      serial=new MySerial();
	      System.out.println("name3");
	      if(!serial.setMyPort()){
	         result_Map.put("msg", "기기 연결을 확인해 주세요.");
	         return result_Map;
	      }
	      System.out.println("name4");
	      serial.openMyPort();
	      System.out.println("name5");
	      serial.start();
	      serial.setFinalTime((System.currentTimeMillis()/1000+1000));
	      return result_Map;
	   }
	   
	   @ResponseBody
	   @RequestMapping(value = "/search_Check", method = RequestMethod.POST)
	   public Map<String, Object> search_Check(){
	      if(serial == null) return null;
	      Map<String, Object> result_Map=new HashMap<>();
	      serial.setFinalTime((System.currentTimeMillis()/1000+10));
	      if(!serial.getFinal_RxData().equals("")) {
	         String tag_Number=serial.getFinal_RxData();
	         List<Product> product = p_Repository.select_Product_By_Tag(tag_Number);
	         System.out.println(product);
	         if(product==null) {
	            result_Map.put("msg", "해당 태그에 일치하는 물건이 없습니다.");
	            serial.setFinal_RxData("");
	            return result_Map;
	         }else {
	            result_Map.put("product", product);
	            serial.setFinal_RxData("");
	            return result_Map;
	         }
	      }   
	      return result_Map;
	   }
	   
	   
	   
	   @ResponseBody
	   @RequestMapping(value = "/search_Stop", method = RequestMethod.POST)
	   public Map<String, Object> sreach_Stop() {
	      Map<String, Object> result_Map=new HashMap<>();
	      System.out.println("name9");
	      serial.sendCL();
	      System.out.println("name10");
	      serial=null;
	      //return "home";
	      result_Map.put("msg", "조회를 중지합니다.");
	      return result_Map;
	   }
}