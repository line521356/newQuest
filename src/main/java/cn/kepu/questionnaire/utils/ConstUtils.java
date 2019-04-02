package cn.kepu.questionnaire.utils;

import cn.kepu.questionnaire.vo.WetherVo;
import com.alibaba.fastjson.JSONObject;


public class ConstUtils {


    public static WetherVo getWetherNow(double optLattitude,double optLongtitude){
        WetherVo wetherVo = new WetherVo();
        String url = "http://v.juhe.cn/weather/geo?format=2&key=您申请的KEY&lon="+optLongtitude+"&lat="+optLattitude;
        String res = HttpClientUtils.doGet(url);
        JSONObject resJson =JSONObject.parseObject(res);
        String resCode = resJson.getString("resultcode");
        if(resCode.equals(200)){
            JSONObject sk = resJson.getJSONObject("result").getJSONObject("sk");
            wetherVo.setTemp(sk.getString("temp"));
            wetherVo.setHumidity(sk.getString("humidity"));
            wetherVo.setWindDirection(sk.getString("wind_direction"));
            wetherVo.setWindStrength(sk.getString("wind_strength"));
        }
        return wetherVo;

    }
}
