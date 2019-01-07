package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.tsumioroshi.vo.Message;

public interface MessageMapper {

	public List<Message> selectTen(Map<String, Object> map);
	public int pageCount(Map<String, Object> map);
	public int insertMessage(Message message);
	public Message selectOne(String message_no);
	public int updateMessage(Message message);
	public int deleteMessage(int mno);
	public int confirmMessage(Message message);
}
