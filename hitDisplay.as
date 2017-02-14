// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//hitDisplay

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

    public dynamic class hitDisplay extends MovieClip {

        public var text_Four:MovieClip;
        public var sumText:Number;
        public var maxDigits;
        public var t:MovieClip;
        public var nextIndex;
        public var strHit:String;

        public function hitDisplay(){
            addFrameScript(0, frame1, 2, frame3, 21, frame22);
        }
        public function mcFillTextFour(ind:Number){
            var total:*;
            var midTotal:*;
            var myTotal:*;
            var myMidTotal:*;
            var i:*;
            var k:*;
            total = (text_Four[("t" + maxDigits)].x + text_Four[("t" + maxDigits)].width);
            midTotal = (total / 2);
            myTotal = (text_Four[("t" + ind)].x + text_Four[("t" + ind)].width);
            myMidTotal = (myTotal / 2);
            sumText = (midTotal - myMidTotal);
            i = 0;
            while (i < ind) {
                nextIndex = (i + 1);
                text_Four[("t" + nextIndex)].text = strHit.slice(i, nextIndex);
                text_Four[("t" + nextIndex)].x = (text_Four[("t" + nextIndex)].x + sumText);
                i++;
            };
            k = (i + 1);
            while (k <= maxDigits) {
                text_Four[("t" + k)].visible = false;
                k++;
            };
        }
        function frame3(){
            strHit = t.ti.text;
            maxDigits = 4;
            sumText = 0;
            switch (strHit.length){
                case 1:
                case 2:
                case 3:
                case 4:
                    mcFillTextFour(strHit.length);
                    text_Four.visible = true;
                    break;
            };
        }
        function frame1(){
            t.visible = false;
        }
        function frame22(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

