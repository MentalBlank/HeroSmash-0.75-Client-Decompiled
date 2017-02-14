// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcConfirmBox_109

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
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

    public dynamic class mcConfirmBox_109 extends MovieClip {

        public var btnClose:SimpleButton;
        public var txtConfirm:TextField;
        public var panelRight:MovieClip;
        public var btnConfirm:SimpleButton;
        public var btnCancel:SimpleButton;

        public function mcConfirmBox_109(){
            addFrameScript(0, frame1);
        }
        public function onC(evt:MouseEvent):void{
            this.visible = false;
        }
        public function onDelete(evt:MouseEvent):void{
            MovieClip(parent.parent).deleteChar();
        }
        function frame1(){
            txtConfirm.tabIndex = 1;
            btnConfirm.addEventListener(MouseEvent.CLICK, onDelete, false, 0, true);
            btnClose.addEventListener(MouseEvent.CLICK, onC, false, 0, true);
            btnCancel.addEventListener(MouseEvent.CLICK, onC, false, 0, true);
            stop();
        }

    }
}//package Game_fla

