package com.domain;

import java.io.Serializable;
import java.util.List;

public class User implements Serializable {

    private static final long serialVersionUID = 223469754864972770L;

    private Integer uno ;
    private String uname ;
    private String upass ;
    private String realname ;
    private String sex ;
    private Integer age ;

    private String yl1 ;
    private String yl2 ;

    private List<Role> roles;

    public User(){}

    public User(Integer uno, String uname, String upass, String realname, String sex, Integer age, String yl1, String yl2) {
        this.uno = uno;
        this.uname = uname;
        this.upass = upass;
        this.realname = realname;
        this.sex = sex;
        this.age = age;
        this.yl1 = yl1;
        this.yl2 = yl2;
    }

    @Override
    public String toString() {
        return "User{" +
                "uno=" + uno +
                ", uname='" + uname + '\'' +
                ", upass='" + upass + '\'' +
                ", realname='" + realname + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", yl1='" + yl1 + '\'' +
                ", yl2='" + yl2 + '\'' +
                ", roles=" + roles +
                '}';
    }

    public Integer getUno() {
        return uno;
    }

    public void setUno(Integer uno) {
        this.uno = uno;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpass() {
        return upass;
    }

    public void setUpass(String upass) {
        this.upass = upass;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
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

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}
