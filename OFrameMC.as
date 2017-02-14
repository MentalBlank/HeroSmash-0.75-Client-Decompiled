// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//OFrameMC

package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.geom.ColorTransform;
    import flash.text.*;

    public class OFrameMC extends MovieClip {

        public var cntMask:MovieClip;
        var hRun:int = 0;
        var mhY:int = 0;
        public var fData:Object = null;
        public var t1:MovieClip;
        public var bg:MovieClip;
        var mbD:int = 0;
        var tcnt:MovieClip;
        var dRun:int = 0;
        var mbY:int = 0;
        var world:MovieClip;
        var mc:MovieClip;
        var isOpen:Boolean = false;
        var mDown:Boolean = false;
        var uli:int;
        var rootClass:MovieClip;

        public function OFrameMC(){
            fData = null;
            isOpen = false;
            mDown = false;
            hRun = 0;
            dRun = 0;
            mbY = 0;
            mhY = 0;
            mbD = 0;
            super();
            addFrameScript(0, frame1, 4, frame5, 9, frame10);
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
        }
        private function dEF(e:Event){
            var scr:*;
            var display:*;
            var hP:*;
            var tY:*;
            scr = tcnt.scr;
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
        private function clearCnt(){
            var tcnt:*;
            tcnt = mc.getChildByName("cnt");
            if (tcnt != null){
                mc.removeChild(tcnt);
            };
        }
        private function hEF(e:Event){
            var scr:*;
            if (mDown){
                scr = tcnt.scr;
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
        public function fClose(){
            isOpen = false;
            fData = {};
            clearCnt();
            if (mc.currentLabel != "Init"){
                if (mc.currentLabel == "Idle"){
                    mc.gotoAndPlay("Close");
                }
                else {
                    mc.gotoAndStop("Init");
                };
            };
        }
        private function scrDown(e:MouseEvent){
            mbY = int(mouseY);
            mhY = int(tcnt.scr.h.y);
            mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        function frame10(){
            stop();
        }
        private function scrUp(e:MouseEvent){
            mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        private function closeClick(e:MouseEvent){
            fClose();
        }
        function frame5(){
            update();
        }
        public function fOpenWith(resObj){
            fData = resObj;
            isOpen = true;
            clearCnt();
            if (mc.currentLabel != "Idle"){
                mc.gotoAndPlay("Open");
            }
            else {
                update();
            };
        }
        public function update(){
            var strLinkage:String;
            var cntClass:Class;
            var cntMC:MovieClip;
            var itemClass:Class;
            var item:Object;
            var ind:int;
            var i:int;
            var s:String;
            var scr:MovieClip;
            var bMask:MovieClip;
            var display:MovieClip;
            clearCnt();
            ind = 0;
            i = 0;
            switch (fData.typ){
                case "userListA":
                    strLinkage = "mcUListA";
                    cntClass = (getDefinitionByName(strLinkage) as Class);
                    cntMC = (mc.addChild(new (cntClass)()) as MovieClip);
                    cntMC.name = "cnt";
                    cntMC.x = t1.x;
                    cntMC.y = ((t1.y + t1.height) + 4);
                    cntMC.mask = cntMask;
                    cntMC.scr.buttonMode = true;
                    t1.txtTitle.text = "Users in your area";
                    t1.txtSubTitle.text = "/who";
                    ind = 0;
                    tcnt = MovieClip(mc.getChildByName("cnt"));
                    tcnt.strMeta.text = "Class";
                    for (s in fData.ul) {
                        itemClass = (tcnt.cnt.iproto.constructor as Class);
                        item = tcnt.cnt.addChild(new (itemClass)());
                        item.ID = fData.ul[s].ID;
                        item.txtName.text = fData.ul[s].sName;
                        item.txtMeta.text = fData.ul[s].sClass;
                        item.txtLevel.text = fData.ul[s].iLvl;
                        item.addEventListener(MouseEvent.CLICK, uNameClick, false, 0, true);
                        item.buttonMode = true;
                        item.y = (ind * 20);
                        ind++;
                    };
                    scr = tcnt.scr;
                    if (tcnt.cnt.height < tcnt.cntMask.height){
                        scr.visible = false;
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.cntMask.width / 2)));
                    }
                    else {
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.width / 2)));
                        bMask = tcnt.cntMask;
                        display = tcnt.cnt;
                        scr.visible = true;
                        scr.h.height = int(((bMask.height / display.height) * scr.b.height));
                        hRun = (scr.b.height - scr.h.height);
                        dRun = ((display.height - bMask.height) + 5);
                        scr.h.y = 0;
                        display.oy = (display.y = scr.y);
                        scr.visible = false;
                        scr.hit.alpha = 0;
                        mDown = false;
                        if (display.height > scr.b.height){
                            scr.visible = true;
                            scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                            scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                            display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
                        };
                    };
                    tcnt.cnt.iproto.visible = false;
                    break;
                case "userListFriends":
                    strLinkage = "mcUListA";
                    cntClass = (getDefinitionByName(strLinkage) as Class);
                    cntMC = (mc.addChild(new (cntClass)()) as MovieClip);
                    cntMC.name = "cnt";
                    cntMC.x = t1.x;
                    cntMC.y = ((t1.y + t1.height) + 4);
                    cntMC.mask = cntMask;
                    cntMC.scr.buttonMode = true;
                    t1.txtTitle.text = "Friends List";
                    t1.txtSubTitle.text = "/friends";
                    ind = 0;
                    tcnt = MovieClip(mc.getChildByName("cnt"));
                    tcnt.strMeta.text = "Server";
                    i = 0;
                    while (i < fData.ul.length) {
                        itemClass = (tcnt.cnt.iproto.constructor as Class);
                        item = tcnt.cnt.addChild(new (itemClass)());
                        item.ID = fData.ul[i].ID;
                        item.txtName.text = fData.ul[i].sName;
                        item.txtMeta.text = fData.ul[i].sServer;
                        item.txtLevel.text = fData.ul[i].iLvl;
                        item.addEventListener(MouseEvent.CLICK, uNameClick, false, 0, true);
                        item.buttonMode = true;
                        item.y = (ind * 20);
                        ind++;
                        if (fData.ul[i].sServer == "Offline"){
                            item.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -100, -100, -100, 0);
                        };
                        i++;
                    };
                    scr = tcnt.scr;
                    if (tcnt.cnt.height < tcnt.cntMask.height){
                        scr.visible = false;
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.cntMask.width / 2)));
                    }
                    else {
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.width / 2)));
                        bMask = tcnt.cntMask;
                        display = tcnt.cnt;
                        scr.visible = true;
                        scr.h.height = int(((bMask.height / display.height) * scr.b.height));
                        hRun = (scr.b.height - scr.h.height);
                        dRun = ((display.height - bMask.height) + 5);
                        scr.h.y = 0;
                        display.oy = (display.y = scr.y);
                        scr.visible = false;
                        scr.hit.alpha = 0;
                        mDown = false;
                        if (display.height > scr.b.height){
                            scr.visible = true;
                            scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                            scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                            display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
                        };
                    };
                    tcnt.cnt.iproto.visible = false;
                    break;
                case "userListIgnore":
                    strLinkage = "mcUListB";
                    cntClass = (getDefinitionByName(strLinkage) as Class);
                    cntMC = (mc.addChild(new (cntClass)()) as MovieClip);
                    cntMC.name = "cnt";
                    cntMC.x = 10;
                    cntMC.y = ((t1.y + t1.height) + 4);
                    cntMC.mask = cntMask;
                    cntMC.scr.buttonMode = true;
                    t1.txtTitle.text = "Ignore List";
                    t1.txtSubTitle.text = "";
                    ind = 0;
                    tcnt = MovieClip(mc.getChildByName("cnt"));
                    fData.ul = [];
                    for each (s in rootClass.chatF.ignoreList.data.users) {
                        fData.ul.push({sName:s});
                    };
                    i = 0;
                    while (i < fData.ul.length) {
                        itemClass = (tcnt.cnt.iproto.constructor as Class);
                        item = tcnt.cnt.addChild(new (itemClass)());
                        item.txtName.text = fData.ul[i].sName;
                        item.addEventListener(MouseEvent.CLICK, uNameClick, false, 0, true);
                        item.buttonMode = true;
                        item.y = (ind * 20);
                        ind++;
                        i++;
                    };
                    scr = tcnt.scr;
                    if (tcnt.cnt.height < tcnt.cntMask.height){
                        scr.visible = false;
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.cntMask.width / 2)));
                    }
                    else {
                        cntMC.x = int(((mc.bg.x + (mc.bg.width / 2)) - (cntMC.width / 2)));
                        bMask = tcnt.cntMask;
                        display = tcnt.cnt;
                        scr.visible = true;
                        scr.h.height = int(((bMask.height / display.height) * scr.b.height));
                        hRun = (scr.b.height - scr.h.height);
                        dRun = ((display.height - bMask.height) + 5);
                        scr.h.y = 0;
                        display.oy = (display.y = scr.y);
                        scr.visible = false;
                        scr.hit.alpha = 0;
                        mDown = false;
                        if (display.height > scr.b.height){
                            scr.visible = true;
                            scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                            scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                            display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
                        };
                    };
                    tcnt.cnt.iproto.visible = false;
                    break;
            };
            mc.bg.btnClose.addEventListener(MouseEvent.CLICK, closeClick, false, 0, true);
            mc.bg.fx.visible = false;
        }
        private function uNameClick(e:MouseEvent){
            var ti:*;
            var params:*;
            ti = MovieClip(e.currentTarget);
            params = {};
            if (("ID" in ti)){
                params.ID = ti.ID;
            };
            params.strUsername = ti.txtName.text;
            if ((((fData.typ == "userListFriends")) && (!((ti.txtMeta.text == rootClass.objServerInfo.sName))))){
                rootClass.ui.cMenu.fOpenWith("offline", params);
            }
            else {
                if (fData.typ == "userListIgnore"){
                    rootClass.ui.cMenu.fOpenWith("ignored", params);
                }
                else {
                    rootClass.ui.cMenu.fOpenWith("user", params);
                };
            };
        }
        function frame1(){
            stop();
        }

    }
}//package 

