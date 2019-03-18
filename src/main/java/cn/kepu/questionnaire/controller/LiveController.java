package cn.kepu.questionnaire.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/live")
public class LiveController {

    @GetMapping("/live")
    public String live(){
        return "livePages/live";
    }
}
