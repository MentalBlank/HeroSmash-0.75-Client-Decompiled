// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//mcAreaList

package {
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

    public dynamic class mcAreaList extends MovieClip {

        public var cntMask:MovieClip;
        public var title:MovieClip;
        public var cnt:MovieClip;
        public var rootClass;

        public function mcAreaList(){
            addFrameScript(0, frame1, 1, frame2, 4, frame5, 19, frame20, 24, frame25);
        }
        function frame1(){
            rootClass = MovieClip(stage.getChildAt(0));
            rootClass.initAreaList();
            title.gotoAndStop(1);
        }
        function frame25(){
            title.gotoAndPlay("out");
        }
        function frame5(){
            title.gotoAndPlay("in");
            MovieClip(Game.root).areaListGet();
        }
        function frame20(){
            stop();
        }
        function frame2(){
            stop();
        }

    }
}//package 

