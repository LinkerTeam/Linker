package com.linker.persistence;

import com.linker.dto.UserDTO;

public interface UserDAO {
	public void loginUser(UserDTO dto) throws Exception;
	public int signUpUser(UserDTO dto) throws Exception;
	public int modifyUser(UserDTO dto) throws Exception;
}
