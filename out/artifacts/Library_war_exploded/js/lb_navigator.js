/**
 * Created by HuShengxiang on 09/10/2017.
 */

var offsetArr = [],
    goToBookTypeArr = [];
function getOffsetTop(el) {
    return el.getBoundingClientRect().top+(window.pageYOffset||document.documentElement.scrollTop)-(document.documentElement.clientTop||0);
}

for(var i = 1; i <= 5; i++){
    offsetArr[i - 1] = getOffsetTop($("#lb_bookType" + i)[0]);
    // console.log(offsetArr);
    eval("var func = function (){$(document.body).animate({scrollTop: " + (getOffsetTop($('#lb_bookType' + i)[0]) - $(" #lb_navigator ").height()) + "});}");
    goToBookTypeArr[i - 1] = func;
    // console.log(goToBookTypeArr.toString())
}

var vNav = new Vue({
    el: "#lb_navigator",
    data: {
        types: [
            {message: '数学分析', href: 'javascript:void(0);', handler: goToBookTypeArr[0]},
            {message: '考研英语', href: 'javascript:void(0);', handler: goToBookTypeArr[1]},
            {message: '马克思主义', href: 'javascript:void(0);', handler: goToBookTypeArr[2]},
            {message: '中国特色社会主义', href: 'javascript:void(0);', handler: goToBookTypeArr[3]},
            {message: '数据结构', href: 'javascript:void(0);', handler: goToBookTypeArr[4]}
        ],
        isLanded: false,
        isAdmin: false,
        user: ""
        },
    computed: {
            href: function () {
                return this.isLanded ? "./personalCenter.jsp" : "./login.html";
            }
    }
});





