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
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<%--引入jquery框架--%>
<script type="text/javascript"
        src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>

<%--引入bootstrap--%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
      rel="stylesheet"/>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<body>
<div class="row">
    <div class="col-md-4 col-md-offset-1">
        <h1>SSM-CRUD</h1>
    </div>
</div>
<%--按钮--%>
<div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-info">添加</button>
        <button class="btn btn-danger">删除</button>
    </div>
</div>

<%--表格--%>
<div class="row">
    <div class="col-md-10 col-md-offset-1">
        <table class="table table-hover">
            <tr>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <th>${emp.empId}</th>
                    <th>${emp.empName}</th>
                    <th>${emp.empGender == "M"?"男":"女"}</th>
                    <th>${emp.empEmail}</th>
                    <th>${emp.department.deptName}</th>
                    <th>
                        <button class="btn btn-primary">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"/>
                            编辑
                        </button>
                        <button class="btn btn-danger">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"/>
                            删除
                        </button>
                    </th>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<%--底部页栏--%>
<div class="row">
    <%--底部提示页码栏--%>
    <div class="col-md-offset-2">
        当前第${pageInfo.pageNum}页，共${pageInfo.pages}页,共${pageInfo.total}条记录
    </div>
    <div class="col-md-offset-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li class="disabled">
                    <a href="${APP_PATH}/emp?pn=1">首页</a>
                </li>
                <%--前一页--%>
                <c:if test="${pageInfo.hasPreviousPage }">
                    <li><a href="${APP_PATH }/emp?pn=${pageInfo.pageNum-1}"
                           aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
                    </a></li>
                </c:if>

                <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                    <c:if test="${page_Num == pageInfo.pageNum }">
                        <li class="active"><a href="#">${page_Num }</a></li>
                    </c:if>
                    <c:if test="${page_Num != pageInfo.pageNum }">
                        <li><a href="${APP_PATH }/emp?pn=${page_Num }">${page_Num }</a></li>
                    </c:if>

                </c:forEach>
                <c:if test="${pageInfo.hasNextPage }">
                    <li><a href="${APP_PATH }/emp?pn=${pageInfo.pageNum+1 }"
                           aria-label="Next"> <span aria-hidden="true">&raquo;</span>
                    </a></li>
                </c:if>
                <li><a href="${APP_PATH }/emp?pn=${pageInfo.pages}">末页</a></li>
            </ul>
        </nav>
    </div>
</div>

</body>
</html>
