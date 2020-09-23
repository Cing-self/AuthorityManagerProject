<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/12
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        window.onload = function () {
            //加载表格数据

            loadData();

            //查询按钮
            var queryBtn = document.getElementById("queryBtn");
            queryBtn.onclick = function () {
                loadData();
            }

            //清空查询
            var clearBtn = document.getElementById("clearBtn");
            clearBtn.onclick = function () {
                document.getElementById("rno").value = '';
                document.getElementById('rname').value = '';
                document.getElementById('description').value = '';
                loadData();
            }

            //上一页
            var prevBtn = document.getElementById("prevBtn");
            prevBtn.onclick = function () {
                var page = document.getElementById('pageSelectBtn').value;
                if (page == 1)
                    return;
                page = parseInt(page);
                page --;
                document.getElementById('pageSelectBtn').value = page;
                loadData();
            }
            //下一页
            var nextBtn = document.getElementById("nextBtn");
            nextBtn.onclick = function () {
                var page = document.getElementById('pageSelectBtn').value;
                var options = document.getElementById('pageSelectBtn').children;
                var maxPage = options[options.length - 1].innerHTML;
                page = parseInt(page);
                maxPage = parseInt(maxPage);
                if (page == maxPage){
                    return;
                }

                page++;

                document.getElementById('pageSelectBtn').value = page;
                loadData();
            }
            //条数转换事件
            var rowSelectBtn = document.getElementById('rowSelectBtn');
            rowSelectBtn.onchange = function () {
                loadData();
            }

            //页数转换事件
            var pageSelectBtn = document.getElementById('pageSelectBtn');
            pageSelectBtn.onchange = function () {
                loadData();
            }
        }

        function loadData(){
            var rno = document.getElementById("rno").value;
            var rname = document.getElementById("rname").value;
            var description = document.getElementById("description").value;
            var row = document.getElementById("rowSelectBtn").value;
            var page = document.getElementById("pageSelectBtn").value;

            var xhr = new XMLHttpRequest();
            xhr.open("post", "getRoleList.do", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    doBack(xhr.responseText);
                }
            };

            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("rno=" + rno + "&rname=" + rname + "&description=" + description + "&row=" + row + "&page=" + page);

            function doBack(result){
                var pageInfo = JSON.parse(result);

                //加载页码列表
                var maxPage = pageInfo.maxPage;
                var pageSelectBtn = document.getElementById("pageSelectBtn");
                pageSelectBtn.innerHTML = ''; // 刷新页码
                for (var i = 1; i <= maxPage; i ++){
                    pageSelectBtn.innerHTML += "<option>" + i +"</option>";
                }
                //设置当前页码
                page = parseInt(page);
                if (page < maxPage){
                    pageSelectBtn.value = page;
                }else {
                    pageSelectBtn.value = maxPage;
                }

                //加载表格数据
                var roleList = pageInfo.list;
                var tbody = document.getElementById('tbody');
                tbody.innerHTML = '';
                if (roleList.length == 0){
                    tbody.innerHTML += '<tr><td align="center" colspan="4">查无数据</td></td>';
                }else {
                    for (var i = 0; i < roleList.length; i ++){
                        var role = roleList[i];
                        var tr = document.createElement('tr');
                        tbody.appendChild(tr);

                        var td1 = document.createElement('td');
                        var td2 = document.createElement('td');
                        var td3 = document.createElement('td');
                        var td4 = document.createElement('td');
                        tr.appendChild(td1);
                        tr.appendChild(td2);
                        tr.appendChild(td3);
                        tr.appendChild(td4);

                        td1.innerHTML = roleList[i].rno;
                        td2.innerHTML = roleList[i].rname;
                        td3.innerHTML = roleList[i].description;
                        td4.innerHTML = '<a href="">删除</a> <a href="">编辑</a> <a href="assignFns.jsp?rno=' + role.rno + '&rname=' + role.rname + '">分配功能</a>' ;

                    }
                }
            }

        }
    </script>
    <style>
        *{
            padding: 0;
        }
        ul li{
            margin: 0;
            list-style: none;
        }

        .headerBox input{
            width: 100px;
        }
        .headerBox li{
            float: left;
            margin-right: 8px;
            margin-bottom: 10px;
        }
        .headerBox{
            margin-left: 10%;
        }

        .footerBox li{
            float: left;
            margin-left: 8px;
        }

        .footerBox{
            position: absolute;
            right: 11%;
        }
    </style>
</head>
<body>
    <h3 align="center">角色列表</h3>
    <ul class="headerBox">
        <li><input id="rno" type="number" name="rno" placeholder="角色编号"></li>
        <li><input id="rname" type="text" name="rname" placeholder="角色名称"></li>
        <li><input id="description" type="text" id="description" placeholder="角色描述"></li>
        <li><button type="button" id="queryBtn">查询</button></li>
        <li><button type="button" id="clearBtn">清空查询</button></li>
    </ul>
    <table align="center" width="80%" cellspacing="0" border="1">
        <thead>
            <tr>
                <th>角色编号</th>
                <th>角色名称</th>
                <th>角色描述</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id='tbody'>

        </tbody>
    </table>
    <ul class="footerBox">
        <li>
            显示
            <select id="rowSelectBtn">
                <option>5</option>
                <option>10</option>
                <option>15</option>
                <option>20</option>
            </select>
            条
        </li>
        <li>
            显示
            <select id="pageSelectBtn">
                <option>1</option>
            </select>
            页
        </li>
        <li><button id="prevBtn">上一页</button></li>
        <li><button id="nextBtn">下一页</button></li>
    </ul>

</body>
</html>
