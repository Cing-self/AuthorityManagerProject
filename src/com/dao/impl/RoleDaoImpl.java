package com.dao.impl;

import com.dao.RoleDao;
import com.domain.Role;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleDaoImpl implements RoleDao {
    @Override
    public long getTotal(Map<String, Object> param) {
        String sql = "select count(*) from t_role where del = 1 ";
        sql = appendSql(sql, param);
        return new SqlSession().selectOne(sql, param, long.class);
    }

    @Override
    public List<Role> findRoleByPageAndFilter(Map<String, Object> param) {
        String sql = "select *from t_role where del = 1 ";
        sql = appendSql(sql, param);
        sql += " order by createtime desc ";
        sql += " limit #{start}, #{length}";
        return new SqlSession().selectList(sql, param, Role.class);
    }

    @Override
    public List<Role> findUnAssignRole(String uno) {
        String sql = "select *from t_role where rno not in (select rno from t_user_role where uno=#{uno})";
        return new SqlSession().selectList(sql, uno, Role.class);
    }

    @Override
    public List<Role> findAssignRole(String uno) {
        String sql = "select *from t_role where rno in (select rno from t_user_role where uno=#{uno})";
        return new SqlSession().selectList(sql, uno, Role.class);
    }

    @Override
    public void removeUser_Role(Integer uno) {
        String sql = "delete from t_user_role where uno=#{uno}";
        new SqlSession().delete(sql, uno);
    }

    @Override
    public void addUser_Role(Integer uno, int rno) {
        String sql = "insert into t_user_role values(#{uno},#{rno})";
        Map<String, Integer> map = new HashMap<>();
        map.put("uno", uno);
        map.put("rno", rno);
        new SqlSession().insert(sql, map);
    }

    private String appendSql(String sql, Map<String,Object> param){
        StringBuilder sb = new StringBuilder(sql);
        Integer rno = (Integer) param.get("rno");
        if (rno != null){
            sb.append("and rno=#{rno} ");
        }
        String rname = (String) param.get("rname");
        if (rname != null && !rname.equals("")){
            sb.append("and rname like concat(#{rname},'%') ");
        }
        String description = (String) param.get("description");
        if (description != null && !description.equals("")){
            sb.append(" and description like concat(#{description}, '%') ");
        }
        return sb.toString();
    }
}
