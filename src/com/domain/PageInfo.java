package com.domain;

import java.util.List;

public class PageInfo {

    private Long maxPage;
    private List<?> list;

    public PageInfo(Long maxPage, List<?> list) {
        this.maxPage = maxPage;
        this.list = list;
    }

    @Override
    public String toString() {
        return "PageInfo{" +
                "maxPage=" + maxPage +
                ", list=" + list +
                '}';
    }

    public Long getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(Long maxPage) {
        this.maxPage = maxPage;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }
}
