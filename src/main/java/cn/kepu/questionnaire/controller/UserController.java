package cn.kepu.questionnaire.controller;


import java.awt.geom.GeneralPath;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.Null;

import cn.kepu.questionnaire.pojo.Eosoperator;
import cn.kepu.questionnaire.pojo.GnrUser;
import cn.kepu.questionnaire.pojo.LogRecord;
import cn.kepu.questionnaire.service.IUserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

  
@Controller
@RequestMapping("/user")  
public class UserController {  
	
	@Autowired
	@Qualifier("userService")
	private IUserService userService;
	
	
	private Log logger = LogFactory.getLog(this.getClass());
		
    //--------------------------Pure dispatcher ----------------------------   
    
    @RequestMapping("/index")
    public String toIndexPage(){
    	return "index";
    }
    
    @RequestMapping("/loginForm")
    public String toLoginForm(){
    	return "loginForm";
    }
    
    @RequestMapping("/loginsuccess")
    public String tologinsuccess(){
    	return "loginsuccess";
    }
    
    @RequestMapping("/userList")
    public String toUserList(){
    	return "SystemManagePages/userList";
    }
    
    @RequestMapping("/logList")
    public String toLogList(){
    	return "SystemManagePages/logList";
    }
    
    @RequestMapping("/revUserWin")
    public String toRvdUser(){
    	return "SystemManagePages/reviseUserInfo";
    }
    
    @RequestMapping("/signUp")
    public String toSignUp(){
    	return "signUp";
    }
  
    //------------------------------functional dispatcher----------------------------
        
    /**
     * 用户登录
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam(value="gnrUserName")String gnrUserName,@RequestParam(value="gnrUserPwd")String gnrUserPwd,
			HttpSession session,Map<String, Object> map){		

    	GnrUser gnrUser = userService.login(gnrUserName, gnrUserPwd);
		
    	if(gnrUser != null){
			session.setAttribute("eosoperatorID", gnrUser.getGnrUserId());	//将用户信息放入session
			session.setAttribute("userName", gnrUser.getGnrUserName());
			MDC.clear();								     //日志记录
			MDC.put("userID", gnrUser.getGnrUserId());
			MDC.put("userName", gnrUser.getGnrUserName());
			logger.info("登陆成功");
			// TODO 分开验证
			return "redirect:/mgrPanel";
		}else{			
			map.put("message", "登录名或密码错误!");
			
			MDC.clear();
			MDC.put("userID", -1);
			MDC.put("userName", gnrUserName);
			logger.error("登录失败");
			return "rpLoginForm";
		}		
	}
    
    /**
     * 用户退出登陆
     * @return
     */
    @RequestMapping("/logOff")
    public String logOff(HttpSession session){
    	session.setAttribute("eosoperatorID", null);
    	session.setAttribute("userName", null);
    	return "redirect:/";
    }
    
    /**
     * 通过转发页面获取用户详细信息（REST）
     * @param operatorId
     * @param map
     * @return
     */
    @RequestMapping("/getEmpInfo/{operatorId}")
    public String getEmpInfo(@PathVariable("operatorId")Integer operatorId, Map<String, Object> map){
    	Eosoperator operator=userService.checkEmpInfo(operatorId);
    	map.put("optrWitEmpInfo",operator);    	
    	return "empInfo";
    }
    
    
    /**
     * 使用Json+AJAX方式获取用户详细信息
     * @param operatorId
     * @return
     */
    @RequestMapping("/json/getEmpInfo/{operatorId}")
    @ResponseBody
    public Object getJson(@PathVariable("operatorId")Integer operatorId){
    	Eosoperator operator=userService.checkEmpInfo(operatorId);
    	return operator;
    }
    
