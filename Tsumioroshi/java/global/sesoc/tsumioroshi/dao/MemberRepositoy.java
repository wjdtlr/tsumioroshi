package global.sesoc.tsumioroshi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.tsumioroshi.vo.Members;

@Repository
public class MemberRepositoy {

	@Autowired
	SqlSession session;
	
	public List<Members> selectAllMembers(Members member){
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<Members> list = mapper.selectAllMembers(member);
		
		return list;
	}

	public List<Members> listOffice() {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<Members> list = mapper.listOffice();

		return list;
	}

	public List<Members> listWareHouse() {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<Members> list = mapper.listWareHouse();

		return list;
	}
	
	public int deleteMember(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.deleteMember(member);
		
		return result;
	}
	
	public Members idCheck(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Members result = mapper.idCheck(member);
		
		return result;
	}
	
	public int insertMember(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.insertMember(member);
		
		return result;
	}
	
	public Members login(Members member)
	{
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Members result = mapper.login(member);
		
		return result;
	}
}
