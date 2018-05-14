package com.linker.service;

import java.util.List;

import com.linker.domain.ReadCardlistVO;


public interface MyCardFavoriteService {
	//즐겨 찾기 리스트 가져오기
	public List<ReadCardlistVO> myTeamList(int u_id) throws Exception;
}
