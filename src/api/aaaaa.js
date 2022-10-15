// ==UserScript==
// @name         跨域
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        http://*/*
// @grant        none
// @include    https://www.seedmm.in/*
// @include    https://www.busjav.cam/*
// @require    http://code.jquery.com/jquery-1.11.0.min.js

// ==/UserScript==

(function() {
    let p = document.querySelector('span.genre > a[href*="https://www.busjav.cam/star/"]');
    if (!p) return;
    p = p.parentNode.parentNode;

    let a = document.createElement('a');
    a.setAttribute('style', 'cursor: pointer; display: block; color: blue;');
    a.textContent = '保存';
    p.appendChild(a);
    a.onclick=getid;
    function getid(){
      var title=$(":header")[1].innerHTML;
      var oldurl = window.location.href;
      var picurl=$(".bigImage")[0].children[0].currentSrc;
      var arrayobj = new Array();
      var arrayurl = new Array();
      var id =oldurl.split('/')[oldurl.split('/').length-1];
      var spans=$(".genre");
      for(var i=0;i<spans.length;i++){
        var href=spans[i].children[0].href;
        var name=spans[i].children[0].innerHTML;
        arrayurl.push([href,name]);
      }
      arrayobj.push(["title",title]);
      arrayobj.push(["picurl",picurl]);
      arrayobj.push(["id",id]);
      arrayobj.push(["arrayurl",arrayurl]);
      var jsons=JSON.stringify(arrayurl);
      $("head").append('<meta http-equiv=\"Content-Security-Policy\" content=\"upgrade-insecure-requests\" />');
      var datas={
        "title":title,
        "picurl":picurl,
        "id":id,
        "arrayurl":jsons
      };

      $.ajax({
        url:"https://192.168.1.12:8443/picandfilms/saveinfo.do",
        type: 'GET',
        data:datas,
        contentType: "application/json; charset=utf-8",
        async:false,
        success: function(rtn){
          alert(rtn);

        },
        error: function(){

        }
      })
    }

    var url;
    url = window.location.href;
    /*$.ajax({
      url:"https://192.168.1.10:5004/website/sysUtil/checkExit?url="+url,
      type: 'GET',
      contentType: "application/json; charset=utf-8",
      async:false,
      success: function(rtn){
        alert(rtn);
        if(rtn.data){
          let span = document.createElement('span');
          span.textContent = '已存在!';
          p.appendChild(span);
        }
      },
      error: function(){

      }
    })*/

    GM_xmlhttpRequest({
      method: "GET",
      url: "https://192.168.1.10:5004/website/sysUtil/checkExit?url="+url,
      headers: {
        "Content-Type":"application/json; charset=utf-8"
      },
      onload: function(response){
        if(rtn.data){
          let span = document.createElement('span');
          span.textContent = '已存在!';
          p.appendChild(span);
        }
      },
      onerror: function(response){
        console.log("请求失败");
      }
    });



  }

)();
