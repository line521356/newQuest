package cn.kepu.questionnaire.utils;

import com.alibaba.fastjson.JSONObject;


public class ConstUtils {

    /**
     * 古德曼函数，返回纬度
     * @param distance
     * @return
     */
    private static double countLat(double distance){
        return (2*Math.atan(Math.pow(Math.E, Math.PI/20037508.3427892*distance)) - Math.PI/2)*180/Math.PI;
        //return Math.atan(Math.pow(Math.E, Math.PI)) * 180 / Math.PI;
    }

    /**
     * 反古德曼函数，返回赤道距离
     * @param gpsLattitude
     * @return
     */
    private static double countDis(double gpsLattitude){
        double earthRad = 6378137.0;
        double a = gpsLattitude * Math.PI / 180;
        double y = earthRad / 2 * Math.log((1.0 + Math.sin(a)) / (1.0 - Math.sin(a)));
        return y;
    }


    public static String mapxToGps(String x){
        return 116.049671 + (Double.valueOf(x)/55.51*197.651473)/85779.66839349142 + "";
    }

    public static String mapyToGps(String y){
        return countLat(countDis(40.071171) - ((Double.valueOf(y)/55.51)*197.651473)) + "";
    }
}
