/**
 * Created by HuShengxiang on 12/10/2017.
 */
var login = new Vue({
    el: "#lb_forms",
    data: {
//                ���������ʾ����ʾ��־λ
        isPswError: true,
//                ��¼����ʾ��־λ
        isLogin: true,
//                ע�������������벻ƥ����ʾ����ʾ��־λ
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
//                            ����json.isPswCorrect�ж���¼�Ƿ�ɹ�
                    if(!json.isPswCorrect){
                        login.isPswError = false;
                    }else {
//                                ����id��user��admin Cookie
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
//                �����������������Ƿ�һ��
        inspectPsw: function () {
            this.isInspected = this.psw_1 == this.psw_2;
//                    console.log(this.psw_1);
//                    console.log(this.psw_1 == this.psw_2)
        },
//                ��¼ע�ᴰת��
        turnToSignUp: function () {
            var lb_loginForm = $(" #lb_loginForm "),
                lb_signUpForm = $(" #lb_SignUpForm ");
            lb_signUpForm.css({transition: "all .5s ease", transform: "translateY(-" + lb_loginForm.height() + "px)", opacity: 1});
            lb_loginForm.css({transition: "all .5s ease", transform: "translateY(-" + lb_loginForm.height() + "px)", opacity: 0});
        }
    }
});