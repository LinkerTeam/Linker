package com.linker.persistence;



import java.util.List;

import com.linker.domain.UserVO;

public interface ModifyDAO {

	public void update(UserVO vo) throws Exception;
	public List<UserVO> listAll() throws Exception;
	}
