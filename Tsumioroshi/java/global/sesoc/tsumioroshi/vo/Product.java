package global.sesoc.tsumioroshi.vo;

public class Product {
	private String product_Name;
	private String product_Number;
	private String tag_Number;
	private int quantity;
	private String expiration_Date;
	private String stock_Date;
	private String product_Location;
	
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product(String product_Name, String product_Number, String tag_Number, int quantity, String expiration_Date,
			String stock_Date, String product_Location) {
		super();
		this.product_Name = product_Name;
		this.product_Number = product_Number;
		this.tag_Number = tag_Number;
		this.quantity = quantity;
		this.expiration_Date = expiration_Date;
		this.stock_Date = stock_Date;
		this.product_Location = product_Location;
	}

	public String getProduct_Name() {
		return product_Name;
	}

	public void setProduct_Name(String product_Name) {
		this.product_Name = product_Name;
	}

	public String getProduct_Number() {
		return product_Number;
	}

	public void setProduct_Number(String product_Number) {
		this.product_Number = product_Number;
	}

	public String getTag_Number() {
		return tag_Number;
	}

	public void setTag_Number(String tag_Number) {
		this.tag_Number = tag_Number;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getExpiration_Date() {
		return expiration_Date;
	}

	public void setExpiration_Date(String expiration_Date) {
		this.expiration_Date = expiration_Date;
	}

	public String getStock_Date() {
		return stock_Date;
	}

	public void setStock_Date(String stock_Date) {
		this.stock_Date = stock_Date;
	}

	public String getProduct_Location() {
		return product_Location;
	}

	public void setProduct_Location(String product_Location) {
		this.product_Location = product_Location;
	}

	@Override
	public String toString() {
		return "Product [product_Name=" + product_Name + ", product_Number=" + product_Number + ", tag_Number="
				+ tag_Number + ", quantity=" + quantity + ", expiration_Date=" + expiration_Date + ", stock_Date="
				+ stock_Date + ", product_Location=" + product_Location + "]";
	}

	
}
