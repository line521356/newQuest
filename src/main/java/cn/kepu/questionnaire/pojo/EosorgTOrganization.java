package cn.kepu.questionnaire.pojo;

/**
 * EosorgTOrganization generated by MyEclipse Persistence Tools
 */

public class EosorgTOrganization implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer orgId;

	private String orgCode;

	private String orgName;

	private Integer orglevel;

	private String orgSeq;

	private String orgTypeId;

	private String orgscope;

	private String orgAddress;

	private String zipCode;

	private Integer managerid;

	private String linkman;

	private String linkmantel;

	private String email;

	private String webUrl;

	private String memo;

	private String addresscode;

	private Integer positionId;

	private String archiveNum;

	private Integer sortId;

	private String orgClass;

	private String userGroupId;

	private String datachgNum;

	private String sendDatachgNum;

	private String recDatachgNum;

	private Integer sortAll;

	private String extParam1;

	private String extParam2;
	
	private Integer isOrg;
	
	private Integer isVirOrg;
	
	private Integer attachedOrgId;
	
	private Integer status;
	
	//Organization nv1 organizationGeneral
	private EosorgTOrganization parent;
	
	private Integer tenantId;
	
	

	// Constructors

	public EosorgTOrganization getParent() {
		return parent;
	}

	public void setParent(EosorgTOrganization parent) {
		this.parent = parent;
	}

	/** default constructor */
	public EosorgTOrganization() {
	}

	/** full constructor */
	public EosorgTOrganization(String orgCode, String orgName,
			Integer orglevel, String orgSeq,
			String orgTypeId, String orgscope, String orgAddress,
			String zipCode, Integer managerid, String linkman,
			String linkmantel, String email, String webUrl, String memo,
			String addresscode, Integer positionId, String archiveNum,
			Integer sortId, String orgClass, String userGroupId,
			String datachgNum, String sendDatachgNum, String recDatachgNum,
			Integer sortAll, String extParam1, String extParam2) {
		this.orgCode = orgCode;
		this.orgName = orgName;
		this.orglevel = orglevel;
		this.orgSeq = orgSeq;
		this.orgTypeId = orgTypeId;
		this.orgscope = orgscope;
		this.orgAddress = orgAddress;
		this.zipCode = zipCode;
		this.managerid = managerid;
		this.linkman = linkman;
		this.linkmantel = linkmantel;
		this.email = email;
		this.webUrl = webUrl;
		this.memo = memo;
		this.addresscode = addresscode;
		this.positionId = positionId;
		this.archiveNum = archiveNum;
		this.sortId = sortId;
		this.orgClass = orgClass;
		this.userGroupId = userGroupId;
		this.datachgNum = datachgNum;
		this.sendDatachgNum = sendDatachgNum;
		this.recDatachgNum = recDatachgNum;
		this.sortAll = sortAll;
		this.extParam1 = extParam1;
		this.extParam2 = extParam2;
	}

	// Property accessors

	public Integer getOrgId() {
		return this.orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return this.orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Integer getOrglevel() {
		return this.orglevel;
	}

	public void setOrglevel(Integer orglevel) {
		this.orglevel = orglevel;
	}

	public String getOrgSeq() {
		return this.orgSeq;
	}

	public void setOrgSeq(String orgSeq) {
		this.orgSeq = orgSeq;
	}

	public String getOrgTypeId() {
		return this.orgTypeId;
	}

	public void setOrgTypeId(String orgTypeId) {
		this.orgTypeId = orgTypeId;
	}

	public String getOrgscope() {
		return this.orgscope;
	}

	public void setOrgscope(String orgscope) {
		this.orgscope = orgscope;
	}

	public String getOrgAddress() {
		return this.orgAddress;
	}

	public void setOrgAddress(String orgAddress) {
		this.orgAddress = orgAddress;
	}

	public String getZipCode() {
		return this.zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public Integer getManagerid() {
		return this.managerid;
	}

	public void setManagerid(Integer managerid) {
		this.managerid = managerid;
	}

	public String getLinkman() {
		return this.linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getLinkmantel() {
		return this.linkmantel;
	}

	public void setLinkmantel(String linkmantel) {
		this.linkmantel = linkmantel;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWebUrl() {
		return this.webUrl;
	}

	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}

	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getAddresscode() {
		return this.addresscode;
	}

	public void setAddresscode(String addresscode) {
		this.addresscode = addresscode;
	}

	public Integer getPositionId() {
		return this.positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	public String getArchiveNum() {
		return this.archiveNum;
	}

	public void setArchiveNum(String archiveNum) {
		this.archiveNum = archiveNum;
	}

	public Integer getSortId() {
		return this.sortId;
	}

	public void setSortId(Integer sortId) {
		this.sortId = sortId;
	}

	public String getOrgClass() {
		return this.orgClass;
	}

	public void setOrgClass(String orgClass) {
		this.orgClass = orgClass;
	}

	public String getUserGroupId() {
		return this.userGroupId;
	}

	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}

	public String getDatachgNum() {
		return this.datachgNum;
	}

	public void setDatachgNum(String datachgNum) {
		this.datachgNum = datachgNum;
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

	public Integer getSortAll() {
		return this.sortAll;
	}

	public void setSortAll(Integer sortAll) {
		this.sortAll = sortAll;
	}

	public String getExtParam1() {
		return this.extParam1;
	}

	public void setExtParam1(String extParam1) {
		this.extParam1 = extParam1;
	}

	public String getExtParam2() {
		return this.extParam2;
	}

	public void setExtParam2(String extParam2) {
		this.extParam2 = extParam2;
	}

	public Integer getIsVirOrg() {
		return isVirOrg;
	}

	public void setIsVirOrg(Integer isVirOrg) {
		this.isVirOrg = isVirOrg;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((orgId == null) ? 0 : orgId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final EosorgTOrganization other = (EosorgTOrganization) obj;
		if (orgId == null) {
			if (other.orgId != null)
				return false;
		} else if (!orgId.equals(other.orgId))
			return false;
		return true;
	}

	public Integer getIsOrg() {
		return isOrg;
	}

	public void setIsOrg(Integer isOrg) {
		this.isOrg = isOrg;
	}

	public Integer getAttachedOrgId() {
		return attachedOrgId;
	}

	public void setAttachedOrgId(Integer attachedOrgId) {
		this.attachedOrgId = attachedOrgId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getTenantId() {
		return tenantId;
	}

	public void setTenantId(Integer tenantId) {
		this.tenantId = tenantId;
	}
}