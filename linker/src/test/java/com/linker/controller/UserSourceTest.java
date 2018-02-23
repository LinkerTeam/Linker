package com.linker.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.dto.UserDTO;
import com.linker.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class UserSourceTest {
	private static Logger logger = LoggerFactory.getLogger(DataSourceTest.class);
	
	@Inject
	private UserService service; 

	/*
	 * 회원가입테스트(로컬)
	 * 회원가입 테스트는 필요시에만 사용한다.
	 * */
//	@Test
	public void testSignUp() throws Exception {
		UserDTO dto = new UserDTO();
		dto.setEmail("test@test.test");
		dto.setPassword("test");
		dto.setNickname("테스트");
		service.signUpUser(dto);	
	}

	// 로그인테스트 
	@Test
	public void testLogin() throws Exception {
		UserDTO dto = new UserDTO();
		dto.setEmail("test@test.test");
		dto.setPassword("test");
		service.loginUser(dto);
	}

	// 회원정보 수정 테스트
	@Test
	public void testUserModify() throws Exception {
		UserDTO dto = new UserDTO();
		dto.setEmail("test2@test.com");
//		dto.setPassword("test2");
		dto.setNickname("테스트2");
		dto.setId(2);
		service.modifyUser(dto);
	}

}