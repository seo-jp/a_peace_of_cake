package com.store.cake.dto.sale;

public class SaleSearchDTO {
	
	private String searchS_name;
	private String searchS_state;
	private String searchFromDate;
	private String searchToDate;
	
	private int startRow;
	private int endRow;
	private String sort;
	
	public String getSearchS_name() {
		return searchS_name;
	}
	public void setSearchS_name(String searchS_name) {
		this.searchS_name = searchS_name;
	}
	public String getSearchS_state() {
		return searchS_state;
	}
	public void setSearchS_state(String searchS_state) {
		this.searchS_state = searchS_state;
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
