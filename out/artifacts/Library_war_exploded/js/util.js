/**
 * Created by HuShengxiang on 10/10/2017.
 */
/**
 * 设置cookie
 * @param cname cookie的键名
 * @param cvalue cookie的值
 * */
function setCookie(cname, cvalue) {
    document.cookie = cname + "=" + cvalue;
}

/**
 * 获取cookie函数
 * @param cname 想要获取值的cookie键名
 * @return string cookie值，如果cookie不存在返回 ""
 **/
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(";");
    for(var i = 0; i < ca.length; i++){
        var c = ca[i].trim();
        if(c.indexOf(name) == 0){
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function delCookie(name) {
    var date = new Date();
    date.setTime(date.getTime() - 10000);
    document.cookie = name + "=a; expires=" + date.toGMTString();
}