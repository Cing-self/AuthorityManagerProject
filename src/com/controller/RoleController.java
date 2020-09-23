package com.controller;

import com.domain.PageInfo;
import com.domain.Role;
import com.service.RoleService;
import com.util.MySpring;
import springmvc.annotation.RequestMapping;
import springmvc.annotation.RequestParam;
import springmvc.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleController {

    private RoleService roleService = MySpring.getBean("com.service.impl.RoleServiceImpl");

    @RequestMapping("getRoleList.do")
    @ResponseBody
    public PageInfo getRoleList(@RequestParam("rno")Integer rno, @RequestParam("rname")String rname, @RequestParam("description")String description, @RequestParam("page")Integer page, @RequestParam("row")Integer row){
        Map<String, Object> map = new HashMap<>();
        map.put("rno", rno);
        map.put("rname", rname);
        map.put("description", description);
        map.put("page", page);
        map.put("row", row);

        PageInfo pageInfo = roleService.findRowByPageAndFilter(map);
        return pageInfo;

    }

    @RequestMapping("unAssignRole.do")
    @ResponseBody
    public List<Role> unAssignRole(@RequestParam("uno") String uno){
        List<Role> list = roleService.findUnAssignRole(uno);
        return list;
    }

    @RequestMapping("assignRole.do")
    @ResponseBody
    public List<Role> assignRole(@RequestParam("uno") String uno){
        List<Role> list = roleService.findAssignRole(uno);
        return list;
    }

    @RequestMapping("assignRoles.do")
    @ResponseBody
    public String assignRole(@RequestParam("uno") Integer uno, @RequestParam("rnos")String rnos){
        roleService.assignRole(uno, rnos);
        return "分配成功";
    }
}
