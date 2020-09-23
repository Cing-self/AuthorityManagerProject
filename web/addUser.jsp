<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/7
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建用户</title>
    <link rel="stylesheet" href="css/addUser.css">
</head>
<body>

    <div class="wrapper">
        <h3 align="center">新建用户</h3>
        <form action="addUser.do" method="post">
            <table align="center">
                <tr>
                    <td>用户名：</td>
                    <td><input class="txt" name="uname" required="required"></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input class="txt" name="upass" value="123" readonly="readonly"></td>
                </tr>
                <tr>
                    <td>真实姓名：</td>
                    <td><input class="txt" name="realname" required="required"></td>
                </tr>
                <tr>
                    <td>年龄：</td>
                    <td><input class="txt" name="age" required="required"></td>
                </tr>
                <tr>
                    <td>性别：</td>
                    <td>
                        <label><input type="radio" name="sex" value="男" checked="checked">男</label>
                        <label><input type="radio" name="sex" value="女">女</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="保存">
                    </td>
                </tr>
            </table>
        </form>
    </div>

</body>
</html>
