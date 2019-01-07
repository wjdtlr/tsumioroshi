package global.sesoc.tsumioroshi.vo;

public class Release_Log {
	private String product_Name;
	private String product_Number;
	private int order_Number;
	private String order_Date;
	private String log_Date;
	private String destination;
	private int delivery_Amount;
	private String charge1;
	private String charge2;
	private String confirm_Date;
	
	public Release_Log() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Release_Log(String product_Name, String product_Number, int order_Number, String order_Date, String log_Date,
			String destination, int delivery_Amount, String charge1, String charge2, String confirm_Date) {
		super();
		this.product_Name = product_Name;
		this.product_Number = product_Number;
		this.order_Number = order_Number;
		this.order_Date = order_Date;
		this.log_Date = log_Date;
		this.destination = destination;
		this.delivery_Amount = delivery_Amount;
		this.charge1 = charge1;
		this.charge2 = charge2;
		this.confirm_Date = confirm_Date;
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

	public int getOrder_Number() {
		return order_Number;
	}

	public void setOrder_Number(int order_Number) {
		this.order_Number = order_Number;
	}

	public String getOrder_Date() {
		return order_Date;
	}

	public void setOrder_Date(String order_Date) {
		this.order_Date = order_Date;
	}

	public String getLog_Date() {
		return log_Date;
	}

	public void setLog_Date(String log_Date) {
		this.log_Date = log_Date;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public int getDelivery_Amount() {
		return delivery_Amount;
	}

	public void setDelivery_Amount(int delivery_Amount) {
		this.delivery_Amount = delivery_Amount;
	}

	public String getCharge1() {
		return charge1;
	}

	public void setCharge1(String charge1) {
		this.charge1 = charge1;
	}

	public String getCharge2() {
		return charge2;
	}

	public void setCharge2(String charge2) {
		this.charge2 = charge2;
	}

	public String getConfirm_Date() {
		return confirm_Date;
	}

	public void setConfirm_Date(String confirm_Date) {
		this.confirm_Date = confirm_Date;
	}

	@Override
	public String toString() {
		return "Release_Log [product_Name=" + product_Name + ", product_Number=" + product_Number + ", order_Number="
				+ order_Number + ", order_Date=" + order_Date + ", log_Date=" + log_Date + ", destination="
				+ destination + ", delivery_Amount=" + delivery_Amount + ", charge1=" + charge1 + ", charge2=" + charge2
				+ ", confirm_Date=" + confirm_Date + "]";
	}	
}