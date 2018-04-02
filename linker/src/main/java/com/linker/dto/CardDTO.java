package com.linker.dto;

public class CardDTO {
	private int id;
	private int p_id;
	private int cl_id;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	
	
	@Override
	public String toString() {
		return "CardDTO [id=" + id + ", p_id=" + p_id + ", cl_id=" + cl_id + "]";
	}
}
