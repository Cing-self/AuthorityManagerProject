<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/18
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .box{
            width: 500px;
            margin: 100px auto;
        }
        ul, li{
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .assignBox,.unAssignBox{
            width: 200px;
            height: 400px;
            border: 2px solid gray;
        }

        .assignBox li,.unAssignBox li{
            margin-bottom: 8px;
            border-bottom: 1px dotted #ccc;
            padding-left: 5px;
            cursor: default;
        }

        .title{
            font-weight: bold;
            border: 0;
        }

        .unAssignBox,.btnBox,.assignBox{
            float: left;
        }

        .btnBox{
            width: 80px;
        }

        .btnBox button{
            width: 60px;
            height: 30px;
            margin-top: 90px;
            margin-left: 10px;
        }

    </style>
    <script src="js/jquery.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url:'unAssignRole.do',
                type:'post',
                data:{
                    'uno' : $('#uno').val()
                },
                async : true,
                success : function (roles) {
                    for (var i = 0; i < roles.length; i ++){
                        var role = roles[i];
                        $('.unAssignBox').append('<li rno="' + role.rno +'">' + role.rname +'</li>');
                        $('.unAssignBox li:gt(0)').click(function () {
                            addClickToRight();
                        })
                    }
                },
                error(msg){
                    console.log(msg);
                },
                dataType : 'json'
            });

            $.ajax({
                url:'assignRole.do',
                type:'post',
                data:{
                    'uno' : $('#uno').val()
                },
                async : true,
                success : function (roles) {
                    console.log(roles);
                    console.log(roles.length);
                    for (var i = 0; i < roles.length; i ++){
                        var role = roles[i];
                        $('.assignBox').append('<li rno="' + role.rno +'">' + role.rname +'</li>');
                        $('.assignBox li:gt(0)').click(function () {
                            addClickToLeft();
                        })
                    }
                },
                error(msg){
                    console.log(msg);
                },
                dataType : 'json'
            });
        });
        $(function () {
            $('#toRightBtn').click(function () {
                $('.unAssignBox li:gt(0)').appendTo($('.assignBox'));
                addClickToLeft();
            });
        });

        $(function () {
            $('#toLeftBtn').click(function () {
                $('.assignBox li:gt(0)').appendTo($('.unAssignBox'));
                addClickToRight();
            });
        });

        //为左侧列表选项增加向右移动的列表事件
        function addClickToRight() {
            $('.unAssignBox li:gt(0)').dblclick(function () {
                //this,表示触发当前事件的对象
                $(this).off('dblclick').appendTo($('.assignBox'));
                addClickToLeft();
            });
        }
        //为右侧列表选项增加向左移动的列表事件
        function addClickToLeft() {
            $('.assignBox li:gt(0)').dblclick(function () {
                //this,表示触发当前事件的对象
                $(this).off('dblclick').appendTo($('.unAssignBox'));

                addClickToRight();
            });
        }

        //给保存按钮增加点击事件
        $(function () {
            $('#saveBtn').click(function () {
                var str = '';
                $('.assignBox li:gt(0)').each(function (index, element) {
                    var rno = $(element).attr('rno');
                    str += rno + ',';
                });
                console.log(str);
                $.ajax({
                    url : 'assignRoles.do',
                    data : {
                        uno : $('#uno').val(),
                        rnos : str
                    },
                    type : 'post',
                    async : true,
                    success : function (result) {
                        console.log(result);
                        alert(result);
                    },
                    dataType: 'json'
                })
            })
        })
    </script>
</head>
<body>
    <input type="hidden" id="uno" value="${param.uno}"/>
    <h2 align="center">为${param.uname}分配角色</h2>
    <p align="center"><button type="button" id="saveBtn">保存</button></p>
    <div class="box">
        <ul class="unAssignBox">
            <li class="title">未分配角色列表</li>
        </ul>
        <ul class="btnBox">
            <li>
                <button id="toRightBtn">&gt; &gt;</button>
                <button id="toLeftBtn">&lt; &lt;</button>
            </li>
        </ul>
        <ul class="assignBox">
            <li class="title">已分配角色列表</li>
        </ul>
    </div>
</body>
</html>
