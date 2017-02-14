// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//avoidDisplay

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

    public dynamic class avoidDisplay extends MovieClip {

        public var miss:MovieClip;
        public var avoid:String;
        public var t:MovieClip;
        public var parry:MovieClip;
        public var block:MovieClip;
        public var dodge:MovieClip;

        public function avoidDisplay(){
            addFrameScript(0, frame1, 1, frame2, 20, frame21);
        }
        function frame1(){
            t.visible = false;
            miss.visible = false;
            dodge.visible = false;
            parry.visible = false;
            block.visible = false;
        }
        function frame21(){
            MovieClip(parent).removeChild(this);
            stop();
        }
        function frame2(){
            avoid = t.ti.text;
            switch (avoid){
                case "Miss!":
                    miss.visible = true;
                    break;
                case "Dodge!":
                    dodge.visible = true;
                    break;
                case "Block!":
                    block.visible = true;
                    break;
                case "Parry!":
                    parry.visible = true;
                    break;
            };
        }

    }
}//package 

