package cn.kepu.questionnaire.utils;

import com.alibaba.fastjson.JSONObject;

public class WetherUtil {

    private final static String APP_KEY = "97e585895c3002ffaaca911c381b5e7b";

    private final static String URl = "http://v.juhe.cn/weather/geo?key="+APP_KEY;

    public static Wether getNowWether(String lon,String 	lat) throws Exception {
        String reqUrl = URl + "&lon=" + lon + "&lat=" + lat + "&dtype=json";
        String res = HttpClientUtils.doGet(reqUrl);
        JSONObject resJSON = JSONObject.parseObject(res);
        System.out.println(resJSON);
        Wether wether = new Wether();
        wether.setHumidity(resJSON.getJSONObject("result").getJSONObject("sk").getString("humidity").replace("%",""));
        wether.setPrecipitation("0");
        wether.setTemperature(resJSON.getJSONObject("result").getJSONObject("sk").getString("temp"));
        wether.setWindPower(resJSON.getJSONObject("result").getJSONObject("sk").getString("wind_strength").replace("级",""));
        return wether;
    }

    public static void main(String[] args) throws Exception {
        Wether wether = getNowWether("116.39277","39.933748");
        System.out.println(wether);
    }
}
