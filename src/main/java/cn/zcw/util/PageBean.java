package cn.zcw.util;

import java.util.List;

//分页bean
public class PageBean<T> {
	private List<T> datas;//集合数据
	private Integer pageno;//当前页码
	//private Integer totalno;//总页码
	private Integer pagesize;//每页显示条数
	private Integer totalsize;//总条数

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}

	public Integer getPageno() {
		return pageno;
	}

	public void setPageno(Integer pageno) {
		this.pageno = pageno;
	}



	public Integer getPagesize() {
		return pagesize;
	}

	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}

	public Integer getTotalsize() {
		return totalsize;
	}

	public void setTotalsize(Integer totalsize) {
		this.totalsize = totalsize;
	}

	public int getLeftLimit(){
		return (pageno-1)*pagesize;
	}

	public Integer getTotalno() {
		return totalsize%pagesize==0?totalsize/pagesize:totalsize/pagesize+1;
	}
}
