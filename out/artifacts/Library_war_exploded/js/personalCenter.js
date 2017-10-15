/**
 * Created by HuShengxiang on 15/10/2017.
 */
var vBanner = new Vue({
    el: "#lb_banner",
    data: {
        userName: getCookie("user"),
        userId: getCookie("userId"),
        books: []
    }
});

var vCustomer = new Vue({
    el: "#lb_CustomerMainContainer",
    data: {
        searchToggle: true,
        types: vNav.types,
        books: [],
        bookTypes: []
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
        turnSearchToggle: function () {
            this.searchToggle = !this.searchToggle;
        },
        search: function () {

        }
    }
});

var books = [];
function getAllLentBooks() {
    $.ajax({
        type: "GET",
        url: "../jsp/getLentBooks.jsp",
        data: {id: vBanner.userId},
        success: function (data) {
            data = data.trim();
            console.log(data);
            if(data !== 'false'){
                var json = JSON.parse(data);
                books = json;
                for(var i in json){
                    console.log(parseInt(json[i].initTime) + typeof json[i].initTime);
                    var initTime = new Date(parseInt(json[i].initTime));
                    var deadline = new Date(parseInt(json[i].deadline));
                    console.log(initTime);
                    json[i].initTime = initTime.getFullYear() + "年" + (initTime.getMonth() + 1) + "月" + (initTime.getDate()) + "日";
                    json[i].deadline = deadline.getFullYear() + "年" + (deadline.getMonth() + 1) + "月" + (deadline.getDate() + 1) + "日";
                    Vue.set(vCustomer.books, i, json[i]);
                }
            }
        }
    });
}

getAllLentBooks();