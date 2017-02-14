// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.fameAnimation_761

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

    public dynamic class fameAnimation_761 extends MovieClip {

        public var nowDigit:String;
        public var maxDigits;
        public var strPoints:String;
        public var f6:MovieClip;
        public var f4:MovieClip;
        public var myTime;
        public var f1:MovieClip;
        public var nextIndex;
        public var f5:MovieClip;
        public var f3:MovieClip;
        public var f2:MovieClip;
        public var intPoints:Number;
        public var maxInd;
        public var ind;

        public function fameAnimation_761(){
            addFrameScript(0, frame1, 4, frame5);
        }
        public function fillDigits(ind:Number){
            var sInd:*;
            var i:*;
            sInd = 0;
            i = ind;
            while (i > 0) {
                nextIndex = (sInd + 1);
                nowDigit = strPoints.slice(sInd, nextIndex);
                this[("f" + i)].f5.tDigit.text = nowDigit;
                sInd++;
                myTime.start();
                i--;
            };
        }
        function frame5(){
            intPoints = MovieClip(parent.parent).intGold;
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
            this[("f" + maxInd)].gotoAndPlay("On");
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

