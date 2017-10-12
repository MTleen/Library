/**
 * Created by HuShengxiang on 09/10/2017.
 */
var vdate = new Vue({
    el: "#lb_bannerContainer .date",
    data: {
        hour: "",
        min: "",
        sec: "",
        day: "",
        date: "",
        month: "",
        year: "",
        show: false
    }
});

//构造一个拼接时间的函数
function spliceTime(num) {
    return (num < 10 ? "0" : "") + num;
}

//每隔1s获取一次时间
setInterval(function () {
    var date = new Date();
    var hour = date.getHours(),
        min = date.getMinutes(),
        sec = date.getSeconds();
    //当hour、min、sec数值小于10的时候需要在前面添加0
    vdate.hour = spliceTime(hour);
    vdate.min = spliceTime(min);
    vdate.sec = spliceTime(sec);
}, 1000);

setInterval(function () {
    vdate.show = !vdate.show;
}, 500);

//获取当前日期
var date = new Date();
var monthNames = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
var dayNames= ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
vdate.day = dayNames[date.getDay()];
vdate.date = date.getDate();
vdate.month = monthNames[date.getMonth()];
vdate.year = date.getFullYear();