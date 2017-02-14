// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcAreaList_203

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

    public dynamic class mcAreaList_203 extends MovieClip {

        public var t1:TextField;
        public var bMinMax:MovieClip;

        public function mcAreaList_203(){
            addFrameScript(0, frame1, 5, frame6);
        }
        function frame6(){
            bMinMax.a1.visible = true;
            bMinMax.a2.visible = false;
            stop();
        }
        function frame1(){
            bMinMax.a1.visible = false;
            bMinMax.a2.visible = true;
            stop();
        }

    }
}//package Game_fla

