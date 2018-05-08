package com.linker.persistence;

import java.util.List;

import com.linker.dto.AdminTeamDTO;

public interface AdminTeamDAO {
	//모든 팀 조회
	public List<AdminTeamDTO> allTeamList() throws Exception;
}
