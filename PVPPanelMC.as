// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//PVPPanelMC

package {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;

    public class PVPPanelMC extends MovieClip {

        public var btnClose:SimpleButton;
        private var uoLeaf:Object;
        private var nextMode:String;
        private var itemSel:MovieClip;
        public var cnt:MovieClip;
        private var uoData:Object;
        private var pending:Boolean = false;
        private var world:MovieClip;
        private var rootClass:MovieClip;
        private var mcPopup:MovieClip;

        public function PVPPanelMC():void{
            rootClass = (stage.getChildAt(0) as MovieClip);
            world = (rootClass.world as MovieClip);
            mcPopup = rootClass.ui.mcPopup;
            uoLeaf = world.myLeaf();
            uoData = world.myAvatar.objData;
            pending = false;
            super();
            addFrameScript(0, frame1, 4, frame5, 11, frame12, 24, frame25, 29, frame30, 36, frame37, 49, frame50);
            btnClose.addEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick, false, 0, true);
        }
        private function updateMaps():void{
            var o:Object;
            var item:MovieClip;
            var itemC:Class;
            var n:int;
            var i:int;
            o = {};
            itemC = (cnt.iList.iproto.constructor as Class);
            while (cnt.iList.numChildren > 1) {
                cnt.iList.removeChildAt(1);
            };
            n = 0;
            i = 0;
            while (i < world.PVPMaps.length) {
                o = world.PVPMaps[i];
                if (!o.hidden){
                    item = cnt.iList.addChild(new (itemC)());
                    item.t1.ti.text = o.nam;
                    item.t2.ti.text = o.desc;
                    item.icon.gotoAndStop(o.icon);
                    item.y = (n * 55);
                    item.iSel = false;
                    item.iHi = false;
                    item.label = o.label;
                    item.warzone = o.warzone;
                    item.hit.alpha = 0;
                    item.hit.buttonMode = true;
                    item.hit.addEventListener(MouseEvent.CLICK, onMapItemClick, false, 0, true);
                    item.hit.addEventListener(MouseEvent.MOUSE_OVER, onMapItemOver, false, 0, true);
                    item.hit.addEventListener(MouseEvent.MOUSE_OUT, onMapItemOut, false, 0, true);
                    n++;
                };
                i++;
            };
            cnt.iList.iproto.visible = false;
            cnt.body.bJoin.addEventListener(MouseEvent.MOUSE_DOWN, btnJoinClick, false, 0, true);
            cnt.body.bExit.addEventListener(MouseEvent.MOUSE_DOWN, btnExitClick, false, 0, true);
            cnt.body.bJoin.visible = false;
            cnt.body.bExit.visible = false;
            cnt.body.msg.visible = false;
            cnt.body.gotoAndPlay("init");
        }
        private function btnCloseClick(e:MouseEvent=null):void{
            mcPopup.onClose();
        }
        private function btnExitClick(e:MouseEvent):void{
            if (!pending){
                pending = true;
                world.requestPVPQueue("none");
            };
        }
        public function updateBody():void{
            var mc:MovieClip;
            mc = cnt.body;
            if (pending){
                pending = false;
            };
            if (itemSel.warzone != world.PVPQueue.warzone){
                mc.bJoin.visible = true;
                mc.msg.visible = false;
                mc.bExit.visible = false;
            }
            else {
                mc.bJoin.visible = false;
                mc.msg.visible = true;
                mc.bExit.visible = true;
            };
        }
        public function fClose():void{
            killCurrentListeners();
        }
        private function killCurrentListeners():void{
            if (this.currentLabel == "maps"){
                cnt.body.bJoin.removeEventListener(MouseEvent.MOUSE_DOWN, btnJoinClick);
                cnt.body.bExit.removeEventListener(MouseEvent.MOUSE_DOWN, btnExitClick);
            };
            if (this.currentLabel == "results"){
                cnt.btnBack.removeEventListener(MouseEvent.CLICK, btnBackClick);
            };
            btnClose.removeEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick);
        }
        public function openWith(o:Object):void{
            nextMode = o.typ;
            if (isValidMode(nextMode)){
                if (((!((this.currentLabel == "init"))) && ((this.currentLabel.indexOf("-out") < 0)))){
                    this.gotoAndPlay((this.currentLabel + "-out"));
                }
                else {
                    this.gotoAndPlay(nextMode);
                };
            };
        }
        function frame12(){
            stop();
        }
        function frame25(){
            playNextMode();
        }
        function frame5(){
            update();
        }
        function frame1(){
            openWith(MovieClip(parent).fData);
        }
        private function playNextMode():void{
            killCurrentListeners();
            this.gotoAndPlay(nextMode);
        }
        private function btnJoinClick(e:MouseEvent):void{
            if (!pending){
                pending = true;
                world.requestPVPQueue(itemSel.warzone);
            };
        }
        function frame37(){
            stop();
        }
        function frame30(){
            update();
        }
        private function onMapItemOver(e:MouseEvent):void{
            var item:MovieClip;
            var otherItem:MovieClip;
            var i:int;
            item = (e.currentTarget.parent as MovieClip);
            if (((!(item.iHi)) && (!(item.iSel)))){
                item.iHi = true;
                item.gotoAndPlay("in1");
            };
            i = 1;
            while (i < cnt.iList.numChildren) {
                otherItem = (cnt.iList.getChildAt(i) as MovieClip);
                if (otherItem != item){
                    if (((otherItem.iHi) && (!(otherItem.iSel)))){
                        otherItem.gotoAndPlay("out1");
                    };
                    otherItem.iHi = false;
                };
                i++;
            };
        }
        private function isValidMode(str:String):Boolean{
            var res:Boolean;
            var i:int;
            res = false;
            i = 0;
            while ((((i < this.currentLabels.length)) && (!(res)))) {
                if (this.currentLabels[i].name == str){
                    res = true;
                };
                i++;
            };
            return (res);
        }
        private function onMapItemOut(e:MouseEvent):void{
            var item:MovieClip;
            item = (e.currentTarget.parent as MovieClip);
            if (((item.iHi) && (!(item.iSel)))){
                item.iHi = false;
                item.gotoAndPlay("out1");
            };
        }
        private function update():void{
            if (MovieClip(this).currentLabel == "maps"){
                updateMaps();
            };
            if (MovieClip(this).currentLabel == "results"){
                updateResults();
            };
        }
        private function onMapItemClick(e:MouseEvent):void{
            var item:MovieClip;
            var otherItem:MovieClip;
            var i:int;
            item = (e.currentTarget.parent as MovieClip);
            item.iHi = false;
            if (!item.iSel){
                itemSel = item;
                item.iSel = true;
                item.gotoAndPlay("in2");
            };
            i = 1;
            while (i < cnt.iList.numChildren) {
                otherItem = (cnt.iList.getChildAt(i) as MovieClip);
                if (otherItem != item){
                    if (otherItem.iSel){
                        otherItem.gotoAndPlay("out2");
                    };
                    if (otherItem.iHi){
                        otherItem.gotoAndPlay("out1");
                    };
                    otherItem.iSel = false;
                    otherItem.iHi = false;
                };
                i++;
            };
            cnt.body.gotoAndStop(item.label);
        }
        function frame50(){
            playNextMode();
        }
        private function btnBackClick(e:MouseEvent):void{
            world.gotoTown("Battleon", "Enter", "Spawn");
            mcPopup.onClose();
        }
        private function updateResults():void{
            var o:Object;
            var t:int;
            o = world.PVPResults;
            t = o.team;
            if (t == world.myAvatar.dataLeaf.pvpTeam){
                cnt.outlineV.visible = true;
                cnt.outlineL.visible = false;
            }
            else {
                cnt.outlineV.visible = false;
                cnt.outlineL.visible = true;
            };
            if (world.PVPFactions.length == 0){
                cnt.ti.text = (("Team " + ["A", "B"][t]) + " won!");
            }
            else {
                cnt.ti.text = (("The " + world.PVPFactions[t].sName) + " team won!");
            };
            cnt.btnBack.addEventListener(MouseEvent.CLICK, btnBackClick, false, 0, true);
        }

    }
}//package 

