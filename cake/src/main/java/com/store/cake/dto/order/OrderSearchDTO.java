package com.store.cake.dto.order;

import java.util.Date;

public class OrderSearchDTO {
	
	private String searchO_name;
	private String searchO_state;
	private String searchFromDate;
	private String searchToDate;
	
	private int startRow;
	private int endRow;
	private String sort;
	
	public String getSearchO_name() {
		return searchO_name;
	}
	public void setSearchO_name(String searchO_name) {
		this.searchO_name = searchO_name;
	}
	public String getSearchO_state() {
		return searchO_state;
	}
	public void setSearchO_state(String searchO_state) {
		this.searchO_state = searchO_state;
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
