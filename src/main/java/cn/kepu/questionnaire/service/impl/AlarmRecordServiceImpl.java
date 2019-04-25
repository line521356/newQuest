package cn.kepu.questionnaire.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import cn.kepu.questionnaire.dao.IAlarmRecordDao;
import cn.kepu.questionnaire.pojo.AlarmRecord;
import cn.kepu.questionnaire.pojo.CirIntersect;
import cn.kepu.questionnaire.pojo.Circle;
import cn.kepu.questionnaire.service.IAlarmRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;



@Service("alarmRecService")
public class AlarmRecordServiceImpl implements IAlarmRecordService {

	@Autowired
	private IAlarmRecordDao alarmRecordDao;
	
	public void startAlarming(Integer aRecId){
		alarmRecordDao.udtAlmStatusToStart(aRecId);
	}
	
	public void stopAlarming(Integer aRecId){
		alarmRecordDao.udtAlmStatusToStop(aRecId);
	}
	
	public List<Integer> chkAlarming(){
		return alarmRecordDao.selIsAlarming();
	}
	
	public List<AlarmRecord> getAlrminRecs(){
		return alarmRecordDao.selAlrmRecs();
	}
	
	/**
	 * 获取未确认的报警记录
	 */
	public JSONObject getUnhandledRes(Integer page, Integer limit){
		JSONObject resObj = new JSONObject();	
		List<AlarmRecord> unhandledRes = alarmRecordDao.selUnhandledRecs();
		resObj.put("count", unhandledRes.size());							//分页
		if (page * limit < unhandledRes.size()) {
			unhandledRes = unhandledRes.subList((page-1)*limit, page*limit);
		} else {
			unhandledRes = unhandledRes.subList((page-1)*limit, unhandledRes.size());
		}
		resObj.put("data", unhandledRes);
		resObj.put("code", 0);
		resObj.put("msg", "");
		return resObj;
	}
	
	/**
	 * 获取已确认的报警记录
	 */
	public JSONObject getHandledRes(Integer page, Integer limit){
		JSONObject resObj = new JSONObject();	
		List<AlarmRecord> handledRes = alarmRecordDao.selHandledRecs();
		resObj.put("count", handledRes.size());							//分页
		if (page * limit < handledRes.size()) {
			handledRes = handledRes.subList((page-1)*limit, page*limit);
		} else {
			handledRes = handledRes.subList((page-1)*limit, handledRes.size());
		}
		resObj.put("data", handledRes);
		resObj.put("code", 0);
		resObj.put("msg", "");
		return resObj;
	}
	
	/**
	 * 获取异常报警记录
	 */
	public JSONObject getErrRes(Integer page, Integer limit){
		JSONObject resObj = new JSONObject();	
		List<AlarmRecord> errRes = alarmRecordDao.selErrRecs();
		resObj.put("count", errRes.size());							//分页
		if (page * limit < errRes.size()) {
			errRes = errRes.subList((page-1)*limit, page*limit);
		} else {
			errRes = errRes.subList((page-1)*limit, errRes.size());
		}
		resObj.put("data", errRes);
		resObj.put("code", 0);
		resObj.put("msg", "");
		return resObj;
	}
	
	/**
	 * 取消警报
	 */
	public void cancelAlm(AlarmRecord alarmRecord){
		alarmRecordDao.udtAlmStatusToCancel(alarmRecord);
	}
	
