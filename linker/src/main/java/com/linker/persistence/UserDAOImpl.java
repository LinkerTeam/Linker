package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	// SqlSession은 데이터베이스와 연결 하고 connetion하는 기능은 가지고있어서 db와 연결시 중요하다
	//그래서 DAO에 꼭필요한 객체이다. 데이터 접근 객체이니.
	private static String namespace="org.linker.mapper.UserMapper";
	  //namespace는 mapper와 연결하기위해서 중요한 것 네임스페이스가 다르면 mapper와 연결이 안된다.
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".login", dto);
	}



}
