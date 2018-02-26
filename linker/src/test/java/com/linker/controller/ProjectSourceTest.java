package com.linker.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.domain.ProjectVO;
import com.linker.persistence.ProjectDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ProjectSourceTest {
	private static Logger logger = LoggerFactory.getLogger(ProjectSourceTest.class);
	
	@Inject
	private ProjectDAO dao;

	@Test
	public void test() throws Exception {
		ProjectVO vo = new ProjectVO();
		vo.setTitle("테스트");
		vo.setU_id(1);
		vo.setT_id(1);
		vo.setPs_id(1);
		dao.createProject(vo);
	}

}
