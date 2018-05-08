package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.linker.domain.Criteria;
import com.linker.dto.AdminUserDTO;
import com.linker.persistence.AdminUserDAO;

@Service
public class AdminUserServiceImpl implements AdminUserService {
	
	@Inject
	private AdminUserDAO dao;
	
	@Inject
	private BCryptPasswordEncoder passwordEncoder; //스프링 시큐리티 암호화
	
	
	//모든 유저 조회
	@Override
	public List<AdminUserDTO> userListAll() throws Exception {
		return dao.userListAll();
	}
	//유저 상세정보 조회
	@Override
	public AdminUserDTO readUser(Integer id) throws Exception {
		return dao.readUser(id);
	}
	//유저 정보 수정
	@Override
	public void updateUser(AdminUserDTO dto) throws Exception {
		//스프링 시큐리티 암호화
		String password = passwordEncoder.encode(dto.getPassword()); 
		dto.setPassword(password);
		dao.updateUser(dto);
	}
	
	//페이징
	@Override
	public List<AdminUserDTO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

}
