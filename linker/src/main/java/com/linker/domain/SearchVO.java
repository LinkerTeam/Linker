
package com.linker.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class SearchVO {

	private String keyword;

	private int c_id; //카드 아이디
	private String c_title; //카드 제목
	private String content; //카드 내용
	private int u_id; //user 아이디 : 모든 검색 할 때 사용함.
	private String nickname; //user 닉네임
	private int cnt_f_cid; //첨부파일 개수
	private int cnt_r_cid; //댓글 개수

	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="GMT+9")
	private Date cdate; //카드 작성 날짜
	private int cl_id; //카드리스트 아이디
	private String cl_title; //카드리스트 제목
	private int p_id; //프로젝트 아이디 : 달성/가리기 검색, 전체 검색할 때 사용함.
	private String p_title; //프로젝트 이름
	private int t_id; //팀 아이디
	private String t_name; //팀 이름
	
	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public String getC_title() {
		return c_title;
	}

	public void setC_title(String c_title) {
		this.c_title = c_title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getCnt_f_cid() {
		return cnt_f_cid;
	}

	public void setCnt_f_cid(int cnt_f_cid) {
		this.cnt_f_cid = cnt_f_cid;
	}

	public int getCnt_r_cid() {
		return cnt_r_cid;
	}

	public void setCnt_r_cid(int cnt_r_cid) {
		this.cnt_r_cid = cnt_r_cid;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public int getCl_id() {
		return cl_id;
	}

	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}

	public String getCl_title() {
		return cl_title;
	}

	public void setCl_title(String cl_title) {
		this.cl_title = cl_title;
	}

	public String getP_title() {
		return p_title;
	}

	public void setP_title(String p_title) {
		this.p_title = p_title;
	}

	public int getT_id() {
		return t_id;
	}

	public void setT_id(int t_id) {
		this.t_id = t_id;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	@Override
	public String toString() {
		return "SearchVO [keyword=" + keyword + ", c_id=" + c_id + ", c_title=" + c_title + ", content=" + content
				+ ", u_id=" + u_id + ", nickname=" + nickname + ", cnt_f_cid=" + cnt_f_cid + ", cnt_r_cid=" + cnt_r_cid
				+ ", cdate=" + cdate + ", cl_id=" + cl_id + ", cl_title=" + cl_title + ", p_id=" + p_id + ", p_title="
				+ p_title + ", t_id=" + t_id + ", t_name=" + t_name + "]";
	}
	
	
}
