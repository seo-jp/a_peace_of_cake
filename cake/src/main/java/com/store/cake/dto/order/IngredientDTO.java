package com.store.cake.dto.order;

import java.util.Date;

public class IngredientDTO {
	
	private int R;
	private int i_id;
	private String i_name;
	private int i_price;
	private char i_state;
	private int i_exipdate;
	private Date i_regdate;
	private String i_img;
	
	public int getR() {
		return R;
	}
	public void setR(int R) {
		this.R = R;
	}
	public int getI_id() {
		return i_id;
	}
	public void setI_id(int i_id) {
		this.i_id = i_id;
	}
	public String getI_name() {
		return i_name;
	}
	public void setI_name(String i_name) {
		this.i_name = i_name;
	}
	public int getI_price() {
		return i_price;
	}
	public void setI_price(int i_price) {
		this.i_price = i_price;
	}
	public char getI_state() {
		return i_state;
	}
	public void setI_state(char i_state) {
		this.i_state = i_state;
	}
	public int getI_exipdate() {
		return i_exipdate;
	}
	public void setI_exipdate(int i_exipdate) {
		this.i_exipdate = i_exipdate;
	}
	public Date getI_regdate() {
		return i_regdate;
	}
	public void setI_regdate(Date i_regdate) {
		this.i_regdate = i_regdate;
	}
	public String getI_img() {
		return i_img;
	}
	public void setI_img(String i_img) {
		this.i_img = i_img;
	}
	

}
