package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    public long getTotal(Map<String, Object> param);

    public List<Role> findRoleByPageAndFilter(Map<String, Object> param);

    public List<Role> findUnAssignRole(String uno);
    public List<Role> findAssignRole(String uno);
    public void removeUser_Role(Integer uno);
    public void addUser_Role(Integer uno,int rno);
}
