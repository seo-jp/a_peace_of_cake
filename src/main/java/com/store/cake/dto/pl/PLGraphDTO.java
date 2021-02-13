package com.store.cake.dto.pl;

public class PLGraphDTO {
	
	String label;
	
	int o_sp_date; // 지출+경비 합계
	int o_data;
	int s_data;
	
	String sp_label;
	int sp_data;
	
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	
	public int getO_sp_date() {
		return o_sp_date;
	}
	public void setO_sp_date(int o_sp_date) {
		this.o_sp_date = o_sp_date;
	}
	public int getO_data() {
		return o_data;
	}
	public void setO_data(int o_data) {
		this.o_data = o_data;
	}
	public int getS_data() {
		return s_data;
	}
	public void setS_data(int s_data) {
		this.s_data = s_data;
	}
	public String getSp_label() {
		return sp_label;
	}
	public void setSp_label(String sp_label) {
		this.sp_label = sp_label;
	}
	public int getSp_data() {
		return sp_data;
	}
	public void setSp_data(int sp_data) {
		this.sp_data = sp_data;
	}
	

}
