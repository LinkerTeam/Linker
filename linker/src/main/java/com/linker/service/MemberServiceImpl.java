package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.MemberVO;
import com.linker.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	MemberDAO dao;
	
	@Override
	public int createMember(MemberVO vo) throws Exception {
		return dao.createMember(vo);
	}

	@Override
	public List<MemberVO> listMember(int userId) throws Exception {
		return dao.listMember(userId);
	}

	@Override
	public int modifyMember(MemberVO vo) throws Exception {
		return dao.modifyMember(vo);
	}

	@Override
	public int deleteMember(MemberVO vo) throws Exception {
		return dao.deleteMember(vo);
	}

}
