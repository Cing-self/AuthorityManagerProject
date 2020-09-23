<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/11
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .wrapper{
            width: 400px;
            background: #FFFFFF;
            border: 2px solid #e2dfe4;
            border-radius: 5%;
            padding: 10px;

            margin: 50px auto;
        }

        .wrapper li{
            list-style: none;
            margin-bottom: 8px;
            text-align: center;
        }

        .wrapper input{
            width: 250px;
            height: 30px;
        }

        .wrapper button{
            width: 50px;
            height: 30px;
        }
    </style>

    <script>
        window.onload = function () {
            var pwdForm = document.getElementById("pwdForm");
            console.log(pwdForm);
            pwdForm.onsubmit = function () {
                var npass = document.getElementById("newpass").value;
                var repass = document.getElementById("repass").value;
                console.log(npass, repass);
                if (npass != repass){
                    alert("新密码与确认密码不一致");
                    return false;
                }
                return true;
            }
        }

    </script>
</head>
<body>
    <div class="wrapper">
        <h3 align="center">修改密码</h3>
        <form id="pwdForm" action="modifyPwd.do" method="post">
            <ul>
                <li><input name="oldpass" id="oldpass" type="password" required="required" placeholder="原密码"></li>
                <li><input name="newpass" id="newpass" type="password" required="required" placeholder="新密码"></li>
                <li><input name="repass" id="repass" type="password" required="required" placeholder="确认密码"></li>
                <li><button>确认</button></li>
            </ul>
        </form>
    </div>
</body>
</html>
