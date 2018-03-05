package com.linker.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linker.domain.CardlistVO;
import com.linker.persistence.CardlistDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CardlistSourceTest {
	
	@Inject
	private CardlistDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(CardlistSourceTest.class);
	
	private final int CARDLIST_STATE_INPROGRESS = 1;
	private final int CARDLIST_STATE_ACHIEVEMENT = 2;
	private final int CARDLIST_STATE_HIDING = 3;
	
	//메소드 테스트
	
	// 카드리스트 생성
//	@Test
//	public void testCreateCardlist()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setP_id(1);
//		cardlist.setU_id(4);
//		cardlist.setTitle("제휴 할인사");
//		dao.createCardlist(cardlist);
//	}
	
	// 진행 상태의 카드리스트 조회
	@Test
	public void testSelectLists()throws Exception {
		int projectID = 2;
		List<CardlistVO> cardlists = dao.selectListInProgress(projectID);
		for(int i=0; i<cardlists.size(); i++)
			logger.info(i+"     "+cardlists.get(i).toString());
	}

	// 카드리스트 제목 수정
//	@Test
//	public void testToChangeTitle()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(10);
//		cardlist.setTitle("회원가입 상세 페이지");
//	    cardlist.setPs_id(1);
//		dao.updateCardlist(cardlist);
//	}
	
	// 카드리스트 상태 수정
//	@Test
//	public void testToChageState()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(17);
//		cardlist.setTitle("제휴 할인사");
//		cardlist.setPs_id(CARDLIST_STATE_ACHIEVEMENT);
//		dao.updateCardlist(cardlist);
//	}
	
//	@Test
//	public void testToChageState2()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(12);
//		cardlist.setPs_id(CARDLIST_STATE_HIDING);
//		dao.updateCardlist(cardlist);
//	}
}
