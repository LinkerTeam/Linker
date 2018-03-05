package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.UserVO;

@Repository
public class ModifyDAOImpl implements ModifyDAO {

	@Inject
	SqlSession sqlsession;

	private static String namespace = "com.linker.mapper.ModifyMapper";

	@Override
	public void update(UserVO vo) throws Exception {
		sqlsession.update(namespace + ".update", vo);

	}

	@Override
	public List<UserVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".listAll");
	}

}
