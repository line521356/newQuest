package cn.kepu.questionnaire.pojo;

import java.sql.Date;

/**
 * 工具类
 * 视频详细信息，用于视频详情页，包括3个表的信息：所属类型表、监控点表、报警记录表
 * @author SilentWhale
 *
 */
public class VideoDetInfo {

	
	Integer vidID;
	String vidName;    //视频名称
	Date startTime;	   //录制时间
	String mptName;    //监控点名称
	String mptIP;	   //监控点IP
	Integer lattitude; //监控点经纬高度信息
	Integer longtitude;
	Integer height;
	Date alarmTime;	 	//报警时间
	Integer isConfirm;	//火情是否确认
	Integer isAlarmed;  //是否已报警
	
	Integer mptId;      //外键，监控点ID
	Integer aRecId;		//外键，报警记录ID
	
	
	public VideoDetInfo() {
		super();
	}
	
	public VideoDetInfo(Integer vidID, String vidName, Date startTime, String mptName, String mptIP, Integer lattitude,
			Integer longtitude, Integer height, Date alarmTime, Integer isConfirm, Integer isAlarmed, Integer mptId,
			Integer aRecId) {
		super();
		this.vidID = vidID;
		this.vidName = vidName;
		this.startTime = startTime;
		this.mptName = mptName;
		this.mptIP = mptIP;
		this.lattitude = lattitude;
		this.longtitude = longtitude;
		this.height = height;
		this.alarmTime = alarmTime;
		this.isConfirm = isConfirm;
		this.isAlarmed = isAlarmed;
		this.mptId = mptId;
		this.aRecId = aRecId;
	}

	public Integer getVidID() {
		return vidID;
	}
	public void setVidID(Integer vidID) {
		this.vidID = vidID;
	}
	public String getVidName() {
		return vidName;
	}
	public void setVidName(String vidName) {
		this.vidName = vidName;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getMptName() {
		return mptName;
	}
	public void setMptName(String mptName) {
		this.mptName = mptName;
	}
	public String getMptIP() {
		return mptIP;
	}
	public void setMptIP(String mptIP) {
		this.mptIP = mptIP;
	}
	public Integer getLattitude() {
		return lattitude;
	}
	public void setLattitude(Integer lattitude) {
		this.lattitude = lattitude;
	}
	public Integer getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(Integer longtitude) {
		this.longtitude = longtitude;
	}
	public Integer getHeight() {
		return height;
	}
	public void setHeight(Integer height) {
		this.height = height;
	}
	public Date getAlarmTime() {
		return alarmTime;
	}
	public void setAlarmTime(Date alarmTime) {
		this.alarmTime = alarmTime;
	}
	public Integer getIsConfirm() {
		return isConfirm;
	}
	public void setIsConfirm(Integer isConfirm) {
		this.isConfirm = isConfirm;
	}
	public Integer getIsAlarmed() {
		return isAlarmed;
	}
	public void setIsAlarmed(Integer isAlarmed) {
		this.isAlarmed = isAlarmed;
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
		return "VideoDetInfo [vidID=" + vidID + ", vidName=" + vidName + ", startTime=" + startTime + ", mptName="
				+ mptName + ", mptIP=" + mptIP + ", lattitude=" + lattitude + ", longtitude=" + longtitude + ", height="
				+ height + ", alarmTime=" + alarmTime + ", isConfirm=" + isConfirm + ", isAlarmed=" + isAlarmed
				+ ", mptId=" + mptId + ", aRecId=" + aRecId + "]";
	}

	
	
	
	
	
}
