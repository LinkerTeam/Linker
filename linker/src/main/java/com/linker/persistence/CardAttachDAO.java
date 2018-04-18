package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardAttachVO;

public interface CardAttachDAO {
	
	//조회
	public List<CardAttachVO> allAttach(Integer c_id) throws Exception;
	//업로드
	public void addAttach(CardAttachVO vo) throws Exception;
	//삭제
	public void deleteAttach(String file) throws Exception;
	
}
