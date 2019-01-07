package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tsumioroshi.vo.FirstCategory;
import global.sesoc.tsumioroshi.vo.SecondCategory;

public interface CategoriesMapper {
	public List<FirstCategory> selectAllFirst();
	public List<SecondCategory> selectSecond();
	public int insertFirst(FirstCategory first);
	public int insertSecond(SecondCategory second);
	public String selectByCodeFirst(String first);
	public FirstCategory selectByNameFirst(FirstCategory first);
	public List<SecondCategory> selectByFcCodeSecond(SecondCategory second);
	public SecondCategory selectByNameSecond(SecondCategory second);
	public String selectByCodeSecond(Map<String, String> map);
	public FirstCategory selectLastFirst();
	public SecondCategory selectLastSecond(SecondCategory second);
	public int countFirst();
	public int countSecond();
	public int deleteFirst(FirstCategory first);
	public int initSecond(FirstCategory first);
	public int deleteSecond(SecondCategory second);
	
	
}
