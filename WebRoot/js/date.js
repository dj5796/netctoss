Date.prototype.toChar= function(format) {
     var o = {
           "M+" : this.getMonth() + 1, // month
           "d+" : this.getDate(), // day
           "h+" : this.getHours(), // hour
           "m+" : this.getMinutes(), // minute
           "s+" : this.getSeconds(), // second
           "w+" : "天一二三四五六".charAt(this.getDay()), // week星期几
           "q+" : Math.floor((this.getMonth() + 3) / 3), // quarter季度
           "S" : this.getMilliseconds()// 毫秒
     };
     if (/(y+)/.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + "")
                     .substr(4 - RegExp.$1.length));
     }
     for ( var k in o) {
           if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
                           : ("00" + o[k]).substr(("" + o[k]).length));
           }
     }
     return format;
}
