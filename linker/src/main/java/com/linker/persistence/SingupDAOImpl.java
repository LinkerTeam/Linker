package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.UserVO;

@Repository
public class SingupDAOImpl implements SignupDAO {
  
  @Inject
  private SqlSession sqlSession;
  
  private static final String namespace ="com.linker.mapper.UserMapper";

	@Override
	public String getTime() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getTime");
	}

	//insert delete update는 반환값이 void 이다. 리턴타입이 없다.
	@Override
	public void insertMember(UserVO vo) {
		sqlSession.insert(namespace+".insertMember",vo);
		
	}

}
