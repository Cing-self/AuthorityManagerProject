package com.service.impl;

import com.dao.FnDao;
import com.domain.Fn;
import com.service.FnService;
import orm.SqlSession;

import java.util.*;

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

    //分配功能
    @Override
    public void assignFns(Integer rno, String fnos) {
        fnDao.removeRelationshipByRole(rno);

        String[] fnoArray = fnos.split(",");
        for (String fno : fnoArray){
            Map<String, Object> map = new HashMap<>();
            map.put("rno", rno);
            map.put("fno", fno);
            fnDao.addRelationshipForRole(map);
        }
    }

    @Override
    public List<Integer> findLinkFns(Integer rno) {
        return fnDao.findLinkFns(rno);
    }

    @Override
    public List<Fn> findUserMenu(Integer uno) {
        List<Fn> fns = fnDao.findMenuByUser(uno);
        return reBuildFn(fns, -1);
    }

    @Override
    public List<Fn> findUserBtn(Integer uno) {
        return fnDao.findBtnByUser(uno);
    }

    @Override
    public List<Fn> findBaseAll() {
        return fnDao.findAll();
    }

    @Override
    public List<Fn> findFnsByUser(int uno) {
        return fnDao.findFnsByUser(uno);
    }


}
