package cn.kepu.questionnaire.pojo;

/**
 * 两个圆相交求交点-圆对象，包含圆心坐标与半径
 * @author SilentWhale
 *
 */
public class Circle {
    private double x;
    private double y;
    private double r;
    public Circle(double X,double Y,double R){
        x=X;
        y=Y;
        r=R;
    }
    public double getX(){
        return x;
    }
    public double getY(){
        return y;
    }
    public double getR(){
        return r;
    }
}
