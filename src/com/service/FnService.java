package com.service;

import com.domain.Fn;

import java.util.List;

public interface FnService {

    public List<Fn> findAll();

    public void addFn(Fn fn);

    public void deleteFn(Integer fno);

    public void updateFn(Fn fn);
}
