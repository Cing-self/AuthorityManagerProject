<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/10
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/userEdit.css">
</head>
<body>

    <div class="wrapper">
        <h3 align="center">用户编辑</h3>
        <form action="userUpdate.do" method="post">
            <input type="hidden" name="uno" value="${requestScope.user.uno}">
            <table align="center">
                <tr>
                    <td>用户名：</td>
                    <td><input class="txt" name="uname" required="required" value="${requestScope.user.uname}"></td>
                </tr>
                <tr>
                    <td>真实姓名：</td>
                    <td><input class="txt" name="realname" required="required" value="${requestScope.user.realname}"></td>
                </tr>
                <tr>
                    <td>年龄：</td>
                    <td><input class="txt" name="age" required="required" value="${requestScope.user.age}"></td>
                </tr>
                <tr>
                    <td>性别：</td>
                    <td>
                        <c:choose>
                            <c:when test="${requestScope.user.sex=='男'}">
                                <label><input type="radio" name="sex" value="男" checked="checked">男</label>
                                <label><input type="radio" name="sex" value="女">女</label>
                            </c:when>
                            <c:otherwise>
                                <label><input type="radio" name="sex" value="男">男</label>
                                <label><input type="radio" name="sex" value="女" checked="checked">女</label>
                            </c:otherwise>
                        </c:choose>

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
