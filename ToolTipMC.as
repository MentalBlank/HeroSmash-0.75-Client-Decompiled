// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ToolTipMC

package {
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import flash.text.*;

    public class ToolTipMC extends MovieClip {

        public var cnt:MovieClip;
        public var t:Timer;
        var world:MovieClip;
        var mc:MovieClip;
        var isOpen:Boolean = false;
        var data:Object;
        var tWidth:int;
        var rootClass:MovieClip;

        public function ToolTipMC(){
            isOpen = false;
            t = new Timer(200, 1);
            super();
            addFrameScript(0, frame1, 9, frame10);
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
            world = rootClass.world;
            mc.cnt.visible = false;
            mc.cnt.ti.autoSize = "left";
            tWidth = mc.cnt.ti.width;
            mc.mouseEnabled = false;
            mc.mouseChildren = false;
            t.addEventListener(TimerEvent.TIMER, open);
            t.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
        }
        public function openWith(newData){
            data = newData;
            t.reset();
            t.start();
        }
        function frame10(){
            stop();
        }
        public function open(e:TimerEvent){
            isOpen = true;
            mc.cnt.visible = true;
            mc.cnt.ti.width = tWidth;
            mc.cnt.ti.htmlText = data.str;
            mc.cnt.ti.width = (int(mc.cnt.ti.textWidth) + 6);
            mc.cnt.bg.width = (int(mc.cnt.ti.width) + 8);
            mc.cnt.bg.height = (int(mc.cnt.ti.height) + 5);
            mc.x = ((rootClass.mouseX - (mc.width / 2)) - rootClass.ui.x);
            mc.y = ((rootClass.mouseY - mc.height) - 15);
            if ((mc.x + mc.cnt.bg.width) > 960){
                mc.x = ((960 - mc.cnt.bg.width) - 10);
            };
            if (mc.x < 1){
                mc.x = 1;
            };
            if (mc.y < 1){
                mc.y = (rootClass.mouseY + 10);
            };
            mc.x = int(mc.x);
            mc.y = int(mc.y);
            mc.gotoAndPlay("in");
        }
        private function onMouseOut(e:MouseEvent):void{
            if (t.running){
                t.stop();
            };
            close();
        }
        function frame1(){
            hide();
            stop();
        }
        public function hide(){
            mc.cnt.visible = false;
            mc.x = 850;
        }
        public function close(){
            isOpen = false;
            t.reset();
            mc.gotoAndPlay("out");
        }

    }
}//package 

