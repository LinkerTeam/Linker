package com.linker.service;



import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;
import com.linker.persistence.UserDAO;
import com.linker.util.MailHandler;


@Service
public class UserServiceImpl implements UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Inject
	private UserDAO dao;
	
	//스프링시큐리티 비밀번호 암호화한것 체크하거나 암호화하는 객체
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	//로그인 체크	    
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
         
		return dao.login(dto);
	}
	
	//로그인한  회원정보 가져오기
	@Override
	public UserVO viewUser(String email) {
		// TODO Auto-generated method stub
		return dao.viewUser(email);
	}

	//회원정보 수정
	@Override
	public void updateUser(UserDTO dto) {
		// TODO Auto-generated method stub
		
		 dao.updateUser(dto);
	}
	
	//자동로그인
	@Override
	public void keepLogin(String email, String sessionId, Date next,String profile) throws Exception {
		dao.keepLogin(email, sessionId, next,profile);
	}
    
	//유저가 가진 쿠키에 저장한 세션키를 DB에 들어간 세션키와 비교하는 과정 
	@Override
	public UserVO checkLoginBefore(String value) throws Exception {

		return dao.chechUserWithSessionKey(value);
	}
   
	//닉네임 중복 확인 
	@Override
	public int checkSignup(String nickname) throws Exception {
 		return dao.checkSignup(nickname);
	}

  
	//이메일을 확인한 매서드 
	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		dao.userAuth(email);
	}

	//이메일 중복확인 
	@Override
	public int emailCheck(String email) throws Exception {
		// TODO Auto-generated method stub
		return dao.emailCheck(email);
	}

	//임의의 비밀번호로 지정한다.
	@Override
	public void forgetpassword(UserVO vo) throws Exception {
		
		dao.forgetpassword(vo);	
		
	}
	//이메일이 가입되있는지 체크
	@Override
	public int serchEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return dao.serchEmail(email);
	}

	/*@Override
	public boolean checkPw(String email, String password) throws Exception {
	
		return dao.checkPw(email, password);
	}
*/

	//비밀번호 변경
	@Override
	public void updatePassword(UserDTO dto) throws Exception {
		
		String password = passwordEncoder.encode(dto.getPassword());
		
		dto.setPassword(password);
		 
	    System.out.println("변경된 비밀번호 뭐니"+dto.getPassword());
		
		dao.updatePassword(dto);
		
	}

	//현재비밀번호 비교하기 위해 가져오기 
	@Override
	public String getPassword(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPassword(dto);
	}

	//유저가 회원 탈퇴하기!!
	@Override
	public void deleteUser(String email) throws Exception {
		
		dao.deleteUser(email);
	}
	
}