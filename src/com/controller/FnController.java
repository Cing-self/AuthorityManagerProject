package com.controller;

import com.domain.Fn;
import com.service.FnService;
import com.util.MySpring;
import springmvc.annotation.RequestMapping;
import springmvc.annotation.RequestParam;
import springmvc.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FnController {

    private FnService service = MySpring.getBean("com.service.impl.FnServiceImpl");
    @RequestMapping("findAllFn.do")
    @ResponseBody
    public List<Fn> findAllFn(){
        List<Fn> fnList = service.findAll();

        return fnList;
    }

    @RequestMapping("fnAdd.do")
    @ResponseBody
    public void fnAdd(Fn fn){
        System.out.println(fn);
        service.addFn(fn);
    }

    @RequestMapping("fnDelete.do")
    @ResponseBody
    public void fnDelete(@RequestParam("fno") Integer fno){
        service.deleteFn(fno);
    }

    @RequestMapping("fnUpdate.do")
    @ResponseBody
    public void fnUpdate(Fn fn){
        System.out.println(fn);
        service.updateFn(fn);
    }
}
