package com.linker.service;

import java.util.List;

import com.linker.domain.Criteria;
import com.linker.dto.AdminUserDTO;

public interface AdminUserService {
	//모든 유저 조회
	public List<AdminUserDTO> userListAll() throws Exception;
	//유저 상세정보 조회
	public AdminUserDTO readUser(Integer id) throws Exception;
	//유저 정보 수정
	public void updateUser(AdminUserDTO dto) throws Exception;
	
	//페이징
	public List<AdminUserDTO> listCriteria(Criteria cri) throws Exception;
	//페이지 total count
	public int listCountCriteria(Criteria cri) throws Exception;
}