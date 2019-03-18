package cn.kepu.questionnaire.dao;

import cn.kepu.questionnaire.pojo.EosorgTEmployee;
import org.apache.ibatis.annotations.Param;


public interface IEmployeeDao {
		
	EosorgTEmployee selectEmpByOpId(@Param("operatorID")Integer operatorID);
		

}
