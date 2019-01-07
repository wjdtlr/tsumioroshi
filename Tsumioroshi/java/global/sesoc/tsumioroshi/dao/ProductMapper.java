package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tsumioroshi.vo.Product;

public interface ProductMapper {
	public List<Product> select_Shelf_Product(String shelf_Name);
	public int insert_Release_Log_Form_2(Product product);
	public int insert_Stock_Log_Form_2(Product product);
	public List<Product> select_Every_Product_By_Num(String product_number);
	public List<Product> productCheck(Product product);
	public List<Product> selectProductByName(Product product);
	public int releaseRaedyProduct(String number);
	public List<Product> viewShelf(String shelf);
	public List<Product> searchProductName(Map<String, String> map);
	public List<Product> searchProductNumber(String pnumber);
	
	public List<Product> select_Product_By_Name();
	public List<Product> select_Product_By_Name2(Map<String, String> map);
	public List<Product> select_Product_By_Tag(String tag_Number);
}