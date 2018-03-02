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
	private CardlistDAO cldao;
	
	private static Logger logger = LoggerFactory.getLogger(CardlistSourceTest.class);
	
	//메소드 테스트
	
	// 카드리스트 생성
//	@Test
//	public void testCreateCardlist()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setP_id(1);
//		cardlist.setU_id(4);
//		cardlist.setTitle("사이트 맵");
//		cldao.createCardlist(cardlist);
//	}
	
	// 진행중인 카드리스트 조회
//	@Test
//	public void testSelectLists()throws Exception {
//		List<CardlistVO> cls = cldao.selectListInProgress();
//		for(int i=0; i<cls.size(); i++)
//			logger.info(i+"     "+cls.get(i).toString());
//	}

	// 카드리스트 제목 수정
//	@Test
//	public void testToChangeTitle()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(7);
//		cardlist.setTitle("사이트맵 변경");
//		cldao.updateTitle(cardlist);
//	}
	
	// 카드리스트 상태 수정
//	@Test
//	public void testToChageState()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(7);
//		cardlist.setPs_id(CardlistDAO.CARDLIST_STATE_ACHIEVEMENT);
//		cldao.updateState(cardlist);
//	}
	
//	@Test
//	public void testToChageState2()throws Exception {
//		CardlistVO cardlist = new CardlistVO();
//		cardlist.setId(5);
//		cardlist.setPs_id(CardlistDAO.CARDLIST_STATE_HIDING);
//		cldao.updateState(cardlist);
//	}
}
