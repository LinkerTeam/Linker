package com.linker.service;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import com.linker.dto.UserDTO;
import com.linker.persistence.UserDAO;

@Repository
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Override
	public void loginUser(UserDTO dto) throws Exception {
		dao.loginUser(dto);
	}

	@Override
	public int signUpUser(UserDTO dto) throws Exception {
		return dao.signUpUser(dto);
	}

	@Override
	public int modifyUser(UserDTO dto) throws Exception {
		return dao.modifyUser(dto);
	}

}
