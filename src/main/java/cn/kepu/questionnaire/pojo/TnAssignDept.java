package cn.kepu.questionnaire.pojo;



/**
 * TnAssignDept entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnAssignDept implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private TnNeedsQuestionnaire  tnNeedsQuestionnaire ;
	private EosorgTOrganization  dept;

	// Constructors

	/** default constructor */
	public TnAssignDept() {
	}

	/** full constructor */
	public TnAssignDept(Integer basicInfoId, Integer deptId) {
//		this.basicInfoId = basicInfoId;
//		this.deptId = deptId;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public TnNeedsQuestionnaire getTnNeedsQuestionnaire() {
		return tnNeedsQuestionnaire;
	}

	public void setTnNeedsQuestionnaire(TnNeedsQuestionnaire tnNeedsQuestionnaire) {
		this.tnNeedsQuestionnaire = tnNeedsQuestionnaire;
	}

	public EosorgTOrganization getDept() {
		return dept;
	}

	public void setDept(EosorgTOrganization dept) {
		this.dept = dept;
	}

	

}