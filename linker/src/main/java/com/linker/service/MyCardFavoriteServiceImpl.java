package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.ReadCardlistVO;
import com.linker.domain.TeamVO;
import com.linker.persistence.MyCardFavoriteDAO;
@Service
public class MyCardFavoriteServiceImpl implements MyCardFavoriteService {
	
	@Inject
	MyCardFavoriteDAO dao;
	
	@Override
	public List<ReadCardlistVO> myTeamList(int u_id) throws Exception {
		return dao.myTeamList(u_id);
	}
}
