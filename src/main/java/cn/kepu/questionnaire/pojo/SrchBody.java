package cn.kepu.questionnaire.pojo;

/**
 * 非实体类，为搜索条件集合的对象
 */

import java.io.Serializable;
import java.sql.Date;

public class SrchBody implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3990285882185719972L;
	
	private Date startDate;
	private Date endDate;
	private Integer vidType;
	private String srchRange;
	private Integer mptInfoType;
	private String mptInfoDesc;
	private String mptInfo;
	private Integer mptId;
	private Integer vidId;

	
	public SrchBody() {
		super();
	}

	public SrchBody(Date startDate, Date endDate, Integer vidType, String srchRange, Integer mptInfoType,
			String mptInfoDesc, String mptInfo, Integer mptId, Integer vidId) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.vidType = vidType;
		this.srchRange = srchRange;
		this.mptInfoType = mptInfoType;
		this.mptInfoDesc = mptInfoDesc;
		this.mptInfo = mptInfo;
		this.mptId = mptId;
		this.vidId = vidId;
	}



	
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getVidType() {
		return vidType;
	}

	public void setVidType(Integer vidType) {
		this.vidType = vidType;
	}

	public String getSrchRange() {
		return srchRange;
	}

	public void setSrchRange(String srchRange) {
		this.srchRange = srchRange;
	}

	public Integer getMptInfoType() {
		return mptInfoType;
	}

	public void setMptInfoType(Integer mptInfoType) {
		this.mptInfoType = mptInfoType;
	}

	public String getMptInfoDesc() {
		return mptInfoDesc;
	}

	public void setMptInfoDesc(String mptInfoDesc) {
		this.mptInfoDesc = mptInfoDesc;
	}

	public String getMptInfo() {
		return mptInfo;
	}

	public void setMptInfo(String mptInfo) {
		this.mptInfo = mptInfo;
	}
	

	public Integer getMptId() {
		return mptId;
	}

	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}

	public Integer getVidId() {
		return vidId;
	}

	public void setVidId(Integer vidId) {
		this.vidId = vidId;
	}

	@Override
	public String toString() {
		return "SrchBody [startDate=" + startDate + ", endDate=" + endDate + ", vidType=" + vidType + ", srchRange="
				+ srchRange + ", mptInfoType=" + mptInfoType + ", mptInfoDesc=" + mptInfoDesc + ", mptInfo=" + mptInfo
				+ ", mptId=" + mptId + ", vidId=" + vidId + "]";
	}

	
	

	

	
	
	

}
