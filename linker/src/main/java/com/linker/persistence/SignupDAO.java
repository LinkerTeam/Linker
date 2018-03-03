package com.linker.persistence;

import com.linker.domain.UserVO;


public interface SignupDAO {
	 public String getTime();
	 
	 public void insertMember(UserVO vo);
}
