/*
 * 작성자 : 김소영
 */
package com.linker.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import com.linker.domain.TeamMemberVO;
import com.linker.domain.UserVO;
import com.linker.domain.HistoryVO;
import com.linker.dto.TeamMemberDTO;

public interface TeamMemberService {
		
	//멤버 중복 체크
	public int checkMember(String email, int t_id) throws Exception;
	
	//멤버 추가 + 멤버이메일인증
	public void create(String email, int t_id) throws Exception, MessagingException, UnsupportedEncodingException;	
	
	//멤버추가
	public HistoryVO connectTeamMember(int u_id, int t_id, String name) throws Exception;
	
	//팀에 속한 멤버 리스트 출력(t_id)
	public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception;	
	
	//멤버 출력(u_id)
	public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception;
	
	//멤버 출력(email)
	public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception;	
	
	//멤버 출력
	public TeamMemberVO userEmail(String email) throws Exception;	
	
	//소유자 수정
	public void TransferAuth(TeamMemberDTO dto) throws Exception;
	
	//멤버수정(인증상태)
	public void modifyStatus(int u_id, int t_id) throws Exception;	
	
	//멤버삭제
	public void deleteMember(int u_id, int t_id) throws Exception;
	
	//멤버프로필가져오기
	public List<UserVO> hasTeamProfile(int t_id) throws Exception;

}
