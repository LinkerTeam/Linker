package com.linker.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	// SqlSession은 데이터베이스와 연결 하고 connetion하는 기능은 가지고있어서 db와 연결시 중요하다
	// 그래서 DAO에 꼭필요한 객체이다. 데이터 접근 객체이니.
	private static String namespace = "com.linker.mapper.UserMapper";

	// namespace는 mapper와 연결하기위해서 중요한 것 네임스페이스가 다르면 mapper와 연결이 안된다.
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".login", dto);
	}

	//컨트롤러로 부터 세션을 받아서  Map으로 저장함 insert into문 
	@Override
	public void keepLogin(String email, String sessionId, Date next,String profile) {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("email", email);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		paramMap.put("profile", profile);

		session.update(namespace + ".keepLogin", paramMap);

	}

	//유저가 가진 쿠키에 저장한 세션키를 DB에 들어간 세션키와 비교하는 과정 
	@Override
	public UserVO chechUserWithSessionKey(String value) {
		return session.selectOne(namespace+".chechUserWithSessionKey",value);
	}
 
	//자신의 회원정보 가져오기
	@Override
	public UserVO viewUser(String email) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".viewUser", email);
	}

	//회원정보 수정
	@Override
	public void updateUser(UserDTO dto) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateUser",dto);
	}

	

	//닉네임 중복 확인 
	@Override
	public int checkSignup(String nickname) throws Exception {
		return session.selectOne(namespace+".checkSignup",nickname);
		
	}

}
