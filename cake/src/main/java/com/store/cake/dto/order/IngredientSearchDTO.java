package com.store.cake.dto.order;

import java.util.Date;

public class IngredientSearchDTO {
	
	private String searchI_name;
	private String searchI_price;
	private String searchI_state;
	private String searchI_exipdate;
	private String searchFromDate;
	private String searchToDate;
	
	private int startRow;
	private int endRow;
	private String sort;
	
	
	public String getSearchI_name() {
		return searchI_name;
	}
	public void setSearchI_name(String searchI_name) {
		this.searchI_name = searchI_name;
	}
	public String getSearchI_price() {
		return searchI_price;
	}
	public void setSearchI_price(String searchI_price) {
		this.searchI_price = searchI_price;
	}
	public String getSearchI_state() {
		return searchI_state;
	}
	public void setSearchI_state(String searchI_state) {
		this.searchI_state = searchI_state;
	}
	public String getSearchI_exipdate() {
		return searchI_exipdate;
	}
	public void setSearchI_exipdate(String searchI_exipdate) {
		this.searchI_exipdate = searchI_exipdate;
	}
	public String getSearchFromDate() {
		return searchFromDate;
	}
	public void setSearchFromDate(String searchFromDate) {
		this.searchFromDate = searchFromDate;
	}
	public String getSearchToDate() {
		return searchToDate;
	}
	public void setSearchToDate(String searchToDate) {
		this.searchToDate = searchToDate;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	
	

}
