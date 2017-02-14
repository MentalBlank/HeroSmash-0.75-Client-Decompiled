// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Apop

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.*;

    public class Apop extends MovieClip {

        public var btnClose:MovieClip;
        public var platformLeft:MovieClip;
        public var bg:MovieClip;
        public var platformRight:MovieClip;
        public var cnt:MovieClip;
        public var o:Object = null;
        public var arrowRight:MovieClip;
        private var mc:MovieClip;
        public var world:MovieClip;
        public var nMask:MovieClip;
        public var arrowLeft:MovieClip;
        public var rootClass:MovieClip;
        public var npc:MovieClip;
        public var placement:MovieClip;

        public function Apop():void{
            o = null;
            super();
            addFrameScript(0, frame1, 5, frame6);
            mc = MovieClip(this);
            mc.btnClose.addEventListener(MouseEvent.CLICK, xClick, false, 0, true);
        }
        private function xClick(e:MouseEvent):void{
            fClose();
        }
        public function exit():void{
            fClose();
        }
        public function fClose():void{
            mc.btnClose.removeEventListener(MouseEvent.CLICK, xClick);
            mc.parent.removeChild(this);
        }
        function frame1(){
            bg.visible = false;
            arrowLeft.visible = false;
            arrowRight.visible = false;
            platformLeft.visible = false;
            platformRight.visible = false;
        }
        public function warn(s:String){
            trace("");
            trace("*^*^* NPC DIALOGUE ERROR *^*^*");
            trace(("  > " + s));
            trace("");
        }
        function frame6(){
            bg.visible = true;
            stop();
        }
        public function update(obj:Object){
            var npc:String;
            var npce:String;
            var scene:String;
            var cnt:String;
            var frame:String;
            var npcClass:Class;
            var npcMC:MovieClip;
            var npcMCB:MovieClip;
            var cntClass:Class;
            var cntmc:*;
            var mcnt:MovieClip;
            var labelOK:Boolean;
            var i:int;
            rootClass = MovieClip(this.stage.getChildAt(0));
            world = rootClass.world;
            o = obj;
            npc = "none";
            npce = "none";
            scene = "none";
            cnt = "none";
            frame = "none";
            if (("npcLinkage" in o)){
                npc = o.npcLinkage;
            };
            if (("npcEntry" in o)){
                npce = o.npcEntry;
            };
            if (("cnt" in o)){
                cnt = o.cnt;
            };
            if (("scene" in o)){
                scene = o.scene;
            };
            if (("frame" in o)){
                frame = o.frame;
            };
            if (npc != "none"){
                npcClass = (world.ldr_map.contentLoaderInfo.applicationDomain.getDefinition(npc) as Class);
                if (npcClass != null){
                    if (npce == "right"){
                        npcMC = mc.npc.npcRight;
                        npcMCB = mc.npc.npcLeft;
                        if (npcMCB.currentLabel != "init"){
                            npcMCB.gotoAndPlay("flash-out");
                        }
                        else {
                            npcMCB.visible = false;
                        };
                    }
                    else {
                        npcMC = mc.npc.npcLeft;
                        npcMCB = mc.npc.npcRight;
                        if (npcMCB.currentLabel != "init"){
                            npcMCB.gotoAndPlay("flash-out");
                        }
                        else {
                            npcMCB.visible = false;
                        };
                    };
                    npcMC.visible = true;
                    npcMC.npc.removeChildAt(0);
                    npcMC.npc.addChild(new (npcClass)());
                    if (npcMC.currentLabel != "init"){
                        npcMC.gotoAndPlay("flash-in");
                    }
                    else {
                        npcMC.gotoAndPlay("flash-in");
                    };
                }
                else {
                    mc.npc.npcRight.visible = false;
                    mc.npc.npcLeft.visible = false;
                };
            };
            if (cnt != "none"){
                cntClass = (world.ldr_map.contentLoaderInfo.applicationDomain.getDefinition(cnt) as Class);
                if (cntClass != null){
                    mc.cnt.removeChildAt(0);
                    cntmc = mc.cnt.addChild(new (cntClass)());
                    cntmc.name = "cnt";
                    if (scene != "none"){
                        cntmc.gotoAndPlay(scene);
                    };
                };
            };
            if (frame != "none"){
                mcnt = MovieClip(mc.cnt.getChildByName("cnt"));
                labelOK = false;
                i = 0;
                while (i < mcnt.currentLabels.length) {
                    if (mcnt.currentLabels[i].name == frame){
                        labelOK = true;
                    };
                    i++;
                };
                if (labelOK){
                    mcnt.gotoAndPlay(frame);
                }
                else {
                    rootClass.addUpdate((("Label " + frame) + " not found!"));
                };
            };
            if (mc.currentLabel == "init"){
                mc.gotoAndPlay("in");
                if (npce == "right"){
                    mc.arrowRight.visible = true;
                    mc.platformRight.visible = true;
                    mc.arrowLeft.visible = false;
                    mc.platformLeft.visible = false;
                }
                else {
                    mc.arrowLeft.visible = true;
                    mc.platformLeft.visible = true;
                    mc.arrowRight.visible = false;
                    mc.platformRight.visible = false;
                };
            };
        }

    }
}//package 

