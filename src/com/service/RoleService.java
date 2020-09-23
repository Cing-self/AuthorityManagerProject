package com.service;

import com.domain.PageInfo;
import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {

    public PageInfo findRowByPageAndFilter(Map<String, Object> param);

    public List<Role> findUnAssignRole(String uno);

    public List<Role> findAssignRole(String uno);

    public void assignRole(Integer uno, String rnos);
}
