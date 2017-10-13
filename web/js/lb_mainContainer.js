/**
 * Created by HuShengxiang on 11/10/2017.
 */
// 拿到数据库中已有的书本生成bookshelf
var currentType = 0;
var books = [],
    searchResult = [];
function getBooks(async, method, searchText) {
    $.ajax({
        type: "GET",
        data: {text: encodeURI(encodeURI(searchText)), type: currentType, bookTable: 'books', method: method},
        url: "../jsp/getBooks.jsp",
        async: async,
        success: function (data) {
            console.log("正在查询的图书类别：" + currentType);
            // console.log(typeof data);
            console.log("data: " + data.substring(0, 5) + " " + data.length + "  data !== 'false':" + (data.substring(0, 5) !== 'false') + "data !== false:" + (data  !== false) );
            if(data.substring(0, 5) !== 'false'){
                var bookJson = JSON.parse(data);
                //若method值为getBooks，查询结果添加到books[]
                //若method值为getSearch，查询结果添加到searchResult[]
                if(method === "getBooks"){
                    books.push(bookJson);
                }else if(method === "getSearch"){
                    vMain.isSearch = true;
                    searchResult.push(bookJson);
                }
                if(currentType < vNav.types.length - 1){
                    currentType++;
                    getBooks(async, method, searchText);
                }else {
                    if(method === "getSearch"){
                        vMain.bookTypes = searchResult;
                    }
                    currentType = 0;
                }
            }else {
                //i<书的总类型数
                if(currentType < vNav.types.length - 1){
                    if(method ==="getBooks"){
                        books.push(false);
                    }else if(method === "getSearch"){
                        searchResult.push(false);
                    }
                    currentType++;
                    getBooks(async, method, searchText);
                }else {
                    if(method === "getSearch"){
                        if(!checkSearchRes()){
                            alert("Oops！没有查找到相应的结果！");
                        }else {
                            vMain.bookTypes = searchResult;
                        }
                    }
                    currentType = 0;
                }
            }
        }
    });
}
getBooks(false, "getBooks", "");

function checkSearchRes() {
    var empty = 0;
    for(var i = 0; i < searchResult.length; i++){
        if(searchResult[i] === false){
            empty++;
        }
    }
    // console.log(empty);
    if(empty === searchResult.length) return false;
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
                getBooks(true, "getSearch", this.searchText);
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
            // console.log(item);
            var temp;
            for(var i = 0; i < this.bookTypes.length - 1; i++){
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
                $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(180deg)"});
                this[toggle] = 0;
            }else {
                console.log("现在是逆序排列");
                $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(0deg)"});
                this[toggle] = 1;
            }
        },
        borrow: function (e, index, type, id, amount, name) {
            var userId = getCookie("userId");
            if(amount > 0){
                var date = new Date(),
                    initDate = date.getTime(),
                    deadline = new Date(initDate + 30 * 24 * 60 * 60 * 1000);
                if(confirm("确认借阅《" + name + "》？请在" + deadline.getFullYear() + "年" + (deadline.getMonth() + 1) + "月" + deadline.getDate() + "日之前归还！")){
                    Vue.set(this.bookTypes[type][index], 'amount', amount - 1);
                    $.ajax({
                        type: "POST",
                        url: "../jsp/borrow.jsp",
                        data: {bookId: id, amount: amount - 1, userId: userId, initDate: initDate, deadline: (initDate + 30 * 24 * 60 * 60 * 1000)},
                        success: function (data) {
                            alert(data);
                        }
                    });
                }
            }else{
                alert("Oops!无书可借啦，等别的小伙伴归还吧！");
            }
        }
    }
});
