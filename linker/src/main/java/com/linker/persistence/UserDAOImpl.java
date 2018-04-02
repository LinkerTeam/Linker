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
		return session.selectOne(namespace+".checkUserWithSessionKey",value);
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
  
	
	//이메일 인증 확인 절차
	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".userAuth", email);
	}
   
	
	//이메일중복검사
	@Override
	public int emailCheck(String email) throws Exception {
		
		return session.selectOne(namespace+".emailCheck",email);
	}
   
	//임의의 비밀번호로 지정한다.
	@Override
	public void forgetpassword(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		 session.update(namespace+".forgetpassword",vo);
	}

	@Override
	public int serchEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".serchEmail",email);
	}

	@Override
	public boolean checkPw(String email, String password) throws Exception {
		    System.out.println("dao"+email);
		    System.out.println("dao"+password);
		   //기본값은 false로 지정 true일경우 비밀번호 일치했다는 것
		    boolean result = false;
		   
		    // session은 하나의 객체또는 값만 하나만 넣을수있어서 두개이상의 값을 넣기 위해선 Map이나 객체를 통해서만 넣을수있다.
		    //파라미터로 들어온값을 Map으로 담아서 mapper로 전달함 
		    Map<String, String> map = new HashMap<String, String>();
	        map.put("email", email);
	        map.put("password", password);
	        
	        int count = session.selectOne(namespace+".checkPw", map);
	        //들어온 값이 1이면 비밀번호가 맞고 0이면 비밀번호가 틀렸다는 이야기
	        System.out.println("카운터"+count);
	        if(count == 1) result= true;
		
	       return result;
	}

	//비밀번호 변경
	@Override
	public void updatePassword(UserDTO dto) throws Exception {
	       String password = dto.getPassword();
		
		System.out.println(session.update(namespace+".updatePassword",dto));
		session.update(namespace+".updatePassword",dto);
	}

	//비밀번호 비교하기 위해 가져오기 
	@Override
	public String getPassword(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".getPassword",dto);
	}

	//유저가 회원 탈퇴하기!!
	@Override
	public void deleteUser(String email) throws Exception {
		 System.out.println(session.delete(namespace+".deleteUser",email));
		 session.delete(namespace+".deleteUser",email);
		
	}

	 
	
 

}
