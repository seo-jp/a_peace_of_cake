package com.store.cake.dto.order;

import java.util.Date;

public class OrderDTO {
	
	private int R;
	private int o_id;
	private String o_name;
	private int o_amount;
	private int o_price;
	private int i_price;
	private Date o_regdate;
	private char o_state;
	private String i_img;
	
	public int getR() {
		return R;
	}
	public void setR(int R) {
		this.R = R;
	}
	public int getO_id() {
		return o_id;
	}
	public void setO_id(int o_id) {
		this.o_id = o_id;
	}
	public String getO_name() {
		return o_name;
	}
	public void setO_name(String o_name) {
		this.o_name = o_name;
	}
	public int getO_amount() {
		return o_amount;
	}
	public void setO_amount(int o_amount) {
		this.o_amount = o_amount;
	}
	public int getO_price() {
		return o_price;
	}
	public void setO_price(int o_price) {
		this.o_price = o_price;
	}
	public Date getO_regdate() {
		return o_regdate;
	}
	public void setO_regdate(Date o_regdate) {
		this.o_regdate = o_regdate;
	}
	public char getO_state() {
		return o_state;
	}
	public void setO_state(char o_state) {
		this.o_state = o_state;
	}
	public int getI_price() {
		return i_price;
	}
	public void setI_price(int i_price) {
		this.i_price = i_price;
	}
	public String getI_img() {
		return i_img;
	}
	public void setI_img(String i_img) {
		this.i_img = i_img;
	}
	
}
