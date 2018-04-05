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
	

	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
         
		return dao.login(dto);
	}

	
	
	
	
	
	@Override
	public UserVO viewUser(String email) {
		// TODO Auto-generated method stub
		return dao.viewUser(email);
	}



	@Override
	public void updateUser(UserDTO dto) {
		// TODO Auto-generated method stub
		 System.out.println("너는 뭐가 들어가니!!!"+dto);
		dao.updateUser(dto);
	}
	
	
	




	@Override
	public void keepLogin(String email, String sessionId, Date next,String profile) throws Exception {
		dao.keepLogin(email, sessionId, next,profile);
	}

	@Override
	public UserVO checkLoginBefore(String value) throws Exception {

		return dao.chechUserWithSessionKey(value);
	}






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






	@Override
	public void forgetpassword(UserVO vo) throws Exception {
		
	
		dao.forgetpassword(vo);
		
		
		
		
		
		
	}






	@Override
	public int serchEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return dao.serchEmail(email);
	}






	@Override
	public boolean checkPw(String email, String password) throws Exception {
		
		
		
		
		
		return dao.checkPw(email, password);
	}






	@Override
	public void updatePassword(UserDTO dto) throws Exception {
		
		String password = passwordEncoder.encode(dto.getPassword());
		
		dto.setPassword(password);
		 
	    System.out.println("변경된 비밀번호 뭐니"+dto.getPassword());
		
		dao.updatePassword(dto);
		
	}






	@Override
	public String getPassword(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPassword(dto);
	}






	@Override
	public void deleteUser(String email) throws Exception {
		
		dao.deleteUser(email);
	}
	
	
	
	
	
	
	
}