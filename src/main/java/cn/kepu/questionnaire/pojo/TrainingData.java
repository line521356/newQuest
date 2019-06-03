package cn.kepu.questionnaire.pojo;

import java.io.Serializable;

public class TrainingData implements Serializable {

    private static final long serialVersionUID = 5045812719268396953L;

    /**
     * 主键，少了它可不行
     */
    private Integer id;

    /**
     * 降水量
     */
    private String precipitation;

    /**
     * 温度
     */
    private String temperature;

    /**
     * 风力
     */
    private String windPower ;

    /**
     * 湿度
     */
    private String humidity;

    /**
     * 对应扑救方案id，这里不设外键，数据量大影响决策树构建速度
     */
    private Integer planId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPrecipitation() {
        return precipitation;
    }

    public void setPrecipitation(String precipitation) {
        this.precipitation = precipitation;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getWindPower() {
        return windPower;
    }

    public void setWindPower(String windPower) {
        this.windPower = windPower;
    }

    public String getHumidity() {
        return humidity;
    }

    public void setHumidity(String humidity) {
        this.humidity = humidity;
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }
}
