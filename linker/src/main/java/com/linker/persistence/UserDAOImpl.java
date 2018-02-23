package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO{

	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.userMapper";

	@Override
	public void loginUser(UserDTO dto) throws Exception {
		session.selectOne(namespace+".loginUser", dto);
	}

	@Override
	public int signUpUser(UserDTO dto) throws Exception {
		return session.insert(namespace+".signUpUser", dto);
	}

	@Override
	public int modifyUser(UserDTO dto) throws Exception {
		return session.update(namespace+".modifyUser", dto);
	}

}
