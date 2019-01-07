package global.sesoc.tsumioroshi.vo;

public class SecondCategory {
	private String fc_code;
	private String sc_code;
	private String sc_name;

	public SecondCategory() {
		super();
	}

	public SecondCategory(String fc_code, String sc_code, String sc_name) {
		super();
		this.fc_code = fc_code;
		this.sc_code = sc_code;
		this.sc_name = sc_name;
	}

	public String getFc_code() {
		return fc_code;
	}

	public void setFc_code(String fc_code) {
		this.fc_code = fc_code;
	}

	public String getSc_code() {
		return sc_code;
	}

	public void setSc_code(String sc_code) {
		this.sc_code = sc_code;
	}

	public String getSc_name() {
		return sc_name;
	}

	public void setSc_name(String sc_name) {
		this.sc_name = sc_name;
	}

	@Override
	public String toString() {
		return "SecondCategory [fc_code=" + fc_code + ", sc_code=" + sc_code + ", sc_name=" + sc_name + "]";
	}

}
