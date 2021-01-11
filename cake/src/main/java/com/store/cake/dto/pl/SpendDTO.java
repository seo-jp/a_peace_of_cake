package com.store.cake.dto.pl;

import java.util.Date;

public class SpendDTO {
	
	private int sp_id;
	private String sp_name;
	private int sp_price;
	private Date sp_regdate;
	
	public int getSp_id() {
		return sp_id;
	}
	public void setSp_id(int sp_id) {
		this.sp_id = sp_id;
	}
	public String getSp_name() {
		return sp_name;
	}
	public void setSp_name(String sp_name) {
		this.sp_name = sp_name;
	}
	public int getSp_price() {
		return sp_price;
	}
	public void setSp_price(int sp_price) {
		this.sp_price = sp_price;
	}
	public Date getSp_regdate() {
		return sp_regdate;
	}
	public void setSp_regdate(Date sp_regdate) {
		this.sp_regdate = sp_regdate;
	}
	
	
	
}
