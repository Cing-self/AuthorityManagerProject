<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/4
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
      <title>XXXX公司人员管理系统</title>
      <link rel="stylesheet" href="css/login.css">
  </head>
  <body>
  <div class="head">
      <p>XXXX公司人员管理系统</p>
  </div>
      <div class="wrap">
          <div class="container">
              <h1 style="color: white; margin: 0; text-align: center">登录</h1>
              <form action="login.do" method="post">
                  <div class="errorMsg" align="center" style="color: red; margin-top: 20px">${param.flag == 9?'用户名或密码错误':''}</div>
                  <label><input type="text" name="uname" placeholder="账号" required="required"/></label>
                  <label><input type="password" name="upass" placeholder="密码" required="required"/></label>

                  <input type="submit" value="登录"/>
              </form>
          </div>
          <ul>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
              <li></li>
          </ul>
      </div>
  </body>
</html>
