<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 08/10/2017
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:v-bind="http://www.w3.org/1999/xhtml">
<head>
    <title>智慧图书馆</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../lib/css/reset.css" type="text/css">
    <link rel="stylesheet" href="../lib/css/bootstrap.css">
    <link rel="stylesheet" href="../css/lb_banner.css">
    <link rel="stylesheet" href="../css/lb_navigator.css">
    <link rel="stylesheet" href="../css/lb_mainContainer.css">
    <style type="text/css">
        html,body{
            position: relative;
            width: 100%;
            height: 100%;
            font-family: 'Hiragino Sans GB','Microsoft YaHei', serif;
            overflow-x: hidden;
        }
        #lb_bannerContainer{
            position: relative;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        #lb_loading{
            position: fixed;
            width: 100%;
            height: 100%;
            background: #f7f7f7;
            z-index: 9999999;
            transition: all .5s;
        }
    </style>

</head>
<body>
<div id="lb_loading">
    <div style="width: 100%; height: 100%; background: url('../images/loading.gif') center no-repeat"></div>
</div>
<!--导航栏-->
<nav id="lb_navigator">
    <div class="blur-pic"></div>
    <div class="container">
        <div class="row">
            <!--上海大学图标-->
            <div id="lb_badge" class="col-md-2 col-lg-2">
                <img src="../images/shuBadge.png">
            </div>
            <!--导航目录-->
            <div class="col-md-10 col-lg-7 col-lg-offset-3">
                <ul class="nav nav-pills nav-justified">
                    <li><a href="index.jsp">主页</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            图书类别
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li v-for="type in types"><a v-bind:href="type.href" @click="type.handler">{{type.message}}</a></li>
                        </ul>
                    </li>
                    <li><a :href="href">个人中心</a></li>
                    <li v-if="isAdmin"><a href="./adminConsole.jsp">管理控制台</a></li>
                    <li v-if="!isLanded" ><a class="login" href="login.html" style="color: #5598b4;">登录</a></li>
                    <li v-if="isLanded"><a href="javascript:void(0);">欢迎您：{{user}}</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!--banner-->
<div id="lb_bannerContainer" >
    <div id="lb_banner">
        <div class="container">
            <div class="welcome row">
                <div class="mainTitle col-md-12 col-lg-12">
                    <h1>Welcome To The Intellectual Digital Library</h1>
                </div>
            </div>
            <!--时间-->
            <div class="date row">
                <div class="col-md-6 col-md-offset-3 col-lg-6 col-lg-offset-3">
                    <div class="row">
                        <div class="day col-lg-12">{{day}}&nbsp;{{date}}&nbsp;{{month}}&nbsp;{{year}}</div>
                    </div>
                    <div class="row">
                        <div id="lb_hours" class="time col-md-2 col-lg-2 col-lg-offset-1">{{hour}}</div>
                        <transition name="dots-fade">
                            <div v-if="show" class="time col-md-2 col-lg-2">:</div>
                        </transition>
                        <div id="lb_min" class="time col-md-2 col-lg-2">{{min}}</div>
                        <transition name="dots-fade">
                            <div v-if="show" class="time col-md-2 col-lg-2">:</div>
                        </transition>
                        <div id="lb_sec" class="time col-md-2 col-lg-2">{{sec}}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--主页面-->
