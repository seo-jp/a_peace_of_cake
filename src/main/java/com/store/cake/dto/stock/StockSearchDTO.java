package com.store.cake.dto.stock;

public class StockSearchDTO {
	
	private String searchS_name;
	private String searchS_state;
	private String searchFromDate1;
	private String searchToDate1;
	private String searchFromDate2;
	private String searchToDate2;
	
	private String viewType;
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
	public String getSearchFromDate1() {
		return searchFromDate1;
	}
	public void setSearchFromDate1(String searchFromDate1) {
		this.searchFromDate1 = searchFromDate1;
	}
	public String getSearchToDate1() {
		return searchToDate1;
	}
	public void setSearchToDate1(String searchToDate1) {
		this.searchToDate1 = searchToDate1;
	}
	public String getSearchFromDate2() {
		return searchFromDate2;
	}
	public void setSearchFromDate2(String searchFromDate2) {
		this.searchFromDate2 = searchFromDate2;
	}
	public String getSearchToDate2() {
		return searchToDate2;
	}
	public void setSearchToDate2(String searchToDate2) {
		this.searchToDate2 = searchToDate2;
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
	public String getViewType() {
		return viewType;
	}
	public void setViewType(String viewType) {
		this.viewType = viewType;
	}
	
	
	

}
