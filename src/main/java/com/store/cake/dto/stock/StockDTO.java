package com.store.cake.dto.stock;

import java.util.Date;

public class StockDTO {
	
	private int R;
	private int s_id;
	private String s_name;
	private String s_category;
	private int s_amount;
	private char s_state;
	private Date s_exipdate;
	private Date s_regdate;
	private Date s_manufdate;
	private String i_img;
	private String p_img;
	
	public int getR() {
		return R;
	}
	public void setR(int R) {
		this.R = R;
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_category() {
		return s_category;
	}
	public void setS_category(String s_category) {
		this.s_category = s_category;
	}
	public int getS_amount() {
		return s_amount;
	}
	public void setS_amount(int s_amount) {
		this.s_amount = s_amount;
	}
	public char getS_state() {
		return s_state;
	}
	public void setS_state(char s_state) {
		this.s_state = s_state;
	}
	public Date getS_exipdate() {
		return s_exipdate;
	}
	public void setS_exipdate(Date s_exipdate) {
		this.s_exipdate = s_exipdate;
	}
	public Date getS_regdate() {
		return s_regdate;
	}
	public void setS_regdate(Date s_regdate) {
		this.s_regdate = s_regdate;
	}
	public Date getS_manufdate() {
		return s_manufdate;
	}
	public void setS_manufdate(Date s_manufdate) {
		this.s_manufdate = s_manufdate;
	}
	public String getI_img() {
		return i_img;
	}
	public void setI_img(String i_img) {
		this.i_img = i_img;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	
	
}
