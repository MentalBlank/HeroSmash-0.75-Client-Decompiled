// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.game_1_mcNotificationWrapper_169

package Game_fla{
    import flash.display.MovieClip;
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

    public dynamic class game_1_mcNotificationWrapper_169 extends MovieClip {

        public var mcNoticeBubble:MovieClip;

        public function game_1_mcNotificationWrapper_169(){
            addFrameScript(0, frame1, 59, frame60);
        }
        public function notify(strNotice:String):void{
            mcNoticeBubble.strNotice.text = strNotice;
            gotoAndPlay(3);
            visible = true;
        }
        function frame1(){
            visible = false;
            stop();
        }
        function frame60(){
            visible = false;
            stop();
        }

    }
}//package Game_fla

