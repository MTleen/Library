/**
 * Created by HuShengxiang on 11/10/2017.
 */
// 拿到数据库中已有的书本生成bookshelf
var currentType = 0;
var books = [],
    searchResult = [];

/**
 *@param async ajax是否阻塞
 * @param currentType 当前查询的书籍类型值
 * @param method 取值为"getSearch"或"getBooks"
 * @param searchText 当用户搜索时的搜索值
 * @param targetObj 数据库查询结构目标输出对象
 * @param bookTable 数据库查询的表
 * */
function getBooks(async, currentType, method, searchText, targetObj, bookTable) {
    $.ajax({
        type: "GET",
        data: {text: encodeURI(encodeURI(searchText)), type: currentType, bookTable: bookTable, method: method},
        url: "../jsp/getBooks.jsp",
        async: async,
        success: function (data) {
            console.log("正在查询的图书类别：" + currentType);
            // console.log(typeof data);
            console.log("data: " + data.trim() + " " + data.length + "  data !== 'false':" + (data.substring(0, 5) !== 'false') + "data !== false:" + (data  !== false) );
            if(data.substring(0, 5) !== 'false'){
                var bookJson = JSON.parse(data);
                //若method值为getBooks，查询结果添加到books[]
                //若method值为getSearch，查询结果添加到searchResult[]
                if(method === "getSearch"){
                    vMain.isSearch = true;
                }
                targetObj.push(bookJson);
                if(currentType < vNav.types.length - 1){
                    currentType++;
                    getBooks(async, currentType, method, searchText, targetObj, bookTable);
                }else {
                    // if(method === "getSearch"){
                        vMain.bookTypes = targetObj;
                    // }
                }
            }else {
                //i<书的总类型数
                if(currentType < vNav.types.length){
                    targetObj.push(false);
                    currentType++;
                    getBooks(async, currentType, method, searchText, targetObj, bookTable);
                }else {
                    if(method === "getSearch"){
                        if(!checkSearchRes(targetObj)){
                            alert("Oops！没有查找到相应的结果！");
                            return;
                        }
                    }
                    vMain.bookTypes = targetObj;
                }
            }
        }
    });
}
//主页加载时获取数据库中所有的
getBooks(false, 0, "getBooks", "", books, 'books');

function checkSearchRes(obj) {
    var empty = 0;
    for(var i = 0; i < obj.length; i++){
        if(obj[i] === false){
            empty++;
        }
    }
    // console.log(empty);
    if(empty === obj.length) return false;
    return true;
}

var vMain = new Vue({
    el: "#lb_mainContainer",
    data:{
        types: vNav.types,
        bookTypes: books,
        isSearch: false,
        searchToggle: true,
        searchText: "",
        sortID: 1,
        sortAmount: 1
    },
    computed: {
        isLanded: function () {
            return vNav.isLanded;
        },
        isAdmin: function () {
            return vNav.isAdmin;
        }
    },
    methods: {
        search: function (e) {
            if(this.searchText){
                searchResult = [];
                this.sortID = 1;
                this.sortAmount = 1;
                $(" #lb_mainContainer #lb_searchOpt .caret ").css({transform: "rotate(0deg)"});
                getBooks(true, 0, "getSearch", this.searchText, searchResult, 'books');
            }else{
                this.searchToggleTurn();
                this.isSearch = false;
                this.bookTypes = books;
                setTimeout(function () {
                    var bookImg = $(" #lb_mainContainer .bookshelf .book .thumbnail img "),
                        bookImgWidth = bookImg.width();
                    bookImg.height(bookImgWidth * 4/3);
                },200);
            }
        },
        searchToggleTurn: function () {
            this.searchToggle = !this.searchToggle;
        },






        //对searchResult以id为关键字进行冒泡排序
        /**
         * @param e window.event 对象
         * @param item 排序的关键字
         * @param toggle 排序标识位
         * */
        sort: function (e, item, toggle) {
            e = window.event;
            // console.log(item);
            var temp;
            for(var i = 0; i < this.bookTypes.length; i++){
                // 对象长度
                var length = this.bookTypes[i].length;

                for(var j = 0; j < length - 1; j++){
                    for(var k = j + 1; k < length; k++){
                        // console.log(this.bookTypes[i][j][item]);
                        if(this.bookTypes[i][j][item] > searchResult[i][k][item]){
                            //改变vue实例数据模型时一定要通过Vue.set()；否则无法触发视图的更新！！！！！！！
                            temp = this.bookTypes[i][k];
                            Vue.set(this.bookTypes[i], k, this.bookTypes[i][j]);
                            Vue.set(this.bookTypes[i], j, temp);
                        }
                    }
                }
                if(this[toggle] === 0 && length !== undefined){
                    this.bookTypes[i].reverse();
                }
            }
            if(this[toggle] === 1){
                // console.log(e);
                $(e.target).find(" .caret ").css({transform: "rotate(180deg)"});
                // $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(180deg)"});
                this[toggle] = 0;
            }else {
                $(e.target).find(" .caret ").css({transform: "rotate(360deg)"});
                // console.log("现在是逆序排列");
                // $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(0deg)"});
                this[toggle] = 1;
            }
        },
        borrow: function (e, index, type, id, amount, name) {
            var userId = getCookie("userId");
            if(amount > 0){
                var date = new Date(),
                    initDate = date.getTime(),
                    deadline = new Date(initDate + 30 * 24 * 60 * 60 * 1000);
                if(confirm("确认借阅《" + name + "》？请在" + deadline.getFullYear() + "年" + (deadline.getMonth() + 1) + "月" + (deadline.getDate() + 1) + "日之前归还！")){
                    $.ajax({
                        type: "POST",
                        url: "../jsp/borrow.jsp",
                        // dataType: 'json',
                        data: {bookId: id, amount: amount - 1, userId: userId, initDate: initDate, deadline: (initDate + 30 * 24 * 60 * 60 * 1000), name: encodeURI(encodeURI(name))},
                        success: function (data) {
                            console.log("data: " + data + "   " + typeof data + data.trim());
                            var json = JSON.parse(data.trim());
                            console.log( "   " + typeof data.status);
                            if(json.status){
                                Vue.set(vMain.bookTypes[type][index], 'amount', amount - 1);
                            }
                            alert(json.message);
                        }
                    });
                }
            }else{
                alert("Oops!无书可借啦，等别的小伙伴归还吧！");
            }
        }
    }
});
