package com.store.cake.util;

import java.text.ParseException;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;

public class ShowDate {
	
	private String showDateFrom;
	private String showDateTo;
	
	private String searchDate;
	
	private String viewType;
	
	public void dateHandling(String viewType) {
		
			showDateTo = LocalDate.now().toString();
			
			switch(viewType) {
				
			case "day" : 
				showDateFrom = LocalDate.now().toString();
				break;
			case "week" : 
				showDateFrom = LocalDate.now().minusWeeks(1).toString();
				break;
			case "month" : 
				showDateFrom = LocalDate.now().minusMonths(1).toString();
				break;
			case "year" :
				showDateFrom = LocalDate.now().minusYears(1).toString();
				break;
			}
			
	}
	
	public void dateHandling2(String viewType) {
		
		searchDate = LocalDate.now().toString();
		showDateFrom = LocalDate.now().toString();
		
		switch(viewType) {
			
		case "day" : 
			showDateTo = LocalDate.now().toString();
			break;
			
		case "month" : 
			showDateTo = LocalDate.now().plusMonths(1).toString().substring(0,7);
			searchDate = searchDate.substring(0,7);
			showDateFrom = showDateFrom.substring(0,7);
			break;
		case "year" :
			showDateTo = LocalDate.now().plusYears(1).toString().substring(0,4);
			searchDate = searchDate.substring(0,4);
			showDateFrom = showDateFrom.substring(0,4);
			break;
		}
		
	}
	

	public void dateHandling3(String viewType, String searchDate) throws ParseException {
		
		DateTime date;
		
		switch(viewType) {
			
		case "day" : 
			showDateFrom = searchDate;
			showDateTo = searchDate;
			break;
			
		case "month" : 
			date = DateTime.parse(searchDate, DateTimeFormat.forPattern("YYYY-MM"));
			showDateFrom = date.toString().substring(0,7);
			showDateTo = date.plusMonths(1).toString().substring(0,7);
			break;
			
		case "year" :
			date = DateTime.parse(searchDate, DateTimeFormat.forPattern("YYYY"));
			showDateFrom = date.toString().substring(0,4);
			showDateTo = date.plusYears(1).toString().substring(0,4);
			break;
		}
		
	}
	

	public String getShowDateFrom() {
		return showDateFrom;
	}

	public String getShowDateTo() {
		return showDateTo;
	}
	
	public String getSearchDate() {
		return searchDate;
	}

}
