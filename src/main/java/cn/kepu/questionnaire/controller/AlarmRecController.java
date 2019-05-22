package cn.kepu.questionnaire.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import cn.kepu.questionnaire.pojo.AlarmRecord;
import cn.kepu.questionnaire.pojo.GnrUser;
import cn.kepu.questionnaire.pojo.MoniterVideo;
import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.service.IAlarmRecordService;
import cn.kepu.questionnaire.service.IMoniterVideoService;
import cn.kepu.questionnaire.service.IUserService;
import cn.zhouyafeng.itchat4j.api.MessageTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@Controller
@RequestMapping("/alrmRec")
public class AlarmRecController {

	
	@Autowired
	@Qualifier("alarmRecService")
	private IAlarmRecordService alarmRecordService;

	@Value("${live.rtmp-url}")
	String baseLiveIp;

	@Autowired
	private IMoniterVideoService moniterVideoService;

	@Autowired
	private IUserService userService;
	
	
	//-------------------------pure dispatcher---------------------- 
		
	@RequestMapping("/UnhandledRecForMap")
	public String toUnhandledRecForMap(){
		return "AlrmPages/unhandledRecForMap";
	}
	
	//-------------------------functional dispatcher----------------
	
	/**
	 * 原为报警记录主面板跳转mapping，现在在跳转之前增加火点定位逻辑
	 * @return
	 */
	@RequestMapping("/toAlrmManage")
	public String toAlrmManage(){
		alarmRecordService.checkFirePoints();
		return "AlrmPages/alrmManageMain";
	}
	
	/**
	 * 开始报警 beta1 默认第一条记录
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/DistributeInfo", method=RequestMethod.POST)
	public void distributeInfo(HttpServletResponse response) throws Exception{
		alarmRecordService.startAlarming(1);
		response.getWriter().write("{\"result\":\"true\"}");
	}
	
	/**
	 * 结束报警 beta1 默认第一条记录
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/StopDistribute", method=RequestMethod.POST)
	public void stopDistribute(HttpServletResponse response) throws Exception{
		alarmRecordService.stopAlarming(1);
		response.getWriter().write("{\"result\":\"true\"}");
	}
	
	/**
	 * 与安卓端连接暗门 beta1 
	 * 查看有无处于报警状态的报警记录
	 * @return
	 */
	@RequestMapping("/almMonitor")
	public String toAlrmMonitor(Map<String, Object> map){
		Integer hasAlarming = 0;	
		List<Integer> isAlarming = alarmRecordService.chkAlarming();
		List<AlarmRecord> alrminRecs = alarmRecordService.getAlrminRecs();
		if (!isAlarming.isEmpty()) {
			hasAlarming = 1;
			map.put("alrminRecs", alrminRecs);
		}
		map.put("hasAlarming", hasAlarming);		
		return "AlrmPages/alrmMonitor";
	}
	
