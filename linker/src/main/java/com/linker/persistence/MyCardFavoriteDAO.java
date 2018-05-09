package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.domain.ReadCardlistVO;
import com.linker.domain.TeamVO;

public interface MyCardFavoriteDAO {
	//즐겨 찾기 된  리스트 가져오기
	public List<ReadCardlistVO> myTeamList(int u_id) throws Exception;
	
}
