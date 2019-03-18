package cn.kepu.questionnaire.pojo;


import java.util.List;





/**
 * TnQuestionnaireItem entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TnQuestionnaireItem implements java.io.Serializable {

	// Fields

	private Integer ID;
	private TnNeedsQuestionnaire  tnNeedsQuestionnaire ;    //�ʾ�  ���һ
	private Integer typeId;
	private Integer questionNo;
	private String title;
	private Integer required;
	private Integer hasOtherInput;
	private List<TnQuestionnaireItemChoice> choices;      //����ѡ�� һ�Զ�
	private List<TnQuestionnaireItemAnswer> answers;
	
	
	// Constructors

	/** default constructor */
	public TnQuestionnaireItem() {
	}

	/** minimal constructor */
	public TnQuestionnaireItem(Integer basicInfoId) {
		//this.basicInfoId = basicInfoId;
	}

	/** full constructor */
	public TnQuestionnaireItem(Integer ID,
			TnNeedsQuestionnaire tnNeedsQuestionnaire, Integer typeId,
			Integer questionNo, String title, Integer required,
			Integer hasOtherInput, List<TnQuestionnaireItemChoice> choices,
			List<TnQuestionnaireItemAnswer> answers) {
		super();
		this.ID = ID;
		this.tnNeedsQuestionnaire = tnNeedsQuestionnaire;
		this.typeId = typeId;
		this.questionNo = questionNo;
		this.title = title;
		this.required = required;
		this.hasOtherInput = hasOtherInput;
		this.choices = choices;
		this.answers = answers;
	}


	// Property accessors
	
	public Integer getRequired() {     //0503 make 添加是否必填属性
		return required;
	}

	
	public void setRequired(Integer required) {
		this.required = required;
	}
	
	

	public Integer getHasOtherInput() {   //0522 make 添加是否有其他选项属性
		return hasOtherInput;
	}

	public void setHasOtherInput(Integer hasOtherInput) {
		this.hasOtherInput = hasOtherInput;
	}
	

	public Integer getID() {
		return this.ID;
	}


	public void setID(Integer ID) {
		this.ID = ID;
	}


	public List<TnQuestionnaireItemChoice> getChoices() {
		return choices;
	}

	public void setChoices(List<TnQuestionnaireItemChoice> choices) {
		this.choices = choices;
	}

	public List<TnQuestionnaireItemAnswer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<TnQuestionnaireItemAnswer> answers) {
		this.answers = answers;
	}

	public TnNeedsQuestionnaire getTnNeedsQuestionnaire() {
		return tnNeedsQuestionnaire;
	}

	public void setTnNeedsQuestionnaire(TnNeedsQuestionnaire tnNeedsQuestionnaire) {
		this.tnNeedsQuestionnaire = tnNeedsQuestionnaire;
	}

	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getQuestionNo() {
		return this.questionNo;
	}

	public void setQuestionNo(Integer questionNo) {
		this.questionNo = questionNo;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "TnQuestionnaireItem [ID=" + ID + ", tnNeedsQuestionnaire="
				+ tnNeedsQuestionnaire + ", typeId=" + typeId + ", questionNo="
				+ questionNo + ", title=" + title + ", required=" + required
				+ ", hasOtherInput=" + hasOtherInput + ", choices=" + choices
				+ ", answers=" + answers + "]";
	}

	
	
	
	

}