package cn.kepu.questionnaire.pojo;

/**
 * TnQuestionnaireItemChoice entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnQuestionnaireItemChoice implements java.io.Serializable {

	// Fields

	private Integer id;
	private TnQuestionnaireItem tnQuestionnaireItem;        //问卷 多对一
	private Integer choiceNo;
	private String choiceContent;
	private Integer allowOtherInput;
	private Character choiceCode;
	private String statisticsPercent;//答题百分�?	private Integer statisticsPerson;//答题人数
	
	// Constructors

	

	/** default constructor */
	public TnQuestionnaireItemChoice() {
	}

	/** minimal constructor */
	public TnQuestionnaireItemChoice(Integer itemId) {
	//	this.itemId = itemId;
	}

	/** full constructor */
	public TnQuestionnaireItemChoice(Integer itemId, Integer choiceNo,
			String choiceContent) {
	//	this.itemId = itemId;
		this.choiceNo = choiceNo;
		this.choiceContent = choiceContent;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}



	public TnQuestionnaireItem getTnQuestionnaireItem() {
		return tnQuestionnaireItem;
	}

	public void setTnQuestionnaireItem(TnQuestionnaireItem tnQuestionnaireItem) {
		this.tnQuestionnaireItem = tnQuestionnaireItem;
	}

	public Integer getChoiceNo() {
		return this.choiceNo;
	}

	public void setChoiceNo(Integer choiceNo) {
		this.choiceNo = choiceNo;
	}

	public String getChoiceContent() {
		return this.choiceContent;
	}

	public void setChoiceContent(String choiceContent) {
		this.choiceContent = choiceContent;
	}

	public Integer getAllowOtherInput() {
		return allowOtherInput;
	}

	public void setAllowOtherInput(Integer allowOtherInput) {
		this.allowOtherInput = allowOtherInput;
	}

	public Character getChoiceCode() {
		return choiceCode;
	}

	public void setChoiceCode(Character choiceCode) {
		this.choiceCode = choiceCode;
	}

	public String getStatisticsPercent() {
		return statisticsPercent;
	}

	public void setStatisticsPercent(String statisticsPercent) {
		this.statisticsPercent = statisticsPercent;
	}

//	public Integer getStatisticsPerson() {
//		return statisticsPerson;
//	}
//
//	public void setStatisticsPerson(Integer statisticsPerson) {
//		this.statisticsPerson = statisticsPerson;
//	}



	
}