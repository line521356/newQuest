package cn.kepu.questionnaire.tree.demo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import cn.kepu.questionnaire.tree.utils.C45Utils;

public class Demos {

    public static void main(String[] args) throws IOException {
        
        List<List<String>> currentData = getData();
        C45Utils.transformContinuouslyVariables(currentData);
    }

    private static List<List<String>> getData() {
        List<List<String>> ll = new ArrayList<>();
        File f = new File("C:\\Users\\admin\\Desktop\\forestfires-bak.csv");
        int count = 0;
        try {
            String templine = null;
            BufferedReader br = new BufferedReader(new FileReader(f));
            while((templine = br.readLine()) != null){
                if(count!=0){
                    String[] lines = templine.split(",");
                    ArrayList<String> l = new ArrayList<>();
                    for (int i = 0; i < lines.length; i++) {
                        if(i == 0){
                            if(Double.parseDouble(lines[i])>2){
                                l.add("大");
                            }else{
                                l.add("小");
                            }
                        }else if(i == 1){
                            Double temp = Double.parseDouble(lines[i]);
                            if(temp<0){
                                l.add("<0");
                            }else if(temp>=0&&temp<8){
                                l.add("0-8");
                            }else if(temp>=8&&temp<18){
                                l.add("8-18");
                            }else if(temp>=18){
                                l.add(">=18");
                            }
                        }else if(i == 2){
                            Double wind = Double.parseDouble(lines[i]);
                            if(wind>4){
                                l.add(">4");
                            }else{
                                l.add("<4");
                            }
                        }else if(i == 3){
                            Double rh = Double.parseDouble(lines[i]);
                            if(rh<50){
                                l.add("<50");
                            }else if(rh>=50&&rh<65){
                                l.add("50-65");
                            }else if(rh>=65&&rh<80){
                                l.add("65-80");
                            }else if(rh>=80){
                                l.add("80");
                            }
                        }else if(i == 4){
                            l.add(lines[i]);
                        }
                    }
                    ll.add(l);
                }
                count ++;
            }
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(ll);
        return ll;
    }

}
