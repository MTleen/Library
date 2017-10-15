/**
 * Created by HuShengxiang on 10/10/2017.
 */
/**
 * ����cookie
 * @param cname cookie�ļ���
 * @param cvalue cookie��ֵ
 * */
function setCookie(cname, cvalue) {
    document.cookie = cname + "=" + cvalue;
}

/**
 * ��ȡcookie����
 * @param cname ��Ҫ��ȡֵ��cookie����
 * @return string cookieֵ�����cookie�����ڷ��� ""
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