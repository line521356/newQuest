package cn.kepu.questionnaire.pojo;

/**
 * 各个单位职工的总体情况，如：单位总的在职人数
 */

public class EosorgTOrgEmpGeneral implements java.io.Serializable {

	private Integer id;

	private Integer orgId;

	private String orgCode;

	private String orgName;

	private Integer year;

//	单位在职总人数
	private Integer onJobStaffTotalNum;

	// Constructors

	/** default constructor */
	public EosorgTOrgEmpGeneral() {
	}

	/** full constructor */
	public EosorgTOrgEmpGeneral(Integer id,Integer orgId,String orgCode,String orgName,Integer year,Integer onJobStaffTotalNum) {
		this.id = id;
		this.orgId = orgId;
		this.orgCode = orgCode;
		this.orgName = orgName;
		this.year = year;
		this.onJobStaffTotalNum = onJobStaffTotalNum;
	}

	// Property accessors
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getOnJobStaffTotalNum() {
		return onJobStaffTotalNum;
	}

	public void setOnJobStaffTotalNum(Integer onJobStaffTotalNum) {
		this.onJobStaffTotalNum = onJobStaffTotalNum;
	}
	
}