package cn.kepu.questionnaire.pojo;


/**
 * TnAssignUser entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnAssignUser implements java.io.Serializable {

	// Fields

	private Integer id;
	private TnNeedsQuestionnaire  tnNeedsQuestionnaire ;
	private Eosoperator user;

	// Constructors

	/** default constructor */
	public TnAssignUser() {
	}

	/** full constructor */
	public TnAssignUser(Integer basicInfoId, Integer userId) {
//		this.basicInfoId = basicInfoId;
//		this.userId = userId;
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

	public Eosoperator getUser() {
		return user;
	}

	public void setUser(Eosoperator user) {
		this.user = user;
	}

	

}