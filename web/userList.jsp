<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/8/6
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="css/userlist.css">
    <link rel="stylesheet" href="css/弹出层.css">
    <script type="text/javascript">
        window.onload = function(){
            var maxPage = document.getElementById('maxPage').value;
            var pageSelectBtn = document.getElementById('pageSelectBtn');
            for (var i = 1; i <= maxPage; i ++){
                pageSelectBtn.innerHTML += '<option>' + i + '</option>';
            }

            //保存查询之后sex的选项
            var sexSelected = document.getElementById("sexSelectBtn");
            var sexValue = document.getElementById("u_sex").value;
            sexSelected.value = sexValue;

            //保存查询之后跳转的页码
            var page = document.getElementById("u_page").value;
            var pageSelected = document.getElementById("pageSelectBtn");
            page = parseInt(page);
            maxPage = parseInt(maxPage);
            page = Math.min(page, maxPage);
            pageSelected.value = page;

            //保存查询之后的记录数
            var rowValue = document.getElementById("u_row").value;
            document.getElementById("rowSelectBtn").value = rowValue;

            //为查询按钮增加点击事件
            var queryBtn = document.getElementById("queryBtn");
            queryBtn.onclick = function () {
                console.log("hhh");
                loadData();
            }

            //新建用户按钮
            var addBtn = document.getElementById("addBtn");
            if (addBtn){
                addBtn.onclick = function () {
                    location.href="addUser.jsp";
                }
            }

            //为清空查询增加点击事件
            var clearBtn = document.getElementById("clearBtn");
            clearBtn.onclick = function () {
                //清空筛选条件
                document.getElementById("unoText").value = '';
                document.getElementById("unameText").value ='';
                document.getElementById("sexSelectBtn").value = '';

                loadData();
            }

            //为上一页增加点击事件
            var prevBtn = document.getElementById("prevBtn");
            prevBtn.onclick = function () {
                var page = document.getElementById("pageSelectBtn").value;
                if (page == 1)
                    return;
                page = parseInt(page);
                page--;
                document.getElementById("pageSelectBtn").value = page;
                loadData();
            }

            //为下一页增加点击事件
            var nextBtn = document.getElementById("nextBtn");
            nextBtn.onclick = function () {
                var maxPage = document.getElementById("maxPage").value;
                var page = document.getElementById('pageSelectBtn').value;
                page = parseInt(page);
                maxPage = parseInt(maxPage);
                if (page == maxPage)
                    return;
                page ++;
                document.getElementById('pageSelectBtn').value = page;

                loadData();
            }

            //为显示几条增加点击事件
            var pageSelectBtn = document.getElementById("pageSelectBtn");
            pageSelectBtn.onchange = function () {
                loadData();
            }

            //为跳转增加点击事件
            var rowSelectBtn = document.getElementById("rowSelectBtn");
            rowSelectBtn.onchange = function () {
                loadData();
            }

            //全选事件
            var selectAllBtn = document.getElementById("selectAllBtn");
            selectAllBtn.onclick = function () {
                var checked = selectAllBtn.checked;
                var unoCheckedBtn = document.getElementsByClassName("unoChecked");
                for (var i = 0; i < unoCheckedBtn.length; i ++){
                    unoCheckedBtn[i].checked = checked;
                }
            }

            //批量删除事件
            var deletesBtn = document.getElementById("deletesBtn");
            if (deletesBtn){
                deletesBtn.onclick = function () {
                    var unoStr = '';//存储所有被选中的用户编号，使用逗号隔开
                    var unos = document.getElementsByClassName("unoChecked");

                    for (var i = 0; i < unos.length; i ++){
                        console.log(unos[i] + "--" + unos[i].checked);
                        if (unos[i].checked == true){
                            unoStr += unos[i].value + ',';
                        }
                    }
                    if (unoStr.length == 0){
                        alert('请选择要删除的记录');
                        return;
                    }
                    var f = confirm('是否确认删除' + unoStr);
                    if (f == false)
                        return;
                    location.href = 'userDeletes.do?unoStr=' + unoStr;
                }
            }


            //导入用户
            var importBtn = document.getElementById("importBtn");
            importBtn.onclick = function () {
                var modal = document.getElementsByClassName("modal")[0];
                modal.style.display = 'block';
                document.getElementById("importFileSelector").value = "";
            }

            var closeBtn = document.getElementsByClassName("close")[0];
            closeBtn.onclick = function () {
                var modal = document.getElementsByClassName("modal")[0];
                modal.style.display = 'none';
            }

            //模板下载
            var templateBtn = document.getElementById("templateBtn");
            templateBtn.onclick = function () {
                location.href = "UserTemplateDownload.do";
            }

            //批量导出
            var exportBtn = document.getElementById("exportBtn");
            exportBtn.onclick = function () {
                location.href = "exportUser.do";
            }

        }

        //用户删除事件
        function toDelete(uno) {
            var f = confirm("是否确认删除");
            if (f == false){
                return;
            }
            location.href = 'userDelete.do?uno=' + uno;
        }

        //编辑用户事件
        function editUser(uno) {
            location.href = 'editUser.do?uno=' + uno;
        }
        function loadData() {
            var uno = document.getElementById("unoText").value;
            var uname = document.getElementById("unameText").value;
            var sex = document.getElementById('sexSelectBtn').value;
            var page = document.getElementById('pageSelectBtn').value;
            var row = document.getElementById('rowSelectBtn').value;

            location.href = 'getUserList.do?uno=' + uno + '&uname=' + uname + '&sex=' + sex + '&page=' + page +
                "&row=" + row;
        }

    </script>
