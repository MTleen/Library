/**
 * Created by HuShengxiang on 12/10/2017.
 */
var login = new Vue({
    el: "#lb_forms",
    data: {
//                密码错误提示框显示标志位
        isPswError: true,
//                登录表单显示标志位
        isLogin: true,
//                注册两次密码输入不匹配提示框显示标志位
        isInspected: true,
        psw_1: "",
        psw_2: ""
    },
    methods: {
        login: function () {
            $.ajax({
                type: "POST",
                url: "../jsp/login.jsp",
                dataType: "html",
                data: $('#lb_loginForm').serialize(),
                success: function (data) {
                    eval("var json = " + data);
//                            根据json.isPswCorrect判定登录是否成功
                    if(!json.isPswCorrect){
                        login.isPswError = false;
                    }else {
//                                设置id、user、admin Cookie
                        login.isPswError = true;
                        var userId = json.id,
                            admin = json.isAdmin;
                        setCookie("user", $(' #userName ').val());
                        setCookie("admin", admin);
                        setCookie("userId", userId);
                        window.location.replace("./index.jsp");
                    }
                }
            });
        },
        signUp: function () {
            $.ajax({
                type: "POST",
                url: "../jsp/signUp.jsp",
                dataType: "html",
                data: $('#lb_SignUpForm').serialize(),
                success: function (data) {
                    console.log(data);
                    eval("var json = " + data);
                    if(data){
                        setCookie("user", $(" #userNameS ").val());
                        setCookie("userId", json.id);
                        setCookie("admin", json.isAdmin);
                        window.location.replace("./index.jsp");
                    }
                }
            });
        },
//                检测两次输入的密码是否一致
        inspectPsw: function () {
            this.isInspected = this.psw_1 == this.psw_2;
//                    console.log(this.psw_1);
//                    console.log(this.psw_1 == this.psw_2)
        },
//                登录注册窗转换
        turnToSignUp: function () {
            var lb_loginForm = $(" #lb_loginForm "),
                lb_signUpForm = $(" #lb_SignUpForm ");
            lb_signUpForm.css({transition: "all .5s ease", transform: "translateY(-" + lb_loginForm.height() + "px)", opacity: 1});
            lb_loginForm.css({transition: "all .5s ease", transform: "translateY(-" + lb_loginForm.height() + "px)", opacity: 0});
        }
    }
});