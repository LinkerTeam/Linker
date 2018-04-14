package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.UserVO;

@Repository
public class SingupDAOImpl implements SignupDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.linker.mapper.UserMapper";

	// insert delete update는 반환값이 void 이다. 리턴타입이 없다.
	@Override
	public void insertMember(UserVO vo) {
		session.insert(namespace + ".insertMember", vo);

	}
	//이메일 AuthKey 생성
	@Override
	public void createAuthKey(String email, String authCode) throws Exception {
		// TODO Auto-generated method stub
		UserVO vo = new UserVO();
		vo.setAuthCode(authCode);
		vo.setEmail(email);

		session.selectOne(namespace + ".createAuthKey", vo);
	}
	//해당 이메일 stauts체크
	@Override
	public void status(String email) throws Exception {
		session.update(namespace+".status",email);
		
	}
	//구글 회원 가입
	@Override
	public void insertGoogle(UserVO vo) throws Exception {
		session.insert(namespace+".insertGoogle",vo);
		
	}
	//구글 회원 가입유무 체크
	@Override
	public UserVO serchGoogle(UserVO vo) throws Exception {
	
		return session.selectOne(namespace+".serchGoogle",vo);
	}


}
