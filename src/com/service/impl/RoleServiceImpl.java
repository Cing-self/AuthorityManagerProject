package com.service.impl;

import com.dao.RoleDao;
import com.domain.PageInfo;
import com.domain.Role;
import com.service.RoleService;
import com.util.MySpring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleServiceImpl implements RoleService {
    private RoleDao roleDao = MySpring.getBean("com.dao.impl.RoleDaoImpl");
    @Override
    public PageInfo findRowByPageAndFilter(Map<String, Object> param) {
        //总记录数
        long total = roleDao.getTotal(param);
        //每页记录数
        int row = (int) param.get("row");
        //最大页数
        int maxPage = (int) (total%row == 0 ? total/row : total/row + 1);
        maxPage = Math.max(1, maxPage);
        //当前页数
        int page = (int) param.get("page");
        page = Math.min(page, maxPage);
        //查询语句页数起始索引
        int start = (page - 1) * row;
        //查询条数
        int length = row;
        param.put("start", start);
        param.put("length", length);

        List<Role> roleList = roleDao.findRoleByPageAndFilter(param);
        return new PageInfo((long) maxPage, roleList);
    }

    @Override
    public List<Role> findUnAssignRole(String uno) {
        return roleDao.findUnAssignRole(uno);
    }


    @Override
    public List<Role> findAssignRole(String uno) {
        return roleDao.findAssignRole(uno);
    }

    @Override
    public void assignRole(Integer uno, String rnos) {
        roleDao.removeUser_Role(uno);
        String[] strings = rnos.split(",");
        Map<String, Object> map = new HashMap<>();
        if (strings.length > 0){
            for (int i = 0; i < strings.length; i ++){
                roleDao.addUser_Role(uno, Integer.parseInt(strings[i]));
            }
        }
    }
}
