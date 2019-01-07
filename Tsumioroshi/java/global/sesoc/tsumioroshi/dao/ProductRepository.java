package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tsumioroshi.vo.Product;

@Repository
public class ProductRepository {
	@Autowired
	SqlSession session;
	
	public List<Product> select_Shelf_Product(String shelf_Name) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list  = mapper.select_Shelf_Product(shelf_Name);
		return list;
	}
	
	public List<Product> select_Every_Product_By_Num(String product_number) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list  = mapper.select_Every_Product_By_Num(product_number);
		return list;
	}
	
	public int insert_Release_Log_Form_2(Product product) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.insert_Release_Log_Form_2(product);

		return result;
	}
	
	public int insert_Stock_Log_Form_2(Product product) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.insert_Stock_Log_Form_2(product);

		return result;
	}
	
	public List<Product> productCheck(Product product){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list = mapper.productCheck(product);
		
		return list;
	}
	
	public List<Product> selectProductByName(Product product){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list = mapper.selectProductByName(product);
		
		return list;
		
	}
	
	public int releaseRaedyProduct(String number) {
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		int result = mapper.releaseRaedyProduct(number);
		
		return result;
		
	}
	
	public List<Product> viewShelf(String shelf){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list = mapper.viewShelf(shelf);
		
		return list;
	}
	
	public List<Product> searchProductName(Map<String, String> map){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list = mapper.searchProductName(map);
		
		return list;
	}
	
	public List<Product> searchProductNumber(String pnumber){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> list = mapper.searchProductNumber(pnumber);
		
		return list;
	}
	
	public List<Product> select_Product_By_Name(){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> products = mapper.select_Product_By_Name();

		return products;
	};
	public List<Product> select_Product_By_Name2(Map<String, String> map){
		ProductMapper mapper = session.getMapper(ProductMapper.class);
		List<Product> products = mapper.select_Product_By_Name2(map);

		return products;
	};
	
	public List<Product> select_Product_By_Tag(String tag_Number) {
	      ProductMapper mapper = session.getMapper(ProductMapper.class);
	      List<Product> product = mapper.select_Product_By_Tag(tag_Number);

	      return product;
	   };
}