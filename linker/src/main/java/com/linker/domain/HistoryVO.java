package com.linker.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class HistoryVO {
	//****팀원의 경우, u_id, t_id를 조인하여 사용
	private int id;
	private int code;
	private int query;
	private String before; //변경 전의 데이터 값
	private String after; //변경 후의 데이터 값	
	private int u_id; //user id
	private int t_id; //team id
	private int p_id; //project id
	private int cl_id; //cardList id
	private int c_id; //card id
	private int f_id; //file id
	private int r_id; //reply id
	private int data_id;
	private String nickname; //이력에 띄울 유저 닉네임
	private String profile; //이력탭에 띄울 프로필 사진
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="GMT+9")
	private Date cdate; //이력탭에 띄울 시간

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
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getCl_id() {
		return cl_id;
	}
	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public int getF_id() {
		return f_id;
	}
	public void setF_id(int f_id) {
		this.f_id = f_id;
	}
	public int getR_id() {
		return r_id;
	}
	public void setR_id(int r_id) {
		this.r_id = r_id;
	}
	public String getBefore() {
		return before;
	}
	public void setBefore(String before) {
		this.before = before;
	}
	public String getAfter() {
		return after;
	}
	public void setAfter(String after) {
		this.after = after;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getQuery() {
		return query;
	}
	public void setQuery(int query) {
		this.query = query;
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
	
	public int getData_id() {
		return data_id;
	}
	public void setData_id(int data_id) {
		this.data_id = data_id;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	@Override
	public String toString() {
		return "HistoryVO [id=" + id + ", code=" + code + ", query=" + query + ", before=" + before + ", after=" + after
				+ ", u_id=" + u_id + ", t_id=" + t_id + ", p_id=" + p_id + ", cl_id=" + cl_id + ", c_id=" + c_id
				+ ", f_id=" + f_id + ", r_id=" + r_id + ", data_id=" + data_id + ", nickname=" + nickname + ", profile="
				+ profile + ", cdate=" + cdate + "]";
	}
	
	
}
