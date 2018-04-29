package com.linker.persistence;

import java.util.List;

import com.linker.dto.AdminUserDTO;


public interface AdminUserDAO {
	//모든 유저 조회
	public List<AdminUserDTO> userListAll() throws Exception;
	//유저 상세정보 조회
	public AdminUserDTO readUser(Integer id) throws Exception;
	//유저 정보 수정
	public void updateUser(AdminUserDTO dto) throws Exception;
}
