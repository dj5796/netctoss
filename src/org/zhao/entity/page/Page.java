package org.zhao.entity.page;

import java.io.Serializable;

/** 该类是分页查询的父类,各个模块分页查询的实体类都要继承该类   */
public abstract class Page implements Serializable {
	private static final long serialVersionUID = 625610868660457373L;
	
	/** 分页时需要传入的参数 */
	
	/** 当前页 **/
	private int currentPage = 1; 
	/** 每页显示多少条数据 **/
	private int pageSize = 5;
	/** 当前页的起始行 **/
	private int begin; 
	/** 当前页的终止行 **/
	private int end;
	/** 总行数，用于计算总页数 */
	private int rows; // 
	/** 总页数，由rows和pageSize计算而来 */
	private int totalPage;

	/*
	 * mybatis写sql进行分页查询时使用大于小于号进行查询或者用between and进行查询
	 * 因此begin=(currentPage-1)*pageSize;end=currentPage*pageSize+1;
	 * 
	 * oracle中between and包含边界值，如 between 1 and 100，则表示包含1和100及以内的一切数值
	 * 如果用between and,则是begin=(currentPage-1)*pageSize+1;end=currentPage*pageSize;
	 */
	public int getBegin() {
		begin = (currentPage - 1) * pageSize;
		return begin;
	}
	
	public void setBegin(int begin) {
		this.begin = begin;
	}
	
	
	public void setEnd(int end) {
		this.end = end;
	}

	public int getEnd() {
		end = currentPage * pageSize + 1;
		return end;
	}

	public int getTotalPage() {
		totalPage=rows % pageSize == 0 ? rows/pageSize : rows/pageSize+1;
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
		
		/*
		 * 总行数发生改变时,可能引起总页数的变化,
		 * 从而可能导致当前页大于总页数,在此处理一下这个情况.
		 */
		if (currentPage > getTotalPage()) {
			currentPage = getTotalPage();
		}
	}

	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", pageSize=" + pageSize + ", begin=" + begin + ", end=" + end
				+ ", rows=" + rows + ", totalPage=" + totalPage + "]";
	}
	
}
