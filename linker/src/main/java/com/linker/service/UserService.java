package com.linker.service;

import com.linker.dto.UserDTO;

public interface UserService {
	public void loginUser(UserDTO dto) throws Exception;
	public int signUpUser(UserDTO dto) throws Exception;
	public int modifyUser(UserDTO dto) throws Exception;
}
