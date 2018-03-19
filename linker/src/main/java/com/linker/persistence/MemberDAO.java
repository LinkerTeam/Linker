package com.linker.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;

@Repository
public interface MemberDAO {

	//멤버생성
	public int createMember(MemberVO vo) throws Exception;
	//멤버 추가
	public int connectTeamMember(int u_id, int t_id) throws Exception;
	//팀에 속한 멤버출력(t_id)
	public List<MemberVO> TeamHasUsers(int u_id) throws Exception;
	//팀에 대한 멤버출력(u_id)
	public MemberVO userHasTeamUid(int u_id, int t_id) throws Exception;
	//팀에 대한 멤버출력(email)
	public MemberVO userHasTeamEmail(String email, int t_id) throws Exception;
	//멤버출력
	public MemberVO userEmail(String email) throws Exception;
	//멤버수정(상태코드)
	public int modifyMemberStatus(int u_id, int t_id) throws Exception;
	//멤버수정(권한)
	public int modifyMemberAuth(MemberVO vo) throws Exception;
	//멤버삭제
	public int deleteMember(int u_id, int t_id) throws Exception;

}
