package com.dao;

import com.domain.Fn;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;
import java.util.Map;

public interface FnDao {

    @Select("select *from t_fn where del = 1")
    public List<Fn> findAll();

    @Insert("insert into t_fn values(null,#{fname},#{fhref},#{flag},#{ftarget},#{pno},1,now(),#{yl1},#{yl2})")
    public void insertOne(Fn fn);

    @Update("update t_fn set del = 2 where fno = #{fno}")
    public void deleteFn(int fno);

    @Update("update t_fn set fname=#{fname},fhref=#{fhref},flag=#{flag},ftarget=#{ftarget} where fno=#{fno}")
    public void updateFn(Fn fn);

    @Delete("delete from t_role_fn where rno = #{rno}")
    public void removeRelationshipByRole(int rno);

    @Insert("insert into t_role_fn values(#{rno}, #{fno})")
    public void addRelationshipForRole(Map<String, Object> param);

    @Select("select fno from t_role_fn where rno = #{rno}")
    public List<Integer> findLinkFns(Integer rno);

    @Select("select *from t_fn where flag = 1 and fno in (select fno from t_role_fn where rno in (select rno from t_user_role where uno=#{uno}) )")
    public List<Fn> findMenuByUser(int uno);

    @Select("select *from t_fn where flag = 2 and fno in (select fno from t_role_fn where rno in (select rno from t_user_role where uno=#{uno}) )")
    public List<Fn> findBtnByUser(int uno);

    @Select("select *from t_fn where fno in (select fno from t_role_fn where rno in (select rno from t_user_role where uno = #{uno}) )")
    public List<Fn> findFnsByUser(int uno);
}
