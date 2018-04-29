package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.dto.AdminUserDTO;

@Repository
public class AdminUserDAOImpl implements AdminUserDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.AdminUserMapper";
	
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
}
