package com.linker.service;



import com.linker.domain.UserVO;

public interface SignupService {
	

	
	
	// insert delete update는 반환값이 void 이다. 리턴타입이 없다.
	
	public void insertMember(UserVO vo) throws Exception;
	

}
