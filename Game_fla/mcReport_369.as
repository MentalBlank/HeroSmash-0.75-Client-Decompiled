// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcReport_369

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.system.*;
    import flash.text.*;
    import flash.net.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.filters.*;
    import flash.ui.*;
    import flash.external.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.xml.*;

    public dynamic class mcReport_369 extends MovieClip {

        public var btnClose:SimpleButton;
        public var tDesc:TextField;
        public var iSel;
        public var bg:MovieClip;
        public var mcSubmit:MovieClip;
        public var ti:TextField;
        public var tDetailTemplate;
        public var mc;
        public var rootClass:MovieClip;
        public var i1:MovieClip;
        public var i2:MovieClip;
        public var i0:MovieClip;
        public var i3:MovieClip;

        public function mcReport_369(){
            addFrameScript(0, frame1, 4, frame5, 9, frame10, 14, frame15, 19, frame20);
        }
        public function clearText(e:FocusEvent):void{
            if (tDesc.text == "Type reason for report here."){
                tDesc.text = "";
            };
        }
        public function itemClick(e:MouseEvent){
            var i:*;
            iSel = int(MovieClip(e.currentTarget).name.substr(1));
            i = 0;
            while (i < 4) {
                if (mc[("i" + i)] != null){
                    mc[("i" + i)].d.f1.visible = (i == iSel);
                };
                i++;
            };
            mcSubmit.visible = true;
            if ((((((((tDetailTemplate.indexOf(tDesc.text) > -1)) || ((tDesc.text == "Type reason for report here.")))) || ((tDesc.text == " ")))) || ((tDesc.text == "")))){
                tDesc.text = tDetailTemplate[iSel];
            };
        }
        function frame10(){
            stop();
        }
        public function submitClick(e:MouseEvent){
            var rootClass:*;
            var mcp:*;
            rootClass = MovieClip(stage.getChildAt(0));
            mcp = MovieClip(parent);
            if (!(((tDesc.text == "")) || ((tDesc.text == "Type reason for report here.")))){
                if (iSel != 3){
                    rootClass.world.sendReport(["reportlang", mcp.fData.unm, iSel, tDesc.text]);
                };
                mcp.onClose(null);
            };
        }
        function frame1(){
            rootClass = (stage.getChildAt(0) as MovieClip);
            iSel = -1;
            mc = MovieClip(this);
            tDetailTemplate = ["Type reason for report here.", "Type reason for report here.", "Type reason for report here.", "Type reason for report here."];
            if ((((rootClass.objServerInfo.iChat == 2)) && (!((rootClass.objServerInfo.sIP == "74.53.22.45"))))){
                gotoAndPlay("limited");
            }
            else {
                gotoAndPlay("full");
            };
        }
        public function checkText(e:FocusEvent):void{
            if (rootClass.trim(tDesc.text) == ""){
                tDesc.text = "Type reason for report here.";
            };
        }
        public function onClose(evt:Event=null):void{
            if (MovieClip(parent).currentLabel != "Init"){
                rootClass.mixer.playSound("Click");
                MovieClip(parent).gotoAndPlay("Init");
            };
        }
        function frame20(){
            stop();
        }
        function frame5(){
            i0.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
            i1.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
            i2.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
            i3.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
            mcSubmit.btn.addEventListener(MouseEvent.CLICK, submitClick, false, 0, true);
            btnClose.addEventListener(MouseEvent.CLICK, onClose, false, 0, true);
            i0.buttonMode = true;
            i1.buttonMode = true;
            i2.buttonMode = true;
            i3.buttonMode = true;
            i0.d.f1.visible = false;
            i1.d.f1.visible = false;
            i2.d.f1.visible = false;
            i3.d.f1.visible = false;
            mcSubmit.visible = false;
            ti.text = MovieClip(parent).fData.unm;
        }
        function frame15(){
            i1.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
            mcSubmit.btn.addEventListener(MouseEvent.CLICK, submitClick, false, 0, true);
            btnClose.addEventListener(MouseEvent.CLICK, onClose, false, 0, true);
            i1.buttonMode = true;
            iSel = 1;
            ti.text = MovieClip(parent).fData.unm;
            tDesc.addEventListener(FocusEvent.FOCUS_IN, clearText);
            tDesc.addEventListener(FocusEvent.FOCUS_OUT, checkText);
        }

    }
}//package Game_fla

