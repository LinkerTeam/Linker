package com.linker.domain;

import java.sql.Date;

public class CardVO {
	
	private int id;
	private int u_id;
	private String title;
	private String content;
	private Date cdate;
	private Date udate;
	private Date ddate;
	private int cl_id;
	private int ps_id;
	
	private int p_id;
	
	
	
	
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public Date getUdate() {
		return udate;
	}
	public void setUdate(Date udate) {
		this.udate = udate;
	}
	public Date getDdate() {
		return ddate;
	}
	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}
	public int getCl_id() {
		return cl_id;
	}
	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}
	public int getPs_id() {
		return ps_id;
	}
	public void setPs_id(int ps_id) {
		this.ps_id = ps_id;
	}
	
	@Override
	public String toString() {
		return "CardVO [id=" + id + ", u_id=" + u_id + ", title=" + title + ", content=" + content + ", cdate=" + cdate
				+ ", udate=" + udate + ", ddate=" + ddate + ", cl_id=" + cl_id + ", ps_id=" + ps_id + ", p_id=" + p_id + "]";
	}
	
}
