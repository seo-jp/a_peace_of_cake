package com.store.cake.dto.sale;

import java.util.Date;

public class SaleDTO {
	
	private int R;
	private int s_id;
	private int s_group_id;
	private String s_name;
	private int s_amount;
	private int s_price;
	private int s_allprice;
	private int s_discount;
	private Date s_regdate;
	private char s_state;
	private String p_img;
	private int s_p_id;
	
	public int getR() {
		return R;
	}
	public void setR(int r) {
		R = r;
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public int getS_group_id() {
		return s_group_id;
	}
	public void setS_group_id(int s_group_id) {
		this.s_group_id = s_group_id;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public int getS_amount() {
		return s_amount;
	}
	public void setS_amount(int s_amount) {
		this.s_amount = s_amount;
	}
	public int getS_price() {
		return s_price;
	}
	public void setS_price(int s_price) {
		this.s_price = s_price;
	}
	public int getS_allprice() {
		return s_allprice;
	}
	public void setS_allprice(int s_allprice) {
		this.s_allprice = s_allprice;
	}
	public int getS_discount() {
		return s_discount;
	}
	public void setS_discount(int s_discount) {
		this.s_discount = s_discount;
	}
	public Date getS_regdate() {
		return s_regdate;
	}
	public void setS_regdate(Date s_regdate) {
		this.s_regdate = s_regdate;
	}
	public char getS_state() {
		return s_state;
	}
	public void setS_state(char s_state) {
		this.s_state = s_state;
	}
	public String getP_img() {
		return p_img;
	}
	public void setP_img(String p_img) {
		this.p_img = p_img;
	}
	public int getS_p_id() {
		return s_p_id;
	}
	public void setS_p_id(int s_p_id) {
		this.s_p_id = s_p_id;
	}
	
	
}
