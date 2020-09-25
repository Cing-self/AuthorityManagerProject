package com.service.impl;

import com.dao.UserDao;
import com.dao.impl.UserDaoImpl;
import com.domain.Fn;
import com.domain.PageInfo;
import com.domain.User;
import com.service.UserService;
import com.util.MySpring;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = MySpring.getBean("com.dao.impl.UserDaoImpl");

    //该方法用于检测登录
    @Override
    public User checkLogin(String uname, String upass) {
        User user = userDao.findUserByNameAndPass(uname, upass);
        return user;
    }

    //该方法根据页数、记录数和过滤条件查找一组用户
    public PageInfo findUserByPageAndFilter(Map<String, Object> paramBox){
        long total = userDao.getTotalPageNumber(paramBox);
        //获取每页的记录数
        Integer row = (Integer) paramBox.get("row");
        //计算出总页数
        int maxPage = (int) Math.ceil(1.0 * total / row);
        //如果计算出的结果是0，那么就为1
        maxPage = Math.max(1, maxPage);

        //获取当前页数
        Integer page = (Integer) paramBox.get("page");
        page = Math.min(page, maxPage);

        //数据库分页：起始索引，查询的条数
        int startIndex = (page - 1) * row;
        int length = row;

        paramBox.put("startIndex", startIndex);
        paramBox.put("length", length);

        //根据筛选条件查找一组用户
        List<User> userList = userDao.findUserList(paramBox);

        return new PageInfo((long) maxPage, userList);
    }

    //插入新的用户
    public void saveUser(User user){
        userDao.insertUser(user);
    }

    //根据uno删除用户
    public void deleteUser(Integer uno){
        userDao.deleteUser(uno);
    }

    @Override
    public User findUserById(Integer uno) {
        return userDao.selectOne(uno);
    }

    public void updateUser(User user){
        userDao.updateUser(user);
    }

    //根据Uno删除一组用户
    public void deleteUserList(String unoStr){
        String[] unoList = unoStr.split(",");
        for (String uno : unoList){
            userDao.deleteUser(Integer.parseInt(uno));
        }
    }

    @Override
    public void importUserList(List<User> userList) {
        for (User user : userList){
            System.out.println(user);
            userDao.insertUser(user);
        }
    }

    @Override
    public List<User> exportUserList() {
        return userDao.findAll();
    }

    @Override
    public void modifyPwd(Integer uno, String newpass) {
        userDao.modifyPwd(uno, newpass);
    }


}
