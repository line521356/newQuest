package cn.kepu.questionnaire.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class StaticFilePathConfig extends WebMvcConfigurerAdapter {

    @Value("${live.backup-path}")
    String backupPath;
    @Value("${live.backup-path-virtual}")
    String backupPathVirtual;
    @Value("${live.pic-path}")
    String picPath;
    @Value("${live.pic-path-virtual}")
    String picPathVirtual;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(backupPathVirtual+"/**").addResourceLocations("file:/"+backupPath);
        registry.addResourceHandler(picPathVirtual+"/**").addResourceLocations("file:/"+picPath);
        super.addResourceHandlers(registry);
    }
}
