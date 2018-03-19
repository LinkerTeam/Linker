package com.linker.service;



import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;
import com.linker.persistence.UserDAO;


@Service
public class UserServiceImpl implements UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Inject
	private UserDAO dao;

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
		 dao.updateUser(dto);
	}




	@Override
	public void keepLogin(String email, String sessionId, Date next,String profile) throws Exception {
		dao.keepLogin(email, sessionId, next,profile);
	}

	@Override
	public UserVO checkLoginBefore(String value) {

		return dao.chechUserWithSessionKey(value);
	}






	@Override
	public int checkSignup(String nickname) throws Exception {
 		return dao.checkSignup(nickname);
	}
	
	
}