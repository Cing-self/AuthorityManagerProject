<%--
  Created by IntelliJ IDEA.
  User: cai jin hong
  Date: 2020/9/23
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分配功能</title>
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
    <script src="js/jquery.js"></script>

    <script>
        $(function () {
            $.ajax({
                url: 'findAllFn.do',
                data: {},
                async: false,
                type: 'get',
                success: function (fnList) {
                    showLevelFnList(fnList, $('#menuBox'));

                    function showLevelFnList(fns, $position) {
                        var ul = $('<ul>');
                        $position.append(ul);
                        for (var i = 0; i < fns.length; i ++){
                            var fn = fns[i];
                            var li = $('<li>');
                            ul.append(li);
                            var div = $('<div>');
                            li.append(div);

                            div.append('<input type="checkbox" value="' + fn.fno + '"/>');
                            div.append(fn.fname);
                            div.append('<span>' + fn.ftarget + '</span>');
                            div.append('<span>' + fn.fhref + '</span>');
                            div.append('<span>' + (fn.ftarget == 1 ? '<font color="green">菜单</font>' : '<font color="red">按钮</font>') + '</span>');

                            if (fn.children && fn.children.length > 0){
                                showLevelFnList(fn.children, li);
                            }
                        }

                    }

                    //数据装载完毕
                    //为菜单列表增加双击展开合并操作
                    $('#menuBox > ul:gt(0) div').dblclick(function () {
                        $(this).next('ul').slideToggle(600);
                    });
                    
                    //为复选框增加点击事件，实现选择或取消
                    $('#menuBox :checkbox').click(function () {
                        if (this.checked){
                            //选中
                            //递归选中当前菜单的子集菜单
                            checkChildren($(this));
                            function checkChildren($parent) {
                                var ul = $parent.parent().next('ul');
                                if (ul.length > 0){
                                    //有子集菜单
                                    var inputs = ul.children().children().children('input');
                                    inputs.prop('checked', true);
                                    checkChildren(inputs);
                                }
                            }

                            checkParent($(this));
                            function checkParent($child) {
                                var div = $child.parent().parent().parent().prev('div');
                                if (div.length > 0){
                                    //有父级菜单
                                    var input = div.children('input');
                                    input.prop('checked', true);
                                    checkParent(input);
                                }

                            }
                        }else {
                            //取消
                            cancelChildren($(this));
                            function cancelChildren($parent) {
                                var ul = $parent.parent().next('ul');
                                if (ul.length > 0){
                                    var inputs = ul.children().children().children('input');
                                    inputs.prop('checked', false);
                                    cancelChildren(inputs);
                                }
                            };

                            cancelParent($(this));
                            function cancelParent($child) {
                                var div = $child.parent().parent().parent().prev('div');
                                if (div.length > 0){
                                    var input = div.children('input');
                                    inputs = div.next().children('li').children('div').children('input:checked');
                                    if (inputs.length > 0){
                                        //子菜单中还有被选中的，当前父级不取消
                                        return;
                                    }
                                    //子菜单都被取消了，父级也需要被取消
                                    input.prop('checked', false);
                                    cancelChildren(input);
                                }
                            };
                        }
                    });
                },
                dataType: 'json'
            });
        });
        $(function () {
            $('#saveBtn').click(function () {
                var rno = $('#rno').val();
                var fnos = '';
                $('#menuBox input:checked').each(function (i, input) {
                    fnos += $(input).val() + ',';
                });
                $.post('assignFns.do',{'rno':rno,'fnos':fnos}, function (result) {
                    console.log(fnos);
                    alert(result);
                });
            });
        });

        $(function () {
            //查询当前角色之前分配的功能，并默认勾选
            $.post('linkFns.do', {'rno':$('#rno').val()}, function (fnos) {
                for (var i = 0; i < fnos.length; i ++){
                    var fno = fnos[i];
                    $('input[value=' + fno + ']').prop('checked', true);
                }
            }, 'json');
        });
    </script>
</head>
<body>
    <h2>为[${param.rname}]分配功能</h2>
    <input type="hidden" id="rno" value="${param.rno}">
    <div id="menuBox">
        <ul><li style=""><div style="border: 0;"><button id="saveBtn">保存</button></div></li> </ul>
        <ul>
            <li  style="border: 0;font-weight: bold">
                <div>
                    菜单名
                    <span>显示位置</span>
                    <span>功能类型</span>
                    <span>功能请求</span>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>