	@RequestMapping(value = "/almMonitor2", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject toAlarmMonitor2(){
		JSONObject result = new JSONObject();		
		Integer hasAlarming = 0;	
		List<Integer> isAlarming = alarmRecordService.chkAlarming();
		List<AlarmRecord> alrminRecs = alarmRecordService.getAlrminRecs();
		if (!isAlarming.isEmpty()) {
			hasAlarming = 1;			
		}
		result.put("alrminRecs", alrminRecs);
		result.put("hasAlarming", hasAlarming);		
		return result;
	}

	public class JSONController {
		@RequestMapping(value="/testUItable", method = RequestMethod.GET)
		public @ResponseBody AlarmRecord getShopInJSON(int page, int limit) {
			AlarmRecord alarmRecord = new AlarmRecord();
			alarmRecord.setMptId(1);
			alarmRecord.setOptHeight(123.132);
			alarmRecord.setOptLattitude(54.123);
			alarmRecord.setOptLongtitude(412.123);
			alarmRecord.setIsConfirm(0);
			alarmRecord.setMptId(12);
			return alarmRecord;
		}
	}
	
	//---------------------------------规范coding-------------------------------
	
	/**
	 * 查询未处理的报警
	 * @param page
	 * @param limit
	 * @return
	 */
	@RequestMapping("/chkUnhandledRecs")
	@ResponseBody
    public JSONObject chkUnhandledRecs(Integer page, Integer limit){
    	JSONObject resObj = new JSONObject();    	
    	resObj = alarmRecordService.getUnhandledRes(page, limit);  	
    	return resObj;
    }
	
	/**
	 * 查询已处理的报警
	 * @param page
	 * @param limit
	 * @return
	 */
	@RequestMapping("/chkHandledRecs")
	@ResponseBody
    public JSONObject chkHandledRecs(Integer page, Integer limit){
    	JSONObject resObj = new JSONObject();    	
    	resObj = alarmRecordService.getHandledRes(page, limit);  	
    	return resObj;
    }
	
	/**
	 * 查询异常报警记录
	 * @param page
	 * @param limit
	 * @return
	 */
	@RequestMapping("/chkErrRecs")
	@ResponseBody
    public JSONObject chkErrRecs(Integer page, Integer limit){
    	JSONObject resObj = new JSONObject();    	
    	resObj = alarmRecordService.getErrRes(page, limit);  	
    	return resObj;
    }
	
	/**
	 * 取消警报
	 * @param alarmRecord
	 * @return
	 */
	@RequestMapping("/cancelAlrm")
	@ResponseBody
	public JSONObject cancelAlrm(@RequestBody AlarmRecord alarmRecord){
		JSONObject result = new JSONObject();
		alarmRecordService.cancelAlm(alarmRecord);
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 经纬度查询接口
	 * @return
	 */
	@RequestMapping("/chkRecInGps")
	@ResponseBody
	public JSONObject chkRecInGps(){
		JSONObject result = new JSONObject();
		List<AlarmRecord> unhandledRecs = alarmRecordService.chkRecsInGps();
		result.put("recs", unhandledRecs);
		result.put("msg", 1);
		return result;
	}

	@RequestMapping("/video")
	public String video(String id, Model model){
		MonitorPoint monitorPoint = moniterVideoService.findMonitorPointById(id);
		String url = baseLiveIp + monitorPoint.getMptIP();
		model.addAttribute("url",url);
		model.addAttribute("monitorPoint",monitorPoint);
		return "AlrmPages/video";
	}

	/**
	 * 发送告警到微信
	 * @param jsonObject
	 * @return
	 */
	@RequestMapping("/sendAlarmMsg")
	@ResponseBody
	public String sendAlarmMsg(@RequestBody JSONObject jsonObject){
		List <GnrUser> gnrUserList = userService.checkAllUsers();
		String user = jsonObject.getString("user");
		String condition = jsonObject.getString("condition");
		String intensity = jsonObject.getString("intensity");
		String direction = jsonObject.getString("direction");
		String speed = jsonObject.getString("speed");
		StringBuffer msg = new StringBuffer();
		msg.append("火情:"+condition+"\n");
		msg.append("火势:"+intensity+"\n");
		msg.append("移动方向:"+direction+"\n");
		msg.append("移动速度:"+speed+"\n");
		msg.append("发送人:"+user+"\n");
		for (GnrUser gnrUser : gnrUserList) {
			MessageTools.sendMsgByNickName(msg.toString(),gnrUser.getWechatName());
		}
		JSONObject result = new JSONObject();
		result.put("code", 0);
		result.put("msg", "success");
		return result.toString();
	}


	/**
	 * 告警归为异常告警
	 * @param aRecId
	 * @return
	 */
	@RequestMapping("/updateToExceptionAlarm")
	@ResponseBody
	public String updateToExceptionAlarm(String aRecId){
		alarmRecordService.alarmRecordService(aRecId);
		JSONObject result = new JSONObject();
		result.put("code", 0);
		result.put("msg", "success");
		return result.toString();
	}
	
	
}
