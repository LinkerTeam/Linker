package com.linker.service;



import com.linker.domain.UserVO;

public interface SignupService {
	

	//회원가입
	public void insertMember(UserVO vo) throws Exception;
	//해당 이메일 stauts체크	
	public void status(String email) throws Exception; 
	//구글 회원 가입
	public void insertGoogle(UserVO vo) throws Exception;
	//구글 회원 가입유무 체크
	public UserVO serchGoogle(UserVO email) throws Exception;
}
