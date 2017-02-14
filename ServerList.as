// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ServerList

package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;

    public class ServerList extends MovieClip {

        public var liveLink:MovieClip;
        public var legend:MovieClip;
        private var hRun:int = 0;
        private var moy:int = 0;
        private var mhY:int = 0;
        private var mox:int = 0;
        public var l1:MovieClip;
        public var bg:MovieClip;
        private var mbD:int = 0;
        private var mbY:int = 0;
        public var l2:MovieClip;
        private var dRun:int = 0;
        public var uCount:MovieClip;
        public var iList:MovieClip;
        private var iCap:int = 0;
        private var mDown:Boolean = false;
        private var blackCT:ColorTransform;
        private var whiteListA:Array;
        private var whiteListB:Array;
        private var rootClass:MovieClip;
        private var objLogin:Object;
        private var scrTgt:MovieClip;
        private var ox:int = 0;
        private var arrServers:Array;
        private var oy:int = 0;

        public function ServerList(){
            var iTotal:int;
            var i:* = undefined;
            var bgh:int;
            var ts:String;
            var itemClass:Class;
            var server:MovieClip;
            var n:int;
            blackCT = new ColorTransform();
            iCap = 0;
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
            whiteListA = ["127.0.0.1", "74.53.7.201"];
            whiteListB = ["74.53.7.201"];
            super();
            addFrameScript(0, frame1, 1, frame2);
            visible = false;
            rootClass = MovieClip(root);
            objLogin = rootClass.objLogin;
            if (objLogin.iAccess >= 70){
                arrServers = whiteList(objLogin.servers, []);
            }
            else {
                if (Game.bPTR){
                    if (objLogin.iAccess >= 40){
                        arrServers = whiteList(objLogin.servers, whiteListA);
                    }
                    else {
                        arrServers = whiteList(objLogin.servers, whiteListB);
                    };
                    liveLink.alpha = 100;
                }
                else {
                    arrServers = whiteList(objLogin.servers, []);
                };
            };
            rootClass.serialCmd.servers = objLogin.servers;
            iTotal = 0;
            blackCT.color = 0;
            i = 0;
            while (i < arrServers.length) {
                itemClass = (iList.iProto.constructor as Class);
                server = (iList.addChildAt(new (itemClass)(), 0) as MovieClip);
                server.ttStr = "";
                if ((i % 2) > 0){
                    server.x = 286;
                }
                else {
                    server.x = 0;
                };
                server.y = (Math.floor((i / 2)) * 44);
                server.obj = arrServers[i];
                server.tName.ti.text = arrServers[i].sName;
                iTotal = (iTotal + int(arrServers[i].iCount));
                if (objLogin.iAccess >= 40){
                    iCap = 10000;
                }
                else {
                    if (objLogin.iUpgDays >= 0){
                        iCap = (arrServers[i].iMax + 1000);
                    }
                    else {
                        iCap = arrServers[i].iMax;
                    };
                };
                arrServers[i].iMax = iCap;
                server.iconStandard.visible = false;
                server.iconSafe.visible = false;
                server.iconLegen.visible = false;
                server.iconChat.visible = true;
                server.iconChat.nullset.visible = false;
                if (arrServers[i].bUpg == 0){
                    server.ttStr = (server.ttStr + "This is a free server. ");
                }
                else {
                    server.ttStr = (server.ttStr + "This is an upgrade-only server. ");
                    server.tName.ti.textColor = 16763955;
                };
                if (arrServers[i].iChat == 0){
                    server.iconStandard.visible = true;
                    server.iconChat.nullset.visible = true;
                    server.ttStr = (server.ttStr + "Only Canned Chat enabled.");
                }
                else {
                    if (arrServers[i].iChat == 1){
                        server.iconChat.alpha = 0.5;
                        server.ttStr = (server.ttStr + "Chat is limited.");
                    }
                    else {
                        server.ttStr = (server.ttStr + "Chat is enabled.");
                    };
                    if (arrServers[i].bUpg == 1){
                        server.iconLegen.visible = true;
                    }
                    else {
                        server.iconStandard.visible = true;
                    };
                    server.iconChat.visible = true;
                };
                n = arrServers[i].iCount;
                server.mcPop.visible = true;
                server.iconFull.visible = false;
                if (n < iCap){
                    server.mcPop.txtPopulation.text = n;
                }
                else {
                    server.mcPop.visible = false;
                    server.iconFull.visible = true;
                    server.ttStr = "Server is full.";
                };
                if (arrServers[i].bOnline == 1){
                    server.bgOff.visible = false;
                    server.iconOffline.visible = false;
                }
                else {
                    server.bgOff.visible = true;
                    server.iconOffline.visible = true;
                    server.iconStandard.visible = false;
                    server.iconSafe.visible = false;
                    server.iconLegen.visible = false;
                    server.iconChat.visible = false;
                    server.mcPop.visible = false;
                    server.tName.alpha = 0.5;
                    server.ttStr = "Server is temporarily offline.";
                };
                server.mouseChildren = false;
                server.addEventListener(MouseEvent.CLICK, onServerClick, false, 0, true);
                server.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
                server.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
                if ((((((((((arrServers[i].bOnline == 0)) || ((n >= iCap)))) || ((((arrServers[i].bUpg == 1)) && ((objLogin.iUpgDays < 0)))))) || ((((((arrServers[i].iChat > 0)) && ((objLogin.iAge < 13)))) && ((objLogin.iUpgDays < 0)))))) || ((((arrServers[i].iChat > 0)) && ((objLogin.bCCOnly == 1)))))){
                    server.buttonMode = true;
                }
                else {
                    server.mouseChildren = false;
                    server.buttonMode = true;
                };
                i = (i + 1);
            };
            iList.iProto.visible = false;
            l2.y = ((iList.y + iList.height) + 15);
            legend.y = (l2.y + (l2.height / 3));
            bgh = int(bg.height);
            bg.height = int(((l2.y + l2.height) + 9));
            bg.y = (bg.y + int(((bg.height - bgh) / 2)));
            if (liveLink.alpha > 0){
                liveLink.y = (bg.getBounds(this).bottomRight.y + 30);
                liveLink.bDefault.addEventListener(MouseEvent.CLICK, onLiveLinkClick, false, 0, true);
            }
            else {
                try {
                    removeChild(getChildByName("liveLink"));
                }
                catch(e:Error) {
                };
            };
            ts = "";
            if (iTotal > 0){
                uCount.ti.htmlText = '<font color="#FFBB3E">';
                uCount.ti.htmlText = (uCount.ti.htmlText + rootClass.strNumWithCommas(iTotal));
                uCount.ti.htmlText = (uCount.ti.htmlText + "</font>");
                uCount.t2.x = (uCount.ti.textWidth + 7);
            }
            else {
                uCount.visible = false;
            };
            MovieClip(this).y = int((275 - (MovieClip(this).height / 2)));
        }
        private function onMouseOver(e:MouseEvent){
            var mc:*;
            mc = MovieClip(e.currentTarget);
            if ((((mc.obj.bOnline > 0)) && (!((mc.frame.currentLabel == "in"))))){
                mc.frame.gotoAndPlay("in");
            };
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
        function frame2(){
            visible = true;
            stop();
        }
        public function fClose():void{
            killModals();
        }
        public function scrDown(e:MouseEvent){
            mbY = int(mouseY);
            mhY = int(MovieClip(e.currentTarget.parent).h.y);
            scrTgt = MovieClip(e.currentTarget.parent);
            scrTgt.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, scrUp, false, 0, true);
        }
        public function scrUp(e:MouseEvent){
            scrTgt.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, scrUp);
        }
        private function onMouseOut(e:MouseEvent){
            var mc:*;
            mc = MovieClip(e.currentTarget);
            if ((((mc.obj.bOnline > 0)) && ((mc.frame.currentLabel == "in")))){
                mc.frame.gotoAndPlay("out");
            };
        }
        private function killModals():void{
            var mc:MovieClip;
            var child:MovieClip;
            var i:int;
            mc = rootClass.mcLogin.ModalStack;
            i = 0;
            while (i < mc.numChildren) {
                child = (mc.getChildAt(i) as MovieClip);
                if (("fClose" in child)){
                    child.fClose();
                };
                i++;
            };
        }
        private function onServerClick(e:MouseEvent){
            var modal:ModalMC;
            var modalO:Object;
            var server:*;
            if (!rootClass.serialCmdMode){
                server = MovieClip(e.currentTarget);
                if (server.obj.bOnline == 0){
                    rootClass.MsgBox.notify("Server currently offline!");
                }
                else {
                    if (server.obj.iCount >= server.obj.iMax){
                        rootClass.MsgBox.notify("Server is Full!");
                    }
                    else {
                        if ((((server.obj.iChat > 0)) && ((objLogin.bCCOnly == 1)))){
                            rootClass.MsgBox.notify("Account Restricted to Kiddy Slag Server Only.");
                        }
                        else {
                            if ((((((server.obj.iChat > 0)) && ((objLogin.iAge < 13)))) && ((objLogin.iUpgDays < 0)))){
                                rootClass.MsgBox.notify("Ask your parent to upgrade your account in order to play on chat enabled servers.");
                            }
                            else {
                                if ((((server.obj.bUpg == 1)) && ((objLogin.iUpgDays < 0)))){
                                    modal = new ModalMC();
                                    modalO = {};
                                    modalO.strBody = "You must upgrade your account to access this server.  Do you want to upgrade your account now?";
                                    modalO.params = {};
                                    modalO.callback = onModalClickUpgrade;
                                    modalO.glow = "white,medium";
                                    modalO.btns = "dual";
                                    rootClass.mcLogin.ModalStack.addChild(modal);
                                    modal.init(modalO);
                                }
                                else {
                                    rootClass.objServerInfo = server.obj;
                                    rootClass.chatF.iChat = server.obj.iChat;
                                    fClose();
                                    rootClass.connectTo(server.obj.sIP);
                                };
                            };
                        };
                    };
                };
            };
        }
        private function onModalClickUpgrade(params:Object):void{
            if (params.accept){
                navigateToURL(new URLRequest("http://portal.battleon.com/store/packages/herosmash.asp"), "_blank");
            };
        }
        public function getServerTabByIP(passedIP:String):MovieClip{
            var mNum:*;
            var tab:*;
            var i:int;
            mNum = numChildren;
            tab = null;
            i = 0;
            while (i < mNum) {
                tab = getChildAt(i);
                if ((((((tab.constructor.toString().indexOf("MCServerItem") > -1)) && (!((MovieClip(tab).obj == null))))) && ((tab.obj.sIP == passedIP)))){
                    return (MovieClip(tab));
                };
                i++;
            };
            return (null);
        }
        private function onLiveLinkClick(e:MouseEvent){
            fClose();
            navigateToURL(new URLRequest("default.asp"), "_self");
        }
        private function whiteList(a:Array, b:Array, memberOnly:Boolean=false):Array{
            var c:Array;
            var pushOK:Boolean;
            var i:int;
            c = [];
            if (a.length > 0){
                i = 0;
                while (i < a.length) {
                    pushOK = false;
                    if ((((b.length == 0)) || ((b.indexOf(a[i].sIP) > -1)))){
                        pushOK = true;
                        if (((memberOnly) && ((rootClass.objLogin.iUpgDays < 1)))){
                            pushOK = false;
                        };
                    };
                    if (pushOK){
                        c.push(a[i]);
                    };
                    i++;
                };
            };
            return (c);
        }
        function frame1(){
            visible = false;
        }

    }
}//package 

