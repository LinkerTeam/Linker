package com.linker.dto;

public class ProjectDTO {
	private int u_id;
	private int t_id;
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
	@Override
	public String toString() {
		return "ProjectDTO [u_id=" + u_id + ", t_id=" + t_id + "]";
	}
	
}
