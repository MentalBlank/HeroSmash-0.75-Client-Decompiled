// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//CastBarMC

package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.text.*;

    public class CastBarMC extends MovieClip {

        public var dur:int = 1000;
        public var callback:Object = null;
        public var cnt:MovieClip;
        public var o:Object = null;
        private var ts:Number;
        public var state:int = -1;
        private var world:MovieClip;
        private var run:int;
        private var mc:MovieClip;
        public var isOpen:Boolean = false;
        private var date:Date;
        private var rootClass:MovieClip;

        public function CastBarMC():void{
            o = null;
            isOpen = false;
            callback = null;
            state = -1;
            dur = 1000;
            super();
            addFrameScript(0, frame1, 4, frame5, 5, frame6, 9, frame10);
        }
        public function init():void{
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
        }
        public function fClose():void{
            var l2:*;
            if (isOpen){
                o = null;
                state = -1;
                isOpen = false;
                l2 = mc.cnt.fillMask;
                l2.removeEventListener(Event.ENTER_FRAME, slide);
                mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, tipFollow);
                mc.gotoAndPlay("out");
                rootClass.world.myAvatar.pMC.endAction();
            };
        }
        private function tipFollow(e:Event):void{
            var tip:*;
            var l2:*;
            tip = mc.cnt.tip;
            l2 = mc.cnt.fillMask;
            tip.x = ((l2.x + l2.width) - tip.width);
        }
        function frame10(){
            cnt.tip.visible = false;
        }
        function frame1(){
            cnt.visible = false;
            init();
            stop();
        }
        function frame6(){
            stop();
        }
        function frame5(){
            cnt.visible = true;
            cnt.tip.visible = true;
        }
        private function slide(e:Event):void{
            var bar:*;
            var len:*;
            var pc:*;
            bar = MovieClip(e.currentTarget);
            date = new Date();
            len = (date.getTime() - ts);
            pc = (len / dur);
            if (pc >= 1){
                mc.gotoAndPlay("out");
                bar.removeEventListener(Event.ENTER_FRAME, slide);
                mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, tipFollow);
                fCallback();
                fClose();
            }
            else {
                bar.x = ((mc.cnt.fill.x - mc.cnt.fillMask.width) + (run * pc));
            };
        }
        public function fOpenWith(obj):void{
            var _local2:*;
            var _local3:*;
            o = obj;
            isOpen = true;
            switch (o.typ){
                case "sia":
                    state = o.args.ID;
                case "generic":
                    mc.cnt.t1.text = o.txt;
                    _local2 = mc.cnt.fill;
                    _local3 = mc.cnt.fillMask;
                    _local3.x = int((_local2.x - _local3.width));
                    run = int((_local2.x - _local3.x));
                    date = new Date();
                    ts = Number(date.getTime());
                    dur = int((1000 * o.dur));
                    _local3.removeEventListener(Event.ENTER_FRAME, slide);
                    _local3.addEventListener(Event.ENTER_FRAME, slide);
                    mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, tipFollow);
                    mc.cnt.tip.addEventListener(Event.ENTER_FRAME, tipFollow);
                    mc.gotoAndPlay("in");
                    break;
            };
        }
        private function fCallback():void{
            if (o.msg != null){
                rootClass.chatF.pushMsg("event", o.msg, "SERVER", "", 0);
            };
            if (o.callback != null){
                if (o.args != null){
                    o.callback(o.args);
                }
                else {
                    o.callback();
                };
            };
            if (o.xtObj != null){
                rootClass.sfc.sendXtMessage("zm", o.xtObj.cmd, o.xtObj.args, "str", rootClass.world.curRoom);
            };
        }

    }
}//package 

