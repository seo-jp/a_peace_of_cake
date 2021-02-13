package com.store.cake.dto.product;

import java.util.Date;

public class ProductSearchDTO {
	
	private String searchP_name;
	private String searchP_price;
	private String searchP_state;
	private String searchP_memo;
	private String searchP_exipdate;
	private String searchFromDate;
	private String searchToDate;
	
	private int startRow;
	private int endRow;
	private String sort;
	
	
	public String getSearchP_name() {
		return searchP_name;
	}
	public void setSearchP_name(String searchP_name) {
		this.searchP_name = searchP_name;
	}
	public String getSearchP_price() {
		return searchP_price;
	}
	public void setSearchP_price(String searchP_price) {
		this.searchP_price = searchP_price;
	}
	public String getSearchP_state() {
		return searchP_state;
	}
	public void setSearchP_state(String searchP_state) {
		this.searchP_state = searchP_state;
	}
	public String getSearchP_memo() {
		return searchP_memo;
	}
	public void setSearchP_memo(String searchP_memo) {
		this.searchP_memo = searchP_memo;
	}
	public String getSearchP_exipdate() {
		return searchP_exipdate;
	}
	public void setSearchP_exipdate(String searchP_exipdate) {
		this.searchP_exipdate = searchP_exipdate;
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
