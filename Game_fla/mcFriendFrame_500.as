// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcFriendFrame_500

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.geom.Point;
    import flash.geom.Rectangle;
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

    public dynamic class mcFriendFrame_500 extends MovieClip {

        public var btnClose:SimpleButton;
        public var bg:MovieClip;
        public var fx:MovieClip;

        public function mcFriendFrame_500(){
            addFrameScript(0, frame1);
        }
        function frame1(){
        }
        public function resizeTo(w:int, h:int, fxdy:int=0):void{
            var i:int;
            var o:Object;
            var p:Point;
            var q:Point;
            var bgA:Rectangle;
            var bgB:Rectangle;
            if (!("boundsOK" in this)){
                buildBounds();
            };
            i = 0;
            o = {};
            p = new Point();
            q = new Point();
            bgA = this.bgA;
            bg.width = w;
            bg.height = h;
            bg.x = (bgA.topLeft.x + Math.round((bg.width / 2)));
            bg.y = (bgA.topLeft.y + Math.round((bg.height / 2)));
            bgB = bg.getBounds(this);
            fx.y = 110;
        }
        public function buildBounds():void{
            var i:int;
            var o:Object;
            var p:Point;
            var q:Point;
            var bgA:Rectangle;
            this.boundsOK = true;
            i = 0;
            o = {};
            p = new Point();
            q = new Point();
            bgA = (this.bgA = bg.getBounds(this));
        }

    }
}//package Game_fla

