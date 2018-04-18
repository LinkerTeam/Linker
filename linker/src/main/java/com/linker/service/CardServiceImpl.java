package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.linker.domain.CardAttachVO;
import com.linker.domain.CardVO;
import com.linker.persistence.CardAttachDAO;
import com.linker.persistence.CardDAO;

@Service
public class CardServiceImpl implements CardService{
	
	@Inject
	private CardDAO dao;
	
	@Inject
	private CardAttachDAO attach_dao;
	
	//카드 생성
	@Override
	public void createCard(CardVO card) throws Exception {
		dao.createCard(card);
	}
	//카드 수정(제목, 내용)
	@Override
	public void updateCard(CardVO card) throws Exception {
		dao.updateCard(card);
	}
	//카드 수정(상태)
	@Override
	public void updateCardStatus(CardVO card) throws Exception {
		dao.updateCardStatus(card);
	}
	//상태값에 따른 카드 목록 조회
	@Override
	public List<CardVO> listCard(CardVO vo) throws Exception {
		return dao.listCard(vo);
	}
	//카드 상세내용 조회
	@Override
	public CardVO readPopcard(CardVO vo) throws Exception {
		return dao.readPopcard(vo);
	}
	
	//첨부파일 조회
	@Override
	public List<CardAttachVO> allAttach(Integer c_id) throws Exception {
		return attach_dao.allAttach(c_id);
	}
	//첨부파일 업로드
	@Override
	public void addAttach(CardAttachVO vo) throws Exception {
		attach_dao.addAttach(vo);
	}
	//첨부파일 삭제
	@Override
	public void deleteAttach(String file) throws Exception {
		attach_dao.deleteAttach(file);
	}
	
}
