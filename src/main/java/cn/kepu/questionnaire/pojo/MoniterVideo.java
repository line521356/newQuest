package cn.kepu.questionnaire.pojo;

import java.io.Serializable;
import java.sql.Date;

public class MoniterVideo implements Serializable{

	
	
	private static final long serialVersionUID = -7327842159310939825L;
	
	private Integer mVidId;
	private String mVidName;
	private Date mVidGrnTime;
	private String mVidUrl;
	private String mSkchImgUrl;
	private Integer mptId;
	
		
	public MoniterVideo() {
		super();
	}


	public MoniterVideo(Integer mVidId, String mVidName, Date mVidGrnTime, String mVidUrl, String mSkchImgUrl,
			Integer mptId) {
		super();
		this.mVidId = mVidId;
		this.mVidName = mVidName;
		this.mVidGrnTime = mVidGrnTime;
		this.mVidUrl = mVidUrl;
		this.mSkchImgUrl = mSkchImgUrl;
		this.mptId = mptId;
	}






	public Integer getmVidId() {
		return mVidId;
	}
	public void setmVidId(Integer mVidId) {
		this.mVidId = mVidId;
	}
	public String getmVidName() {
		return mVidName;
	}
	public void setmVidName(String mVidName) {
		this.mVidName = mVidName;
	}
	public Date getmVidGrnTime() {
		return mVidGrnTime;
	}
	public void setmVidGrnTime(Date mVidGrnTime) {
		this.mVidGrnTime = mVidGrnTime;
	}
	public String getmVidUrl() {
		return mVidUrl;
	}
	public void setmVidUrl(String mVidUrl) {
		this.mVidUrl = mVidUrl;
	}	
	
	public String getmSkchImgUrl() {
		return mSkchImgUrl;
	}


	public void setmSkchImgUrl(String mSkchImgUrl) {
		this.mSkchImgUrl = mSkchImgUrl;
	}


	public Integer getMptId() {
		return mptId;
	}


	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}


	@Override
	public String toString() {
		return "MoniterVideo [mVidId=" + mVidId + ", mVidName=" + mVidName + ", mVidGrnTime=" + mVidGrnTime
				+ ", mVidUrl=" + mVidUrl + ", mSkchImgUrl=" + mSkchImgUrl + ", mptId=" + mptId + "]";
	}


	


	
	
	
	
	
}
