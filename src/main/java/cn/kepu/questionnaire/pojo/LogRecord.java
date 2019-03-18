package cn.kepu.questionnaire.pojo;

import java.util.Date;

public class LogRecord {

	Integer logID;
	String logDate;
	String logger;
	String logLev;
	String logMsg;
	Integer userID;
	String userName;
	
	public LogRecord() {
		super();
	}

	public LogRecord(Integer logID, String logDate, String logger, String logLev, String logMsg, Integer userID,
			String userName) {
		super();
		this.logID = logID;
		this.logDate = logDate;
		this.logger = logger;
		this.logLev = logLev;
		this.logMsg = logMsg;
		this.userID = userID;
		this.userName = userName;
	}

	public Integer getLogID() {
		return logID;
	}

	public void setLogID(Integer logID) {
		this.logID = logID;
	}

	public String getLogDate() {
		return logDate;
	}

	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}

	public String getLogger() {
		return logger;
	}

	public void setLogger(String logger) {
		this.logger = logger;
	}

	public String getLogLev() {
		return logLev;
	}

	public void setLogLev(String logLev) {
		this.logLev = logLev;
	}

	public String getLogMsg() {
		return logMsg;
	}

	public void setLogMsg(String logMsg) {
		this.logMsg = logMsg;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "LogRecord [logID=" + logID + ", logDate=" + logDate + ", logger=" + logger + ", logLev=" + logLev
				+ ", logMsg=" + logMsg + ", userID=" + userID + ", userName=" + userName + "]";
	}
	
	
	
	
}
