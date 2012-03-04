// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//= require_tree .
function compareDay(a,b){//a , b 格式为 yyyy-MM-dd 
     var a1 = a.split("-"); 
     var b1 = b.split("-"); 
     var d1 = new Date(a1[0],a1[1],a1[2]); 
     var d2 = new Date(b1[0],b1[1],b1[2]); 
		var msg;
     if(Date.parse(d1) - Date.parse(d2) == 0){ //a==b 
        msg= 0; 
     } 
     if (Date.parse(d1) - Date.parse(d2) < 0) {//a>b 
        msg= 1; 
     } 
     if (Date.parse(d1) - Date.parse(d2) > 0) {//a<b 
        msg= -1; 
     } 
		return msg;
}

//   n天后
        function doit(dtstr,n) {
            var v = dtstr;
            if (v == "") return false;
            var dt = new Date(v.replace(/\-/g, "\/"));
            dt.setDate(dt.getDate() + n);
            var newdt = dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + dt.getDate();
            return newdt;
              
        }
       

        function addmulMonth(dtstr, n) {       //   n个月后
            
            var s = dtstr.split("-");
            var yy = parseInt(s[0]);
            var mm = parseInt(s[1]) - 1; 
            var dd = parseInt(s[2]);
            var dt = new Date(yy, mm, dd); 
            dt.setMonth(dt.getMonth() + n);
            if ((dt.getYear() * 12 + dt.getMonth()) > (yy * 12 + mm + n)) {
                dt = new Date(dt.getYear(), dt.getMonth(), 0); 
            }
            return dt.getYear() + "-" + dt.getMonth() + "-" + dt.getDate();
        }    
 
//n年后
        function addmulYear(dtstr,n)
        {
            var s = dtstr.split("-");
            var yy = parseInt(s[0]);
            var mm = parseInt(s[1]); 
            var dd = parseInt(s[2]);
            return yy + n + "-" + mm + "-" + dd;
        }