<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/5
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人员信息管理系统</title>
    <link rel="stylesheet" href="css/main.css">
    <script type="text/javascript">
        function toExit() {
            var f = confirm("是否确认注销");
            if (f){
                location.href = "exitUser.do";
            }
        }
    </script>
    <style>
    </style>
</head>
<body>
    <div class="top">
        <h2>xxxx公司人员信息管理系统</h2>
        <div>
            欢迎 [<a href="javascript:toExit()"><span>${sessionScope.loginUser.realname}</span></a>]
        </div>
    </div>
    <div class="left">
        <ul class="menu">
            <li>
                <div>权限管理</div>
                <ul>
                    <li>
                        <div>
                            <a href="getUserList.do" target="right">用户管理</a>
                        </div>
                    </li>
                    <li><div><a href="roleList.jsp" target="right">角色管理</a></div></li>
                    <li><div><a href="fnList.jsp" target="right">功能管理</a></div></li>
                </ul>
            </li>
            <li>
                <div>基本信息管理</div>
                <ul>
                    <li><div>商品管理</div></li>
                    <li><div>供应商管理</div></li>
                    <li><div>仓库管理</div></li>
                </ul>
            </li>
            <li>
                <div>系统管理</div>
                <ul>
                    <li>
                        <div><a href="modifyPwd.jsp" target="right">修改密码</a></div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="right">
        <iframe name="right" width="100%" height="100%" frameborder="0"/>
    </div>
</body>
</html>
