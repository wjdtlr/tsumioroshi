package global.sesoc.tsumioroshi.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tsumioroshi.vo.Message;

@Repository
public class MessageRepository {

	@Autowired
	SqlSession session;
	
	public List<Message> selectTen(Map<String, Object> map){
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		List<Message> list = mapper.selectTen(map);
		return list;
		
	}
	public int pageCount(Map<String, Object> map) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.pageCount(map);
		
		return result;
	}
	
	public int insertMessage(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.insertMessage(message);
		
		return result;
	}
	
	public Message selectOne(String message_no) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		Message message = mapper.selectOne(message_no);
		
		return message;
	}
	
	public int updateMessage(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.updateMessage(message);
		
		return result;
	}
	
	public int deleteMessage(int mno) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.deleteMessage(mno);
		
		return result;
	}
	
	public int confirmMessage(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = mapper.confirmMessage(message);
		
		return result;
	}
}
