
function json2(data){
    var JSONData = eval("("+data+")");
    var jsonArray = JSONData.root;// 或者 jsonArray = JSONData[root];
    for (var i=0; i< jsonArray.length; i++){
        var item = jsonArray[i];
        var rightName = item.name;
        var amount = item.invest;
        var investTime = item.repayState;
        var bzurl = item.bzurl;
        var str="<li id='bztype' onClick=\"aa('"+bzurl+"')\"><p class='alignL rightName'>借款姓名：<span>"+rightName+"</span></p><div class='cont'><p class='name'>在投金额：<span>"+amount+"</span>元</p><p class='time'>投资时间：<span>"+investTime+"</span></p></div></li>";
        list.innerHTML += str;
    }
}

function aa(bb){
    alert("check start");
    var device = navigator.userAgent.toLowerCase();
    var isIphone = device.indexOf("iphone") > -1;// iphone 设备
    var isAndroid = device.indexOf("android") > -1;// android 设备
    if(isIphone){
        try{
            readyMessageIframe = document.createElement('iframe');
            readyMessageIframe.style.display = 'none';
            readyMessageIframe.src = bb;
            document.documentElement.appendChild(readyMessageIframe);
            document.documentElement.removeChild(readyMessageIframe)
        }catch(err) {
        }
    }else if(isAndroid){
        window.bridge.topagebz(bb);
    }
    alert("check end");
}
