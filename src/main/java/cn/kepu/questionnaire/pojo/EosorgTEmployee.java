package cn.kepu.questionnaire.pojo;

import java.util.Date;

/**
 * EosorgTEmployee generated by MyEclipse Persistence Tools
 */

public class EosorgTEmployee implements java.io.Serializable {

	// Fields

	private Integer operatorId;

	private String empCode;
	private Integer orgId;
	
	private String orgName;

	//Employee nv1 Organization 
	private EosorgTOrganization eosorgTOrganization;

	private String positionId;

	private String otel1;

	private String otel2;

	private String oemail;

	private String htel;

	private String haddress;

	private String zipCode;

	private String ptel1;

	private String ptel2;

	private String pemail;

	private String pid;

	private Date birthDate;

	private Integer gender;

	private String party;

	private String degree;

	private String major;

	private String hobby;

	private String specialty;

	private String workExp;

	private String training;
	
//	��ְʱ��
	private Date regDate;

	private String faxNo;

	private String mobileNo;

	private String bpno;

	private Date createTime;

	private Date lastModifyTime;

	private String empstatus;

	private String custcolumn;

	private Integer sortid;

	private String custnotice;

	private String custnoticename;

	private String orggrade;

	private String address;

	private Integer netdiskSize;

	private Integer defaultdiskSize;

	private String ismobileenc;

	private String emptype;

	private String sendDatachgNum;

	private String recDatachgNum;
	
//	ְ��
	private String title;
//  ְ��
	private String job;
//	��λ
	private String position;
	
	private String type;
	private String suggestion;
	
	private String emailPwd;
	private String emailHost;
	private Integer emailSetEnable;
	private Integer isTip;
	

	private Integer isCtnEduRequire;

	private Integer newEmployeeYear;
	
	

	public Integer getIsTip() {
		return isTip;
	}

	public void setIsTip(Integer isTip) {
		this.isTip = isTip;
	}

	private Eosoperator eosoperator;

	// Constructors

	public Eosoperator getEosoperator() {
		return eosoperator;
	}

	public void setEosoperator(Eosoperator eosoperator) {
		this.eosoperator = eosoperator;
	}

	/** default constructor */
	public EosorgTEmployee() {
	}


	// Property accessors

