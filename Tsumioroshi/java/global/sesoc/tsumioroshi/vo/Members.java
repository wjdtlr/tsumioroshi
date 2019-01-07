package global.sesoc.tsumioroshi.vo;

public class Members {
	private String id;
	private String password;
	private String masterpw;
	private String authority;

	public Members() {
	}
	
	public Members(String id, String password, String masterpw, String authority) {
		super();
		this.id = id;
		this.password = password;
		this.masterpw = masterpw;
		this.authority = authority;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMasterpw() {
		return masterpw;
	}

	public void setMasterpw(String masterpw) {
		this.masterpw = masterpw;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	@Override
	public String toString() {
		return "Members [id=" + id + ", password=" + password + ", masterpw=" + masterpw + ", authority=" + authority
				+ "]";
	}

}
