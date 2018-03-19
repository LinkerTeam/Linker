package com.linker.service;



import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;

public interface UserService {
 public UserVO login(LoginDTO dto) throws Exception;
 public UserVO viewUser(String email);
 public void updateUser(UserDTO dto);
 public void keepLogin(String email,String sessionId,Date next,String profile)throws Exception;
 public UserVO checkLoginBefore(String value);
 public int checkSignup(String nickname) throws Exception;
}
