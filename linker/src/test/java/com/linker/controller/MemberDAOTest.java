package com.linker.controller;



import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.linker.domain.UserVO;
import com.linker.persistence.SignupDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberDAOTest {
	
	@Inject
	private SignupDAO dao;

	//회원가입 
	@Test
	public void testInsertMeber() throws Exception{
		
		UserVO vo = new UserVO();
	
        System.out.println();
	    vo.setEmail("asd1111111@gmail.com");
		vo.setPassword("12345");
		vo.setNickname("robin2");
		System.out.println("VO:"+vo.toString());
		
		dao.insertMember(vo);
		
		System.out.println("DAO:"+dao.toString());
		
	}

}
