<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 11/10/2017
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <title>个人中心</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../lib/css/reset.css" type="text/css">
    <link rel="stylesheet" href="../lib/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="../css/personalCenter.css" type="text/css">
</head>
<body>

    <div id="lb_bg"></div>
    <div id="lb_banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-1 col-md-1" id="lb_logo">
                    <img src="../images/shuBadge.png">
                </div>
                <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1">
                    <h2><small style="color: #ffffff; font-weight: 600; text-align: center">{{userName}}，欢迎来到个人中心，在这里您可以进行续借、还书等操作！</small></h2>
                </div>
            </div>
        </div>
    </div>

    <div id="lb_CustomerMainContainer">
        <div class="container">
            <div class="row">
                <%--导航栏--%>
                <div class="col-lg-2 col-md-2" id="lb_nav">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="index.jsp">主页</a></li>
                        <li class="active"><a href="#lb_manage" data-toggle="tab">图书管理</a></li>
                        <li><a href="#lb_charts" data-toggle="tab">报表统计</a></li>
                        <li><a href="javascript:void(0);" style="font-size: 1.1em" @click="turnSearchToggle">🔍</a></li>
                        <li style="overflow-y: hidden">
                            <transition name="slide">
                                <a v-if="!searchToggle" style="padding: 0">
                                    <div class="input-group">
                                        <input v-model="searchText" @keyup.enter="search" class="form-control" type="text" style="font-size: 12px; padding-left: 2px" placeholder="请输入书名/作者">
                                        <span class="input-group-btn">
                                        <button class="btn btn-default" @click="search">Go!</button>
                                    </span>
                                    </div>
                                </a>
                            </transition>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-10 col-md-10 tab-content" id="lb_display">
                    <%--图书管理--%>
                    <div class="tab-pane fade in active" id="lb_manage">
                        <%--<div class="row">--%>
                            <%--<div class="col-lg-12 col-md-12">--%>
                                <%--<ul class="nav nav-tabs">--%>
                                    <%--<li class="active"><a data-toggle="tab" href="#allBooks">全部书籍</a></li>--%>
                                    <%--<li class="dropdown">--%>
                                        <%--<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">图书类别<span class="caret"></span></a>--%>
                                        <%--<ul class="dropdown-menu">--%>
                                            <%--<li v-for="(type, index) in types"><a data-toggle="tab" :href="targets[index]">{{type.message}}</a></li>--%>
                                        <%--</ul>--%>
                                    <%--</li>--%>
                                <%--</ul>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 tab-content">
                                <div id="allBooks" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-10 col-md-10">
                                            <ul class="nav nav-tabs nav-justified uHead">
                                                <li><a>ID</a></li>
                                                <li><a>书名</a></li>
                                                <li><a>作者/出版社</a></li>
                                                <li><a>类型</a></li>
                                                <li><a>借阅时间</a></li>
                                                <li><a>最晚归还时间</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <transition-group name="sort" tag="div">
                                        <ul class="nav nav-tabs nav-justified" v-for="(book,index) in books" :key="book.id">
                                            <li><a>{{book.id}}</a></li>
                                            <li><a>{{book.name}}</a></li>
                                            <li><a>{{book.version}}</a></li>
                                            <li><a>{{typeArr[index]}}</a></li>
                                            <li><a>{{book.initTime}}</a></li>
                                            <li><a>{{book.deadline}}</a></li>
                                            <li><a><button class="btn btn-default btn-sm">续借</button></a></li>
                                            <li><a><button class="btn btn-success btn-sm">还书</button></a></li>
                                        </ul>
                                    </transition-group>
                                    <%--<table class="table table-hover">--%>
                                        <%--<thead>--%>
                                        <%--<tr>--%>
                                            <%--<td><a href="#" @click="sort('', 'id', 'sortID', 'books')">ID<span class="caret"></span></a></td>--%>
                                            <%--<td>书名</td>--%>
                                            <%--<td>作者</td>--%>
                                            <%--<td>版本/出版社</td>--%>
                                            <%--<td>类型</td>--%>
                                            <%--<td><a href="#" @click="sort('', 'total', 'sortTotal', 'books')">借阅时间<span class="caret"></span></a></td>--%>
                                            <%--<td><a href="#" @click="sort('', 'amount', 'sortAmount', 'books')">最晚归还日期<span class="caret"></span></a></td>--%>
                                        <%--</tr>--%>
                                        <%--</thead>--%>
                                        <%--<tbody>--%>
                                        <%--<transition-group name="sort" tag="tbody">--%>
                                            <%--<tr v-for="book in books[0]" :key="book.id">--%>
                                                <%--<td>{{book.id}}</td>--%>
                                                <%--<td>《{{book.name}}》</td>--%>
                                                <%--<td>{{book.author}}</td>--%>
                                                <%--<td>{{book.version}}</td>--%>
                                                <%--<td>{{typeArr[book.type]}}</td>--%>
                                                <%--<td>{{book.initTime}}</td>--%>
                                                <%--<td>{{book.deadline}}</td>--%>
                                                <%--<td><button class="btn btn-default">续借</button></td>--%>
                                                <%--<td><button class="btn btn-danger" @click="exStore('', book.id, book.name, book.amount, book.total)">还书</button></td>--%>
                                            <%--</tr>--%>
                                        <%--</transition-group>--%>
                                        <%--</tbody>--%>
                                    <%--</table>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--报表统计--%>
                    <div class="tab-pane fade" id="lb_charts">报表统计</div>
                </div>
            </div>
        </div>
    </div>
    <script src="../lib/js/jquery-3.2.1.js"></script>
    <script src="../lib/js/bootstrap.js"></script>
    <script src="../lib/js/vue.js"></script>
    <script src="../js/util.js"></script>
    <script src="../js/lb_navigator.js"></script>
    <%--<script src="../js/lb_mainContainer.js"></script>--%>
    <%--<script src="../js/adminConsole.js"></script>--%>
    <script src="../js/personalCenter.js"></script>

</body>
</html>
