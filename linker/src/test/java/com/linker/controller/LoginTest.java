package com.linker.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.dto.LoginDTO;
import com.linker.persistence.UserDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class LoginTest {

	@Inject
	UserDAO dao;
	
	@Test
	public void testLogin() throws Exception {
	 LoginDTO dto =new LoginDTO();
	    dto.setEmail("asd111@gmail.com");
	    dto.setPassword("12345");
	    System.out.println(dto.toString());
	  dao.login(dto);
	}

}
