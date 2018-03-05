package com.linker.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

  @Inject
  private UserDAO dao;

  @Override
  public UserVO login(LoginDTO dto) throws Exception {

    return dao.login(dto);
  }
  
}