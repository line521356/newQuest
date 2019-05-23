package cn.kepu.questionnaire.tree.model;

/**
 * <p>
 * 连续变量单元
 * 此类用于保存一个属性的连续变量，以及此变量下的结果
 * 设计此类的目的在于方便计算连续变量的阈值
 *
 */
public class ContinuouslyVariableUnit {

    private int value = 0;
    private String classify = "";
    
    public ContinuouslyVariableUnit() {
    }
    
    public ContinuouslyVariableUnit(int value, String classify) {
        this.value = value;
        this.classify = classify;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }
    
    @Override
    public String toString() {
        return "[" + value + ", " + classify + "]";
    }
}
