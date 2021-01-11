package com.store.cake.dto.pl;

import java.util.Date;

public class PLDTO {
	
	private int R;
	private char category;
	private String name;
	private int amount;
	private int price;
	private Date regdate;
	
	/* 수익 */
	private int s_id;
	
	/* 지출 */
	private int o_id;
	
	/* 경비지출 */
	private int sp_id;

	public int getR() {
		return R;
	}

	public void setR(int r) {
		R = r;
	}

	public char getCategory() {
		return category;
	}

	public void setCategory(char category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getS_id() {
		return s_id;
	}

	public void setS_id(int s_id) {
		this.s_id = s_id;
	}

	public int getO_id() {
		return o_id;
	}

	public void setO_id(int o_id) {
		this.o_id = o_id;
	}

	public int getSp_id() {
		return sp_id;
	}

	public void setSp_id(int sp_id) {
		this.sp_id = sp_id;
	}
	
	
	
	
	
	
}
