package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.sql.Date;

public class AlarmVideo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4067495905194077642L;
	
	private Integer aVidId;
	private String aVidName;
	private String aVidFormat;
	private Integer aVidSize;
	private String aVidUrl;
	private String skchImgUrl;
	private Date startTime;
	private Integer mptId;
	private Integer aRecId;
	
	public AlarmVideo() {
		super();
	}

	public AlarmVideo(Integer aVidId, String aVidName, String aVidFormat, Integer aVidSize, String aVidUrl,
			String skchImgUrl, Date startTime, Integer mptId, Integer aRecId) {
		super();
		this.aVidId = aVidId;
		this.aVidName = aVidName;
		this.aVidFormat = aVidFormat;
		this.aVidSize = aVidSize;
		this.aVidUrl = aVidUrl;
		this.skchImgUrl = skchImgUrl;
		this.startTime = startTime;
		this.mptId = mptId;
		this.aRecId = aRecId;
	}

	public Integer getaVidId() {
		return aVidId;
	}

	public void setaVidId(Integer aVidId) {
		this.aVidId = aVidId;
	}

	public String getaVidName() {
		return aVidName;
	}

	public void setaVidName(String aVidName) {
		this.aVidName = aVidName;
	}

	public String getaVidFormat() {
		return aVidFormat;
	}

	public void setaVidFormat(String aVidFormat) {
		this.aVidFormat = aVidFormat;
	}

	public Integer getaVidSize() {
		return aVidSize;
	}

	public void setaVidSize(Integer aVidSize) {
		this.aVidSize = aVidSize;
	}

	public String getaVidUrl() {
		return aVidUrl;
	}

	public void setaVidUrl(String aVidUrl) {
		this.aVidUrl = aVidUrl;
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

	public Integer getaRecId() {
		return aRecId;
	}

	public void setaRecId(Integer aRecId) {
		this.aRecId = aRecId;
	}

	@Override
	public String toString() {
		return "AlarmVideo [aVidId=" + aVidId + ", aVidName=" + aVidName + ", aVidFormat=" + aVidFormat + ", aVidSize="
				+ aVidSize + ", aVidUrl=" + aVidUrl + ", skchImgUrl=" + skchImgUrl + ", startTime=" + startTime
				+ ", mptId=" + mptId + ", aRecId=" + aRecId + "]";
	}
	
	
	
	
	
}
