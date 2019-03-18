package cn.kepu.questionnaire.scheduleds;

import cn.zhouyafeng.itchat4j.api.MessageTools;
import cn.zhouyafeng.itchat4j.api.WechatTools;
import cn.zhouyafeng.itchat4j.core.Core;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

//@Component
public class SendAlarmScheduled {

    @Autowired
    Core wechatCore;

    @Scheduled(cron = "0 0/5 * * * ? ")
    public void sendMsg(){
        MessageTools.sendMsgByNickName("测试消息勿回asldkfjalskdjflaskdjf","titi");

    }

}
