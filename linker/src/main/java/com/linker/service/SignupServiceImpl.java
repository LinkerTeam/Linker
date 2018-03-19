package com.linker.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.UserVO;
import com.linker.persistence.SignupDAO;

//@Serviec는 애노테이션은 이클래스가 service클래스라는것 명시해주는것 component에서 읽을수있다 지정해줘야
@Service
public class SignupServiceImpl implements SignupService{
   @Inject
   SignupDAO dao;
	  
	@Override
	public void insertMember(UserVO vo) throws Exception {
		   dao.insertMember(vo);
		
	}

}
