// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcFactions_381

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

    public dynamic class mcFactions_381 extends MovieClip {

        public var scr:MovieClip;
        public var fList:MovieClip;
        public var bg:MovieClip;
        public var bMask:MovieClip;
        public var aMask:MovieClip;

        public function mcFactions_381(){
            addFrameScript(4, frame5, 9, frame10, 17, frame18);
        }
        function frame10(){
            MovieClip(parent).showFactionList();
        }
        function frame18(){
            stop();
        }
        function frame5(){
            stop();
        }

    }
}//package Game_fla

