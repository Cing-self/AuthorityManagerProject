<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/13
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #menuBox{
            width: 1000px;
            margin: 50px auto;
        }
        ul li{
            list-style: none;
            margin-top: 5px;
            cursor: default;
        }

        #menuBox div{
            border-bottom: 1px solid #a7c4c9;
        }

        #menuBox span{
            display: block;
            width: 200px;
            height: 16px;
            float: right;
        }

        input{
            width: 100px;
        }

        #menuBox div#active{
            background: #a7c4c9;
        }
    </style>
    <script>
        window.onload = function() {
            loadData();
        };
        function loadData(){
            var xhr = new XMLHttpRequest();
            xhr.open("post","findAllFn.do",true);
            xhr.onreadystatechange = function(){
                if (xhr.readyState == 4 && xhr.status == 200){
                    doBack(xhr.responseText);
                }
            }
            xhr.send();
        }
        function doBack(str) {
            var json = JSON.parse(str);
            var menuBox = document.getElementById("menuBox");
            showFn(json, menuBox);

            function showFn(fnList, position) {
                var ul = document.createElement('ul');
                position.appendChild(ul);
                for (var i = 0; i < fnList.length; i++) {
                    var fn = fnList[i];
                    var li = document.createElement('li');
                    ul.appendChild(li);
                    var div = document.createElement('div');
                    li.appendChild(div);

                    var flag = fn.flag == 1 ? '<font color="green">菜单</font>' : '<font color="#ff4500">按钮</font>';
                    div.innerHTML = fn.fname + '<span>' + fn.ftarget + '</span>' + '<span>' + fn.fhref + '</span>' + '<span>' + flag + '</span>';
                    div.fno = fn.fno;
                    div.fname = fn.fname;
                    div.fhref = fn.fhref;
                    div.ftarget = fn.ftarget;
                    div.flag = fn.flag;
                    if (fn.children && fn.children.length > 0) {
                        showFn(fn.children, li);
                    }
                }
            }

            //给Div增加点击事件,双击隐藏/展开
            var menuBox = document.getElementById('menuBox');
            var div = menuBox.getElementsByTagName('div');
            for (var i = 0; i <div.length; i ++){
                var d = div[i];
                d.ondblclick = function () {
                    var nextUl = this.nextElementSibling;
                    if (nextUl){
                        if (nextUl.style.display == 'none'){
                            nextUl.style.display = 'block';
                        }else {
                            nextUl.style.display = 'none';
                        }
                    }
                }
            }


            //点击网页空白处，右击开启新建主功能
            document.oncontextmenu = function () {
                addRootFn();
                return false;
            }

            //给每一个菜单项新建右键子功能的功能
            var divs = document.getElementById("menuBox").getElementsByTagName('div');
            for (var i = 0; i < divs.length ; i ++){
                var div = divs[i];
                div.oncontextmenu = function (ev) {
                    return addChildFn(this, ev);
                }
            }

            //新建主功能
            var rootBtn = document.getElementById("rootBtn");
            rootBtn.onclick = function () {
                addRootFn();
            }

            //新建子功能
            var childBtn = document.getElementById("childBtn");
            childBtn.onclick = function () {

            }

            //为每一个菜单增加单击选中效果
            var menuBox = document.getElementById("menuBox");
            var div = menuBox.getElementsByTagName("div");
            for (var i = 1; i < divs.length; i ++){
                var div = divs[i];
                div.onclick = function (e) {
                    var active = document.getElementById("active");
                    if (active != null)
                        active.id='';
                    this.id = "active";
                }
            }

            //为删除按钮增加点击事件
            var deleteBtn = document.getElementById("deleteBtn");
            deleteBtn.onclick = function () {
                var active = document.getElementById("active");
                if (!active){
                    alert("请选择要删除的功能");
                    return;
                }
                console.log(active.fno);
                var ul = active.nextElementSibling;
                if (ul && ul.children && ul.children.length > 0){
                    //有子功能，不能删除
                    alert("请先删除子功能");
                    return;
                }
                if (confirm("是否确认删除")){
                    var xhr = new XMLHttpRequest();

                    xhr.open('get', 'fnDelete.do?fno='+ active.fno, true);

                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200){
                            doBack(xhr.responseText);
                        }
                    }

                    xhr.send();

                    function doBack(responseText) {
                        alert("删除成功");
                        var menuBox = document.getElementById("menuBox");
                        var uls = menuBox.children;
                        var ul = uls[uls.length - 1];
                        menuBox.removeChild(ul);
                        loadData();
                    }
                }
            }

            //为编辑按钮增加点击事件
            var editBtn = document.getElementById("editBtn");
            editBtn.onclick = function () {
                var fname = document.getElementById('fname');
                if (fname){
                    alert("操作还未完成");
                    return false;
                }

                var active = document.getElementById("active");
                if (!active){
                    alert("请选择要编辑修改的功能");
                    return;
                }
                var oldDiv = active.innerHTML;//保存编辑之前的数据

                active.innerHTML = '<input id="fname" placeholder="功能名称" required="required" value="'+ active.fname + '+"/>' +
                    '<span><input id="ftarget" placeholder="功能类型" value="'+ active.ftarget +'"/><button id="updateBtn" style="margin-left: 2px">修改</button><button id="cancelBtn" style="margin-left: 2px">取消</button></span>' +
                    '<span><input id="fhref" placeholder="功能请求" value="' + active.fhref + '"/></span>';
                if (active.flag == 1){
                    active.innerHTML += '<span><select id="flag">' +
                        '<option value="1">菜单</option><option value="2">按钮</option>' +
                        '</select></span>';
                }else {
                    active.innerHTML += '<span><select id="flag">' +
                        '<option value="1">菜单</option><option value="2" selected="selected">按钮</option>' +
                        '</select></span>';
                }

                var cancelBtn = document.getElementById("cancelBtn");
                cancelBtn.onclick = function () {
                    active.innerHTML = oldDiv;
                }

                var updateBtn = document.getElementById("updateBtn");
                updateBtn.onclick = function () {
                    var fname = document.getElementById("fname").value;
                    var ftarget = document.getElementById("ftarget").value;
                    var fhref = document.getElementById("fhref").value;
                    var flag = document.getElementById("flag").value;
                    var fno = active.fno;

                    //ajax发送保存功能的请求
                    var xhr = new XMLHttpRequest();
                    xhr.open("post","fnUpdate.do",true);
                    xhr.onreadystatechange = function(){
                        if (xhr.readyState == 4 && xhr.status == 200){
                            doBack();
                        }
                    }
                    xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    xhr.send("fname="+fname+"&ftarget="+ftarget+"&fhref="+fhref+"&flag="+flag+"&fno="+ fno);

                    function doBack() {
                        alert("修改成功");
                        var menuBox = document.getElementById("menuBox");
                        var uls = menuBox.children;
                        var ul = uls[uls.length - 1];
                        menuBox.removeChild(ul);
                        loadData();
                    }

                }

            }
        }

        //增加子菜单函数
        function addChildFn(ele, ev) {
            ev.cancelBubble = true;//组织冒泡

            var spans = ele.getElementsByTagName('span');
            var lastSpan = spans[spans.length - 1];
            if (lastSpan.innerHTML.indexOf("按钮") != -1){
                //证明这个是一个按钮
                alert('不能为按钮增加子功能');
                return false;
            }
            var nextUl = ele.nextElementSibling;
            if (nextUl == null){
                nextUl = document.createElement('ul');
                ele.parentNode.appendChild(nextUl);
            }
            addFn(nextUl, ele.fno);

            return false;
        }

        //增加根菜单函数
        function addRootFn() {
            var menuBox = document.getElementById("menuBox");
            var uls = menuBox.children;
            var ul = uls[uls.length - 1];
            addFn(ul, -1);

            return false;
        }


        function addFn(ul, pno) {
            var fname = document.getElementById('fname');
            if (fname){
                alert("操作还未完成");
                return false;
            }


            var li = document.createElement("li");
            ul.appendChild(li);

            var div = document.createElement("div");
            li.appendChild(div);

            div.innerHTML = '<input id="fname" placeholder="功能名称" required="required"/>' +
                '<span><input id="ftarget" placeholder="功能类型"/><button id="saveBtn" style="margin-left: 2px">保存</button><button id="cancelBtn" style="margin-left: 2px">取消</button></span>' +
                '<span><input id="fhref" placeholder="功能请求"/></span>' +
                '<span><select id="flag">' +
                '<option value="1">菜单</option><option value="2">按钮</option>' +
                '</select></span>';


            //取消功能
            var cancel = document.getElementById("cancelBtn");
            cancel.onclick = function () {
                ul.removeChild(li);
            }

            //保存功能
            var saveBtn = document.getElementById("saveBtn");
            saveBtn.onclick = function () {
                var fname = document.getElementById("fname").value;
                var ftarget = document.getElementById("ftarget").value;
                var fhref = document.getElementById("fhref").value;
                var flag = document.getElementById("flag").value;
                var parentNo = pno;

                //ajax发送保存功能的请求
                var xhr = new XMLHttpRequest();
                xhr.open("post","fnAdd.do",true);
                xhr.onreadystatechange = function(){
                    if (xhr.readyState == 4 && xhr.status == 200){
                        doBack(xhr.responseText);
                    }
                }
                xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                xhr.send("fname="+fname+"&ftarget="+ftarget+"&fhref="+fhref+"&flag="+flag+"&pno="+parentNo);

                function doBack(responseText) {
                    alert("保存成功");
                    var menuBox = document.getElementById("menuBox");
                    var uls = menuBox.children;
                    var ul = uls[uls.length - 1];
                    menuBox.removeChild(ul);
                    loadData();
                }
            }

        }
    </script>
</head>
<body>
    <h3 align="center">功能管理</h3>
    <div id="menuBox">
        <ul>
            <li>
                <button id="rootBtn">新建主功能</button>
                <button id="childBtn">新建子功能</button>
                <button id="deleteBtn">删除功能</button>
                <button id="editBtn">编辑功能</button>
            </li>
        </ul>
        <ul>
            <li style="border: 0;font-weight: bold">
                <div>
                    菜单名称
                    <span>显示位置</span>
                    <span>功能请求</span>
                    <span>功能类型</span>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>
