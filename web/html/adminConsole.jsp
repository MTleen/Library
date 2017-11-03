<%--
  Created by IntelliJ IDEA.
  User: HuShengxiang
  Date: 11/10/2017
  Time: 19:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <title>管理员控制台</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../lib/css/reset.css" type="text/css">
    <link rel="stylesheet" href="../lib/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="../css/adminConsole.css" type="text/css">
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
                    <h2><small>{{userName}}，欢迎来到<strong>图书管理控制台</strong>，在这里您可以进行管理图书管理、图书入库等工作！</small></h2>
                </div>
            </div>
        </div>
    </div>
    <div id="lb_consoleMainContainer">
        <div class="container">
            <div class="row">
                <%--控制中心导航栏--%>
                <div class="col-lg-2 col-md-2" id="lb_consoleNav">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="index.jsp">主页</a></li>
                        <li><a href="personalCenter.jsp">个人中心</a></li>
                        <li class="active"><a href="#lb_booksManage" data-toggle="tab">图书管理</a></li>
                        <li><a href="#lb_input" data-toggle="tab">图书入库</a></li>
                        <%--<li><a href="#lb_charts" data-toggle="tab">报表统计</a></li>--%>
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
                    <%--<li><a href="javascript:void(0);">图书类别管理</a></li>--%>
                    </ul>
                </div>
                <%--控制中心主展示区--%>
                <div class="col-lg-10 col-md-10 tab-content" id="lb_consoleDisplay">
                    <%--图书管理--%>
                    <div class="tab-pane fade in active" id="lb_booksManage">
                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#allBooks">全部书籍</a></li>
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">图书类别<span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li v-for="(type, index) in types"><a data-toggle="tab" :href="targets[index]">{{type.message}}</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <%--*********展示表*******--%>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 tab-content">
                                <div id="allBooks" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'id', 'sortID', 'books')" style="color: #488ac6;">ID<span class="caret"></span></a></div>
                                        <div class="col-lg-2 col-md-2 uHead">书名</div>
                                        <div class="col-lg-2 col-md-1 uHead">作者</div>
                                        <div class="col-lg-2 col-md-2 uHead">版本/出版社</div>
                                        <div class="col-lg-2 col-md-2 uHead">类型</div>
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'amount', 'sortAmount', 'books')" style="color: #488ac6;">剩余<span class="caret"></span></a></div>
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'total', 'sortTotal', 'books')" style="color: #488ac6;">总数<span class="caret"></span></a></div>
                                    </div>
                                    <transition-group name="sort" tag="div">
                                        <div class="row uBody-row" v-for="book in books[0]" :key="book.id" style="border-bottom: 1px solid #757575">
                                            <div class="col-lg-1 col-md-1 uBody">{{book.id}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" contenteditable="true">《{{book.name}}》</div>
                                            <div class="col-lg-2 col-md-1 uBody" contenteditable="true">{{book.author}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" contenteditable="true">{{book.version}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" style="padding-right: 0">{{typeArr[book.type]}}</div>
                                            <div class="col-lg-1 col-md-1 uBody" contenteditable="true">{{book.amount}}</div>
                                            <div class="col-lg-1 col-md-1 uBody" contenteditable="true">{{book.total}}</div>
                                            <%--<div class="col-lg-1 col-md-1 uBody"><button class="btn btn-default btn-sm">修改</button></div>--%>
                                            <div class="col-lg-1 col-md-1 uBody"><button class="btn btn-danger btn-sm" @click="exStore('', book.id, book.name, book.amount, book.total)">出库</button></div>
                                        </div>
                                    </transition-group>
                                </div>
                                <%--**********************************分类展示分割线*************************************--%>
                                <div v-for="(type, index) in types" :id="index" class="tab-pane fade">
                                    <div class="row">
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'id', 'sortID', 'bookTypes')" style="color: #488ac6;">ID<span class="caret"></span></a></div>
                                        <div class="col-lg-2 col-md-2 uHead">书名</div>
                                        <div class="col-lg-2 col-md-1 uHead">作者</div>
                                        <div class="col-lg-2 col-md-2 uHead">版本/出版社</div>
                                        <div class="col-lg-2 col-md-2 uHead">类型</div>
                                        <div class="col-lg-2 col-md-2 uHead"><a href="#" @click="sort('', 'total', 'sortTotal', 'bookTypes')" style="color: #488ac6;">剩余<span class="caret"></span></a></div>
                                        <div class="col-lg-1 col-md-1 uHead"><a href="#" @click="sort('', 'amount', 'sortAmount', 'bookTypes')" style="color: #488ac6;">总数<span class="caret"></span></a></div>
                                    </div>
                                    <transition-group name="sort" tag="div">
                                        <div class="row uBody-row" v-for="book in bookTypes[index]" :key="book.id" style="border-bottom: 1px solid #757575">
                                            <div class="col-lg-1 col-md-1 uBody">{{book.id}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" contenteditable="true">《{{book.name}}》</div>
                                            <div class="col-lg-2 col-md-1 uBody" contenteditable="true">{{book.author}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" contenteditable="true">{{book.version}}</div>
                                            <div class="col-lg-2 col-md-2 uBody" style="padding-right: 0">{{typeArr[book.type]}}</div>
                                            <div class="col-lg-1 col-md-1 uBody" contenteditable="true">{{book.amount}}</div>
                                            <div class="col-lg-1 col-md-1 uBody" contenteditable="true">{{book.total}}</div>
                                            <%--<div class="col-lg-1 col-md-1 uBody" style="padding-right: 0; text-align: right"><button class="btn btn-default btn-sm">修改</button></div>--%>
                                            <div class="col-lg-1 col-md-1 uBody"><button class="btn btn-danger btn-sm" @click="exStore('', book.id, book.name, book.amount, book.total)">出库</button></div>
                                        </div>
                                    </transition-group>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--图书入库--%>
                    <div class="tab-pane fade" id="lb_input">
                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <h4 style="font-weight: 600">图书入库</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md=12">
                                <form class="form-horizontal" role="form" >
                                    <%--书本封面图--%>
                                    <div class="form-group row">
                                        <label class="control-label col-lg-2 col-md-2" for="bookCover">书本封面图</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <div v-if="insertBook.cover" style="width: 100px; height: 150px; border: 1px solid #cccccc; border-radius: 4px 4px;" id="cover_display">
                                                <img :src="instantCover" style="width: 100%; height: 100%; border-radius: 4px 4px">
                                            </div>
                                            <input type="file" class="form-control" id="bookCover" name="bookCover" accept="image/*" @change="getCoverName('')">
                                            <span class="help-block">请选择书本封面图片，建议使用比例 2:3 的图片</span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="control-label col-lg-2 col-md-2">请选择书本类型</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <select class="form-control" v-model="insertBook.type">
                                                <option v-for="(type, index) in types" :value="index">{{type.message}}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="control-label col-lg-2 col-md-2" for="bookName">书名</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <input v-model="insertBook.name" type="text" class="col-lg-10 col-md-10 form-control" id="bookName" name="bookName" placeholder="请输入书名">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="author" class="control-label col-lg-2 col-md-2">作者</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <input v-model="insertBook.author" type="text" class="col-md-10 col-lg-10 form-control" id="author" name="author" placeholder="请输入作者">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="edition" class="control-label col-lg-2 col-md-2">版本/出版社</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <input v-model="insertBook.edition" type="text" class="col-md-10 col-lg-10 form-control" id="edition" name="edition" placeholder="请输入书本的版本/出版社">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="amount" class="control-label col-lg-2 col-md-2">现有数量</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <input v-model="insertBook.amount" type="number" class="col-md-10 col-lg-10 form-control" id="amount" name="amount" placeholder="请输入现有的数量">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="total" class="control-label col-lg-2 col-md-2">总量</label>
                                        <div class="col-lg-6 col-md-6 ">
                                            <input v-model="insertBook.total" type="number" class="col-md-10 col-lg-10 form-control" id="total" name="total" placeholder="请输入书本的总量">
                                            <span class="help-block" style="color: red" v-if="parseInt(insertBook.total) < parseInt(insertBook.amount)">书本总量不能小于现有馆藏量，请修改！</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-10 col-md-10 col-lg-offset-2 col-md-offset-2">
                                            <button class="btn btn-success btn-sm" @click.prevent="store">入库</button>
                                            &nbsp;&nbsp;&nbsp;
                                            <input type="reset" id="reset" value="重置" class="btn btn-sm btn-danger" @click="reset">
                                        </div>
                                    </div>
                                </form>
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
    <script src="../lib/js/ajaxfileupload.js"></script>
    <script src="../lib/js/bootstrap.js"></script>
    <script src="../lib/js/vue.js"></script>
    <script src="../js/util.js"></script>
    <script src="../js/lb_navigator.js"></script>
    <script src="../js/lb_mainContainer.js"></script>
    <script src="../js/adminConsole.js"></script>

</body>
</html>
