// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.xpAnimation_764

package Game_fla{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
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

    public dynamic class xpAnimation_764 extends MovieClip {

        public var nowDigit:String;
        public var maxDigits;
        public var strPoints:String;
        public var myTime;
        public var nextIndex;
        public var x1:MovieClip;
        public var x2:MovieClip;
        public var x3:MovieClip;
        public var x5:MovieClip;
        public var x6:MovieClip;
        public var intPoints:Number;
        public var x4:MovieClip;
        public var maxInd;
        public var ind;

        public function xpAnimation_764(){
            addFrameScript(0, frame1, 5, frame6);
        }
        public function fillDigits(ind:Number){
            var sInd:*;
            var i:*;
            sInd = 0;
            i = ind;
            while (i > 0) {
                nextIndex = (sInd + 1);
                nowDigit = strPoints.slice(sInd, nextIndex);
                this[("x" + i)].x1.tDigit.text = nowDigit;
                sInd++;
                myTime.start();
                i--;
            };
        }
        function frame6(){
            intPoints = MovieClip(parent.parent).intXp;
            strPoints = String(intPoints);
            maxDigits = 6;
            ind = strPoints.length;
            myTime = new Timer(80, 1);
            myTime.addEventListener("timer", onTimer, false, 0, true);
            maxInd = ind;
            trace(ind);
            switch (ind){
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                    fillDigits(ind);
                    break;
            };
            stop();
        }
        function frame1(){
            stop();
        }
        public function onTimer(evt:TimerEvent):void{
            myTime.stop();
            myTime.reset();
            this[("x" + maxInd)].gotoAndPlay("On");
            maxInd--;
            if (maxInd > 0){
                myTime.start();
            }
            else {
                removeEventListener("timer", onTimer);
            };
        }

    }
}//package Game_fla

