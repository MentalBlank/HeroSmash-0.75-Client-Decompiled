// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//DFrameMC

package {
    import flash.display.MovieClip;
    import flash.filters.GlowFilter;
    import flash.events.MouseEvent;
    import flash.text.*;

    public class DFrameMC extends MovieClip {

        public var fWidth:int = 175;
        var fData:Object = null;
        public var fHeight:int = 38;
        var rarityCA:Array;
        public var cnt:DFrameMCcnt;
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

        public function DFrameMC(resObj:Object):void{
            fData = null;
            isOpen = false;
            iniFrameT = 0;
            iniFrameC = 0;
            durFrameT = 35;
            durFrameC = 0;
            rarityCA = [0x666666, 0xFFFFFF, 0x66FF00, 2663679, 0xFF00FF, 0xFFCC00, 0xFF0000];
            fWidth = 175;
            fHeight = 38;
            fX = 0;
            fY = 0;
            super();
            addFrameScript(0, frame1, 2, frame3, 3, frame4, 8, frame9, 12, frame13);
            fData = resObj;
        }
        public function init(){
            var middleBG:*;
            var difference:Number;
            var mcFilter:*;
            var sIcon:String;
            var AssetClass:Class;
            var mcIcon:*;
            var newMiddle:*;
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
            middleBG = (mc.cnt.bg.width / 2);
            difference = 0;
            mc.cnt.strName.autoSize = "left";
            mc.cnt.strName.text = fData.sName;
            if (mc.cnt.strName.height > 20){
                mc.cnt.strName.y = (mc.cnt.strName.y - int((mc.cnt.strName.height / 2)));
                if (mc.cnt.strName.y < 3){
                    mc.cnt.strName.y = 3;
                };
            };
            mc.cnt.strName.width = (mc.cnt.strName.textWidth + 6);
            mc.cnt.strType.text = rootClass.getDisplaysType(fData);
            if (fData.iQty > 1){
                mc.cnt.strQ.text = ("x" + fData.iQty);
                mc.cnt.strQ.x = ((mc.cnt.bg.width - mc.cnt.strQ.width) - 7);
                mc.cnt.strQ.visible = true;
                mc.cnt.bg.width = ((int(mc.cnt.strName.width) + int(mc.cnt.strQ.x)) + 20);
            }
            else {
                mc.cnt.strQ.x = 0;
                mc.cnt.strQ.visible = false;
                mc.cnt.bg.width = (int(mc.cnt.strName.textWidth) + 50);
                newMiddle = (mc.cnt.bg.width / 2);
                difference = (middleBG - newMiddle);
                mc.cnt.glow.x = (mc.cnt.glow.x - difference);
            };
            mc.cnt.fx1.width = mc.cnt.bg.width;
            fWidth = mc.cnt.bg.width;
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
            AssetClass = (rootClass.world.getClass(sIcon) as Class);
            mcIcon = mc.cnt.icon.addChild(new (AssetClass)());
            mcIcon.scaleX = (mcIcon.scaleY = 0.5);
            mcFilter = mc.cnt.icon.filters;
            mcFilter = new GlowFilter(rarityCA[fData.iRty], 1, 8, 8, 2, 1, false, false);
            mc.cnt.icon.filters = [mcFilter];
        }
        function frame3(){
            iniFrameC++;
            if (!(iniFrameC > (MovieClip(parent).getChildIndex(this) * 2))){
                this.gotoAndPlay((currentFrame - 1));
            };
        }
        private function closeClick(e:MouseEvent){
        }
        function frame13(){
            MovieClip(parent).removeChild(this);
            stop();
        }
        function frame4(){
            visible = true;
        }
        function frame9(){
            durFrameC++;
            if (!(durFrameC > durFrameT)){
                this.gotoAndPlay((currentFrame - 1));
            };
        }
        function frame1(){
            visible = false;
        }

    }
}//package 

