package com.linker.service;



import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;

public interface UserService {

	//로그인 체크	
	public UserVO login(LoginDTO dto) throws Exception;
	//로그인한  회원정보 가져오기
	public UserVO viewUser(String email);
	//회원정보 수정
	public void updateUser(UserDTO dto);
	//자동로그인
	public void keepLogin(String email,String sessionId,Date next,String profile)throws Exception;
	//유저가 가진 쿠키에 저장한 세션키를 DB에 들어간 세션키와 비교하는 과정 
	public UserVO checkLoginBefore(String value)throws Exception;
	//닉네임 중복 확인 
	public int checkSignup(String nickname) throws Exception;
	//이메일 인증 확인 절차
	public void userAuth(String email) throws Exception;
	//이메일중복검사
	public int emailCheck(String email) throws Exception;
	//임의의 비밀번호로 지정한다.
	public void forgetpassword(UserVO vo)throws Exception;
	//이메일이 가입되있는지 체크
	public int serchEmail(String email) throws Exception;
	//비밀번호 변경
	public void updatePassword(UserDTO dto) throws Exception;
	//현재비밀번호 비교하기 위해 가져오기 
	public String getPassword(LoginDTO dto) throws Exception;
	//유저가 회원 탈퇴하기
	public void deleteUser(String email) throws Exception;

}
