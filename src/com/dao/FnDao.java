package com.dao;

import com.domain.Fn;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;

public interface FnDao {

    @Select("select *from t_fn where del = 1")
    public List<Fn> findAll();

    @Insert("insert into t_fn values(null,#{fname},#{fhref},#{flag},#{ftarget},#{pno},1,now(),#{yl1},#{yl2})")
    public void insertOne(Fn fn);

    @Update("update t_fn set del = 2 where fno = #{fno}")
    public void deleteFn(int fno);

    @Update("update t_fn set fname=#{fname},fhref=#{fhref},flag=#{flag},ftarget=#{ftarget} where fno=#{fno}")
    public void updateFn(Fn fn);
}
