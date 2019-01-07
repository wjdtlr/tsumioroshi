package global.sesoc.tsumioroshi.vo;

public class FirstCategory {
	private String fc_code;
	private String fc_name;

	public FirstCategory() {}

	public FirstCategory(String fc_code, String fc_name) {
		super();
		this.fc_code = fc_code;
		this.fc_name = fc_name;
	}

	public String getFc_code() {
		return fc_code;
	}

	public void setFc_code(String fc_code) {
		this.fc_code = fc_code;
	}

	public String getFc_name() {
		return fc_name;
	}

	public void setFc_name(String fc_name) {
		this.fc_name = fc_name;
	}

	@Override
	public String toString() {
		return "FirstCategory [fc_code=" + fc_code + ", fc_name=" + fc_name + "]";
	}

}
