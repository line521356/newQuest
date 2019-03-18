package cn.kepu.questionnaire.pojo;

import java.sql.Date;

/**
 * 截图
 * @author SilentWhale
 *
 */
public class ShotCutImg {

	Integer scImgId;
	String scImgName;
	Integer scImgSize;
	String scImgUrl;
	String createTime;
	Integer scImgType;    //截图类型，分为从视频源直接截取和从视屏播放流中截取：1视频源截取，2监控视频，3手动录制视频，4报警视频
	Integer vidId;		  //如果是从视频播放流中截取则需与视频关联
	Integer mptId;
	Integer crewID;
	
	MonitorPoint srcMonitor;		//截图来源监控点
	Crew srcCrew;					//截图当天值守人员
	
	
	public ShotCutImg() {
		super();
	}
			
	public ShotCutImg(Integer scImgId, String scImgName, Integer scImgSize, String scImgUrl, String createTime,
			Integer scImgType, Integer vidId, Integer mptId, Integer crewID, MonitorPoint srcMonitor, Crew srcCrew) {
		super();
		this.scImgId = scImgId;
		this.scImgName = scImgName;
		this.scImgSize = scImgSize;
		this.scImgUrl = scImgUrl;
		this.createTime = createTime;
		this.scImgType = scImgType;
		this.vidId = vidId;
		this.mptId = mptId;
		this.crewID = crewID;
		this.srcMonitor = srcMonitor;
		this.srcCrew = srcCrew;
	}


	public Integer getScImgId() {
		return scImgId;
	}
	public void setScImgId(Integer scImgId) {
		this.scImgId = scImgId;
	}
	public String getScImgName() {
		return scImgName;
	}
	public void setScImgName(String scImgName) {
		this.scImgName = scImgName;
	}
	public Integer getScImgSize() {
		return scImgSize;
	}
	public void setScImgSize(Integer scImgSize) {
		this.scImgSize = scImgSize;
	}
	public String getScImgUrl() {
		return scImgUrl;
	}
	public void setScImgUrl(String scImgUrl) {
		this.scImgUrl = scImgUrl;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getScImgType() {
		return scImgType;
	}
	public void setScImgType(Integer scImgType) {
		this.scImgType = scImgType;
	}
	public Integer getVidId() {
		return vidId;
	}
	public void setVidId(Integer vidId) {
		this.vidId = vidId;
	}
		
	public Integer getMptId() {
		return mptId;
	}

	public void setMptId(Integer mptId) {
		this.mptId = mptId;
	}

	public Integer getCrewID() {
		return crewID;
	}

	public void setCrewID(Integer crewID) {
		this.crewID = crewID;
	}

	public MonitorPoint getSrcMonitor() {
		return srcMonitor;
	}

	public void setSrcMonitor(MonitorPoint srcMonitor) {
		this.srcMonitor = srcMonitor;
	}

	public Crew getSrcCrew() {
		return srcCrew;
	}

	public void setSrcCrew(Crew srcCrew) {
		this.srcCrew = srcCrew;
	}

	@Override
	public String toString() {
		return "ShotCutImg [scImgId=" + scImgId + ", scImgName=" + scImgName + ", scImgSize=" + scImgSize
				+ ", scImgUrl=" + scImgUrl + ", createTime=" + createTime + ", scImgType=" + scImgType + ", vidId="
				+ vidId + ", mptId=" + mptId + ", crewID=" + crewID + ", srcMonitor=" + srcMonitor + ", srcCrew="
				+ srcCrew + "]";
	}

	
}