</head>
<body>
<h2 align="center">用户列表</h2>
<ul class="btnBox">
    <li><input type="number" id="unoText" placeholder="输入编号" /></li>
    <li><input id="unameText" placeholder="输入名称" /></li>
    <li>
        <input type="hidden" id="u_no" value="${requestScope.uno}">
        <input type="hidden" id="u_name" value="${requestScope.uname}">
        <input type="hidden" id="u_sex" value="${requestScope.sex}">
        <input type="hidden" id="u_page" value="${requestScope.page}">
        <input type="hidden" id="u_row" value="${requestScope.row}">
        <select id="sexSelectBtn">
            <option value="">=性别=</option>
            <option>男</option>
            <option>女</option>
        </select>
    </li>
    <li><button type="button" id="queryBtn">查询</button></li>
    <li><button type="button" id="clearBtn">清空查询</button></li>
    <c:forEach items="${sessionScope.userBtn}" var="fn">
        <c:if test="${fn.fhref == 'addUser.jsp'}">
            <li><button type="button" id="addBtn">新建用户</button> </li>
        </c:if>
    </c:forEach>
    <c:forEach items= "${sessionScope.userBtn}" var= "fn">
        <c:if test="${fn.fhref == 'userDeleteByGroup.do'}">
            <li><button type="button" id="deletesBtn">批量删除</button> </li>
        </c:if>
    </c:forEach>
    <li><button type="button" id="importBtn">批量导入</button></li>
    <li><button type="button" id="exportBtn">批量导出</button></li>
</ul>
<table width="80%" border="1" align="center" cellspacing="0">
    <thead>
    <tr>
        <th><input type="checkbox" id="selectAllBtn"></th>
        <th>用户编号</th>
        <th>用户名</th>
        <th>真实姓名</th>
        <th>年龄</th>
        <th>性别</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${requestScope.pageInfo.list.size() == 0}">
            <tr align="center">
                <td colspan="6">没有任何记录</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${requestScope.pageInfo.list}" var="user" >
                <tr align="center">
                    <td><input type="checkbox" class="unoChecked" value="${user.uno}"></td>
                    <td>${user.uno}</td>
                    <td>${user.uname}</td>
                    <td>${user.realname}</td>
                    <td>${user.age}</td>
                    <td>${user.sex}</td>
                    <td>
                        <c:forEach items="${sessionScope.userBtn}" var="fn">
                            <c:if test="${fn.fhref == 'editUser.do'}">
                                <a href="javascript:editUser(${user.uno})">编辑</a> |
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${sessionScope.userBtn}" var="fn">
                            <c:if test="${fn.fhref == 'deleteUser.do'}">
                                <a href="javascript:toDelete(${user.uno})">删除</a>
                            </c:if>
                        </c:forEach>
                        <a href="assignRoles.jsp?uno=${user.uno}&uname=${user.realname}">分配角色</a>
                    </td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>

<ul class="pageBox">
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
        <input type="hidden" id="maxPage" value="${requestScope.pageInfo.maxPage}" />
        跳转
        <select id="pageSelectBtn"></select>
        页
    </li>
    <li><button id="prevBtn" type="button">上一页</button></li>
    <li><button id="nextBtn" type="button">下一页</button></li>
</ul>

    <div class="modal"style="display: none">
        <div class="container">
            <form action="importUser.do" method="post" enctype="multipart/form-data">
                <table align="center">
                    <tr>
                        <td><h3>用户导入</h3></td>
                    </tr>
                    <tr>
                        <td><input type="file" id="importFileSelector" name="excel"></td>
                    </tr>
                    <tr>
                        <td><input type="button" id="templateBtn" value="模板下载"></td>
                    </tr>
                    <tr>
                        <td><input type="submit"></td>
                    </tr>
                </table>
            </form>
            <div class="close">
                X
            </div>
        </div>
    </div>
</body>
</html>

