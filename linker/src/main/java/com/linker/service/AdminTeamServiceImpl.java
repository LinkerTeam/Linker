package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.dto.AdminTeamDTO;
import com.linker.persistence.AdminTeamDAO;

@Service
public class AdminTeamServiceImpl implements AdminTeamService {
	
	@Inject
	AdminTeamDAO dao;
	
	//모든 팀 
	@Override
	public List<AdminTeamDTO> allTeamList() throws Exception {
		return dao.allTeamList();
	}

}
