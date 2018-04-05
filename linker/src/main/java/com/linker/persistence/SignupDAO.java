package com.linker.persistence;

import com.linker.domain.UserVO;


public interface SignupDAO {
	 public String getTime();
	 
	 public void insertMember(UserVO vo);
	 
	 public void createAuthKey(String email, String authCode) throws Exception ;
     public void status(String email) throws Exception;
     public void insertGoogle(UserVO vo) throws Exception;
     public UserVO serchGoogle(UserVO vo) throws Exception;
}
