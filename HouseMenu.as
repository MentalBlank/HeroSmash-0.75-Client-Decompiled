// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//HouseMenu

package {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.filters.GlowFilter;
    import flash.text.*;

    public class HouseMenu extends MovieClip {

        var mhY:int = 0;
        public var tTitle:MovieClip;
        public var bg:MovieClip;
        public var iListB:MovieClip;
        public var toolsBtm:MovieClip;
        public var iListA:MovieClip;
        var mDown:Boolean = false;
        public var fxmask:MovieClip;
        var scrTgt:MovieClip;
        public var btnClose:SimpleButton;
        var hRun:int = 0;
        public var txtWarning:TextField;
        var moy:int = 0;
        var mox:int = 0;
        public var fData:Object = null;
        var mbD:int = 0;
        var mbY:int = 0;
        public var toolsBG:MovieClip;
        var dRun:int = 0;
        public var world:MovieClip;
        public var hit:MovieClip;
        public var btnJoin:MovieClip;
        public var rootClass:MovieClip;
        public var CHARS:MovieClip;
        public var preview:MovieClip;
        var ox:int = 0;
        var oy:int = 0;
        public var btnSave:MovieClip;

        public function HouseMenu():void{
            var mc:MovieClip;
            fData = null;
            mDown = false;
            hRun = 0;
            dRun = 0;
            mbY = 0;
            mhY = 0;
            mbD = 0;
            ox = 0;
            oy = 0;
            mox = 0;
            moy = 0;
            super();
            mc = (this as MovieClip);
            mc.tTitle.mouseEnabled = false;
            mc.preview.tPreview.mouseEnabled = false;
            mc.hit.alpha = 0;
            mc.hit.buttonMode = true;
        }
        public function dEF(e:Event){
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
        public function scrUp(e:MouseEvent){
            scrTgt.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        public function onHouseMenuBGRelease(e:MouseEvent):void{
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, onHouseMenuBGRelease);
        }
        public function onHouseMenuItemClick(e:MouseEvent):void{
            var imc:MovieClip;
            var cmc:MovieClip;
            var parMC:MovieClip;
            var mc:MovieClip;
            var item:Object;
            var i:int;
            var s:String;
            imc = (e.currentTarget as MovieClip);
            parMC = (imc.parent as MovieClip);
            mc = (this as MovieClip);
            i = 0;
            s = "";
            if (imc.typ == "A"){
                i = 0;
                while (i < parMC.numChildren) {
                    MovieClip(parMC.getChildAt(i)).bg.visible = false;
                    i++;
                };
                imc.bg.visible = true;
                buildItemList(fData[imc.val], "B", MovieClip(imc.parent));
            };
            if (imc.typ == "B"){
                i = 1;
                while (i < parMC.numChildren) {
                    cmc = (parMC.getChildAt(i) as MovieClip);
                    cmc.iSel = false;
                    i++;
                };
                imc.iSel = true;
                refreshIListB();
                item = imc.val;
                world.loadHouseItemB(item);
                resizeMe();
            };
        }
        public function showEditMenu():void{
            var mc:MovieClip;
            mc = MovieClip(this);
            buildHouseMenu();
            mc.visible = true;
            mc.y = int((280 - (mc.bg.height / 2)));
            mc.x = int((480 - (mc.bg.width / 2)));
        }
        public function onHouseMenuBGClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.mDown = true;
            mc.ox = mc.x;
            mc.oy = mc.y;
            mc.mox = stage.mouseX;
            mc.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP, onHouseMenuBGRelease, false, 0, true);
        }
        private function destroyIList(lmc:MovieClip):void{
            var child:MovieClip;
            while (lmc.iList.numChildren > 1) {
                child = lmc.iList.getChildAt(1);
                child.removeEventListener(MouseEvent.CLICK, onHouseMenuItemClick);
                child.removeEventListener(MouseEvent.MOUSE_OVER, onHouseMenuItemMouseOver);
                delete child.val;
                lmc.iList.removeChildAt(1);
            };
            lmc.scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN, scrDown);
            lmc.scr.h.removeEventListener(Event.ENTER_FRAME, hEF);
            lmc.iList.removeEventListener(Event.ENTER_FRAME, dEF);
        }
        public function buildItemList(list:Array, typ:String, par:MovieClip):void{
            var i:int;
            var mc:MovieClip;
            var lmc:MovieClip;
            var item:MovieClip;
            var itemC:Class;
            var s:String;
            var ok:Boolean;
            var w:int;
            var scr:MovieClip;
            var bMask:MovieClip;
            var display:MovieClip;
            i = 0;
            mc = (this as MovieClip);
            s = "";
            ok = true;
            w = 90;
            mc.preview.cnt.visible = false;
            mc.preview.t2.visible = false;
            mc.preview.bAdd.visible = false;
            mc.preview.tPreview.visible = false;
            if (typ == "A"){
                mc.iListB.visible = false;
                lmc = mc.iListA;
                destroyIList(lmc);
                lmc.par = par;
                i = 0;
                while (i < list.length) {
                    itemC = (lmc.iList.iproto.constructor as Class);
                    item = lmc.iList.addChild(new (itemC)());
                    item.ti.autoSize = "left";
                    item.ti.text = String(list[i]);
                    if (item.ti.textWidth > w){
                        w = int(item.ti.textWidth);
                    };
                    item.hit.alpha = 0;
                    item.typ = typ;
                    item.val = list[i];
                    item.iSel = false;
                    item.addEventListener(MouseEvent.CLICK, onHouseMenuItemClick, false, 0, true);
                    item.addEventListener(MouseEvent.MOUSE_OVER, onHouseMenuItemMouseOver, false, 0, true);
                    item.y = (lmc.iList.iproto.y + (i * 16));
                    item.bg.visible = false;
                    item.buttonMode = true;
                    i++;
                };
                lmc.iList.iproto.visible = false;
                lmc.iList.y = ((lmc.imask.height / 2) - (lmc.iList.height / 2));
            }
            else {
                if (typ == "B"){
                    mc.iListB.visible = true;
                    lmc = mc.iListB;
                    destroyIList(lmc);
                    lmc.par = par;
                    i = 0;
                    while (i < list.length) {
                        itemC = (lmc.iList.iproto.constructor as Class);
                        item = lmc.iList.addChild(new (itemC)());
                        item.ti.autoSize = "left";
                        item.ti.text = String(list[i].sName);
                        if (item.ti.textWidth > w){
                            w = int(item.ti.textWidth);
                        };
                        item.hit.alpha = 0;
                        item.typ = typ;
                        item.val = list[i];
                        item.iSel = false;
                        item.addEventListener(MouseEvent.CLICK, onHouseMenuItemClick, false, 0, true);
                        item.addEventListener(MouseEvent.MOUSE_OVER, onHouseMenuItemMouseOver, false, 0, true);
                        item.y = (lmc.iList.iproto.y + (i * 16));
                        item.bg.visible = (item.val.bEquip == 1);
                        item.buttonMode = true;
                        i++;
                    };
                    lmc.iList.iproto.visible = false;
                    lmc.x = ((lmc.par.x + lmc.par.width) + 1);
                    lmc.iList.y = ((lmc.imask.height / 2) - (lmc.iList.height / 2));
                };
            };
            w = (w + 7);
            i = 1;
            while (i < lmc.iList.numChildren) {
                item = (lmc.iList.getChildAt(i) as MovieClip);
                item.bg.width = w;
                item.hit.width = w;
                i++;
            };
            scr = lmc.scr;
            bMask = lmc.imask;
            display = lmc.iList;
            scr.h.y = 0;
            scr.visible = false;
            scr.hit.alpha = 0;
            scr.mDown = false;
            if (display.height > scr.b.height){
                scr.h.height = int(((scr.b.height / display.height) * scr.b.height));
                hRun = (scr.b.height - scr.h.height);
                dRun = ((display.height - scr.b.height) + 10);
                display.oy = (display.y = bMask.y);
                scr.visible = true;
                scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
            }
            else {
                scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN, scrDown);
                scr.h.removeEventListener(Event.ENTER_FRAME, hEF);
                display.removeEventListener(Event.ENTER_FRAME, dEF);
            };
            lmc.imask.width = (w - 1);
            lmc.divider.x = w;
            lmc.scr.x = w;
            if (lmc.scr.visible){
                lmc.w = (w + lmc.scr.width);
            }
            else {
                lmc.w = (w + 1);
            };
            resizeMe();
        }
        public function hEF(e:Event){
            var scr:*;
            if (MovieClip(e.currentTarget.parent).mDown){
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
        public function onHandleMoveClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = rootClass.ui.mcPopup.mcHouseItemHandle;
            mc.mDown = true;
            mc.ox = mc.x;
            mc.oy = mc.y;
            mc.mox = stage.mouseX;
            mc.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP, onHandleMoveRelease, false, 0, true);
        }
        public function onItemAddClick(e:MouseEvent):void{
            var item:Object;
            var placeX:*;
            var floorY:*;
            var wallY:*;
            var ay:int;
            item = MovieClip(e.currentTarget.parent).item;
            if (int(item.bEquip) != 1){
                if ((((item.bUpg == 1)) && (!(rootClass.world.myAvatar.isUpgraded())))){
                    rootClass.showUpgradeWindow();
                }
                else {
                    if (item.sType == "House"){
                        world.equipHouse(item);
                    }
                    else {
                        item.bEquip = 1;
                        refreshIListB();
                        placeX = (480 + Math.abs(world.map.cell.x));
                        floorY = (300 + Math.abs(world.map.cell.y));
                        wallY = (150 + Math.abs(world.map.cell.y));
                        ay = (((item.sType.toLowerCase().indexOf("wall"))>-1) ? wallY : floorY);
                        world.loadHouseItem(item, placeX, ay);
                    };
                };
            };
        }
        public function onHouseMenuBGEnterFrame(e:Event){
            var mc:MovieClip;
            mc = (e.currentTarget.parent as MovieClip);
            if (mc.visible){
                if (mc.mDown){
                    mc.x = (mc.ox + (stage.mouseX - mc.mox));
                    mc.y = (mc.oy + (stage.mouseY - mc.moy));
                    if (mc.x < 0){
                        mc.x = 0;
                    };
                    if ((mc.x + mc.bg.width) > 960){
                        mc.x = (960 - mc.bg.width);
                    };
                    if (mc.y < 0){
                        mc.y = 0;
                    };
                    if ((mc.y + mc.bg.height) > 495){
                        mc.y = (495 - mc.bg.height);
                    };
                };
            };
        }
        public function fClose(e:MouseEvent=null):void{
            var mc:MovieClip;
            var mcp:MovieClip;
            var h:MovieClip;
            hideItemHandle();
            mc = MovieClip(this);
            mcp = MovieClip(rootClass.ui.mcPopup);
            h = MovieClip(this.parent).mcHouseItemHandle;
            h.removeEventListener(Event.ENTER_FRAME, onHandleEnterFrame);
            h.bCancel.removeEventListener(MouseEvent.CLICK, onHandleCancelClick);
            h.bDelete.removeEventListener(MouseEvent.CLICK, onHandleDeleteClick);
            h.frame.removeEventListener(MouseEvent.MOUSE_DOWN, onHandleMoveClick);
            mc.btnSave.removeEventListener(MouseEvent.CLICK, world.onHouseOptionsSaveClick);
            mc.btnJoin.removeEventListener(MouseEvent.CLICK, onJoinClick);
            mc.preview.bAdd.removeEventListener(MouseEvent.CLICK, onItemAddClick);
            mc.btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClick);
            mc.bg.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseMenuBGClick);
            mc.bg.removeEventListener(Event.ENTER_FRAME, onHouseMenuBGEnterFrame);
            mc.hit.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseMenuBGClick);
            mc.hit.removeEventListener(Event.ENTER_FRAME, onHouseMenuBGEnterFrame);
            mc.btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClick);
            destroyIList(mc.iListA);
            destroyIList(mc.iListB);
            mc.visible = false;
            MovieClip(parent).gotoAndStop("Init");
            stage.focus = stage;
        }
        private function refreshIListB():void{
            var mc:MovieClip;
            var i:int;
            var imc:MovieClip;
            mc = MovieClip(this).iListB.iList;
            i = 1;
            while (i < mc.numChildren) {
                imc = (mc.getChildAt(i) as MovieClip);
                if (imc.val != null){
                    imc.bg.visible = false;
                    if (imc.iSel){
                        imc.bg.visible = true;
                        imc.bg.alpha = 0.5;
                    };
                    if (int(imc.val.bEquip) == 1){
                        imc.bg.visible = true;
                        imc.bg.alpha = 1;
                    };
                };
                i++;
            };
        }
        public function onHandleDeleteClick(e:MouseEvent):void{
            var mc:MovieClip;
            var itemClip:MovieClip;
            rootClass.mixer.playSound("Click");
            mc = rootClass.ui.mcPopup.mcHouseItemHandle;
            itemClip = mc.tgt;
            itemClip.item.bEquip = 0;
            refreshIListB();
            delete itemClip.item;
            delete itemClip.ItemID;
            itemClip.removeEventListener(Event.ENTER_FRAME, world.onHouseItemEnterFrame);
            itemClip.parent.removeChild(itemClip);
            hideItemHandle();
        }
        public function showMsg(msg:String, color:String=null){
            var txtPos:int;
            if (msg != null){
                txtWarning.htmlText = "";
                switch (color){
                    case "Red":
                        txtWarning.htmlText = (("<font color='#990000'>" + msg) + "</font>");
                        break;
                    case "Yellow":
                        txtWarning.htmlText = (("<font color='#FFCC00'>" + msg) + "</font>");
                        break;
                    case "Green":
                        txtWarning.htmlText = (("<font color='#99CC00'>" + msg) + "</font>");
                        break;
                    default:
                        txtWarning.htmlText = (("<font color='#FFFFFF'>" + msg) + "</font>");
                };
                txtWarning.visible = true;
                if (btnJoin.visible){
                    if (btnSave.visible){
                        txtPos = (btnSave.y + btnSave.height);
                    }
                    else {
                        txtPos = (btnJoin.y + btnJoin.height);
                    };
                }
                else {
                    if (btnSave.visible){
                        txtPos = (btnSave.y + btnSave.height);
                    }
                    else {
                        txtPos = btnJoin.y;
                    };
                };
                txtWarning.y = txtPos;
            };
            resizeTools();
        }
        public function onJoinClick(evt:MouseEvent){
            rootClass.world.gotoHouse(rootClass.sfc.myUserName);
        }
        public function previewHouseItem(obj:Object):void{
            var s:String;
            var itemC:Class;
            var mc:MovieClip;
            var sizeX:*;
            var sizeY:*;
            var cntMidX:*;
            var cntMidY:*;
            var item:MovieClip;
            var scaleFactor:*;
            var rect:*;
            var itemMidX:*;
            var itemMidY:*;
            if (obj.item.sType == "House"){
                s = (obj.item.sFile.substr(0, -4).substr((obj.item.sFile.lastIndexOf("/") + 1)).split("-").join("_") + "_preview");
            }
            else {
                s = obj.item.sLink;
            };
            itemC = (world.loaderD.getDefinition(s) as Class);
            mc = (MovieClip(this).preview.cnt as MovieClip);
            sizeX = 130;
            sizeY = 113;
            cntMidX = (sizeX / 2);
            cntMidY = (sizeY / 2);
            if (mc.numChildren > 0){
                mc.removeChildAt(0);
            };
            item = (mc.addChild(new (itemC)()) as MovieClip);
            scaleFactor = (sizeX / item.width);
            if (item.height > item.width){
                scaleFactor = (sizeY / item.height);
            };
            item.scaleX = scaleFactor;
            item.scaleY = scaleFactor;
            rect = item.getBounds(mc);
            itemMidX = (rect.x + (item.width / 2));
            itemMidY = (rect.y + (item.height / 2));
            item.x = (cntMidX - itemMidX);
            item.y = (cntMidY - itemMidY);
            item.ItemID = obj.item.ItemID;
            MovieClip(this).preview.item = obj.item;
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).preview.cnt.visible = true;
        }
        public function resizeMe(){
            var mc:MovieClip;
            var minWidth:*;
            mc = MovieClip(this);
            if (mc.iListA.visible){
                mc.bg.width = ((mc.iListA.x + mc.iListA.w) + 5);
            };
            if (mc.iListB.visible){
                mc.iListB.x = ((mc.iListA.x + mc.iListA.w) + 1);
                mc.bg.width = (mc.bg.width + (mc.iListB.w + 1));
                mc.iListA.divider.visible = !(mc.iListA.scr.visible);
            }
            else {
                mc.iListA.divider.visible = false;
            };
            if (((mc.preview.t2.visible) || (mc.preview.cnt.visible))){
                mc.preview.x = ((mc.iListB.x + mc.iListB.w) + 4);
                mc.bg.width = (mc.bg.width + (mc.preview.width + 4));
                mc.iListB.divider.visible = !(mc.iListB.scr.visible);
            }
            else {
                mc.iListB.divider.visible = false;
            };
            minWidth = ((((mc.tTitle.x + tTitle.width) + 4) + mc.btnClose.width) + 4);
            if (mc.bg.width < minWidth){
                mc.bg.width = minWidth;
            };
            mc.btnClose.x = (mc.bg.width - 19);
            mc.fxmask.width = mc.bg.width;
            if (mc.x < 0){
                mc.x = 0;
            };
            if ((mc.x + mc.bg.width) > 960){
                mc.x = (960 - mc.bg.width);
            };
            if (mc.y < 0){
                mc.y = 0;
            };
            if ((mc.y + mc.bg.height) > 495){
                mc.y = (495 - mc.bg.height);
            };
        }
        public function drawItemHandle(mc:MovieClip):void{
            var h:MovieClip;
            var r:Rectangle;
            var tgtPt:Point;
            h = (MovieClip(this.parent).mcHouseItemHandle as MovieClip);
            h.visible = true;
            r = mc.getBounds(stage);
            h.frame.width = (((r.width)>50) ? r.width : 50);
            h.frame.height = (((r.height)>50) ? r.height : 50);
            h.bCancel.x = ((h.frame.width - h.bCancel.width) - 4);
            h.bDelete.x = ((h.bCancel.x - h.bDelete.width) - 4);
            tgtPt = mc.parent.localToGlobal(new Point(mc.x, mc.y));
            h.tgtOffsetX = (tgtPt.x - r.x);
            h.tgtOffsetY = (tgtPt.y - r.y);
            h.x = ((r.x + (r.width / 2)) - (h.frame.width / 2));
            h.y = ((r.y + (r.height / 2)) - (h.frame.height / 2));
            if (h.tgt != null){
                h.tgt.filters = [];
            };
            h.tgt = mc;
            h.tgt.filters = [new GlowFilter(0xFFFFFF, 1, 8, 8, 2, 2)];
        }
        public function resizeTools(){
            var addSize:*;
            var bgSize:*;
            addSize = 5;
            bgSize = 0;
            if (btnJoin.visible == true){
                bgSize = (bgSize + btnJoin.height);
            };
            if (btnSave.visible == true){
                bgSize = (bgSize + btnSave.height);
            };
            if (txtWarning.visible == true){
                bgSize = (bgSize + txtWarning.height);
            };
            toolsBG.height = (bgSize + addSize);
            toolsBtm.y = ((toolsBG.y + toolsBG.height) - 1);
        }
        public function onHandleMoveRelease(e:MouseEvent):void{
            var mc:MovieClip;
            mc = rootClass.ui.mcPopup.mcHouseItemHandle;
            mc.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, onHandleMoveRelease);
            world.houseItemValidate(MovieClip(mc.tgt));
        }
        public function onHouseMenuItemMouseOver(e:MouseEvent):void{
            var mc:MovieClip;
            var item:MovieClip;
            var i:int;
            mc = MovieClip(e.currentTarget);
            i = 1;
            while (i < mc.parent.numChildren) {
                item = MovieClip(mc.parent.getChildAt(i));
                if (item.bg.alpha < 0.4){
                    item.bg.visible = false;
                };
                i++;
            };
            if (!mc.bg.visible){
                mc.bg.visible = true;
                mc.bg.alpha = 0.33;
            };
        }
        public function onHandleEnterFrame(e:Event){
            var mc:MovieClip;
            var r:Rectangle;
            mc = (e.currentTarget as MovieClip);
            if (mc.visible){
                if (mc.mDown){
                    mc.x = (mc.ox + (stage.mouseX - mc.mox));
                    mc.y = (mc.oy + (stage.mouseY - mc.moy));
                    if ((mc.x + (mc.frame.width / 2)) < 0){
                        mc.x = -(int((mc.frame.width / 2)));
                    };
                    if ((mc.x + (mc.frame.width / 2)) > 960){
                        mc.x = int((960 - (mc.frame.width / 2)));
                    };
                    if ((mc.y + (mc.frame.height / 2)) < 0){
                        mc.y = -(int((mc.frame.height / 2)));
                    };
                    if ((mc.y + (mc.frame.height / 2)) > 495){
                        mc.y = int((495 - (mc.frame.height / 2)));
                    };
                    mc.tgt.x = ((mc.x + -(world.map.cell.x)) + mc.tgtOffsetX);
                    mc.tgt.y = ((mc.y + -(world.map.cell.y)) + mc.tgtOffsetY);
                }
                else {
                    r = mc.tgt.getBounds(stage);
                    mc.x = ((r.x + (r.width / 2)) - (mc.frame.width / 2));
                    mc.y = ((r.y + (r.height / 2)) - (mc.frame.height / 2));
                };
            };
        }
        public function onHandleCancelClick(e:MouseEvent=null):void{
            var mc:MovieClip;
            mc = rootClass.ui.mcPopup.mcHouseItemHandle;
            if (mc.tgt != null){
                mc.tgt.filters = [];
            };
            mc.tgt = null;
            mc.x = 1000;
            mc.visible = false;
        }
        public function fOpen(mode:String):void{
            var h:MovieClip;
            var mc:MovieClip;
            rootClass = (stage.getChildAt(0) as MovieClip);
            world = (rootClass.world as MovieClip);
            CHARS = (rootClass.world.CHARS as MovieClip);
            h = MovieClip(this.parent).mcHouseItemHandle;
            h.visible = false;
            h.x = 1000;
            h.addEventListener(Event.ENTER_FRAME, onHandleEnterFrame, false, 0, true);
            h.bCancel.addEventListener(MouseEvent.CLICK, onHandleCancelClick, false, 0, true);
            h.bDelete.addEventListener(MouseEvent.CLICK, onHandleDeleteClick, false, 0, true);
            h.frame.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMoveClick, false, 0, true);
            h.bCancel.buttonMode = true;
            h.bDelete.buttonMode = true;
            mc = (this as MovieClip);
            mc.preview.bAdd.buttonMode = true;
            mc.preview.t2.mouseEnabled = false;
            mc.preview.bAdd.addEventListener(MouseEvent.CLICK, onItemAddClick, false, 0, true);
            mc.btnClose.addEventListener(MouseEvent.CLICK, btnCloseClick, false, 0, true);
            mc.bg.addEventListener(MouseEvent.MOUSE_DOWN, onHouseMenuBGClick, false, 0, true);
            mc.bg.addEventListener(Event.ENTER_FRAME, onHouseMenuBGEnterFrame, false, 0, true);
            mc.hit.addEventListener(MouseEvent.MOUSE_DOWN, onHouseMenuBGClick, false, 0, true);
            mc.hit.addEventListener(Event.ENTER_FRAME, onHouseMenuBGEnterFrame, false, 0, true);
            if (rootClass.world.isHouseEquipped()){
                if (rootClass.world.isMyHouse()){
                    btnJoin.visible = false;
                    txtWarning.visible = false;
                    btnSave.addEventListener(MouseEvent.CLICK, world.onHouseOptionsSaveClick, false, 0, true);
                    btnSave.x = btnJoin.x;
                    btnSave.y = btnJoin.y;
                    btnSave.visible = true;
                    resizeTools();
                }
                else {
                    btnJoin.txtTitle.text = "Go to your House";
                    btnSave.visible = false;
                    txtWarning.visible = false;
                    btnJoin.addEventListener(MouseEvent.CLICK, onJoinClick, false, 0, true);
                    btnJoin.visible = true;
                    resizeTools();
                };
            }
            else {
                txtWarning.x = btnJoin.x;
                txtWarning.y = btnJoin.y;
                showMsg("You need to equip a house.", "Yellow");
                btnJoin.visible = false;
                btnSave.visible = false;
                resizeTools();
            };
            showEditMenu();
            mc.visible = true;
        }
        public function buildHouseMenu():void{
            var i:int;
            var o:Object;
            var mc:MovieClip;
            var item:Object;
            var s:String;
            var a:Array;
            var ok:Boolean;
            var list:Array;
            var j:int;
            i = 0;
            o = {};
            mc = (this as MovieClip);
            item = {};
            s = "";
            a = [];
            ok = true;
            trace("build house Item-----------!");
            trace((world + "-world House Items----------------------"));
            i = 0;
            while (i < world.houseitems.length) {
                ok = true;
                item = world.houseitems[i];
                s = item.sType;
                if (!(s in o)){
                    o[s] = [];
                };
                a = o[s];
                j = 0;
                while (j < a.length) {
                    if (a[j].ItemID == item.ItemID){
                        ok = false;
                    };
                    j++;
                };
                if (ok){
                    a.push(item);
                };
                i++;
            };
            for (s in o) {
                o[s].sortOn("sName");
            };
            fData = o;
            list = [];
            for (s in o) {
                list.push(s);
            };
            list.sort(rootClass.arraySort);
            buildItemList(list, "A", mc);
            if (list.length == 0){
                showMsg("You need to buy a House.", "Red");
            };
        }
        public function scrDown(e:MouseEvent){
            mbY = int(mouseY);
            mhY = int(MovieClip(e.currentTarget.parent).h.y);
            scrTgt = MovieClip(e.currentTarget.parent);
            scrTgt.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, scrUp, false, 0, true);
        }
        public function hideEditMenu():void{
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.visible = false;
            mc.x = 1000;
            stage.focus = stage;
            onHandleCancelClick();
        }
        public function btnCloseClick(e:MouseEvent=null):void{
            rootClass.mixer.playSound("Click");
            fClose();
        }
        public function hideItemHandle():void{
            var h:MovieClip;
            h = (MovieClip(this.parent).mcHouseItemHandle as MovieClip);
            h.visible = false;
            h.x = 1000;
            if (h.tgt != null){
                h.tgt.filters = [];
            };
            h.tgt = null;
        }

    }
}//package 

