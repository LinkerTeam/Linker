package com.linker.domain;

import java.util.Date;

public class ReadCardlistVO {
	
	private int p_id;
	private int cl_id; //카드리스트 id
	private int cl_u_id; //카드리스트 user id
	private String cl_title; //카드리스트 title
	private Date cl_cdate; //카드리스트 생성날짜
	private Date cl_udate; //카드리스트 업뎃날짜
	private int cl_ps_id; //카드리스트 상태코드
	
	private int c_id; //카드 id
	private int c_u_id; //카드 user id
	private String c_title; //카드 title
	private String content; //카드 내용
	private Date c_cdate; //카드 생성날짜
	private Date c_udate; //카드 업뎃날짜
	private int c_ps_id; //카드 상태코드
	
	private int status;//즐겨찾기 상태코드

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

	public int getCl_u_id() {
		return cl_u_id;
	}

	public void setCl_u_id(int cl_u_id) {
		this.cl_u_id = cl_u_id;
	}

	public String getCl_title() {
		return cl_title;
	}

	public void setCl_title(String cl_title) {
		this.cl_title = cl_title;
	}

	public Date getCl_cdate() {
		return cl_cdate;
	}

	public void setCl_cdate(Date cl_cdate) {
		this.cl_cdate = cl_cdate;
	}

	public Date getCl_udate() {
		return cl_udate;
	}

	public void setCl_udate(Date cl_udate) {
		this.cl_udate = cl_udate;
	}

	public int getCl_ps_id() {
		return cl_ps_id;
	}

	public void setCl_ps_id(int cl_ps_id) {
		this.cl_ps_id = cl_ps_id;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public int getC_u_id() {
		return c_u_id;
	}

	public void setC_u_id(int c_u_id) {
		this.c_u_id = c_u_id;
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

	public Date getC_cdate() {
		return c_cdate;
	}

	public void setC_cdate(Date c_cdate) {
		this.c_cdate = c_cdate;
	}

	public Date getC_udate() {
		return c_udate;
	}

	public void setC_udate(Date c_udate) {
		this.c_udate = c_udate;
	}

	public int getC_ps_id() {
		return c_ps_id;
	}

	public void setC_ps_id(int c_ps_id) {
		this.c_ps_id = c_ps_id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ReadCardlistVO [p_id=" + p_id + ", cl_id=" + cl_id + ", cl_u_id=" + cl_u_id + ", cl_title=" + cl_title
				+ ", cl_cdate=" + cl_cdate + ", cl_udate=" + cl_udate + ", cl_ps_id=" + cl_ps_id + ", c_id=" + c_id
				+ ", c_u_id=" + c_u_id + ", c_title=" + c_title + ", content=" + content + ", c_cdate=" + c_cdate
				+ ", c_udate=" + c_udate + ", c_ps_id=" + c_ps_id + ", status=" + status + "]";
	}
	
	
}
