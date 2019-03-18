package cn.kepu.questionnaire.dao;

import java.util.List;

import cn.kepu.questionnaire.pojo.EosorgTOrganization;
import cn.kepu.questionnaire.pojo.TnAssignDept;
import org.apache.ibatis.annotations.Param;

public interface IAssignDao {
				
	
	
	EosorgTOrganization selOrgByIdWithPrOrg(@Param("orgID") Integer orgID);
	
	EosorgTOrganization selPrOrgById(@Param("parentOrgID") Integer parentOrgID);
	
	List<EosorgTOrganization> selChilOrgsByPrId(Integer orgId);
	
	EosorgTOrganization selOrgById(Integer orgId);
	
	void istAssnDep(TnAssignDept assignDept);
	
	List<TnAssignDept> selAssnDeptsByQsnrId(@Param("QsnrId") Integer QsnrId);
	
	
}
