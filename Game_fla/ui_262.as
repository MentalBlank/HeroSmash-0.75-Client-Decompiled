// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.ui_262

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

    public dynamic class ui_262 extends MovieClip {

        public var HP:MovieClip;
        public var strGold:TextField;
        public var strName:TextField;
        public var partyLead:MovieClip;
        public var pStatus:MovieClip;
        public var mcHead:MovieClip;
        public var iconBoost:MovieClip;
        public var mcStatusBoxFrame:MovieClip;
        public var MP:MovieClip;
        public var pvpIcon:MovieClip;
        public var strLevel:TextField;

        public function ui_262(){
            addFrameScript(0, frame1);
        }
        function frame1(){
            mcHead.backhair.visible = false;
        }

    }
}//package Game_fla

