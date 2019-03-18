package cn.kepu.questionnaire.pojo;


/**
 * TnQuestionnaireItemAnswer entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnQuestionnaireItemAnswer implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer itemID;
	private String answer;
	private String answerID;
	private Integer Qn_id;
	private String otherAnswer;
	// Constructors

	/** default constructor */
	public TnQuestionnaireItemAnswer() {
	}

	/** minimal constructor */
	public TnQuestionnaireItemAnswer(Integer itemId, Integer qnId) {
	//	this.itemId = itemId;
	}

	/** full constructor */
	public TnQuestionnaireItemAnswer(Integer itemId, String answer, Integer qnId) {
	//	this.itemId = itemId;
		this.answer = answer;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Integer getItemID() {
		return itemID;
	}

	public void setItemID(Integer itemID) {
		this.itemID = itemID;
	}

	public Integer getQn_id() {
		return Qn_id;
	}

	public void setQn_id(Integer qn_id) {
		Qn_id = qn_id;
	}

	public String getOtherAnswer() {
		return otherAnswer;
	}

	public void setOtherAnswer(String otherAnswer) {
		this.otherAnswer = otherAnswer;
	}

	public String getAnswerID() {
		return answerID;
	}

	public void setAnswerID(String answerID) {
		this.answerID = answerID;
	}



}