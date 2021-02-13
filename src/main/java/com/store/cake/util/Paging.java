package com.store.cake.util;

/*https://zorba91.tistory.com/263 참고*/

public class Paging {

	private int pageIndex; //현재페이지
	
	private int pageSize; //한 블록안의 데이터 수 (얼마나 보여줄건지)
	private int startRow; //DB에서 몇번째 데이터부터 찾는지
	private int endRow; //DB에서 몇번째 데이터까지 찾는지
	private int totalCount; //전체 데이터 위한 카운트
	
	private int pageCount; //페이지의 수 카운트
	private int block; // 페이지 끊는 단위
	private int startPage; //시작할 페이지
	private int endPage; // 끝 페이지
	
	public Paging() {
		this(0, 0, 0, 0);
	}
	
	// basic
	public Paging(int pageIndex, int totalCount) { 
		this(pageIndex, totalCount, 30, 10);
	}
	
	// custom
	public Paging(int pageIndex, int totalCount, int pageSize, int block) { 
		
		 this.pageIndex = pageIndex;
		 this.pageSize = pageSize;
		 this.totalCount = totalCount;
		 this.block = block;
		 
	}
	
	public void pageHandling() {
		
		pageCount = (int) Math.ceil(totalCount/(double)pageSize);
		//pageCount = totalCount/pageSize +1;
		//if(totalCount == pageSize) pageCount = 1;
		if(pageIndex < 1) pageIndex = 1;
		if(pageIndex > pageCount) pageIndex = pageCount;
		
		startRow = (pageIndex*pageSize)-(pageSize -1);
		endRow = pageIndex * pageSize;
		
		startPage = ((pageIndex-1)/block*block)+1;
		endPage = ((pageIndex-1)/block*block)+block;
		if(endPage> pageCount){
			endPage = pageCount;
		}
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getStartRow() {
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getPageCount() {
		return pageCount;
	}

	public int getBlock() {
		return block;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}
	
	
}
