package cn.kepu.questionnaire.controller;

import java.util.List;

import cn.kepu.questionnaire.pojo.ShotCutImg;
import cn.kepu.questionnaire.service.IShotCutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;


@Controller
@RequestMapping("/shotcut")
public class ShotCutController {

	
	@Autowired
	@Qualifier("shotCutService")
	private IShotCutService shotCutService;
	
	
	@RequestMapping("/checkAllShots")
	public String checkAllShots(){
		return "ShotCutPages/shotCutPanel";
	}
	
	@RequestMapping("/checkImgList")
	public String checkImgList(){
		return "ShotCutPages/imgList";
	}

	@RequestMapping("/broadcastList")
	public String broadcast(){
		return "ShotCutPages/broadcastList";
	}
	
	/**
	 * 图片浏览-加载所有图片
	 * @return
	 */
	@RequestMapping("/loadAllShots")
	@ResponseBody
	public JSONObject loadAllShots(){
		
		JSONObject result = new JSONObject();
		List<ShotCutImg> shotCutImgs = shotCutService.getAllShots();
		result.put("shotCutImgs", shotCutImgs);
		
		return result;
	}
	
	/**
	 * 图片管理-加载所有图片
	 * @return
	 */
	@RequestMapping("/loadImgList")
	@ResponseBody
	public JSONObject loadImgList(){
		JSONObject result = new JSONObject();
		List<ShotCutImg> shotCutImgs = shotCutService.getAllShots();		
		result.put("data", shotCutImgs);
		result.put("code", 0);
		result.put("msg", "");
		return result;
	}
	
	/**
	 * 图片管理-删除图片
	 * @param shotCutImg
	 * @return
	 */
	@RequestMapping("/delImg")
	@ResponseBody
	public JSONObject delImg(@RequestBody ShotCutImg shotCutImg){
		JSONObject result = new JSONObject();
		shotCutService.delImg(shotCutImg.getScImgId());
		result.put("msg", 1);
		return result;
	}
	
	/**
	 * 图片搜索
	 * @param page
	 * @param limit
	 * @param kwType
	 * @param keyWord
	 * @param imgType
	 * @param recTime_st
	 * @param recTime_ed
	 * @return
	 */
	@RequestMapping("/srchImgs")
	@ResponseBody
	public JSONObject srchImgs(Integer page, Integer limit, Integer kwType, String keyWord,Integer imgType, String recTime_st, String recTime_ed){
		JSONObject result = new JSONObject();
		List<ShotCutImg> shotCutImgs = shotCutService.srchImgs(kwType, keyWord, imgType, recTime_st, recTime_ed);
		result.put("data", shotCutImgs);
		result.put("code", 0);
		result.put("msg", "");
		return result;		
	}
	
	/**
	 * 图片搜索-图片浏览
	 * @param shotCutImg
	 * @return
	 */
	@RequestMapping("/srchImgsForView")
	@ResponseBody
	public JSONObject srchImgsForView(@RequestBody ShotCutImg shotCutImg){			//忽略对象名，具体参数意义参看上面图片列表的搜索
		JSONObject result = new JSONObject();
		List<ShotCutImg> shotCutImgs = shotCutService.srchImgs(shotCutImg.getScImgId(), shotCutImg.getScImgName(), shotCutImg.getScImgType(), shotCutImg.getScImgUrl(), shotCutImg.getCreateTime());
		result.put("shotCutImgs", shotCutImgs);
		result.put("msg", 1);
		return result;
	}
			
}
