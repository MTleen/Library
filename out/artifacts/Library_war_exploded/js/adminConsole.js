/**
 * Created by HuShengxiang on 14/10/2017.
 */
var vBanner = new Vue({
    el: "#lb_banner",
    data: {
        userName: getCookie("user")
    }
});

var vConsole = new Vue({
    el: "#lb_consoleMainContainer",
    data: {
        types: vNav.types,
        bookTypes: vMain.bookTypes,
        books: [],
        sortID: 1,
        sortTotal: 1,
        sortAmount: 1,
        searchToggle: true,
        searchText: "",
        isSelectedCover: false,
        coverSrc: ""
    },
    computed: {
        targets: function(){
            var arr = [];
            for(var i = 0; i < this.types.length; i++){
                arr.push("#" + i);
            }
            return arr;
        },
        typeArr: function () {
            var arr = [];
            for(var i = 0; i < this.types.length; i++){
                arr.push(this.types[i].message);
            }
            return arr;
        }
    },
    methods: {
        /**
         * @param e window.event 对象
         * @param item 排序的关键字
         * @param toggle 排序标识位
         * @param dataModel 进行排序的数据模型
         * */
        sort: function (e, item, toggle, dataModel) {
            e = window.event;
            console.log(item);
            var temp;
            for(var i = 0; i < this[dataModel].length; i++){
                var length = this[dataModel][i].length;
                for(var j = 0; j < length - 1; j++){
                    for(var k = j + 1; k < length; k++){
                        // console.log(this.bookTypes[i][j][item]);
                        if(this[dataModel][i][j][item] > this[dataModel][i][k][item]){
                            //改变vue实例数据模型时一定要通过Vue.set()；否则无法触发视图的更新！！！！！！！
                            temp = this[dataModel][i][k];
                            Vue.set(this[dataModel][i], k, this[dataModel][i][j]);
                            Vue.set(this[dataModel][i], j, temp);
                        }
                    }
                }
                if(this[toggle] === 0 && length !== undefined){
                    this[dataModel][i].reverse();
                }
            }
            if(this[toggle] === 1){
                // console.log(e);
                $(e.target).find(" .caret ").css({transition: 'all .3s',transform: "rotate(180deg)"});
                // $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(180deg)"});
                this[toggle] = 0;
            }else {
                $(e.target).find(" .caret ").css({transition: 'all .3s',transform: "rotate(360deg)"});
                setTimeout(function () {
                    $(e.target).find(" .caret ").css({transition: 'all 0s',transform: "rotate(0deg)"});
                }, 300);
                // console.log("现在是逆序排列") ;
                // $(" #lb_mainContainer #lb_searchOpt #lb_" + toggle + " .caret ").css({transform: "rotate(0deg)"});
                this[toggle] = 1;
            }
        },
        turnSearchToggle: function () {
            this.searchToggle = !this.searchToggle;
        },
        search: function () {
            if(this.searchText){
                searchResult = [];
                this.sortID = this.sortAmount = this.sortTotal = 1;
                $(" .caret ").css({transform: "rotate(0deg)"});
                getBooks(true, 0, "getSearch", this.searchText, searchResult, 'books');
                this.bookTypes = vMain.bookTypes;
                getAllBooks();
            }else{
                this.turnSearchToggle();
                this.bookTypes = vMain.bookTypes = books;
                getAllBooks();
            }
        },
        store: function () {

        },
        fileHandle: function (files) {

        },

        // 出库
        exStore: function (e, id, name, amount, total) {
            e = window.event;
            if(confirm("正在出库《" + name + "》，请确认，出库操作将无法恢复！")){
                if(amount < total){
                    if(confirm("《" + name + "》仍有书本处于借出状态，若仍确认出库将丢失数据！")){
                        this.exBook(id, name);
                    }
                }else {
                    this.exBook(id, name);
                }
            }
        },

        //出库
        exBook: function (id, name) {
            $.ajax({
                type: "GET",
                url: "../jsp/exBooks.jsp",
                data: {id: id, name: encodeURI(encodeURI(name))},
                success: function (data) {
                    // alert(data.trim());
                    books = [];
                    getBooks(true, 0, "getBooks", "", books, 'books');
                    setTimeout(function () {
                        vMain.bookTypes = books;
                        vConsole.bookTypes = vMain.bookTypes;
                        getAllBooks();
                    },200);
                }
            });
        }
    }
});

function getAllBooks() {
    var arr = [];
    var i,j;
    for(i in vConsole.bookTypes){
        // console.log(this.bookTypes[i]);
        for(j in vConsole.bookTypes[i]){
            // console.log(vConsole.bookTypes[i][j]);
            arr.push(vConsole.bookTypes[i][j]);
            //生成每本书所对应的type值
            arr[arr.length - 1].type = i;
        }
    }
    Vue.set(vConsole.books, 0, arr);
}

getAllBooks();