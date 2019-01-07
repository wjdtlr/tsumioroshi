package global.sesoc.tsumioroshi.util;

import java.util.HashMap;
import java.util.Map;

public class CalPages {
	
	static final int PAGEPERCOUNT = 10;
	
	public CalPages() {}
	
	
	public int CalTotalPage(int pages) {
		 int totalPage;
		 if(pages%PAGEPERCOUNT == 0) {
			 totalPage = pages/PAGEPERCOUNT;
		 }else {
			 totalPage = pages/PAGEPERCOUNT+1;
		 }
		 
		 return totalPage;
	}
	
	public Map<String, Object> CalStartEnd(int currPage, int totalPage, int pages ) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (currPage-1)*PAGEPERCOUNT+1;
		int end;
		
		if(pages%PAGEPERCOUNT == 0) {
			end = currPage*PAGEPERCOUNT;
			
		}else{
			if(totalPage == currPage) {
				end = pages -(PAGEPERCOUNT*currPage-20);
				
			}else {
				end = currPage*PAGEPERCOUNT;
	
			}
		}
		map.put("start", start);
		map.put("end", end);
		
		return map;
	}
}
