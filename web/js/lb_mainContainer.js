/**
 * Created by HuShengxiang on 11/10/2017.
 */

// 拿到数据库中已有的书本生成bookshelf
var i = 0;
var books = [],
    searchResult = [];
function getBooks() {
    $.ajax({
        type: "GET",
        data: {type: i, bookTable: 'books'},
        url: "../jsp/getSearch.jsp",
        async: false,
        success: function (data) {
            if(data !== 'false'){
                var bookJson = JSON.parse(data);
                // console.log("data:"+data + "\n" + typeof data + "  " + typeof bookJson);
                books.push(bookJson);
                if(i < 5){
                    i++;
                    console.log("正在查询的图书类别：" + i);
                    getBooks();
                }
            }else {
                books.push([]);
                //i<书的总类型数
                if(i < vNav.types.length){
                    i++;
                    console.log(i);
                    getBooks();
                }
            }
        }
    });
}
getBooks();

var vMain = new Vue({
    el: "#lb_mainContainer",
    data:{
        types: vNav.types,
        bookTypes: books,
        isSearch: false,
        searchToggle: true,
        searchText: ""
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
                this.isSearch = true;
                $.ajax({
                    type: "GET",
                    data: {text: this.searchText},
                    url: "../jsp/getSearchResult.jsp",
                    success: function (data) {
                        if(data !== 'false'){
                            var resJson = JSON.parse(data);
                            searchResult = resJson;
                            console.log("searchResult:" + searchResult);
                            vMain.bookTypes = searchResult;
                        }else {
                            alert("Oops！没有查找到相应的结果！");
                        }
                    }
                });
            }else{
                this.searchToggleTurn();
                this.isSearch = false;
                this.bookTypes = books;
            }

            console.log("GO");
        },
        searchToggleTurn: function () {
            this.searchToggle = !this.searchToggle;
        }
    }
});
