package com.linker.domain;

public class TeamMemberVO {

	private int u_id; //회원아이디
	private int t_id; //팀아이디	
	private int auth; //그 팀에 대한 회원의 권한
	private String nickname; //회원 닉네임
	private String name; //팀이름
	private String email;//회원이메일
	private int status;//메일 인증이 되었는지 확인하는 상태. 0 : 인증 안함. 1 : 인증함.
	
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "TeamMemberVO [u_id=" + u_id + ", t_id=" + t_id + ", auth=" + auth + ", nickname=" + nickname + ", name="
				+ name + ", email=" + email + ", status=" + status + "]";
	}
	
	
	
}
