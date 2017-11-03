/**
 * Created by HuShengxiang on 09/10/2017.
 */
var vNav = new Vue({
    el: "#lb_navigator",
    data: {
        types: [
            {message: '数学分析', href: 'javascript:void(0);', handler: ""},
            {message: '考研英语', href: 'javascript:void(0);', handler: ""},
            {message: '马克思主义', href: 'javascript:void(0);', handler: ""},
            {message: '中国特色社会主义', href: 'javascript:void(0);', handler: ""},
            {message: '数据结构', href: 'javascript:void(0);', handler: ""}
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




