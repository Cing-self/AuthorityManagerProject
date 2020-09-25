package com.controller;

import com.domain.Fn;
import com.service.FnService;
import com.util.MySpring;
import springmvc.annotation.RequestMapping;
import springmvc.annotation.RequestParam;
import springmvc.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
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
        service.updateFn(fn);
    }

    @RequestMapping("assignFns.do")
    @ResponseBody
    public String assignFns(@RequestParam("rno") Integer rno, @RequestParam("fnos") String fnos){
        service.assignFns(rno, fnos);
        return "分配成功";
    }

    @RequestMapping("linkFns.do")
    @ResponseBody
    public List<Integer> linkFns(@RequestParam("rno") Integer rno){
        return service.findLinkFns(rno);
    }

    @RequestMapping("userMenu.do")
    @ResponseBody
    public List<Fn> userMenu(HttpServletRequest request){
        List<Fn> fns = (List<Fn>) request.getSession().getAttribute("userMenu");
        return fns;
    }

    @RequestMapping("userBtn.do")
    @ResponseBody
    public List<Fn> userBtn(HttpServletRequest request){
        return (List<Fn>) request.getSession().getAttribute("userBtn");
    }
}
