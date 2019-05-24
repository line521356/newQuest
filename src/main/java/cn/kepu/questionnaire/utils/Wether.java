package cn.kepu.questionnaire.utils;

public class Wether {

    private String precipitation;

    private String temperature;

    private String windPower;

    private String humidity;

    public Wether() {
    }

    public Wether(String precipitation, String temperature, String windPower, String humidity) {
        this.precipitation = precipitation;
        this.temperature = temperature;
        this.windPower = windPower;
        this.humidity = humidity;
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

    @Override
    public String toString() {
        return "Wether{" +
                "precipitation='" + precipitation + '\'' +
                ", temperature='" + temperature + '\'' +
                ", windPower='" + windPower + '\'' +
                ", humidity='" + humidity + '\'' +
                '}';
    }
}
