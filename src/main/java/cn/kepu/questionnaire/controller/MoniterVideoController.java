package cn.kepu.questionnaire.controller;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.kepu.questionnaire.pojo.MoniterVideo;
import cn.kepu.questionnaire.pojo.MonitorPoint;
import cn.kepu.questionnaire.pojo.SrchBody;
import cn.kepu.questionnaire.pojo.VideoDetInfo;
import cn.kepu.questionnaire.service.ILiveService;
import cn.kepu.questionnaire.service.IMoniterVideoService;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/mVid")
public class MoniterVideoController {
	
	
	@Autowired
	@Qualifier("moniterVideoService")
	private IMoniterVideoService moniterVideoService;
	
	private Log logger = LogFactory.getLog(this.getClass());
	
	//------------------------------------Pure dispatcher--------------------------------
	
	//V1.0 版本 只能实现规排 不能实现搜索
	@RequestMapping("/toVideoBoard")
	public String toVideoBoard(){
		return "MoniterVideoPages/videoBoard";
	}
	
	//尝试加入搜索 
	@RequestMapping("/toVideoBoard2")
	public String toVideoBoard2(Map<String, Object> map){
		map.put("isSrched", 0);
		map.put("srchBody", new SrchBody());
		return "MoniterVideoPages/videoBoard2";
	}
	
	
	//测试JSON字符串和JSON对象的转换，待删除
	@RequestMapping("/testJsonObjNStr")
	public String testJsonObjNStr(Map<String, Object> map){
		List<Object> testJsonStr = new ArrayList<Object>();
		testJsonStr.add("{mood:'general',pressure:6}");
		map.put("testArrayList", testJsonStr);
		return "MoniterVideoPages/testJsonObjNStr";
	}
	
	//------------------------------------Functional dispatcher---------------------------
	/**
	 * 播放某一视频,并获得该视频详情
	 * @return
	 */
	@RequestMapping("/view/{vidId}/{videoType}/{videoUrl:.+}") 
	public String toView(Map<String, Object> map, @PathVariable("videoType") String videoType,@PathVariable("vidId") String vidId, @PathVariable("videoUrl") String videoUrl, HttpSession session){			
		String compUrl = videoType  + "/" + videoUrl;
		VideoDetInfo detInfo = moniterVideoService.getVidDetInfo(Integer.valueOf(vidId), videoType);
		map.put("videoUrl", compUrl);
		map.put("detInfo", detInfo);
		
		MDC.clear();								     //日志记录
		MDC.put("userID", Integer.parseInt(session.getAttribute("eosoperatorID").toString()));
		MDC.put("userName", session.getAttribute("userName").toString());
		logger.info("用户["+session.getAttribute("userName").toString()+"]播放视频[" + videoType + "/" + videoUrl + "]");
		return "MoniterVideoPages/playVideo";   
	}
	
	/**
	 * 显示单个视频
	 * @return
	 */
	@RequestMapping("/showVideos")
	public String showVideos(Map<String, Object> map){
		MoniterVideo moniterVideo = moniterVideoService.getSigVid();
		map.put("sampleVideo", moniterVideo);
		
		return "MoniterVideoPages/videoCentre";
	}
	
	/**
	 * AJAX获取monitor表中的所有视频
	 * @return
	 */
	@RequestMapping(value="/getAllmVids", method=RequestMethod.POST)
	@ResponseBody
	public List<Object> getAllmVids(HttpSession session){
		List<Object> mVidsJson = moniterVideoService.mVidsListJson();
		
		MDC.clear();								     //日志记录
		MDC.put("userID", Integer.parseInt(session.getAttribute("eosoperatorID").toString()));
		MDC.put("userName", session.getAttribute("userName").toString());
		logger.info("用户["+session.getAttribute("userName").toString()+"]进入视频管理主页，查询全视频列表");
		return mVidsJson;
	}
	
	/**
	 * AJAX获取满足搜索条件的视频
	 * @param srchBody
	 * @return
	 */
	@RequestMapping(value="/getKeyWords", method=RequestMethod.POST)
	@ResponseBody
	public List<Object> getKeyWords(@RequestBody SrchBody srchBody){

		//全类型视频搜索
		if( (srchBody.getVidType() == null) || (srchBody.getVidType() > 3 ) ){
			List<Object> GsrchRsltVideos = moniterVideoService.GlobalSrch(srchBody);
			return GsrchRsltVideos;			
		}
		
		//指定视频类型搜索
		List<Object> DsrchRsltVideos = moniterVideoService.getDSrchResult(srchBody);
		return DsrchRsltVideos;
	}
		
	@RequestMapping(value="/delVids", method=RequestMethod.POST)
	public void delVids(@RequestBody List<SrchBody> srchBodies,HttpServletResponse response) throws Exception{
		moniterVideoService.delVids(srchBodies);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("{\"result\":\"true\"}");    
		//强行success
	}
}
