// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.cnt_505

package Game_fla{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
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

    public dynamic class cnt_505 extends MovieClip {

        public var counter:MovieClip;
        public var bg:MovieClip;

        public function cnt_505(){
            addFrameScript(0, frame1, 1, frame2, 4, frame5, 19, frame20, 56, frame57);
        }
        function frame1(){
            this.removeEventListener(MouseEvent.CLICK, clickHandler);
            this.buttonMode = true;
        }
        function frame5(){
            this.visible = true;
        }
        function frame20(){
            stop();
        }
        function frame2(){
            stop();
        }
        public function clickHandler(e:MouseEvent){
            MovieClip(e.currentTarget.parent.parent.world).resPlayer();
            MovieClip(e.currentTarget).visible = false;
            MovieClip(e.currentTarget).gotoAndStop(1);
        }
        function frame57(){
            this.addEventListener(MouseEvent.CLICK, clickHandler);
            stop();
        }

    }
}//package Game_fla

