package com.service.impl;

import com.dao.FnDao;
import com.domain.Fn;
import com.service.FnService;
import orm.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class FnServiceImpl implements FnService {

    private FnDao fnDao = new SqlSession().getMapper(FnDao.class);

    @Override
    public List<Fn> findAll() {
        List<Fn> list = fnDao.findAll();
        return reBuildFn(list, -1);
    }

    /**
     *
     * @param source 还没组装好的功能列表（没有按照子父关系组装）
     * @param pno 给定开始位置（父节点）
     * @return 当前这一层组装好的功能信息（包含子信息）
     */
    private List<Fn> reBuildFn(List<Fn> source, int pno){
        List<Fn> newList = new ArrayList<>();
        for (Fn fn : source){
            if (fn.getPno() == pno){
                //找到了当前这层的功能
                if (fn.getFlag() == 2){
                    newList.add(fn);
                }else {
                    List<Fn> childList = reBuildFn(source, fn.getFno());
                    fn.setChildren(childList);
                    newList.add(fn);
                }
            }
        }
        return newList;
    }

    public void addFn(Fn fn){
        fnDao.insertOne(fn);
    }

    public void deleteFn(Integer fno){
        fnDao.deleteFn(fno);
    }

    @Override
    public void updateFn(Fn fn) {
        fnDao.updateFn(fn);
    }
}
