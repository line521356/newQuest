package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.sql.Date;

public class RecordVideo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8180272535086524517L;
	
	private Integer rVidId;
	private String rVidName;
	private String rVidFormat;
	private Integer rVidSize;
	private String rVidUrl;
	private String skchImgUrl;
	private Date startTime;
	private Integer mptId;
	private Integer oprId;
	
	public RecordVideo() {
		super();
	}

	public RecordVideo(Integer rVidId, String rVidName, String rVidFormat, Integer rVidSize, String rVidUrl,
			String skchImgUrl, Date startTime, Integer mptId, Integer oprId) {
		super();
		this.rVidId = rVidId;
		this.rVidName = rVidName;
		this.rVidFormat = rVidFormat;
		this.rVidSize = rVidSize;
		this.rVidUrl = rVidUrl;
		this.skchImgUrl = skchImgUrl;
		this.startTime = startTime;
		this.mptId = mptId;
		this.oprId = oprId;
	}

	public Integer getrVidId() {
		return rVidId;
	}

	public void setrVidId(Integer rVidId) {
		this.rVidId = rVidId;
	}

	public String getrVidName() {
		return rVidName;
	}

	public void setrVidName(String rVidName) {
		this.rVidName = rVidName;
	}

	public String getrVidFormat() {
		return rVidFormat;
	}

	public void setrVidFormat(String rVidFormat) {
		this.rVidFormat = rVidFormat;
	}

	public Integer getrVidSize() {
		return rVidSize;
	}

	public void setrVidSize(Integer rVidSize) {
		this.rVidSize = rVidSize;
	}

	public String getrVidUrl() {
		return rVidUrl;
	}

	public void setrVidUrl(String rVidUrl) {
		this.rVidUrl = rVidUrl;
	}

	public String getSkchImgUrl() {
		return skchImgUrl;
	}

	public void setSkchImgUrl(String skchImgUrl) {
		this.skchImgUrl = skchImgUrl;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Integer getMptId() {
		return mptId;
	}

	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}

	public Integer getOprId() {
		return oprId;
	}

	public void setOprId(Integer oprId) {
		this.oprId = oprId;
	}

	@Override
	public String toString() {
		return "RecordVideo [rVidId=" + rVidId + ", rVidName=" + rVidName + ", rVidFormat=" + rVidFormat + ", rVidSize="
				+ rVidSize + ", rVidUrl=" + rVidUrl + ", skchImgUrl=" + skchImgUrl + ", startTime=" + startTime
				+ ", mptId=" + mptId + ", oprId=" + oprId + "]";
	}
	
	
	
	
	
	

}
