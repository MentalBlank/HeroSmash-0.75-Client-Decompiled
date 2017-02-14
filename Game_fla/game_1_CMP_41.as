// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.game_1_CMP_41

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
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

    public dynamic class game_1_CMP_41 extends MovieClip {

        public var checkmark:MovieClip;
        public var chkBtn:SimpleButton;
        public var bitChecked:Boolean;

        public function game_1_CMP_41(){
            addFrameScript(0, frame1);
        }
        function frame1(){
            checkmark.mouseEnabled = false;
            chkBtn.addEventListener(MouseEvent.CLICK, onClick, false, 1, true);
        }
        public function onClick(event:MouseEvent){
            MovieClip(stage.getChildAt(0)).mixer.playSound("Click");
            bitChecked = !(bitChecked);
            checkmark.visible = bitChecked;
        }

    }
}//package Game_fla

