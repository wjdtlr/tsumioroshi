package global.sesoc.tsumioroshi.dao;

import java.util.List;

import global.sesoc.tsumioroshi.vo.Members;

public interface MemberMapper {
	public List<Members> selectAllMembers(Members member);
	public List<Members> listOffice();
	public List<Members> listWareHouse();
	public int deleteMember(Members member);
	public Members idCheck(Members member);
	public int insertMember(Members member);
	public Members login(Members members);
}
