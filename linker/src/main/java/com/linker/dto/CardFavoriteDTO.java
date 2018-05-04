package com.linker.dto;

public class CardFavoriteDTO {
 
	private int u_id;
	private int t_id;
	private int p_id;
	private int cl_id;
	private int c_id;
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
	@Override
	public String toString() {
		return "CardFavoriteDTO [u_id=" + u_id + ", t_id=" + t_id + ", p_id=" + p_id + ", cl_id=" + cl_id + ", c_id="
				+ c_id + "]";
	}
	
}
