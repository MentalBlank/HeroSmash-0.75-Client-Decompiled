// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//goldDisplay

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

    public dynamic class goldDisplay extends MovieClip {

        public var text_Four:MovieClip;
        public var sumText:Number;
        public var maxDigits;
        public var t:MovieClip;
        public var txtMask:MovieClip;
        public var tMask:MovieClip;
        public var nextIndex;
        public var strHit:String;
        public var ind;

        public function goldDisplay(){
            addFrameScript(0, frame1, 1, frame2, 40, frame41);
        }
        public function mcFillTextFour(ind:Number){
            var total:*;
            var midTotal:*;
            var myTotal:*;
            var myMidTotal:*;
            var i:*;
            var lastDigit:*;
            var k:*;
            trace((ind + "Index"));
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
                txtMask[("t" + nextIndex)].text = strHit.slice(i, nextIndex);
                txtMask[("t" + nextIndex)].x = (txtMask[("t" + nextIndex)].x + sumText);
                i++;
            };
            lastDigit = (i - 1);
            text_Four.fStar.x = (text_Four[("t" + lastDigit)].x + text_Four[("t" + lastDigit)].width);
            k = (i + 1);
            while (k <= maxDigits) {
                text_Four[("t" + k)].visible = false;
                txtMask[("t" + k)].text = "";
                k++;
            };
        }
        function frame1(){
            tMask.visible = false;
            t.visible = false;
            text_Four.visible = false;
        }
        function frame41(){
            MovieClip(parent).removeChild(this);
            stop();
        }
        function frame2(){
            strHit = t.ti.text;
            maxDigits = 6;
            sumText = 0;
            ind = strHit.length;
            switch (ind){
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                    trace((strHit + " -------Gold ------------------"));
                    mcFillTextFour(ind);
                    text_Four.visible = true;
                    txtMask.visible = true;
                    break;
            };
        }

    }
}//package 

