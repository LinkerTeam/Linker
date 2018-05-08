package com.linker.service;

import java.util.List;

import com.linker.dto.AdminTeamDTO;


public interface AdminTeamService {
	//모든 팀 조회
	public List<AdminTeamDTO> allTeamList() throws Exception;
}
