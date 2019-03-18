package cn.kepu.questionnaire.config;

import cn.zhouyafeng.itchat4j.controller.LoginController;
import cn.zhouyafeng.itchat4j.core.Core;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WeChatConfig {

    @Value("${wechat.qrpath}")
    String qrPath;

    @Bean("wechatCore")
    public Core wechatCore(){
        Core core = Core.getInstance();
        LoginController login = new LoginController();
        login.login(qrPath);
        return core;
    }
}
