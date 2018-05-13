package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.Criteria;
import com.linker.dto.AdminUserDTO;

@Repository
public class AdminUserDAOImpl implements AdminUserDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.adminUserMapper";
	
	//모든 유저정보 조회
	@Override
	public List<AdminUserDTO> userListAll() throws Exception {
		return session.selectList(namespace + ".userListAll");
	}
	//유저 상세정보 조회
	@Override
	public AdminUserDTO readUser(Integer id) throws Exception {
		return session.selectOne(namespace + ".readUser", id);
	}
	//유저 정보 수정
	@Override
	public void updateUser(AdminUserDTO dto) throws Exception {
		session.update(namespace + ".updateUser", dto);
	}
	
	//페이징
	@Override
	public List<AdminUserDTO> listPage(int page) throws Exception {
		if(page <= 0) { page = 1; }
		page = (page - 1) * 10;
		return session.selectList(namespace + ".listPage", page);
	}
	@Override
	public List<AdminUserDTO> listCriteria(Criteria cri) throws Exception {
		return session.selectList(namespace + ".listCriteria", cri);
	}
	//페이지 total count
	@Override
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace + ".countPaging", cri);
	}
}
