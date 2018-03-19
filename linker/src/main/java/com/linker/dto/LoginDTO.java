package com.linker.dto;
//화면으로부터 전달된 데이터를 수집하는 용도(하는곳)
//STS가 자동으로 request를 수집하고 자동으로 파라미터에 넣어준다.
public class LoginDTO {
	private String email;
	private String password;
	private String nickname;
	private String profile;
	private boolean useCookie;

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}

	public String getEmail() {
		return email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	@Override
	public String toString() {
		return "LoginDTO [email=" + email + ", password=" + password + ", useCookie=" + useCookie + "]";
	}
}
