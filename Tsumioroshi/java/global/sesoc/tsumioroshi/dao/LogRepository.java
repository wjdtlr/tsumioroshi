package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tsumioroshi.vo.Release_Log;
import global.sesoc.tsumioroshi.vo.Stock_Log;


@Repository
public class LogRepository {
	@Autowired
	SqlSession session;
	
	public int insert_Release_Log_1(Release_Log r_Log) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		int result = mapper.insert_Release_Log_1(r_Log);
		
		return result;
	}
	
	public int insert_Stock_Log_1(Stock_Log s_Log) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		int result = mapper.insert_Stock_Log_1(s_Log);
		
		return result;
	}
	
	public List<Release_Log> select_Every_Release_Log() {		
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		List<Release_Log> list = mapper.select_Every_Release_Log();
		
		return list;
	}
	
	public List<Stock_Log> select_Every_Stock_Log() {		
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		List<Stock_Log> list = mapper.select_Every_Stock_Log();
		
		return list;
	}
	
	public Release_Log select_Release_Log_By_Num(int order_Number) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		Release_Log log  = mapper.select_Release_Log_By_Num(order_Number);
		
		return log;
	}
	
	public Stock_Log select_Stock_Log_By_Num(int order_Number) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		Stock_Log log  = mapper.select_Stock_Log_By_Num(order_Number);
		
		return log;
	}
	
	public Release_Log select_Release_Log_By_P_Num(String product_Number) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		Release_Log log  = mapper.select_Release_Log_By_P_Num(product_Number);
		
		return log;
	}
	
	public Stock_Log select_Stock_Log_By_P_Num(String product_Number) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		
		Stock_Log log  = mapper.select_Stock_Log_By_P_Num(product_Number);
		
		return log;
	}
	
	public int update_Stock_Log_Charge2(Map<String, Object> map) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		int result = mapper.update_Stock_Log_Charge2(map);
		
		return result;
	}
	
	public int update_Release_Log_Charge2(Map<String, Object> map) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		int result = mapper.update_Release_Log_Charge2(map);
		
		return result;
	}
	
	public List<Stock_Log> search_Stock_Log(Map<String, String> map) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		List<Stock_Log> stock_Logs = mapper.search_Stock_Log(map);
		
		return stock_Logs;
	}
	
	public List<Release_Log> search_Release_Log(Map<String, String> map) {
		LogMapper mapper = session.getMapper(LogMapper.class);
		List<Release_Log> release_Logs = mapper.search_Release_Log(map);
		
		return release_Logs;
	}
	
	public List<Stock_Log> searchStockByName(String product_Name){
		LogMapper mapper = session.getMapper(LogMapper.class);
		List<Stock_Log> list = mapper.searchStockByName(product_Name);
		
		return list;
		
	}
	
	public List<Stock_Log> lastStockNumber(String product_Number){
		LogMapper mapper = session.getMapper(LogMapper.class);
		List<Stock_Log> list = mapper.lastStockNumber(product_Number);
		
		return list;
	}
}
