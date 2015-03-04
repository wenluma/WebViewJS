var $_GET = (
             function(){
             var url = window.document.location.href.toString();
             var u = url.split("?");
             if(typeof(u[1]) == "string"){
                u = u[1].split("&");
                var get = {};
                for(var i in u){
                var j = u[i].split("=");
                    get[j[0]] = j[1];
                }
                return get;
             }else{
                return {};
             }
             })();

var Client = {
    
ua: function() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
    var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
    var bIsAndroid = sUserAgent.match(/android/i) == "android";
    var res = {
    a: false,
    i: false
    };
    if (bIsAndroid) {
        return 'android'
    } else if (bIsIpad || bIsIphoneOs) {
        return 'ios'
    }
    return 'other'
},
func: function(fname, param) {
    if (Client.ua() == 'android') {
        var funtxt = "";
        if (param.length > 0) {
            param = param.length > 0 ? "\"" + param.join("\",\"") + "\"": "";
            funtxt = "window.bridge." + fname + "(" + param + ")"
        } else {
            funtxt = "window.bridge." + fname + "()"
        }
        window.setTimeout(function() {
                          try {
                          window.bridge ? eval(funtxt) : ""
                          } catch(err) {
                          Client.talert("ERR:" + funtxt)
                          }
                          },
                          100)
    } else if (Client.ua() == 'ios') {
        if (param) {
            param = param.join("-@@-")
        }
        window.setTimeout(function() {
                          try {
                          readyMessageIframe = document.createElement('iframe');
                          readyMessageIframe.style.display = 'none';
                          readyMessageIframe.src = "protocol://" + fname + "/" + param;
                          document.documentElement.appendChild(readyMessageIframe);
                          document.documentElement.removeChild(readyMessageIframe)
                          } catch(err) {
                          Client.talert("ERR:" + funtxt)
                          }
                          },
                          1)
    }
}
};

$(function(){
  var url=decodeURIComponent(document.URL);
  var para="";
  var eventid="";
  var cellid="";
  var bzurl="";
  var loanname="";
  var loanno="";
  var loanmoney="";
  var loanlimit="";
  var loandate="";
  var type="";
  var imgurls="";
  var por="";
  var num = "";
  if(url.lastIndexOf("?")>0)
  {
  para=url.substring(url.lastIndexOf("?")+1,url.length);
  var arr=para.split("&");
  para="";
  loanname=decodeURIComponent($_GET['loan_name']);
  loanno=decodeURIComponent($_GET['loan_no']);
  loanmoney=decodeURIComponent($_GET['loan_money']);
  loanlimit=decodeURIComponent($_GET['loan_limit']);
  loandate=decodeURIComponent($_GET['loan_date']);
  eventid=$_GET['eventid'];
  cellid=$_GET['periodId'];
  
  bzurl=decodeURIComponent($_GET['bzurl']);
  type=$_GET['type'];
  imgurls=$_GET['imgurls'];
  por=$_GET['por'];
  
  bzurl=bzurl+"?type="+type+"&imgurls="+imgurls+"&por="+por + "&loan_name=" + loanname + "&guarantor=" + $_GET['TheGuarantor'] + "&license_no=" + $_GET['id'];
  $("#loan_name").html(loanname);
  $("#loan_no").html(loanno);
  $("#loan_money").html(loanmoney+"元");
  $("#loan_limit").html(loanlimit+"天");
  $("#loan_date").html(loandate);
  }
  else
  {
  document.write("没有参数!");
  }
		$("#contract").click(function(){
                             
                             //window.bridge.getcontract(eventid,cellid);
                             var param = new Array();
                             param.push(eventid);
                             param.push(cellid);
                             Client.func("getcontract", param);
                             
                             });
		
		$("#bztype").click(function(){
                           
                           //window.bridge.topagebz(bzurl);
                           var param = new Array();
                           param.push(bzurl);
                           Client.func("topagebz", param);
                           
                           });
		if($_GET['name'] == undefined){
  
		}else{
  $("#loan_name").text("" + decodeURIComponent($_GET['name']));
		}
		if($_GET['TheGuarantor'] == undefined){
  
		}else{
  
  $("#loan_guarantor").text("" + decodeURIComponent($_GET['TheGuarantor']));
  $("#loan_guarantor_title").parent().parent().css("display", "block");
  
		}
		if($_GET['id'] == undefined){
  
		}else{
  $("#loan_no_title").text("营业执照");
  $("#loan_no").text("" + $_GET['id']);
		}
  });
