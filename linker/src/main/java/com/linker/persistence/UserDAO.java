package com.linker.persistence;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;

public interface UserDAO {
  public UserVO login(LoginDTO dto)throws Exception;
  public void keepLogin(String email,String sessionId,Date next,String profile);
  public UserVO chechUserWithSessionKey(String value);
  public UserVO viewUser(String email);
  public void updateUser(UserDTO dto);
  public int checkSignup(String nickname) throws Exception;
}
