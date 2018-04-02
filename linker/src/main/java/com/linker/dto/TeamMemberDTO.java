package com.linker.dto;

public class TeamMemberDTO {

	private int deleteT_id;
	private int deleteU_id;
	private int transferT_id;
	private int transferU_id;
	private int auth;
	
	public int getDeleteT_id() {
		return deleteT_id;
	}
	public void setDeleteT_id(int deleteT_id) {
		this.deleteT_id = deleteT_id;
	}
	public int getDeleteU_id() {
		return deleteU_id;
	}
	public void setDeleteU_id(int deleteU_id) {
		this.deleteU_id = deleteU_id;
	}
	public int getTransferT_id() {
		return transferT_id;
	}
	public void setTransferT_id(int transferT_id) {
		this.transferT_id = transferT_id;
	}
	public int getTransferU_id() {
		return transferU_id;
	}
	public void setTransferU_id(int transferU_id) {
		this.transferU_id = transferU_id;
	}
	
	public int getTransferAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	@Override
	public String toString() {
		return "TeamMemberDTO [deleteT_id=" + deleteT_id + ", deleteU_id=" + deleteU_id + ", transferT_id="
				+ transferT_id + ", transferU_id=" + transferU_id + ", auth=" + auth + "]";
	}
	
	
	
}
