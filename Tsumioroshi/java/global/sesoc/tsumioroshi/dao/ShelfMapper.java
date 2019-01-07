package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tsumioroshi.vo.Shelf;

public interface ShelfMapper {
	public Shelf select_Shelf(String shelf_Name);
	public List<Shelf> select_Every_Shelves();
	public int insertSelves(Shelf shelf);
	public int updateShelves(Shelf shelf);
	public int deleteBox(String shelfname);
}