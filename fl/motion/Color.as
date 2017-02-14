// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//fl.motion.Color

package fl.motion{
    import flash.geom.ColorTransform;
    import flash.display.*;

    public class Color extends ColorTransform {

        private var _tintMultiplier:Number = 0;
        private var _tintColor:Number = 0;

        public function Color(redMultiplier:Number=1, greenMultiplier:Number=1, blueMultiplier:Number=1, alphaMultiplier:Number=1, redOffset:Number=0, greenOffset:Number=0, blueOffset:Number=0, alphaOffset:Number=0){
            _tintColor = 0;
            _tintMultiplier = 0;
            super(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
        }
        public static function interpolateColor(fromColor:uint, toColor:uint, progress:Number):uint{
            var q:Number;
            var fromA:uint;
            var fromR:uint;
            var fromG:uint;
            var fromB:uint;
            var toA:uint;
            var toR:uint;
            var toG:uint;
            var toB:uint;
            var resultA:uint;
            var resultR:uint;
            var resultG:uint;
            var resultB:uint;
            var resultColor:uint;
            q = (1 - progress);
            fromA = ((fromColor >> 24) & 0xFF);
            fromR = ((fromColor >> 16) & 0xFF);
            fromG = ((fromColor >> 8) & 0xFF);
            fromB = (fromColor & 0xFF);
            toA = ((toColor >> 24) & 0xFF);
            toR = ((toColor >> 16) & 0xFF);
            toG = ((toColor >> 8) & 0xFF);
            toB = (toColor & 0xFF);
            resultA = ((fromA * q) + (toA * progress));
            resultR = ((fromR * q) + (toR * progress));
            resultG = ((fromG * q) + (toG * progress));
            resultB = ((fromB * q) + (toB * progress));
            resultColor = ((((resultA << 24) | (resultR << 16)) | (resultG << 8)) | resultB);
            return (resultColor);
        }
        public static function interpolateTransform(fromColor:ColorTransform, toColor:ColorTransform, progress:Number):ColorTransform{
            var q:Number;
            var resultColor:ColorTransform;
            q = (1 - progress);
            resultColor = new ColorTransform(((fromColor.redMultiplier * q) + (toColor.redMultiplier * progress)), ((fromColor.greenMultiplier * q) + (toColor.greenMultiplier * progress)), ((fromColor.blueMultiplier * q) + (toColor.blueMultiplier * progress)), ((fromColor.alphaMultiplier * q) + (toColor.alphaMultiplier * progress)), ((fromColor.redOffset * q) + (toColor.redOffset * progress)), ((fromColor.greenOffset * q) + (toColor.greenOffset * progress)), ((fromColor.blueOffset * q) + (toColor.blueOffset * progress)), ((fromColor.alphaOffset * q) + (toColor.alphaOffset * progress)));
            return (resultColor);
        }
        public static function fromXML(xml:XML):Color{
            return (Color(new (Color)().parseXML(xml)));
        }

        public function setTint(tintColor:uint, tintMultiplier:Number):void{
            var r:uint;
            var g:uint;
            var b:uint;
            this._tintColor = tintColor;
            this._tintMultiplier = tintMultiplier;
            this.redMultiplier = (this.greenMultiplier = (this.blueMultiplier = (1 - tintMultiplier)));
            r = ((tintColor >> 16) & 0xFF);
            g = ((tintColor >> 8) & 0xFF);
            b = (tintColor & 0xFF);
            this.redOffset = Math.round((r * tintMultiplier));
            this.greenOffset = Math.round((g * tintMultiplier));
            this.blueOffset = Math.round((b * tintMultiplier));
        }
        public function set tintColor(value:uint):void{
            this.setTint(value, this.tintMultiplier);
        }
        public function get brightness():Number{
            return (((this.redOffset) ? (1 - this.redMultiplier) : (this.redMultiplier - 1)));
        }
        private function deriveTintColor():uint{
            var ratio:Number;
            var r:uint;
            var g:uint;
            var b:uint;
            var colorNum:uint;
            ratio = (1 / this.tintMultiplier);
            r = Math.round((this.redOffset * ratio));
            g = Math.round((this.greenOffset * ratio));
            b = Math.round((this.blueOffset * ratio));
            colorNum = (((r << 16) | (g << 8)) | b);
            return (colorNum);
        }
        public function get tintMultiplier():Number{
            return (this._tintMultiplier);
        }
        public function get tintColor():uint{
            return (this._tintColor);
        }
        public function set brightness(value:Number):void{
            var percent:Number;
            var offset:Number;
            if (value > 1){
                value = 1;
            }
            else {
                if (value < -1){
                    value = -1;
                };
            };
            percent = (1 - Math.abs(value));
            offset = 0;
            if (value > 0){
                offset = (value * 0xFF);
            };
            this.redMultiplier = (this.greenMultiplier = (this.blueMultiplier = percent));
            this.redOffset = (this.greenOffset = (this.blueOffset = offset));
        }
        public function set tintMultiplier(value:Number):void{
            this.setTint(this.tintColor, value);
        }
        private function parseXML(xml:XML=null):Color{
            var firstChild:XML;
            var att:XML;
            var name:String;
            var tintColorNumber:uint;
            if (!xml){
                return (this);
            };
            firstChild = xml.elements()[0];
            if (!firstChild){
                return (this);
            };
            for each (att in firstChild.attributes()) {
                name = att.localName();
                if (name == "tintColor"){
                    tintColorNumber = (Number(att.toString()) as uint);
                    this.tintColor = tintColorNumber;
                }
                else {
                    this[name] = Number(att.toString());
                };
            };
            return (this);
        }

    }
}//package fl.motion

