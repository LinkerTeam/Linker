package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.ReadCardlistVO;
import com.linker.domain.TeamVO;

@Repository
public class MyCardFavoriteDAOImpl implements MyCardFavoriteDAO {

	@Inject
	SqlSession session;
	
	private static String namespace = "com.linker.mapper.MyCardFavoriteMapper";
	
	@Override
	public List<ReadCardlistVO> myTeamList(int u_id) throws Exception {
		return session.selectList(namespace+".myTeamList",u_id);
	}
}
