package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tsumioroshi.vo.Release_Log;
import global.sesoc.tsumioroshi.vo.Stock_Log;

public interface LogMapper {
	public int insert_Release_Log_1(Release_Log r_Log);
	public int insert_Stock_Log_1(Stock_Log s_Log);
	
	public List<Release_Log> select_Every_Release_Log();
	public List<Stock_Log> select_Every_Stock_Log();
	
	public Release_Log select_Release_Log_By_Num(int order_Number);
	public Stock_Log select_Stock_Log_By_Num(int order_Number);

	public Release_Log select_Release_Log_By_P_Num(String Product_Number);
	public Stock_Log select_Stock_Log_By_P_Num(String Product_Number);
	
	public int update_Stock_Log_Charge2(Map<String, Object> map);
	public int update_Release_Log_Charge2(Map<String, Object> map);
	
	public List<Release_Log> search_Release_Log(Map<String, String> map);
	public List<Stock_Log> search_Stock_Log(Map<String, String> map);
	public List<Stock_Log> searchStockByName(String product_Name);
	public List<Stock_Log> lastStockNumber(String product_Number);
}