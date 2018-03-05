package com.linker.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.domain.UserVO;
import com.linker.persistence.ModifyDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
	locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ModifyTest {
    
	@Inject
	private ModifyDAO dao;
	
	@Test
	public void testUpdate() throws Exception {
		System.out.println("DAO:"+dao);
		UserVO vo = new UserVO();
		    vo.setNickname("viwer");
			vo.setEmail("a@naver");
			vo.setPassword("viwer");
  
			dao.update(vo);
	}

}
