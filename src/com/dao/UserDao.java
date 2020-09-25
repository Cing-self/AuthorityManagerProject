package com.dao;

import com.domain.Fn;
import com.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    public User findUserByNameAndPass(String uname, String upass);

    public long getTotalPageNumber(Map<String, Object> paramBox);

    public List<User> findUserList(Map<String, Object> paramBox);

    public void insertUser(User user);

    public void deleteUser(Integer uno);

    public User selectOne(Integer uno);

    public void updateUser(User user);

    public List<User> findAll();

    public void modifyPwd(Integer uno, String newpass);

}

