package com.linker.persistence;

import com.linker.domain.UserVO;


public interface SignupDAO {
	 //회원가입
	 public void insertMember(UserVO vo);
	 //이메일 AuthKey 생성
	 public void createAuthKey(String email, String authCode) throws Exception ;
     //해당 이메일 stauts체크
	 public void status(String email) throws Exception;
     //구글 회원 가입
	 public void insertGoogle(UserVO vo) throws Exception;
     //구글 회원 가입유무 체크
	 public UserVO serchGoogle(UserVO vo) throws Exception;
}
