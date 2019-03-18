package cn.kepu.questionnaire.service.impl;


import cn.kepu.questionnaire.dao.IUserDao;
import cn.kepu.questionnaire.pojo.Eosoperator;
import cn.kepu.questionnaire.pojo.GnrUser;
import cn.kepu.questionnaire.pojo.LogRecord;
import cn.kepu.questionnaire.pojo.User;
import cn.kepu.questionnaire.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service("userService")
public class UserServiceImpl implements IUserService {
	
	@Autowired
    private IUserDao userDao;
    
 
    public User getUserById(int userId) {
        return this.userDao.selectByPrimaryKey(userId);  
    }
    
    public GnrUser login(String gnrUserName, String gnrUserPwd){
    	return userDao.loginWithUserIdNPwd(gnrUserName, gnrUserPwd);    	
    }
    
    public GnrUser chkUserInfo(Integer gnrUserId){
    	return userDao.selUserInfo(gnrUserId);
    }
    
    public Eosoperator checkEmpInfo(Integer operatorID){
    	return userDao.selOptrByIdWithEmpInfo(operatorID);
    }
    
    public List<GnrUser> checkAllUsers(){
    	return userDao.selAllUsers();
    }
    
    public void delUser(Integer gnrUserId){
    	userDao.delUserByID(gnrUserId);
    }
    
    public GnrUser priUserInfo(Integer gnrUserId){
    	return userDao.selUserInfo(gnrUserId);
    }
    
    public void rvdUserInfo(GnrUser user){
    	userDao.updateUser(user);
    }
    
    public List<GnrUser> srchUsers(Integer kwType, String keyWord){
    	List<GnrUser> resUsers = new ArrayList<GnrUser>();
    	if (kwType == 1) {
			resUsers.add(userDao.selUserInfo(Integer.parseInt(keyWord)));
		}
    	if (kwType == 2) {
			resUsers = userDao.selUsersByName(keyWord);
		}
    	if (kwType == 3) {
			resUsers = userDao.selUsersByDep(keyWord);
		}
    	return resUsers;
    }
    
    /**
     * 查询所有日志记录
     */
    public List<LogRecord> chkLogs(){
    	return userDao.selAllLogs();
    }
    
    /**
     * 查找日志记录
     */
    public List<LogRecord> srchLogs(Integer kwType, String keyWord, String recTime_st, String recTime_ed){
    	List<LogRecord> resLogs = new ArrayList<LogRecord>();
    	if (kwType !=null && kwType == 2) {
			resLogs = userDao.selLogsByUserName(keyWord, recTime_st, recTime_ed);
    	} 
		if (kwType !=null && kwType == 1) {
			resLogs = userDao.selLogsByLogLev(keyWord, recTime_st, recTime_ed);
		}
		if (kwType !=null && kwType == 3){
			resLogs = userDao.selLogsByLogCont(keyWord, recTime_st, recTime_ed);
		}
		if (kwType !=null && kwType == 4) {
			resLogs = userDao.selLogsByUserID(Integer.parseInt(keyWord), recTime_st, recTime_ed);
		}
		if (kwType == null && (recTime_st != null || recTime_ed !=null)){
			resLogs = userDao.selLogsByDate(recTime_st, recTime_ed);
		} 
    	return resLogs;
    }
    
    /**
     * 用户注册-通过注册新建用户固定为普通用户
     */
    public void signUpUser(GnrUser user){
    	user.setUserRight(1);
    	user.setUserGroup("普通用户");
    	userDao.istNewUser(user);
    }
    
}
