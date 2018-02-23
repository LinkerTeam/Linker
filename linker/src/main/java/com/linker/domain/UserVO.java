package com.linker.domain;

public class UserVO {
	private int id;
	private String email;
	private String nickname;
	private String profile;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", email=" + email + ", nickname=" + nickname + ", profile=" + profile + "]";
	}
	

	
}
