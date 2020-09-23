package com.dao.impl;

import com.dao.UserDao;
import com.domain.User;
import orm.SqlSession;

import java.util.*;

public class UserDaoImpl implements UserDao {

    @Override
    public User findUserByNameAndPass(String uname, String upass) {
        String sql = "select *from t_user where uname=#{uname} and upass=#{upass} and del=1";
        Map<String, Object> param = new HashMap<>();
        param.put("uname", uname);
        param.put("upass", upass);

        SqlSession sqlSession = new SqlSession();
        return sqlSession.selectOne(sql, param, User.class);
    }

    //根据筛选条件查找一组用户
    public List<User> findUserList(Map<String, Object> paramBox){
        StringBuilder sql = new StringBuilder("select *from t_user where del=1 ");
        appendSql(paramBox, sql);
        sql.append(" order by createtime desc");
        sql.append(" limit #{startIndex}, #{length}");
        return new SqlSession().selectList(sql.toString(), paramBox, User.class);
    }

    //根据筛选条件查找总记录数
    public long getTotalPageNumber(Map<String, Object> paramBox){
        StringBuilder sql = new StringBuilder("select count(*) from t_user where del=1 ");
        appendSql(paramBox, sql);
        return new SqlSession().selectOne(sql.toString(), paramBox, long.class);
    }

    private void appendSql(Map<String, Object> paramBox, StringBuilder sql){
        Integer uno = (Integer) paramBox.get("uno");
        if (uno != null){
            sql.append("and uno=#{uno} ");
        }
        String uname = (String) paramBox.get("uname");
        if (uname != null && !"".equals(uname)){
            sql.append(" and uname like concat(#{uname},'%') ");
        }
        String sex = (String) paramBox.get("sex");
        if (sex != null && !"".equals(sex)){
            sql.append(" and sex=#{sex}");
        }
    }

    @Override
    public void insertUser(User user) {
        String sql = "insert into t_user values(null,#{uname},#{upass},#{realname},#{sex},#{age},1,now(),#{yl1},#{yl2})";
        new SqlSession().insert(sql, user);
    }

    @Override
    public void deleteUser(Integer uno) {
        String sql = "delete from t_user where uno=#{uno}";
        new SqlSession().delete(sql, uno);
    }

    @Override
    public User selectOne(Integer uno) {
        String sql = "select *from t_user where uno=#{uno}";
        return new SqlSession().selectOne(sql, uno, User.class);
    }

    @Override
    public void updateUser(User user) {
        String sql = "update t_user set uname=#{uname},realname=#{realname},age=#{age},sex=#{sex} where uno=#{uno}";
        new SqlSession().update(sql, user);
    }

    @Override
    public List<User> findAll() {
        String sql = "select *from t_user where del = 1";
        return new SqlSession().selectList(sql,null, User.class);
    }

    public void modifyPwd(Integer uno, String newPass){
        String sql = "update t_user set upass=#{newpass} where uno=#{uno}";
        Map<String, Object> map = new HashMap<>();
        map.put("uno", uno);
        map.put("newpass",newPass);
        new SqlSession().update(sql, map);
    }
}
