package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.dto.AdminTeamDTO;

@Repository
public class AdminTeamDAOImle implements AdminTeamDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.adminTeamMapper";
	
	//모든 유저정보 조회
	@Override
	public List<AdminTeamDTO> allTeamList() throws Exception {
		return session.selectList(namespace + ".allTeamList");
	}
	
}
