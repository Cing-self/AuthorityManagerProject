package com.service;

import com.domain.Fn;
import com.domain.PageInfo;
import com.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    public User checkLogin(String uname, String upass);

    public PageInfo findUserByPageAndFilter(Map<String, Object> paramBox);

    public void saveUser(User user);

    public void deleteUser(Integer uno);

    public User findUserById(Integer uno);

    public void updateUser(User user);

    public void deleteUserList(String unoStr);

    public void importUserList(List<User> userList);

    public List<User> exportUserList();

    public void modifyPwd(Integer uno, String newpass);

}
