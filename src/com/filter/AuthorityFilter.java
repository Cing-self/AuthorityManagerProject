package com.filter;

import com.domain.Fn;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class AuthorityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String reqStr = request.getServletPath();

        //获取所有功能
        List<Fn> fns = (List<Fn>) request.getSession().getAttribute("fns");
        //用户还没登录的时候不验证
        if (fns == null){
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        //获取该用户拥有的功能
        List<Fn> userFns = (List<Fn>) request.getSession().getAttribute("userFns");
        for (Fn fn : fns){
            if (fn.getFhref() != null && !"".equals(fn.getFhref()) && reqStr.indexOf(fn.getFhref()) != -1){
                //该请求在所有的功能中，需要权限验证
                for (Fn uFn : userFns){
                    //循环该用户的权限，如果存在，表明该用户有该权限，直接放过
                    if (uFn.getFhref() != null && !"".equals(uFn.getFhref()) && reqStr.indexOf(uFn.getFhref()) != -1){
                        filterChain.doFilter(servletRequest, servletResponse);
                        return;
                    }
                    //证明该用户没有权限，需要进行权限验证
                    servletResponse.setContentType("text/html; charset=UTF-8");
                    servletResponse.getWriter().println("该用户权限不足");

                    return;
                }
            }
        }
        //此次请求不在功能列表中，不需要验证
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
