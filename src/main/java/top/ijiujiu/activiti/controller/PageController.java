package top.ijiujiu.activiti.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by top.ijiujiu on 2019/3/25.
 */
@Controller
public class PageController {
    @GetMapping("editor")
    public String test(){
        return "/modeler";
    }
}
