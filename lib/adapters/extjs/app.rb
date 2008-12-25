module Rwt

  def call_view(url)
    JS.new("getJs.createCallback('#{url}')")
  end
  
  class App < Rwt::Component
    def init_cmp
      Rwt << "
         Ext.BLANK_IMAGE_URL='/ext/resources/images/default/s.gif';
         Ext.onReady(function(){
           Ext.QuickTips.init();

           Rwt={};
           owner=Rwt;

           var errJs=function(response,options){
             alert('error');
           };

           var exeJs=function(xhttp){
             var ret=eval(xhttp.responseText+'(Rwt)');
           };

           var getJs=function(url){
             Ext.Ajax.request({
               url: url,
               success: exeJs,
               failure: errJs
             });
           };

           Rwt.debug= function(text){
             if(!Rwt.debugWindow){
                 Rwt.debugWindow=new Ext.Window({title:'Rwt debug window',width:200,height:200,
                   x:document.body.getBoundingClientRect().right-200,y:0,
                   autoScroll:true ,closeAction:'hide',
                   tbar:[
                      {text:'Clear',handler:function(){while(Rwt.debugWindow.body.first()){Rwt.debugWindow.body.first().remove()}}}
                        ]
                  });
                 Rwt.debugWindow.show();
               };
             var p=document.createElement('p');
             p.textContent= text;
             Rwt.debugWindow.body.appendChild(p);
             if(Rwt.debugWindow.hidden){Rwt.debugWindow.show()};
           };

           Rwt.message=function(title,message){
              Ext.Msg.alert(title,message)
           };
         "
    end

    def render_create
      Rwt << '});' # completes Ext.onReady(function(){
    end

  end

end
