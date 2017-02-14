// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ModalMC

package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.text.*;

    public class ModalMC extends MovieClip {

        private var glowSizes:Object;
        private var fData:Object = null;
        private var callback:Object = null;
        private var glowColors:Object;
        public var cnt:MovieClip;
        private var world:MovieClip;
        private var mc:MovieClip;
        public var greedy:Boolean = false;
        public var isOpen:Boolean = false;
        private var rootClass:MovieClip;

        public function ModalMC():void{
            fData = null;
            callback = null;
            glowColors = {
                white:0xFFFFFF,
                red:0xFF0000,
                green:0xFF00,
                blue:0xFF,
                gold:16750899
            };
            glowSizes = {medium:3};
            isOpen = false;
            greedy = false;
            super();
            addFrameScript(3, frame4, 11, frame12);
        }
        private function nMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        }
        private function yMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        }
        public function init(resObj){
            var glowColor:String;
            var glowSize:String;
            fData = resObj;
            callback = resObj.callback;
            if (resObj.greedy != null){
                greedy = resObj.greedy;
            };
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
            mc.cnt.strBody.autoSize = "center";
            mc.cnt.strBody.htmlText = fData.strBody;
            if ((((resObj.btns == null)) || ((resObj.btns == "dual")))){
                mc.cnt.btns.dual.ybtn.buttonMode = true;
                mc.cnt.btns.dual.nbtn.buttonMode = true;
                mc.cnt.btns.dual.ybtn.addEventListener(MouseEvent.CLICK, yClick, false, 0, true);
                mc.cnt.btns.dual.ybtn.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
                mc.cnt.btns.dual.ybtn.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
                mc.cnt.btns.dual.nbtn.addEventListener(MouseEvent.CLICK, nClick, false, 0, true);
                mc.cnt.btns.dual.nbtn.addEventListener(MouseEvent.MOUSE_OVER, nMouseOver, false, 0, true);
                mc.cnt.btns.dual.nbtn.addEventListener(MouseEvent.MOUSE_OUT, nMouseOut, false, 0, true);
                mc.cnt.btns.mono.visible = false;
            };
            if (((!((resObj.btns == null))) && ((resObj.btns == "mono")))){
                mc.cnt.btns.mono.buttonMode = true;
                mc.cnt.btns.mono.addEventListener(MouseEvent.CLICK, mClick, false, 0, true);
                mc.cnt.btns.mono.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
                mc.cnt.btns.mono.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
                mc.cnt.btns.dual.visible = false;
            };
            mc.cnt.bg.height = Math.ceil((mc.cnt.strBody.textHeight + 42));
            mc.cnt.btns.y = (mc.cnt.bg.height - 1);
            mc.x = ((960 / 2) - (mc.width / 2));
            mc.y = ((550 / 2) - (mc.height / 2));
            if (resObj.glow != null){
                glowColor = resObj.glow.split(",")[0];
                glowSize = resObj.glow.split(",")[1];
                mc.filters = [new GlowFilter(glowColors[glowColor], 1, glowSizes[glowSize], glowSizes[glowSize], 64, 1)];
            };
        }
        private function mClick(e:MouseEvent){
            var btn:*;
            var mc:*;
            btn = MovieClip(e.currentTarget);
            mc = MovieClip(this);
            setCT(btn.bg, 0xFF0000);
            mc.mouseChildren = false;
            if (mc.callback != null){
                mc.callback(fData.params);
            };
            killButtons();
            mc.gotoAndPlay("out");
        }
        public function fClose():void{
            callback = null;
            killButtons();
            mc.parent.removeChild(this);
        }
        private function killButtons():void{
            mc.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.CLICK, yClick);
            mc.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            mc.cnt.btns.dual.ybtn.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
            mc.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.CLICK, nClick);
            mc.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.MOUSE_OVER, nMouseOver);
            mc.cnt.btns.dual.nbtn.removeEventListener(MouseEvent.MOUSE_OUT, nMouseOut);
            mc.cnt.btns.mono.removeEventListener(MouseEvent.CLICK, mClick);
            mc.cnt.btns.mono.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            mc.cnt.btns.mono.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
        }
        private function nMouseOver(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0x222222);
        }
        function frame12(){
            if (this.stage != null){
                fClose();
            };
        }
        private function setCT(obj, col){
            var ct:*;
            ct = obj.transform.colorTransform;
            ct.color = col;
            obj.transform.colorTransform = ct;
        }
        function frame4(){
            stop();
        }
        private function yMouseOver(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0x222222);
        }
        private function yClick(e:MouseEvent){
            var btn:*;
            var mc:*;
            btn = MovieClip(e.currentTarget);
            mc = MovieClip(this);
            setCT(btn.bg, 43775);
            fData.params.accept = true;
            mc.mouseChildren = false;
            mc.callback(mc.fData.params);
            killButtons();
            mc.gotoAndPlay("out");
        }
        private function nClick(e:MouseEvent){
            var btn:*;
            var mc:*;
            btn = MovieClip(e.currentTarget);
            mc = MovieClip(this);
            setCT(btn.bg, 0xFF0000);
            fData.params.accept = false;
            mc.mouseChildren = false;
            mc.callback(fData.params);
            killButtons();
            mc.gotoAndPlay("out");
        }

    }
}//package 

