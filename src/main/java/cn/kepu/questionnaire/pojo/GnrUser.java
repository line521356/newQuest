package cn.kepu.questionnaire.pojo;

import java.io.Serializable;

public class GnrUser implements Serializable{

	
	private static final long serialVersionUID = -6312931711749121391L;
	
	private Integer gnrUserId;
	
	private String gnrUserName;
	
	private String gnrUserPwd;
	
	private Integer gusClubCount;
	
	private String gusClassName;
	
	private String gusGrade;
	
	private Integer gusActCount;

	private Integer userRight;
	
	private String userGroup;
	
	private String userEmail;
	
	private String userPhone;

	private String wechatName;
	
	
	public GnrUser() {
		super();
	}
	
	public GnrUser(Integer gnrUserId, String gnrUserName, String gnrUserPwd, Integer gusClubCount, String gusClassName,
			String gusGrade, Integer gusActCount, Integer userRight, String userGroup, String userEmail,
			String userPhone) {
		super();
		this.gnrUserId = gnrUserId;
		this.gnrUserName = gnrUserName;
		this.gnrUserPwd = gnrUserPwd;
		this.gusClubCount = gusClubCount;
		this.gusClassName = gusClassName;
		this.gusGrade = gusGrade;
		this.gusActCount = gusActCount;
		this.userRight = userRight;
		this.userGroup = userGroup;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
	}


	public Integer getGnrUserId() {
		return gnrUserId;
	}

	public void setGnrUserId(Integer gnrUserId) {
		this.gnrUserId = gnrUserId;
	}

	public String getGnrUserName() {
		return gnrUserName;
	}

	public void setGnrUserName(String gnrUserName) {
		this.gnrUserName = gnrUserName;
	}

	public String getGnrUserPwd() {
		return gnrUserPwd;
	}

	public void setGnrUserPwd(String gnrUserPwd) {
		this.gnrUserPwd = gnrUserPwd;
	}

	public Integer getGusClubCount() {
		return gusClubCount;
	}

	public void setGusClubCount(Integer gusClubCount) {
		this.gusClubCount = gusClubCount;
	}

	public String getGusClassName() {
		return gusClassName;
	}

	public void setGusClassName(String gusClassName) {
		this.gusClassName = gusClassName;
	}

	public String getGusGrade() {
		return gusGrade;
	}

	public void setGusGrade(String gusGrade) {
		this.gusGrade = gusGrade;
	}

	public Integer getGusActCount() {
		return gusActCount;
	}

	public void setGusActCount(Integer gusActCount) {
		this.gusActCount = gusActCount;
	}
		
	public Integer getUserRight() {
		return userRight;
	}


	public void setUserRight(Integer userRight) {
		this.userRight = userRight;
	}	

	public String getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(String userGroup) {
		this.userGroup = userGroup;
	}
		
	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	@Override
	public String toString() {
		return "GnrUser [gnrUserId=" + gnrUserId + ", gnrUserName=" + gnrUserName + ", gnrUserPwd=" + gnrUserPwd
				+ ", gusClubCount=" + gusClubCount + ", gusClassName=" + gusClassName + ", gusGrade=" + gusGrade
				+ ", gusActCount=" + gusActCount + ", userRight=" + userRight + ", userGroup=" + userGroup
				+ ", userEmail=" + userEmail + ", userPhone=" + userPhone + "]";
	}

	public String getWechatName() {
		return wechatName;
	}

	public void setWechatName(String wechatName) {
		this.wechatName = wechatName;
	}
}
