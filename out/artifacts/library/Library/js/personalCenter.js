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
        bookTypes: [],
        sortId: 1,
        sortInit: 1,
        sortDeadline: 1,
        sortType: 1,
        isAdmin: getCookie('admin')
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

        },
        delCookie: function () {
            delCookie('user');
            delCookie('userId');
            delCookie('admin');
            window.location.replace("../html/index.jsp");
        },
        sort: function (e, item, toggle) {
            // $(e.target).find(".caret").css({transition: 'all, 0s', transform: 'rotate(' + (this[toggle] * 180) + 'deg)'});
            e = window.event;
            for(var i = 0; i < this.books.length - 1; i++){
                for(var j = i + 1; j < this.books.length; j++){
                    if(item === 'initTime' || item === 'deadline'){
                        if((this.books[i][item].getDay() > this.books[j][item].getDay() && this.books[i][item].getMonth() > this.books[j][item].getMonth()) || (this.books[i][item].getMonth() > this.books[j][item].getMonth())){
                            var temp = this.books[j];
                            Vue.set(this.books, j, this.books[i]);
                            Vue.set(this.books, i, temp);
                        }
                    }else{
                        if(this.books[i][item] > this.books[j][item]){
                            var temp = this.books[j];
                            Vue.set(this.books, j, this.books[i]);
                            Vue.set(this.books, i, temp);
                        }
                    }
                }
            }
            if(this[toggle] === 0){
                this.books.reverse();
                // console.log($(e.target).find('.caret'));
                $(e.target).find(".caret").css({transition: 'all, .3s', transform: 'rotate(' + ((this[toggle] + 1) * 360) + 'deg)'});
                this[toggle] = 1;
                setTimeout(function () {
                    $(e.target).find(" .caret ").css({transition: 'all 0s',transform: "rotate(0deg)"});
                }, 300);
                return;
            }
            $(e.target).find(".caret").css({transition: 'all, .3s', transform: 'rotate(180deg)'});
            this[toggle] = 0;
        },
        extend: function (e, id, name, date, isExtended) {
            if(isExtended === 'false'){
                var userId = getCookie('userId');
                if(confirm('确认延长《' + name +' 》的借阅时间？')){
                    $.ajax({
                        type: 'GET',
                        data: {name: encodeURI(encodeURI(name)), id: id, userId: userId, deadline: date.getTime() + (30 * 24 * 60 * 60 *1000)},
                        url: '../jsp/extendBooks.jsp',
                        success: function (data) {
                            var json = JSON.parse(data.trim());
                            var date = new Date(parseInt(json.date));
                            alert("《" + json.name + "》续借成功，请在" + date.getFullYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + "日之前归还！");
                            getAllLentBooks();
                        }
                    })
                }
            }else {
                alert('请注意，只能延长归还时间一次，请按期归还书本后再借阅！');
            }

        },
        returnBook: function (e, id, name) {
            var userId = getCookie('userId');
            if(confirm('确认归还《' + name +' 》？')){
                $.ajax({
                    type: 'GET',
                    data: {id:id, userId: userId},
                    url: '../jsp/returnBooks.jsp',
                    success: function (data) {
                        alert(data.trim());
                        getAllLentBooks();
                    }
                })
            }
        }
    }
});

var books = [];
function getAllLentBooks() {
    $.ajax({
        type: "GET",
        url: "../jsp/getLentBooks.jsp",
        data: {id: getCookie("userId")},
        success: function (data) {
            data = data.trim();
            console.log(data);
            if(data !== 'false'){
                var json = JSON.parse(data);
                books = json;
                vCustomer.books = [];
                for(var i in json){
                    // console.log(parseInt(json[i].initTime) + typeof json[i].initTime);
                    var initTime = new Date(parseInt(json[i].initTime));
                    var deadline = new Date(parseInt(json[i].deadline));
                    console.log(initTime);
                    json[i].initTime = initTime;
                    json[i].deadline = deadline;
                    Vue.set(vCustomer.books, i, json[i]);
                }
            }else {
                vCustomer.books = [];
            }
        }
    });
}

getAllLentBooks();