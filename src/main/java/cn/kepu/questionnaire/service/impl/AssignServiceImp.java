package cn.kepu.questionnaire.service.impl;

import java.util.ArrayList;
import java.util.List;


import cn.kepu.questionnaire.dao.IAssignDao;
import cn.kepu.questionnaire.pojo.EosorgTOrganization;
import cn.kepu.questionnaire.pojo.TnAssignDept;
import cn.kepu.questionnaire.pojo.TnNeedsQuestionnaire;
import cn.kepu.questionnaire.pojo.ZtreeNode;
import cn.kepu.questionnaire.service.IAssignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service("assignService")
public class AssignServiceImp implements IAssignService {

	@Autowired
	private IAssignDao assignDao;
	
	
	//Ztree树定义为本Service中全局变量
	private List<Object> listZTree = new ArrayList<Object>();
	
	
		
	public EosorgTOrganization getOrg(Integer orgID){
			return assignDao.selOrgByIdWithPrOrg(orgID);
	}
	
	public List<EosorgTOrganization> getChilOrgs(Integer orgId){		
		return assignDao.selChilOrgsByPrId(orgId);
	}
	
	public EosorgTOrganization getSingleOrg(Integer orgId){
		return assignDao.selOrgById(orgId);
	}
	
	
	/**
	 * 根据根节点生成初始树
	 * @param rootId
	 * @return List<Object>
	 * @author SilWhale_Make
	 */
	public List<Object> getOrgsToZTree(Integer rootId){
	
		listZTree.removeAll(listZTree);  //置空
		List<EosorgTOrganization> departments = assignDao.selChilOrgsByPrId(rootId);
		
		
		if(departments.size() > 0){
			//设置根节点，决定生成几棵树，这里目前只有一棵树（中国科学院）
			String prNodestr = "{id:'" +rootId + "', pId:'" + 0 +"', name:\""+ assignDao.selOrgById(rootId).getOrgName() +"\" }";
			listZTree.add(prNodestr);
			buildZtree(departments,rootId);
		}
		
		return listZTree;
	}
	
	
	/**
	 * 填充初始树
	 * @param List<EosorgTOrganization> subDeps, Integer parentNodeId
	 * @return 
	 * @author SilWhale_Make
	 */
	public void buildZtree(List<EosorgTOrganization> subDeps, Integer parentNodeId){
		
		//构建树
		String str = "";
		
		
		//这里如若需要构建完整树，循环终止条件应该是 i < subDeps.size() 但为调试选择部门功能减少加载时间设置成了(subDeps.size()/3) 即使是这样还是需要4-5s来加载 复杂度太高
		//  TODO 减少建树算法复杂度
		for (int i = 0; i < (subDeps.size()/3); i++) {
			EosorgTOrganization organization = subDeps.get(i);//分类信息
			List<EosorgTOrganization> childrenOrgs = assignDao.selChilOrgsByPrId(organization.getOrgId());
			
			if(childrenOrgs.size() > 0){
				buildZtree(childrenOrgs, organization.getOrgId());
			}
		
			str = "{id:'" +organization.getOrgId() + "', pId:'" + parentNodeId +"', name:\""+organization.getOrgName()+"\" }";   //封装ztree需要格式的字符串
			System.out.println(str);
			listZTree.add(str);
		}
				
	}
	
	
	public void saveAssnDept(TnAssignDept assignDept){
		assignDao.istAssnDep(assignDept);
	}
	
	public List<TnAssignDept> getAssnDepts(Integer QsnrId){
		return assignDao.selAssnDeptsByQsnrId(QsnrId);
	}
	
	
	
	/**
	 * 1、将Ztree节点转化为assignDept对象
	 * 2、过滤掉半勾选节点
	 * 3、存储assignDept对象
	 * 
	 * @param List<ZtreeNode> ztreeNodes
	 * @author SilWhale_Make
	 */
	public void transNSaveAssnDept(List<ZtreeNode> ztreeNodes){
		
		TnAssignDept assignDept= new TnAssignDept();
		TnNeedsQuestionnaire needsQuestionnaire = new TnNeedsQuestionnaire();
		EosorgTOrganization organization = new EosorgTOrganization();
		
		for(int i=0; i<ztreeNodes.size(); i++){			
			ZtreeNode node = ztreeNodes.get(i);
			if(node.getCheck_child_state() > 0){
				continue;
			}
			organization.setOrgId(node.getId());
			needsQuestionnaire.setID(node.getQuesnrID());
			assignDept.setDept(organization);
			assignDept.setTnNeedsQuestionnaire(needsQuestionnaire);
			saveAssnDept(assignDept);
			System.out.println("  !  ");
		}
		
	}
	
	
	
	
}
