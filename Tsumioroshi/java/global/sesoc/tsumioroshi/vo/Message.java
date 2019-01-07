package global.sesoc.tsumioroshi.vo;

public class Message {
	public int message_no;
	public String id;
	public String password;
	public String title;
	public String regdate;
	public String content;
	public String confirm;
	public String user_to;
	public String confirm_date;

	public Message() {
	}

	public Message(int message_no, String id, String password, String title, String regdate, String content,
			String confirm, String user_to, String confirm_date) {
		super();
		this.message_no = message_no;
		this.id = id;
		this.password = password;
		this.title = title;
		this.regdate = regdate;
		this.content = content;
		this.confirm = confirm;
		this.user_to = user_to;
		this.confirm_date = confirm_date;
	}

	public int getMessage_no() {
		return message_no;
	}

	public void setMessage_no(int message_no) {
		this.message_no = message_no;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public String getUser_to() {
		return user_to;
	}

	public void setUser_to(String user_to) {
		this.user_to = user_to;
	}

	public String getConfirm_date() {
		return confirm_date;
	}

	public void setConfirm_date(String confirm_date) {
		this.confirm_date = confirm_date;
	}

	@Override
	public String toString() {
		return "Message [message_no=" + message_no + ", id=" + id + ", password=" + password + ", title=" + title
				+ ", regdate=" + regdate + ", content=" + content + ", confirm=" + confirm + ", user_to=" + user_to
				+ ", confirm_date=" + confirm_date + "]";
	}

}
