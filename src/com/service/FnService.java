package com.service;

import com.domain.Fn;

import java.util.List;

public interface FnService {

    public List<Fn> findAll();

    public void addFn(Fn fn);

    public void deleteFn(Integer fno);

    public void updateFn(Fn fn);

    public void assignFns(Integer rno, String fnos);

    public List<Integer> findLinkFns(Integer rno);

    public List<Fn> findUserMenu(Integer uno);
    public List<Fn> findUserBtn(Integer uno);

    public List<Fn> findBaseAll();

    public List<Fn> findFnsByUser(int uno);

}