	public Integer getOperatorId() {
		return this.operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public String getEmpCode() {
		return this.empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getPositionId() {
		return this.positionId;
	}

	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}

	public String getOtel1() {
		return this.otel1;
	}

	public void setOtel1(String otel1) {
		this.otel1 = otel1;
	}

	public String getOtel2() {
		return this.otel2;
	}

	public void setOtel2(String otel2) {
		this.otel2 = otel2;
	}

	public String getOemail() {
		return this.oemail;
	}

	public void setOemail(String oemail) {
		this.oemail = oemail;
	}

	public String getHtel() {
		return this.htel;
	}

	public void setHtel(String htel) {
		this.htel = htel;
	}

	public String getHaddress() {
		return this.haddress;
	}

	public void setHaddress(String haddress) {
		this.haddress = haddress;
	}

	public String getZipCode() {
		return this.zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getPtel1() {
		return this.ptel1;
	}

	public void setPtel1(String ptel1) {
		this.ptel1 = ptel1;
	}

	public String getPtel2() {
		return this.ptel2;
	}

	public void setPtel2(String ptel2) {
		this.ptel2 = ptel2;
	}

	public String getPemail() {
		return this.pemail;
	}

	public void setPemail(String pemail) {
		this.pemail = pemail;
	}

	public String getPid() {
		return this.pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Date getBirthDate() {
		return this.birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public Integer getGender() {
		return this.gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getParty() {
		return this.party;
	}

	public void setParty(String party) {
		this.party = party;
	}

	public String getDegree() {
		return this.degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getMajor() {
		return this.major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getHobby() {
		return this.hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getSpecialty() {
		return this.specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	public String getWorkExp() {
		return this.workExp;
	}

	public void setWorkExp(String workExp) {
		this.workExp = workExp;
	}

	public String getTraining() {
		return this.training;
	}

	public void setTraining(String training) {
		this.training = training;
	}

	public Date getRegDate() {
		return this.regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getFaxNo() {
		return this.faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getMobileNo() {
		return this.mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getBpno() {
		return this.bpno;
	}

	public void setBpno(String bpno) {
		this.bpno = bpno;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastModifyTime() {
		return this.lastModifyTime;
	}

	public void setLastModifyTime(Date lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public String getEmpstatus() {
		return this.empstatus;
	}

	public void setEmpstatus(String empstatus) {
		this.empstatus = empstatus;
	}

	public String getCustcolumn() {
		return this.custcolumn;
	}

	public void setCustcolumn(String custcolumn) {
		this.custcolumn = custcolumn;
	}

	public Integer getSortid() {
		return this.sortid;
	}

	public void setSortid(Integer sortid) {
		this.sortid = sortid;
	}

	public String getCustnotice() {
		return this.custnotice;
	}

	public void setCustnotice(String custnotice) {
		this.custnotice = custnotice;
	}

	public String getCustnoticename() {
		return this.custnoticename;
	}

	public void setCustnoticename(String custnoticename) {
		this.custnoticename = custnoticename;
	}

	public String getOrggrade() {
		return this.orggrade;
	}

	public void setOrggrade(String orggrade) {
		this.orggrade = orggrade;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getNetdiskSize() {
		return this.netdiskSize;
	}

	public void setNetdiskSize(Integer netdiskSize) {
		this.netdiskSize = netdiskSize;
	}

	public Integer getDefaultdiskSize() {
		return this.defaultdiskSize;
	}

	public void setDefaultdiskSize(Integer defaultdiskSize) {
		this.defaultdiskSize = defaultdiskSize;
	}

	public String getIsmobileenc() {
		return this.ismobileenc;
	}

	public void setIsmobileenc(String ismobileenc) {
		this.ismobileenc = ismobileenc;
	}

	public String getEmptype() {
		return this.emptype;
	}

	public void setEmptype(String emptype) {
		this.emptype = emptype;
	}

	public String getSendDatachgNum() {
		return this.sendDatachgNum;
	}

	public void setSendDatachgNum(String sendDatachgNum) {
		this.sendDatachgNum = sendDatachgNum;
	}

	public String getRecDatachgNum() {
		return this.recDatachgNum;
	}

	public void setRecDatachgNum(String recDatachgNum) {
		this.recDatachgNum = recDatachgNum;
	}

	public EosorgTOrganization getEosorgTOrganization() {
		return eosorgTOrganization;
	}

	public void setEosorgTOrganization(EosorgTOrganization eosorgTOrganization) {
		this.eosorgTOrganization = eosorgTOrganization;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSuggestion() {
		return suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	public String getEmailPwd() {
		return emailPwd;
	}

	public void setEmailPwd(String emailPwd) {
		this.emailPwd = emailPwd;
	}

	public String getEmailHost() {
		return emailHost;
	}

	public void setEmailHost(String emailHost) {
		this.emailHost = emailHost;
	}

	public Integer getEmailSetEnable() {
		return emailSetEnable;
	}

	public void setEmailSetEnable(Integer emailSetEnable) {
		this.emailSetEnable = emailSetEnable;
	}

	
	public Integer getIsCtnEduRequire() {
		return isCtnEduRequire;
	}

	public void setIsCtnEduRequire(Integer isCtnEduRequire) {
		this.isCtnEduRequire = isCtnEduRequire;
	}

	public Integer getNewEmployeeYear() {
		return newEmployeeYear;
	}

	public void setNewEmployeeYear(Integer newEmployeeYear) {
		this.newEmployeeYear = newEmployeeYear;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	
}