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
                    <h2><small style="color: #e7e7e7; font-weight: 600; text-align: center">{{userName}}，欢迎来到个人中心，在这里您可以进行续借、还书等操作！</small></h2>
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
                        <li v-if="isAdmin"><a href="adminConsole.jsp">管理控制台</a></li>
                        <li class="active"><a href="#lb_manage" data-toggle="tab">图书管理</a></li>
                        <li><a href="#lb_charts" data-toggle="tab">报表统计</a></li>
                        <li><a @click="delCookie" href="#">注销</a></li>
                    </ul>
                </div>
                <div class="col-lg-10 col-md-10 tab-content" id="lb_display">
                    <%--图书管理--%>
                    <div class="tab-pane fade in active" id="lb_manage">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 tab-content">
                                <div id="allBooks" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'id', 'sortId')" style="color: #488ac6;">ID<span class="caret"></span></a></div>
                                        <div class="col-lg-2 col-md-2 uHead">书名</div>
                                        <div class="col-lg-2 col-md-1 uHead">作者</div>
                                        <div class="col-lg-2 col-md-2 uHead">版本/出版社</div>
                                        <div class="col-lg-1 col-md-2 uHead"><a href="#" @click="sort('', 'type', 'sortType')" style="color: #488ac6;">类型<span class="caret"></span></a></div>
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'initTime', 'sortInit')" style="color: #488ac6;">借阅时间<span class="caret"></span></a></div>
                                        <div class="col-lg-2 col-md-2 uHead"><a href="#" @click="sort('', 'deadline', 'sortDeadline')" style="color: #488ac6;">最晚归还时间<span class="caret"></span></a></div>
                                    </div>
                                    <transition-group name="sort" tag="div">
                                        <div class="row uBody-row" v-for="(book, index) in books" :key="book.id" style="border-bottom: 1px solid #757575">
                                            <div class="col-lg-1 col-md-1 uBody">{{book.id}}</div>
                                            <div class="col-lg-2 col-md-2 uBody">《{{book.name}}》</div>
                                            <div class="col-lg-2 col-md-1 uBody">{{book.author}}</div>
                                            <div class="col-lg-2 col-md-2 uBody">{{book.version}}</div>
                                            <div class="col-lg-1 col-md-2 uBody" style="padding-right: 0">{{typeArr[book.type]}}</div>
                                            <div class="col-lg-1 col-md-1 uBody">{{book.initTime.getFullYear() + "." + (book.initTime.getMonth() + 1) + "." + (book.initTime.getDate())}}</div>
                                            <div class="col-lg-1 col-md-1 uBody">{{book.deadline.getFullYear() + "." + (book.deadline.getMonth() + 1) + "." + (book.deadline.getDate())}}</div>
                                            <div class="col-lg-1 col-md-1 uBody" style="padding-right: 0; text-align: right"><button class="btn btn-default btn-sm" @click="extend('' ,book.id, book.name, book.deadline, book.isExtended)">续借</button></div>
                                            <div class="col-lg-1 col-md-1 uBody"><button class="btn btn-info btn-sm" @click="returnBook('', book.id, book.name)">还书</button></div>
                                        </div>
                                    </transition-group>
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
    <script src="../js/personalCenter.js"></script>

</body>
</html>
