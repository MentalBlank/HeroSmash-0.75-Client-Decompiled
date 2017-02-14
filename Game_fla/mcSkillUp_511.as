// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcSkillUp_511

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

    public dynamic class mcSkillUp_511 extends MovieClip {

        public var c:int;
        public var t:int;
        public var rootClass:MovieClip;

        public function mcSkillUp_511(){
            addFrameScript(0, frame1, 1, frame2, 10, frame11, 41, frame42);
        }
        public function fClose():void{
            this.gotoAndStop("reset");
        }
        function frame1(){
            this.visible = false;
            this.x = 961;
            rootClass = (stage.getChildAt(0) as MovieClip);
            c = 0;
            t = 60;
            this.addEventListener(MouseEvent.CLICK, onSkillUpClick, false, 0, true);
            this.buttonMode = true;
            stop();
        }
        function frame2(){
            this.visible = false;
            this.x = 961;
            stop();
        }
        function frame11(){
            this.visible = true;
            this.x = 766;
            c = 0;
        }
        public function onSkillUpClick(e:MouseEvent):void{
            rootClass.toggleCharpanel("spend");
            fClose();
        }
        function frame42(){
            if (++c < t){
                this.gotoAndPlay((this.currentFrame - 1));
            }
            else {
                fClose();
            };
        }

    }
}//package Game_fla

