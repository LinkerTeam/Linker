package com.linker.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.domain.TeamMemberVO;
import com.linker.persistence.TeamMemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class TeamMemberSourceTest {
	private Logger logger = LoggerFactory.getLogger(TeamMemberSourceTest.class);
	
	@Inject
	private TeamMemberDAO dao;
	
	//멤버생성
	@Test
	public void testCreateMember() throws Exception{
		TeamMemberVO vo = new TeamMemberVO();
		vo.setT_id(1);
		vo.setU_id(9);
		vo.setAuth(2);
		dao.createMember(vo);
	}
	
	//멤버권한수정
	@Test
	public void testUpdateMember() throws Exception{
		TeamMemberVO vo = new TeamMemberVO();
		vo.setU_id(14);
		vo.setT_id(4);
		vo.setAuth(1);
		dao.modifyMemberAuth(vo);
	}
	
	//멤버삭제
	@Test
	public void testDeleteMember() throws Exception{
//		MemberVO vo = new MemberVO();
//		vo.setT_id(2);
//		vo.setU_id(12);
		dao.deleteMember(2, 12);
	}
	
	//멤버출력(한 회원이 가진 팀들의 멤버들)
	@Test
	public void testListMember() throws Exception{
		int userId = 1;
		List<TeamMemberVO> list = dao.TeamHasUsers(userId);
		for(int i=0; i<list.size(); i++) {
			logger.info(i + " " + list.get(i).toString());
		}
	}

}
