package cn.kepu.questionnaire.scheduleds;

import cn.kepu.questionnaire.pojo.AlarmRecord;
import cn.kepu.questionnaire.pojo.GnrUser;
import cn.kepu.questionnaire.service.IAlarmRecordService;
import cn.kepu.questionnaire.service.IUserService;
import cn.kepu.questionnaire.utils.ConstUtils;
import cn.kepu.questionnaire.utils.Wether;
import cn.kepu.questionnaire.utils.WetherUtil;
import cn.zhouyafeng.itchat4j.api.MessageTools;
import cn.zhouyafeng.itchat4j.core.Core;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 发送警报，当前处理方式为一旦有未处理警报，向所有人发送警报，发送频率待定
 */
@Component
public class SendAlarmScheduled {

    @Autowired
    Core wechatCore;

    @Autowired
    IAlarmRecordService iAlarmRecordService;

    @Autowired
    IUserService iUserService;

    @Scheduled(cron = "0 0/5 * * * ? ")
    public void sendMsg(){
        List<AlarmRecord> alarmRecordList = iAlarmRecordService.selAllIsAlarming();
        List <GnrUser> userList = iUserService.checkAllUsers();
        alarmRecordList.forEach(a ->{userList.forEach(u->{
            StringBuffer msg = new StringBuffer();
//            WetherVo wetherVo = ConstUtils.getWetherNow(a.getOptLattitude(),a.getOptLongtitude());
            Wether wether = null;
            try {
                wether = WetherUtil.getNowWether(a.getOptLongtitude()+"",a.getOptLattitude()+"");
            } catch (Exception e) {
                e.printStackTrace();
            }
            msg.append("火灾报警消息\n");
            msg.append("报警记录id:" + a.getaRecId() +"\n");
            msg.append("经度:" + a.getOptLongtitude() +"\n");
            msg.append("纬度:" + a.getOptLattitude() +"\n");
            msg.append("监控点id:" + a.getMptId() +"\n");
            msg.append("报警时间:" + a.getAlarmTime() +"\n");
            msg.append("温度:" + wether.getTemperature() +"\n");
            msg.append("湿度:" + wether.getHumidity() +"\n");
            msg.append("降水量:" + wether.getPrecipitation() +"\n");
            msg.append("风力:" + wether.getWindPower() +"\n");
            MessageTools.sendMsgByNickName(msg.toString(),u.getWechatName());
        });});


    }

}
