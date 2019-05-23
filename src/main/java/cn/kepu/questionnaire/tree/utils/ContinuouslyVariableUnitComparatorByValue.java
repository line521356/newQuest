package cn.kepu.questionnaire.tree.utils;

import java.util.Comparator;

import cn.kepu.questionnaire.tree.model.ContinuouslyVariableUnit;

/**
 * <p>
 * 通过连续变量单元的值进行比较两个连续变量单元
 * </p>
 * Create Date: 2016年6月23日
 * Last Modify: 2016年6月23日
 *
 */
public class ContinuouslyVariableUnitComparatorByValue implements Comparator<ContinuouslyVariableUnit> {

    @Override
    public int compare(ContinuouslyVariableUnit unit1, ContinuouslyVariableUnit unit2) {
        return unit1.getValue() - unit2.getValue();
    }

}
