package com.linker.persistence;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;

public interface UserDAO {
  public UserVO login(LoginDTO dto)throws Exception;

}
