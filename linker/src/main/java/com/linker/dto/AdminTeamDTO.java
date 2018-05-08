package com.linker.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class AdminTeamDTO {
	private int t_id; //팀아이디
	private String name; //팀이름
	private int u_id; //회원아이디
	private String email;//회원이메일
	private String nickname; //회원 닉네임
	private int auth; //그 팀에 대한 회원의 권한
	private int status;//메일 인증이 되었는지 확인하는 상태. 0 : 인증 안함. 1 : 인증함.
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="GMT+9")
	private Date cdate; //생성 날짜
	
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
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
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	
	@Override
	public String toString() {
		return "AdminTeamDTO [t_id=" + t_id + ", name=" + name + ", u_id=" + u_id + ", email=" + email + ", nickname="
				+ nickname + ", auth=" + auth + ", status=" + status + ", cdate=" + cdate + "]";
	}
}
