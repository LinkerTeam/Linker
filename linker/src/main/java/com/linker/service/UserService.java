package com.linker.service;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;

public interface UserService {
 public UserVO login(LoginDTO dto) throws Exception;
     
}
