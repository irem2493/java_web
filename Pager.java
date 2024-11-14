package dto;

import lombok.Data;

@Data
public class Pager {
	private int pageNum;
	private int totalBoard;
	private int pageSize;
	private int blockSize;
	
	private int totalPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	private int prevPage;
	private int nextPage;
	
	public Pager(int pageNum, int totalBoard, int pageSize, int blockSize) {
		this.pageNum = pageNum;
		this.totalBoard = totalBoard;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		
		calcPage();
	}
	
	private void calcPage() {
		totalPage=(int)Math.ceil((double)totalBoard/pageSize);
		
		if(pageNum <= 0 || pageNum > totalPage) {pageNum = 1;}
	
		startRow = (pageNum-1)*pageSize+1;
		endRow = pageNum * pageSize;
		if(endRow > totalPage) {endRow = totalPage;}
		
		startPage=(pageNum-1)/blockSize*blockSize+1;
		endPage=startPage+blockSize-1;
		if(endPage>totalPage) {endPage = totalPage;}
		
		prevPage = startPage-blockSize;
		nextPage = startPage+blockSize;
	
	}
}