	/**
	 * 火点定位
	 */
	public void checkFirePoints(){
		List<AlarmRecord> unHandledRecs = new ArrayList<AlarmRecord>();
		unHandledRecs = alarmRecordDao.selUnposRecs();
		if (unHandledRecs.size() < 1) {
			System.out.println("暂无待定位的报警记录或不足2两条报警记录");
		} else {
			AlarmRecord htRecord = new AlarmRecord();
			AlarmRecord ltRecord = new AlarmRecord();
			for(AlarmRecord alarmRecord : unHandledRecs){
				if (alarmRecord.getMptId() == 1) {
					htRecord = alarmRecord;
				}
				if (alarmRecord.getMptId() == 2) {
					ltRecord = alarmRecord;
				}
			}
			if (htRecord.getHrzAngle() == null || ltRecord.getHrzAngle() == null) {
				System.out.println("不足两个监控塔报警记录");
			} else {							
				double tower1x = 840;				//高位监控塔的位置
				double tower1y = 311;
				double tower1to2 = 36.28;			//高位塔相对于地位塔的角度
				double tower2to1 = 216.28;			//地位塔相对于高位塔的角度
				double tower1Ag = htRecord.getHrzAngle();	//高位塔旋转角度
				double tower2Ag = ltRecord.getHrzAngle();	//地位塔旋转角度
				double orTower1Ag = htRecord.getHrzAngle();	//高位塔旋转角度，保存原始值
				double k = -0.7340425531914894;							//监控点直线函数的斜率与截距
				double lineC = 478.5310857196218;						//监控点之间的距离
				int checkLoc = 0;
				int angCtrl = 0;
				
				if (tower1Ag > tower2to1) {
					checkLoc = 1;
				} else {
					checkLoc = -1;
				}
				if (orTower1Ag < 90 || (orTower1Ag > 270 && orTower1Ag < 360)) {				//初步判断火点相对于瞭望塔的位置（右侧）
					tower1Ag = (tower1Ag - tower2to1)>0?(tower1Ag - tower2to1):-(tower1Ag - tower2to1);
					tower2Ag = (tower1to2 - tower2Ag)>0?(tower1to2 - tower2Ag):-(tower1to2 - tower2Ag);
					if (tower1Ag > 180) {
						tower1Ag = 360 - tower1Ag;
					}
					if (tower2Ag > 180) {
						tower2Ag = 360 - tower2Ag;
					}
					angCtrl = 1;
				}
				if (orTower1Ag > 90 && orTower1Ag < 270) {				//初步判断火点相对于瞭望塔的位置（左侧）
					tower1Ag = (tower2to1 - tower1Ag)>0?(tower2to1 - tower1Ag):-(tower2to1 - tower1Ag);
					tower2Ag = (tower2Ag - tower1to2)>0?(tower2Ag - tower1to2):-(tower2Ag - tower1to2);
					if (tower1Ag > 180) {
						tower1Ag = 360 - tower1Ag;
					}
					if (tower2Ag > 180) {
						tower2Ag = 360 - tower2Ag;
					}
					angCtrl = 2;
				}
				double fpAg = 180 - (tower1Ag + tower2Ag);
				double lineB = Math.sin(tower2Ag * Math.PI / 180) * lineC / Math.sin(fpAg * Math.PI / 180);
				double lineA = Math.sin(tower1Ag * Math.PI / 180) * lineC / Math.sin(fpAg * Math.PI / 180);
			
				//----------------------三角形的三条边和三个角都计算完毕-------------------
			
				Circle c1 = new Circle(840, 311, lineB);
				Circle c2 = new Circle(464, 607, lineA);
				
				CirIntersect intersect = new CirIntersect(c1, c2);
				double res[] = intersect.intersect();
				if (res.length < 4) {
					System.out.println("计算错误");
				} else {							
					//----------------------完成解方程，开始解析根----------------------------
					
					double fp1x = res[0];
					double fp1y = res[1];
					double fp2x = res[2];
					double fp2y = res[3];
					
					double k2 = (fp1y - tower1y) / (fp1x - tower1x);	//火点1与瞭望塔连线的斜率
					double k3 = (fp2y - tower1y) / (fp2x - tower1x);	//火点2与瞭望塔连线的斜率
					double resAngle1 = Math.atan((k2-k)/(1+ k*k2)) * 180 / Math.PI;		//计算火点连线与监控点连线的旋转角
					double resAngle2 = Math.atan((k3-k)/(1+ k*k3)) * 180 / Math.PI;
					if (resAngle1 * checkLoc > 0) {
						if (angCtrl == 1) {
							htRecord.setOptLattitude(fp1x);
							htRecord.setOptLongtitude(fp1y);
							ltRecord.setOptLattitude(fp1x);
							ltRecord.setOptLongtitude(fp1y);
						}
						if (angCtrl == 2) {
							htRecord.setOptLattitude(fp2x);
							htRecord.setOptLongtitude(fp2y);
							ltRecord.setOptLattitude(fp2x);
							ltRecord.setOptLongtitude(fp2y);
						}
						htRecord.setIsConfirm(1);
						ltRecord.setIsConfirm(1);
						alarmRecordDao.updateRecAftLoc(htRecord);
						alarmRecordDao.updateRecAftLoc(ltRecord);
					}
					if (resAngle2 * checkLoc > 0) {
						if (angCtrl == 1) {
							htRecord.setOptLattitude(fp2x);
							htRecord.setOptLongtitude(fp2y);
							ltRecord.setOptLattitude(fp2x);
							ltRecord.setOptLongtitude(fp2y);
						}
						if (angCtrl == 2) {
							htRecord.setOptLattitude(fp1x);
							htRecord.setOptLongtitude(fp1y);
							ltRecord.setOptLattitude(fp1x);
							ltRecord.setOptLongtitude(fp1y);
						}
						htRecord.setIsConfirm(1);
						ltRecord.setIsConfirm(1);
						alarmRecordDao.updateRecAftLoc(htRecord);
						alarmRecordDao.updateRecAftLoc(ltRecord);
					}
				}
			}
		}
	}
	
	/**
	 * 经纬度报警记录查询接口
	 */
	public List<AlarmRecord> chkRecsInGps(){
		List<AlarmRecord> unhandledRes = alarmRecordDao.selUnhandledRecs();
		for(AlarmRecord rec : unhandledRes){
			rec.setOptLattitude(countLat(countDis(40.071171) - ((rec.getOptLongtitude()/55.51)*197.651473)));
			rec.setOptLongtitude(116.049671 + (rec.getOptLattitude()/55.51*197.651473)/85779.66839349142);
		}
		return unhandledRes;
	}

	@Override
	public List<AlarmRecord> selAllIsAlarming() {
		return alarmRecordDao.selAllIsAlarming();
	}

	@Override
	public void alarmRecordService(String aRecId) {
		alarmRecordDao.updateToExceptionAlarm(aRecId);
	}

	/**
	 * 古德曼函数，返回纬度
	 * @param distance
	 * @return
	 */
	private double countLat(double distance){
		return (2*Math.atan(Math.pow(Math.E, Math.PI/20037508.3427892*distance)) - Math.PI/2)*180/Math.PI;
		//return Math.atan(Math.pow(Math.E, Math.PI)) * 180 / Math.PI;
	}
	
	/**
	 * 反古德曼函数，返回赤道距离
	 * @param gpsLattitude
	 * @return
	 */
	private double countDis(double gpsLattitude){
		double earthRad = 6378137.0; 		
		double a = gpsLattitude * Math.PI / 180;  
		double y = earthRad / 2 * Math.log((1.0 + Math.sin(a)) / (1.0 - Math.sin(a)));		
		return y;		
	}
	
}
