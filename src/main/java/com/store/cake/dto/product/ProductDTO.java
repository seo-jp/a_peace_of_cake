package com.store.cake.dto.product;

import java.util.Date;

public class ProductDTO {
	
	private int R;
	private int p_id;
	private String p_name;
	private int p_price;
	private char p_state;
	private String p_memo;
	private String p_exipdate;
	private Date p_regdate;
	private String p_img;
	
	public int getR() {
		return R;
	}
	public void setR(int R) {
		this.R = R;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public char getP_state() {
		return p_state;
	}
	public void setP_state(char p_state) {
		this.p_state = p_state;
	}
	public String getP_memo() {
		return p_memo;
	}
	public void setP_memo(String p_memo) {
		this.p_memo = p_memo;
	}
	public String getP_exipdate() {
		return p_exipdate;
	}
	public void setP_exipdate(String p_exipdate) {
		this.p_exipdate = p_exipdate;
	}
	public Date getP_regdate() {
		return p_regdate;
	}
	public void setP_regdate(Date p_regdate) {
		this.p_regdate = p_regdate;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	
	
}
