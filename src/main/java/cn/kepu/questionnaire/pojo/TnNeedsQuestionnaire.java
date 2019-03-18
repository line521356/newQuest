package cn.kepu.questionnaire.pojo;

import java.util.Date;



/**
 * TnNeedsQuestionnaire entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnNeedsQuestionnaire implements java.io.Serializable {

	// Fields

	private Integer ID;
	private String theme;
	private Date startTime;
	private Date endTime;
	private Integer pubStatus;
	private Integer pubUserID;
	private String remark;
	private int joinCount;
	private int finishCount;
	private Integer orgId;
	private Integer trainId;
	private Integer sendMail;
	private Integer ifAnonymous;
	private String publishAddr;
	private Integer tenantId;
	
	// Constructors


	/** default constructor */
	public TnNeedsQuestionnaire() {
	}

	/** minimal constructor */
	public TnNeedsQuestionnaire(String theme) {
		this.theme = theme;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	/** full constructor */
	public TnNeedsQuestionnaire(String theme, Date startTime, Date endTime,
			Integer pubStatus, Long pubUserId, String remark) {
		this.theme = theme;
		this.startTime = startTime;
		this.endTime = endTime;
		this.pubStatus = pubStatus;
	//	this.pubUserId = pubUserId;
		this.remark = remark;
	}

	// Property accessors

	public Integer getID() {
		return this.ID;
	}

	public void setID(Integer ID) {
		this.ID = ID;
	}

	public String getTheme() {
		return this.theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getPubStatus() {
		return this.pubStatus;
	}

	public void setPubStatus(Integer pubStatus) {
		this.pubStatus = pubStatus;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getJoinCount() {
		return joinCount;
	}

	public void setJoinCount(int joinCount) {
		this.joinCount = joinCount;
	}

	public int getFinishCount() {
		return finishCount;
	}

	public void setFinishCount(int finishCount) {
		this.finishCount = finishCount;
	}

	public Integer getPubUserID() {
		return pubUserID;
	}

	public void setPubUserID(Integer pubUserID) {
		this.pubUserID = pubUserID;
	}

	public Integer getTrainId() {
		return trainId;
	}

	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}

	public Integer getSendMail() {
		return sendMail;
	}

	public void setSendMail(Integer sendMail) {
		this.sendMail = sendMail;
	}

	public Integer getIfAnonymous() {
		return ifAnonymous;
	}

	public String getPublishAddr() {
		return publishAddr;
	}

	public void setPublishAddr(String publishAddr) {
		this.publishAddr = publishAddr;
	}

	public void setIfAnonymous(Integer ifAnonymous) {
		this.ifAnonymous = ifAnonymous;
	}

	public Integer getTenantId() {
		return tenantId;
	}

	public void setTenantId(Integer tenantId) {
		this.tenantId = tenantId;
	}

	@Override
	public String toString() {
		return "TnNeedsQuestionnaire [ID=" + ID + ", theme=" + theme
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", pubStatus=" + pubStatus + ", pubUserID=" + pubUserID
				+ ", remark=" + remark + ", joinCount=" + joinCount
				+ ", finishCount=" + finishCount + ", orgId=" + orgId
				+ ", trainId=" + trainId + ", sendMail=" + sendMail
				+ ", ifAnonymous=" + ifAnonymous + ", publishAddr="
				+ publishAddr + ", tenantId=" + tenantId + "]";
	}

	
	
	
	
	
	
	
	
}