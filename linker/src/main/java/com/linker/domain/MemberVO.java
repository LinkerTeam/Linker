package com.linker.domain;

public class MemberVO {

	private int u_id; //회원아이디
	private int t_id; //팀아이디
	private int auth; //그 팀에 대한 회원의 권한
	private String nickName; //회원 닉네임
	private String name; //팀이름
	
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "MemberVO [u_id=" + u_id + ", t_id=" + t_id + ", auth=" + auth + ", nickName=" + nickName + ", name="
				+ name + "]";
	}
	
	
	
}
