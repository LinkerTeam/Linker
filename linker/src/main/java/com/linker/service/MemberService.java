package com.linker.service;

import java.util.List;

import com.linker.domain.MemberVO;

public interface MemberService {
	
	//멤버생성
	public int createMember(MemberVO vo) throws Exception;
	
	//멤버 출력
	public List<MemberVO> listMember(int userId) throws Exception;
	
	//멤버수정(권한)
	public int modifyMember(MemberVO vo) throws Exception;
	
	//멤버삭제
	public int deleteMember(MemberVO vo) throws Exception;

}
