package com.linker.controller;

import static org.junit.Assert.*;

import java.util.List;
import java.util.ListIterator;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.domain.TeamVO;
import com.linker.persistence.TeamDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class TeamSourceTest {

	private static Logger logger = LoggerFactory.getLogger(TeamSourceTest.class);
	
	@Inject
	private TeamDAO dao;
	
//팀생성
	@Test
	public void testCreateTeam() throws Exception{
		TeamVO vo = new TeamVO();
		vo.setName("team12");
		dao.createTeam(vo);
	}
//팀수정(이름)
	@Test
	public void testModifyTeam() throws Exception{
		TeamVO vo= new TeamVO();
		vo.setName("updateTeam12");
		vo.setT_id(5);
//		vo.setAuth(2);//실패
		vo.setAuth(0);//성공
		System.out.println("VO: " + vo.toString());
		dao.modifyTeam(vo);
		System.out.println("DAO : " + dao.toString() );
	}
	//팀삭제
	@Test
	public void testDeleteTeam() throws Exception{
		TeamVO vo = new TeamVO();
		vo.setAuth(0); //삭제 성공
//		vo.setAuth(2); //삭제 실패
		vo.setT_id(13);
		dao.deleteTeam(11);
//		System.out.println("VO : " + vo.toString());
		
	}
	//팀출력	
	@Test
	public void testListTeam() throws Exception{
		int userId=1;
		List<TeamVO> list = dao.listTeam(userId);
		for(int i=0; i<list.size(); i++) {
			logger.info(i + " " + list.get(i).toString());
		}
	}
}
