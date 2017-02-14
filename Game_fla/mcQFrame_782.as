// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcQFrame_782

package Game_fla{
    import flash.display.MovieClip;
    import flash.text.TextField;
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

    public dynamic class mcQFrame_782 extends MovieClip {

        public var scr:MovieClip;
        public var bg:MovieClip;
        public var bMask:MovieClip;
        public var btns:MovieClip;
        public var mc;
        public var core:MovieClip;
        public var strTitle:TextField;
        public var qList:MovieClip;
        public var aMask:MovieClip;

        public function mcQFrame_782(){
            addFrameScript(4, frame5, 9, frame10, 10, frame11, 14, frame15, 21, frame22, 35, frame36, 46, frame47, 52, frame53, 57, frame58, 66, frame67);
        }
        function frame10(){
            MovieClip(parent).showQuestList();
            bg.resizeTo(326, 379);
        }
        function frame15(){
            MovieClip(parent).showQuestList();
        }
        function frame5(){
            stop();
        }
        function frame22(){
            stop();
        }
        function frame36(){
            MovieClip(parent).showQuestDetail();
            bg.resizeTo(326, 379);
        }
        function frame11(){
            stop();
        }
        function frame47(){
            stop();
        }
        function frame58(){
            MovieClip(parent).killDetailUI();
        }
        function frame53(){
            stop();
        }
        function frame67(){
            mc = MovieClip(parent);
            if (mc.qData != null){
                gotoAndPlay("detail");
            }
            else {
                gotoAndPlay("list");
            };
        }

    }
}//package Game_fla

