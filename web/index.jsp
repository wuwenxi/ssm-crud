<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wwx
  Date: 2018/5/20
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
</head>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<%--引入jquery框架--%>
<script type="text/javascript"
        src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>

<%--引入bootstrap--%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
      rel="stylesheet"/>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<body>

        <%--员工修改模态框部分--%>
        <div class="modal fade" tabindex="-1" role="dialog" id="emp_update_modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">员工修改</h4>
                    </div>
                    <div class="modal-body">
                        <%--制作具体表单   name属性：封装存储数据时  与POJO匹配 --%>
                        <form id="emp_form_id" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Name</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="emp_update_name"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="email" name="empEmail" class="form-control" id="emp_update_email" placeholder="Email@wwx.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Gender</label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="emp_update_gender1" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="emp_update_gender2" value="W"> 女
                                </label>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Dept</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="empDid">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_save">更新</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

                <%--员工添加模态框部分--%>
        <div class="modal fade" tabindex="-1" role="dialog" id="emp_add_modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <%--制作具体表单   name属性：封装存储数据时  与POJO匹配 --%>
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Name</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="emp_add_name" placeholder="Name">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="email" name="empEmail" class="form-control" id="emp_add_email" placeholder="Email@wwx.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Gender</label>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="emp_add_gender1" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="emp_add_gender2" value="W"> 女
                                </label>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Dept</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="empDid">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_add_save">保存</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <div class="row">
        <div class="col-md-4 col-md-offset-1" >
            <h1>SSM-CRUD</h1>
        </div>
        </div>
        <%--按钮--%>
            <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-info" id="emp_add_btn">添加</button>
                <button class="btn btn-danger" id="emp_del_btn">删除</button>
            </div>
        </div>

        <%--表格--%>
            <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <table class="table table-hover" id="emp_tbl">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        <%--底部页栏--%>
        <div class="row">
        <%--底部提示页码栏--%>
            <div class="col-md-offset-2" id="page_info"></div>
            <div class="col-md-offset-6" id="page_nav"></div>
        </div>

    <script type="text/javascript">

        var totalPages;
        var currentPages;
        //去到第几页
        $(function () {
            to_page(1);
        });

        //
        function to_page(pn){
            $.ajax({
                url:"${APP_PATH}/emp",
                data:"pn=" + pn,
                type:"GET",
                success:function (result) {
                    totalPages = result.extend.pageInfo.total;
                    currentPages = result.extend.pageInfo.pageNum;

                    build_emp_table(result);

                    build_page_info(result);

                    build_page_nav(result);
                }
            });
        }

        /*
                 创建 员工表
        * */
        function build_emp_table(result) {
            //每次清除页面数据
            $("#emp_tbl tbody").empty();
            var emp = result.extend.pageInfo.list;
            //jQuery遍历元素
            $.each(emp,function (index,item) {

                /*
                * alter跳出弹框
                * */
                /*alert(item.empName);*/

                //取出每一列数据
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var empGenderTd = $("<td></td>").append(item.empGender=="M"?"男":"女");
                var empEmailTd = $("<td></td>").append(item.empEmail);
                var empDeptTd = $("<td></td>").append(item.department.deptName);


                //按钮
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit_id",item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("del_btn",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                //制作表格  appendTo:将表添加到 emp_tbl 的 tbody当中
                $("<tr></tr>").append(empIdTd)
                    .append(empNameTd)
                    .append(empGenderTd)
                    .append(empEmailTd)
                    .append(empDeptTd)
                    .append(btnTd)
                    .appendTo("#emp_tbl tbody");
            });
        }

        //显示所有表单的信息
        function build_page_info(result) {
            $("#page_info").empty();
            var pageNum = result.extend.pageInfo.pageNum;
            var pages = result.extend.pageInfo.pages;
            var total = result.extend.pageInfo.total;
            $("#page_info").append("当前第"+pageNum+"页，共"+pages+"页，共"+total+"条记录");
        }

        //导航栏
        function build_page_nav(result) {
            $("#page_nav").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            /*
            *  <li><a href = "#">首页</a></li>
            * */
            var firstPage = $("<li></li>")
                .append($("<a></a>").append("首页"));
            var prePage =  $("<li></li>")
                .append($("<a></a>").append("&laquo;"));
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPage.addClass("disabled");
                prePage.addClass("disabled");
            }else {
                firstPage.click(function () {
                    to_page(1);
                });
                prePage.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                })
            }

            var lastPage = $("<li></li>")
                .append($("<a></a>").append("末页"));
            var nextPage =  $("<li></li>")
                .append($("<a></a>").append("&raquo;"));

            /*
            *
            *  按钮的响应事件
            * */
            if(result.extend.pageInfo.hasNextPage == false){
                lastPage.addClass("disabled");
                nextPage.addClass("disabled");
            }else {
                lastPage.click(function () {
                    to_page(result.extend.pageInfo.pages);
                })
                nextPage.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                })
            }

            ul.append(firstPage).append(prePage);

            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                //若页码与当页码相同 处于激活状态
                if (result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active")
                }

                numLi.click(function () {
                    to_page(item);
                })

                ul.append(numLi);
            });

            ul.append(nextPage).append(lastPage);

            var  nav = $("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
        }

        //移除表单样式
        function reset_form(ele){
            $(ele)[0].reset();

            //清空表单
            $(ele).find("*").removeClass("has-success has-error");
            $(ele).find(".help-block").text("");
        }

        /*
        * 添加按钮的点击事件
        * */
        $("#emp_add_btn").click(function () {

            reset_form("#emp_add_modal form");

            getDept("#emp_add_modal select");
            //点击的同时  发送ajax得到部门详细情况
            $("#emp_add_modal").modal({
                backdrop:"static"
            });
        });

       //数据校验
        function validate_add_form(){

            //1、拿到要校验的数据，使用正则表达式
            var empName = $("#emp_add_name").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                show_validate_msg("#emp_add_name", "error", "用户名可以是2-4位中文或者6-16位英文和数字的组合");
                return false;
            }else{
                show_validate_msg("#emp_add_name", "success", "");
            }
            //2、校验邮箱信息
            var email = $("#emp_add_email").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                //应该清空这个元素之前的样式
                show_validate_msg("#emp_add_email", "error", "请输入邮箱");
                return false;
            }else{
                show_validate_msg("#emp_add_email", "success", "");
            }
            return true;
        }

        //将显示表单样式的方法抽象出来
        function show_validate_msg(ele,status,msg){
            //清空表单内容
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //校验用户名是否可用
        $("#emp_add_name").change(function(){
            //发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"POST",
                success:function(result){
                    if(result.code==100){
                        show_validate_msg("#emp_add_name","success","用户名可用");
                        $("#emp_add_save").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#emp_add_name","error",result.extend.msg);
                        $("#emp_add_save").attr("ajax-va","error");
                    }
                }
            });
        });

        $("#emp_add_email").change(function(){
            var email = $("#emp_add_email").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                //应该清空这个元素之前的样式
                show_validate_msg("#emp_add_email", "error", "邮箱格式不正确");
                $("#emp_add_save").attr("validate","error");
            }else{
                show_validate_msg("#emp_add_email", "success", "");
                $("#emp_add_save").attr("validate","success");
            }
        });

        //保存按钮
        $("#emp_add_save").click(function () {

            if($(this).attr("ajax-va") === "error"
                || $(this).attr("validate") === "error"){
                return false;
            }
            if(!validate_add_form()){
                return false;
            }

            $.ajax({
                url:"${APP_PATH}/save",
                type:"POST",
                /*将form表单中的数据序列化  返回给POJO 再存入数据库*/
                data:$("#emp_add_modal form").serialize(),
                success:function (result) {
                    if(result.code == 100){
                        $("#emp_add_modal").modal('hide');
                        to_page(totalPages);
                    }else {
                        //如果
                        if(undefined != result.extend.errorField.empEmail){
                            show_validate_msg("#emp_add_emial","error",result.extend.errorField.empEmail);
                        }else if(undefined != result.extend.errorField.empName){
                            show_validate_msg("#emp_add_name","error",result.extend.errorField.empName);
                        }
                    }
                }
            })
        });

        //查询部门信息
        function getDept(ele) {
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/dept",
                type:"GET",
                success:function (result) {
                    /* 返回的json 数据
                    *extend:{dept: [{deptId: 1, deptName: "研发部"},
                        {deptId: 2, deptName: "销售部"}, {deptId: 3, deptName: "后勤部"}]}
                    * */
                    $.each(result.extend.dept,function () {
                        var dept = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        dept.appendTo(ele);
                    });
                }
            });
        }

        //编辑按钮
        $(document).on("click",".edit_btn",function () {

            //清空email样式
            $("#emp_update_email").parent().removeClass("has-success has-error");
            $("#emp_update_email").next("span").text("");

            //获取部门信息
            getDept("#emp_update_modal select");

            //查出当前需要修改员工信息  并放入模态框中
            getEmp($(this).attr("edit_id"));
            //需要更新员工的id
            $("#emp_update_save").attr("empId",$(this).attr("edit_id"));

            $("#emp_update_modal").modal({
                backdrop:'static'
            })
        });

        //查询单个员工信息
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/getEmp/"+id,
                type:"GET",
                success:function (result) {

                    //console.log(result);
                    //取出查询对象
                    var updateEmp = result.extend.employee;

                    //将数据填充在表单中
                    $("#emp_update_name").text(updateEmp.empName);
                    $("#emp_update_email").val(updateEmp.empEmail);
                    $("#emp_update_modal input[name=gender]").val([updateEmp.empGender]);
                    $("#emp_update_modal select").val([updateEmp.empDid]);
                }
            });
        }

        //校验更新邮箱
        $("#emp_update_email").change(function () {
            var email = $("#emp_update_email").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确");
                //应该清空这个元素之前的样式
                show_validate_msg("#emp_update_email", "error", "邮箱格式不正确");
                $("#emp_update_save").attr("validate","error");
            }else{
                show_validate_msg("#emp_update_email", "success", "");
                $("#emp_update_save").attr("validate","success");
            }
        });

        //提交更新数据
        $("#emp_update_save").click(function () {
            //邮箱格式不正确
            if($(this).attr("validate")==="error"){
                return false;
            }

            $.ajax({
                url:"${APP_PATH}/update/"+$(this).attr("empId"),
                type:"PUT",
                data:$("#emp_form_id").serialize(),
                success:function (result) {
                    $("#emp_update_modal").modal('hide');

                    to_page(currentPages);
                }
            });
        });

        //单个删除按钮
        $(document).on("click",".del_btn",function () {

        })

    </script>

</body>
</html>

