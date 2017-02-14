// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//FactionsMC

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.*;

    public class FactionsMC extends MovieClip {

        var hRun:int = 0;
        var mhY:int = 0;
        var iRepMax:int = 302500;
        public var cnt:MovieClip;
        var mbY:int = 0;
        var mbD:int = 0;
        var dRun:int = 0;
        public var world:MovieClip;
        var mc:MovieClip;
        var isOpen:Boolean = false;
        var mDown:Boolean = false;
        public var rootClass:MovieClip;
        var qly:int = 70;
        public var factions:Array;

        public function FactionsMC():void{
            isOpen = false;
            mDown = false;
            hRun = 0;
            dRun = 0;
            mbY = 0;
            mhY = 0;
            mbD = 0;
            qly = 70;
            iRepMax = 302500;
            super();
            addFrameScript(0, frame1, 6, frame7, 11, frame12, 15, frame16);
            mc = MovieClip(this);
            mc.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK, xClick);
        }
        private function dEF(e:Event){
            var scr:*;
            var display:*;
            var hP:*;
            var tY:*;
            scr = MovieClip(e.currentTarget.parent).scr;
            display = MovieClip(e.currentTarget);
            hP = (-(scr.h.y) / hRun);
            tY = (int((hP * dRun)) + display.oy);
            if (Math.abs((tY - display.y)) > 0.2){
                display.y = (display.y + ((tY - display.y) / 4));
            }
            else {
                display.y = tY;
            };
        }
        private function hEF(e:Event){
            var scr:*;
            if (mDown){
                scr = MovieClip(e.currentTarget.parent);
                mbD = (int(mouseY) - mbY);
                scr.h.y = (mhY + mbD);
                if ((scr.h.y + scr.h.height) > scr.b.height){
                    scr.h.y = int((scr.b.height - scr.h.height));
                };
                if (scr.h.y < 0){
                    scr.h.y = 0;
                };
            };
        }
        private function bMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.fx.visible = false;
        }
        private function showEmptyList(){
            var itemClass:*;
            var item:*;
            itemClass = (mc.cnt.fList.iproto.constructor as Class);
            item = mc.cnt.fList.addChild(new (itemClass)());
            item.t1.htmlText = '<font color="#DDDDDD">No Factions!</font>';
            item.t2.visible = false;
            item.tRank.visible = false;
            item.hit.alpha = 0;
            item.x = 10;
            mc.cnt.fList.iproto.visible = false;
            mc.cnt.scr.visible = false;
        }
        public function fClose():void{
            mc.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK, xClick);
            rootClass.ui.mcPopup.onClose();
        }
        private function scrDown(e:MouseEvent){
            mbY = int(mouseY);
            mhY = int(MovieClip(e.currentTarget.parent).h.y);
            mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        private function scrUp(e:MouseEvent){
            mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        function frame12(){
        }
        function frame7(){
            stop();
        }
        private function setCT(obj, col){
            var ct:*;
            ct = obj.transform.colorTransform;
            ct.color = col;
            obj.transform.colorTransform = ct;
        }
        public function open(){
            rootClass = MovieClip(this.stage.getChildAt(0));
            world = rootClass.world;
            factions = world.factions;
            mc = MovieClip(this);
            if (!isOpen){
                isOpen = true;
                mc.cnt.gotoAndPlay("intro");
            }
            else {
                isOpen = false;
                fClose();
            };
        }
        function frame16(){
            fClose();
        }
        function frame1(){
            open();
        }
        private function iMouseOver(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
            item.parent.mHi.visible = true;
            item.parent.mHi.y = item.y;
        }
        private function buildFactionList(){
            var i:*;
            var scr:*;
            var bMask:*;
            var display:*;
            var faction:*;
            var itemClass:*;
            var item:MovieClip;
            i = 0;
            while (i < factions.length) {
                faction = factions[i];
                if (faction != null){
                    itemClass = (mc.cnt.fList.iproto.constructor as Class);
                    item = (mc.cnt.fList.addChild(new (itemClass)()) as MovieClip);
                    item.t1.htmlText = faction.sName;
                    item.tRank.htmlText = ("Rank " + faction.iRank);
                    item.t2.htmlText = ((faction.iSpillRep + " <font color='#FF0000'>/</font> ") + faction.iRepToRank);
                    item.addEventListener(MouseEvent.MOUSE_OVER, iMouseOver, false, 0, true);
                    item.addEventListener(MouseEvent.MOUSE_OUT, iMouseOut, false, 0, true);
                    item.buttonMode = true;
                    item.hit.alpha = 0;
                    item.y = (i * 20);
                    item.x = 10;
                };
                i++;
            };
            scr = mc.cnt.scr;
            bMask = mc.cnt.bMask;
            display = mc.cnt.fList;
            scr.h.height = int(((scr.b.height / display.height) * scr.b.height));
            hRun = (scr.b.height - scr.h.height);
            dRun = ((display.height - scr.b.height) + 20);
            scr.h.y = 0;
            display.oy = (display.y = qly);
            scr.visible = false;
            scr.hit.alpha = 0;
            mDown = false;
            if (display.height > scr.b.height){
                scr.visible = true;
                scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
            };
            mc.cnt.fList.iproto.visible = false;
        }
        public function showFactionList(){
            if (factions.length > 0){
                buildFactionList();
            }
            else {
                showEmptyList();
            };
            mc.cnt.fList.visible = true;
            mc.cnt.fList.mHi.visible = false;
            mc.cnt.mouseChildren = true;
        }
        private function fListClick(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
        }
        private function bMouseOver(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.fx.visible = true;
        }
        private function iMouseOut(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
            item.parent.mHi.visible = false;
        }
        public function xClick(e:MouseEvent=null){
            mc.gotoAndPlay("outro");
        }

    }
}//package 

