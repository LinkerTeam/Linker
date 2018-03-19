package com.linker.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;

public interface MemberService {
	
	//멤버 추가 + 멤버이메일인증
	public int create(MemberVO vo) throws Exception, MessagingException, UnsupportedEncodingException;
	
	//멤버추가
	public int connectTeamMember(int u_id, int t_id) throws Exception;

	//팀에 속한 멤버 리스트 출력(t_id)
	public List<MemberVO> TeamHasUsers(int u_id) throws Exception;
	
	//멤버 출력(u_id)
	public MemberVO userHasTeamUid(int u_id, int t_id) throws Exception;
	
	//멤버 출력(email)
	public MemberVO userHasTeamEmail(String email, int t_id) throws Exception;
	
	//멤버 출력
	public MemberVO userEmail(String email) throws Exception;
	
	//멤버수정(권한)
	public int modifyAuth(MemberVO vo) throws Exception;
	
	//멤버수정(인증상태)
	public void modifyStatus(int u_id, int t_id) throws Exception;
	
	//멤버삭제
	public void deleteMember(int u_id, int t_id) throws Exception;

}