    /**
     * 加载全用户列表
     * @return
     */
    @RequestMapping("/loadUserList")
    @ResponseBody
    public JSONObject userList(Integer page, Integer limit){
    	JSONObject result = new JSONObject();
    	List<GnrUser> allUsers = userService.checkAllUsers();
		result.put("count", allUsers.size());							//分页
		if (page * limit < allUsers.size()) {
			allUsers = allUsers.subList((page-1)*limit, page*limit);
		} else {
			allUsers = allUsers.subList((page-1)*limit, allUsers.size());
		}
    	result.put("data", allUsers);
		result.put("code", 0);
		result.put("msg", "");
    	return result;
    }
    
    /**
     * 删除用户
     * @param user
     * @return
     */
    @RequestMapping("/delUser")
    @ResponseBody
    public JSONObject delUser(@RequestBody GnrUser user){
    	JSONObject result = new JSONObject();
    	userService.delUser(user.getGnrUserId());
    	result.put("msg", 1);
    	return result;
    }
    
    /**
     * 修改用户信息-回显用户信息
     * @param user
     * @return
     */
    @RequestMapping("/priUserInfo")
    @ResponseBody
    public JSONObject priUserInfo(@RequestBody GnrUser user){
    	JSONObject result = new JSONObject();
    	result.put("priUser", userService.priUserInfo(user.getGnrUserId()));
    	result.put("msg", 1);
    	return result;
    }
    
    /**
     * 修改用户信息
     * @param user
     * @return
     */
    @RequestMapping("/rvdUser")
    @ResponseBody
    public JSONObject rvdUser(@RequestBody GnrUser user){
    	JSONObject result = new JSONObject();
    	userService.rvdUserInfo(user);
    	result.put("msg", 1);
    	return result;    	
    }
    
    /**
     * 查找用户
     * @param page
     * @param limit
     * @param kwType
     * @param keyWord
     * @return
     */
    @RequestMapping("/srchUser")
    @ResponseBody
    public JSONObject srchUsers(Integer page, Integer limit, Integer kwType, String keyWord){
    	JSONObject result = new JSONObject();
    	List<GnrUser> users = userService.srchUsers(kwType, keyWord);
		result.put("count", users.size());							//分页
		if (page * limit < users.size()) {
			users = users.subList((page-1)*limit, page*limit);
		} else {
			users = users.subList((page-1)*limit, users.size());
		}
    	result.put("data", users);
		result.put("code", 0);
		result.put("msg", "");
    	return result; 
    }
    
    /**
     * 日志列表
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/allLogs")
    @ResponseBody
    public JSONObject allLogs(Integer page, Integer limit){
    	JSONObject result = new JSONObject();
    	List<LogRecord> logRecords = userService.chkLogs();
		result.put("count", logRecords.size());							//分页
		if (page * limit < logRecords.size()) {
			logRecords = logRecords.subList((page-1)*limit, page*limit);
		} else {
			logRecords = logRecords.subList((page-1)*limit, logRecords.size());
		}
    	result.put("data", logRecords);
		result.put("code", 0);
		result.put("msg", "");
    	return result; 
    }
    
    @RequestMapping("/srchLogs")
    @ResponseBody
    public JSONObject srchLogs(Integer page, Integer limit, Integer kwType, String keyWord, String recTime_st, String recTime_ed){
    	JSONObject result = new JSONObject();
    	List<LogRecord> logRecords = userService.srchLogs(kwType, keyWord, recTime_st, recTime_ed);
		result.put("count", logRecords.size());							//分页
		if (page * limit < logRecords.size()) {
			logRecords = logRecords.subList((page-1)*limit, page*limit);
		} else {
			logRecords = logRecords.subList((page-1)*limit, logRecords.size());
		}
    	result.put("data", logRecords);
		result.put("code", 0);
		result.put("msg", "");
    	return result;    	
    }
    
    @RequestMapping("/signUpUser")
    @ResponseBody
    public JSONObject signUpUser(@RequestBody GnrUser user){
    	JSONObject result = new JSONObject();
    	userService.signUpUser(user);
    	result.put("msg", 1);
    	return result;
    }
    
}  