<div id="lb_mainContainer">
    <%--书籍展示界面侧边导航栏--%>
    <div id="lb_bookNav" class="row" style="width: 25%" >
        <div class="col-lg-6 col-md-6 col-lg-offset-3 col-md-offset-3 book-nav">
            <ul class="nav nav-pills nav-stacked">
                <li><a href="#" style="font-size: 1.5em" @click="searchToggleTurn">🔍</a></li>
                <li v-show="!searchToggle">
                    <a style="padding: 0;">
                        <div class="input-group">
                            <input v-model="searchText" @keyup.enter="search" class="form-control" type="text" style="font-size: 12px; padding-left: 2px" placeholder="请输入书名/作者">
                            <span class="input-group-btn">
                                <button class="btn btn-default" @click="search">Go!</button>
                            </span>
                        </div>
                    </a>
                </li>
                <li v-for="type in types"><a :href="type.href" @click="type.handler">{{type.message}}</a></li>
            </ul>
        </div>
    </div>

    <div v-if="isSearch" id="lb_searchOpt">
        <div class="row">
            <div class="col-lg-10 col-md-10 col-lg-offset-2 col-md-offset-2 ">
                <div class="row">
                    <div class="col-lg-6 col-lg-offset-1 col-md-6 col-md-offset-1">
                        <ul class="nav nav-tabs nav-justified">
                            <li class="disabled"><a class="disabled">{{searchText}}</a></li>
                            <li><a href="javascript:void(0);" @click="sort('', 'id', 'sortID')" id="lb_sortID">ID&nbsp;<span class="caret"></span></a></li>
                            <li><a href="javascript:void(0);" @click="sort('', 'amount', 'sortAmount')" id="lb_sortAmount">剩余数量&nbsp;<span class="caret"></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%--***************************************我是分割线***********************************************************--%>
    <div class="bookshelf" v-for="(type,typeIndex) in types"  :id="typeIndex">
        <div class="container">
            <div class="row" style="margin-bottom: 20px">
                <div class="col-lg-10 col-lg-offset-2 col-md-offset-2 col-md-10">
                    <h2 style="color: #000000; font-weight: 600">{{type.message}}</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 col-md-10 col-lg-offset-2 col-md-offset-2">
                    <%--从这里开始是书本展示--%>
                    <%--***************************************************--%>
                    <div class="row">
                        <transition-group name="showBooks" tag="div">
                            <div class="col-lg-3 book" v-for="(book,index) in bookTypes[typeIndex]" :key="book.id">
                                <a class="thumbnail">
                                    <img src="../images/shuBadge.png">
                                    <div class="caption">
                                        <h5>《{{book.name}}》</h5>
                                    </div>
                                    <div class="book-cover">
                                        <ul class="intro">
                                            <li data-name="book_id" class="row">
                                                <div class="col-lg-5">ID:</div>
                                                <div class="col-lg-7">{{book.id}}</div>
                                            </li>
                                            <li data-name="author" class="row">
                                                <div class="col-lg-5">作者:</div>
                                                <div class="col-lg-7">{{book.author}}</div>
                                            </li>
                                            <li data-name="edition" class="row">
                                                <div class="col-lg-5">版本:</div>
                                                <div class="col-lg-7">{{book.version}}</div>
                                            </li>

                                            <li data-name="total" class="row">
                                                <div class="col-lg-5">总馆藏数:</div>
                                                <div class="col-lg-7">{{book.total}}</div>
                                            </li>
                                            <li data-name="amounts" class="row">
                                                <div class="col-lg-5">剩余数量:</div>
                                                <div class="col-lg-7">{{book.amount}}</div>
                                            </li>
                                        </ul>
                                        <div class="row" v-if="isLanded">
                                            <div class="col-md-6 col-lg-6 col-lg-offset-3 col-md-offset-3" style="text-align: center">
                                                <button class="btn btn-sm btn-danger" @click="borrow('', index, book.type, book.id, book.amount, book.name)">借书</button>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </transition-group>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-2 col-md-2"></div>
                <div class="col-lg-10 col-md-10" style="border: 1px solid grey"></div>
            </div>
        </div>
    </div>
</div>

<!--页脚-->
<div id="lb_footer"></div>

<script src="../lib/js/jquery-3.2.1.js"></script>
<script src="../lib/js/bootstrap.js"></script>
<script src="../lib/js/vue.js"></script>
<script src="../js/lb_banner.js"></script>
<script src="../js/lb_navigator.js"></script>
<script src="../js/util.js"></script>
<script src="../js/lb_mainContainer.js"></script>
<script>
//    检测是否已经登录
    function isLanded() {
        var user = getCookie("user");
        if(user){
            vNav.isLanded = true;
            vNav.user = user;
        }
    }
//    检测是否是管理员
    function isAdmin() {
        var admin = getCookie("admin");
//        console.log(Boolean(admin) + admin);
        vNav.isAdmin = admin === 'true';
    }

    isLanded();
    isAdmin();

//    监听body scroll事件，当banner完全卷去是固定 #lb_bookNav 的位置
   $('body').scroll(function () {
//        console.log(document.body.scrollTop);
        if(document.body.scrollTop > $(" #lb_banner ").height()){
            $(" #lb_bookNav ").css({position: "fixed"});
        }else{
            $(" #lb_bookNav ").css({position: "absolute"});
        }
    });
//    统一设置书本缩略图的高度
    var bookImg = $(" #lb_mainContainer .bookshelf .book .thumbnail img "),
        bookImgWidth = bookImg.width();
    bookImg.height(bookImgWidth * 4/3);
//    加载动画
    window.onload = function () {
        setTimeout(function () {
            $(" #lb_loading ").animate({opacity: 0},500, function () {
                $(" #lb_loading ").css({visibility: "hidden"});
            });
        }, 1000);

//        导航栏按钮添加事件处理函数
        function getOffsetTop(el) {
            return el.getBoundingClientRect().top+(window.pageYOffset||document.documentElement.scrollTop)-(document.documentElement.clientTop||0);
        }
        for(var i = 0; i < vNav.types.length; i++){
            eval("var func = function (){$(document.body).animate({scrollTop: " + (getOffsetTop($('#' + i)[0]) - $(" #lb_navigator ").height()) + "});}");
            Vue.set(vNav.types[i], 'handler', func);
        }
    };


</script>
</body>
</html>
