// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//DFrame2MC

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import flash.filters.GlowFilter;
    import flash.text.*;

    public class DFrame2MC extends MovieClip {

        public var fWidth:int = 250;
        var fData:Object = null;
        public var fHeight:int = 86;
        var rarityCA:Array;
        public var cnt:MovieClip;
        var world:MovieClip;
        var iniFrameT:int = 0;
        var mc:MovieClip;
        var iniFrameC:int = 0;
        var isOpen:Boolean = false;
        public var fY:int = 0;
        public var fX:int = 0;
        var rootClass:MovieClip;
        var durFrameC:int = 0;
        var durFrameT:int = 35;

        public function DFrame2MC(resObj:Object):void{
            fData = null;
            isOpen = false;
            iniFrameT = 0;
            iniFrameC = 0;
            durFrameT = 35;
            durFrameC = 0;
            rarityCA = [0x666666, 0xFFFFFF, 0x66FF00, 2663679, 0xFF00FF, 0xFFCC00, 0xFF0000];
            fWidth = 250;
            fHeight = 86;
            fX = 0;
            fY = 0;
            super();
            addFrameScript(3, frame4, 11, frame12);
            fData = resObj;
        }
        private function nMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0);
        }
        private function yMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0);
        }
        public function init(){
            var mcFilter:* = undefined;
            var sIcon:String;
            var AssetClass:Class;
            var mcIcon:DisplayObject;
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
            mc.cnt.strName.autoSize = "left";
            mc.cnt.strName.text = fData.sName;
            if (fData.iStk > 1){
                mc.cnt.strName.text = (mc.cnt.strName.text + (" x" + fData.iQty));
            };
            mc.cnt.bg.width = Math.max(((mc.cnt.strName.x + int(mc.cnt.strName.textWidth)) + 15), 250);
            mc.cnt.ybtn.bg.width = Math.round((mc.cnt.bg.width / 2));
            mc.cnt.nbtn.bg.width = Math.round((mc.cnt.bg.width - mc.cnt.ybtn.bg.width));
            mc.cnt.nbtn.x = mc.cnt.ybtn.width;
            mc.cnt.ybtn.ti.x = (((mc.cnt.ybtn.bg.width / 2) - (mc.cnt.ybtn.ti.textWidth / 2)) + 4);
            mc.cnt.nbtn.ti.x = (((mc.cnt.nbtn.bg.width / 2) - (mc.cnt.nbtn.ti.textWidth / 2)) - 4);
            mc.cnt.ybtn.ti.mouseEnabled = false;
            mc.cnt.nbtn.ti.mouseEnabled = false;
            mc.cnt.strType.text = rootClass.getDisplaysType(fData);
            mcFilter = mc.cnt.bg.filters;
            mcFilter = new GlowFilter(rarityCA[fData.iRty], 1, 8, 8, 2, 1, false, false);
            mc.cnt.bg.filters = [mcFilter];
            mc.cnt.icon.removeAllChildren();
            sIcon = "";
            if (fData.sType.toLowerCase() == "enhancement"){
                sIcon = rootClass.getIconBySlot(fData.sES);
            }
            else {
                if ((((((fData.sIcon == null)) || ((fData.sIcon == "")))) || ((fData.sIcon == "none")))){
                    if (fData.sLink.toLowerCase() != "none"){
                        sIcon = "iidesign";
                    }
                    else {
                        sIcon = "iibag";
                    };
                }
                else {
                    sIcon = fData.sIcon;
                };
            };
            try {
                AssetClass = (rootClass.world.getClass(sIcon) as Class);
                mcIcon = mc.cnt.icon.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                AssetClass = (rootClass.world.getClass("iibag") as Class);
                mcIcon = mc.cnt.icon.addChild(new (AssetClass)());
            };
            mcIcon.scaleX = (mcIcon.scaleY = 0.5);
            mcFilter = mc.cnt.icon.filters;
            mcFilter = new GlowFilter(rarityCA[fData.iRty], 1, 8, 8, 2, 1, false, false);
            mc.cnt.icon.filters = [mcFilter];
            mc.cnt.ybtn.buttonMode = true;
            mc.cnt.nbtn.buttonMode = true;
            mc.cnt.ybtn.addEventListener(MouseEvent.CLICK, yClick, false, 0, true);
            mc.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
            mc.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
            mc.cnt.nbtn.addEventListener(MouseEvent.CLICK, nClick, false, 0, true);
            mc.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OVER, nMouseOver, false, 0, true);
            mc.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OUT, nMouseOut, false, 0, true);
        }
        public function fClose():void{
            killButtons();
            MovieClip(this).parent.removeChild(this);
        }
        private function killButtons():void{
            mc.cnt.ybtn.removeEventListener(MouseEvent.CLICK, yClick);
            mc.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            mc.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
            mc.cnt.nbtn.removeEventListener(MouseEvent.CLICK, nClick);
            mc.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OVER, nMouseOver);
            mc.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OUT, nMouseOut);
        }
        function frame12(){
            fClose();
        }
        private function nMouseOver(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0x222222);
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
            var invFull:Boolean;
            var item:Object;
            var btn:*;
            var mc:*;
            invFull = true;
            for each (item in rootClass.world.items) {
                if ((((item.ItemID == fData.ItemID)) && ((item.iQty < item.iStk)))){
                    invFull = false;
                };
            };
            if (((invFull) && ((rootClass.world.items.length < rootClass.world.myAvatar.objData.iBagSlots)))){
                invFull = false;
            };
            if (((rootClass.isHouseItem(fData)) && ((rootClass.world.houseitems.length >= rootClass.world.myAvatar.objData.iHouseSlots)))){
                rootClass.MsgBox.notify("House Inventory Full!");
            }
            else {
                if (invFull){
                    rootClass.MsgBox.notify("Item Inventory Full!");
                }
                else {
                    btn = MovieClip(e.currentTarget);
                    mc = MovieClip(btn.parent.parent);
                    setCT(btn.bg, 3385873);
                    mc.mouseChildren = false;
                    rootClass.sfc.sendXtMessage("zm", "getDrop", [fData.ItemID], "str", rootClass.world.curRoom);
                    killButtons();
                    mc.gotoAndPlay("out");
                };
            };
        }
        private function nClick(e:MouseEvent){
            var btn:*;
            var mc:*;
            btn = MovieClip(e.currentTarget);
            mc = MovieClip(btn.parent.parent);
            setCT(btn.bg, 0xFF0000);
            mc.mouseChildren = false;
            killButtons();
            mc.gotoAndPlay("out");
        }

    }
}//package 

