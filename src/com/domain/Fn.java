package com.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Fn implements Serializable {

    private static final long serialVersionUID = -5079029529218882664L;

    private Integer fno;
    private String fname;
    private String fhref;
    private Integer flag;
    private String ftarget;
    private Integer pno;

    private String yl1;
    private String yl2;

    private Fn pfn;
    private List<Fn> children = new ArrayList<>();

    public Fn() {
    }

    public Fn(Integer fno, String fname, String fhref, Integer flag, String varchar, Integer pno, String yl1, String yl2) {
        this.fno = fno;
        this.fname = fname;
        this.fhref = fhref;
        this.flag = flag;
        this.ftarget = varchar;
        this.pno = pno;
        this.yl1 = yl1;
        this.yl2 = yl2;
    }

    @Override
    public String toString() {
        return "Fn{" +
                "fno=" + fno +
                ", fname='" + fname + '\'' +
                ", fhref='" + fhref + '\'' +
                ", flag=" + flag +
                ", ftarget='" + ftarget + '\'' +
                ", pno=" + pno +
                ", yl1='" + yl1 + '\'' +
                ", yl2='" + yl2 + '\'' +
                ", pfn=" + pfn +
                ", children=" + children +
                '}';
    }

    public void setChildren(List<Fn> children) {
        this.children = children;
    }

    public List<Fn> getChildren() {
        return children;
    }

    public Integer getFno() {
        return fno;
    }

    public void setFno(Integer fno) {
        this.fno = fno;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getFhref() {
        return fhref == null ? "" : fhref;
    }

    public void setFhref(String fhref) {
        this.fhref = fhref;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public String getFtarget() {
        return ftarget == null ? "" : ftarget;
    }

    public void setFtarget(String ftarget) {
        this.ftarget = ftarget;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public String getYl1() {
        return yl1;
    }

    public void setYl1(String yl1) {
        this.yl1 = yl1;
    }

    public String getYl2() {
        return yl2;
    }

    public void setYl2(String yl2) {
        this.yl2 = yl2;
    }

    public Fn getPfn() {
        return pfn;
    }

    public void setPfn(Fn pfn) {
        this.pfn = pfn;
    }
}
