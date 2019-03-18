package cn.kepu.questionnaire.mythread;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

public class ApplicationStartup implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        ApplicationContext ac = contextRefreshedEvent.getApplicationContext();
        SendStreamExecutor sendStreamExecutor = ac.getBean(SendStreamExecutor .class);
        Thread thread = new Thread(sendStreamExecutor);
        thread.start();

    }
}
