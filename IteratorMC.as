// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//IteratorMC

package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;

    public class IteratorMC extends MovieClip {

        public var cheats:MovieClip;
        public var serverStack:MovieClip;
        var mHiOnCT:ColorTransform;
        public var eventStack:MovieClip;
        var eventStackCenter:int;
        public var bg:MovieClip;
        var cheatArr;
        var mHiPendingCT:ColorTransform;
        public var cmd:MovieClip;
        var iCap:int = 0;
        var objLogin:Object;
        var rootClass:MovieClip;
        public var bgfx:MovieClip;

        public function IteratorMC(){
            iCap = 0;
            mHiOnCT = new ColorTransform();
            mHiPendingCT = new ColorTransform();
            cheatArr = ["/iteratortest", "/clear map", "/clear quest", "/clear item", "/clear shop", "/clear report", "/shutdownnow", "/shutdown"];
            super();
            cheats.cnt.iproto.visible = false;
            serverStack.cnt.iproto.visible = false;
            eventStack.cnt.iproto.visible = false;
            bgfx.visible = false;
            rootClass = MovieClip(root);
            rootClass.serialCmd.servers = [];
            objLogin = rootClass.objLogin;
            mHiOnCT.color = 39423;
            mHiPendingCT.color = 0xFF6600;
            eventStackCenter = eventStack.y;
            cmd.btnGo.addEventListener(MouseEvent.CLICK, submitClick, false, 0, true);
            cmd.btnGo.buttonMode = true;
            buildCheats();
            buildServers();
            initEventStack();
        }
        private function onVarDelClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget.parent as MovieClip);
            mc.btnAdd.removeEventListener(MouseEvent.CLICK, onVarAddClick);
            mc.btnDel.removeEventListener(MouseEvent.CLICK, onVarDelClick);
            delVarFromCmd(mc.t1.text, mc.t2.text, mc.t3.text);
            eventStack.cnt.removeChild(mc);
            updateEventStack();
        }
        private function buildCheats():void{
            var cnt:MovieClip;
            var iproto:*;
            var mc:MovieClip;
            var i:int;
            cnt = cheats.cnt;
            iproto = cheats.cnt.iproto.constructor;
            i = 0;
            while (i < cheatArr.length) {
                mc = (cnt.addChild(new (iproto)()) as MovieClip);
                mc.ti.text = cheatArr[i];
                mc.addEventListener(MouseEvent.CLICK, onCheatClick, false, 0, true);
                mc.buttonMode = true;
                mc.y = (cheats.cnt.iproto.y + (i * 21));
                i++;
            };
        }
        private function addToEventStack():void{
            var cnt:MovieClip;
            var iproto:MovieClip;
            var iprotoC:*;
            var item:MovieClip;
            cnt = eventStack.cnt;
            iproto = eventStack.cnt.iproto;
            iprotoC = iproto.constructor;
            item = (cnt.addChild(new (iprotoC)()) as MovieClip);
            item.btnAdd.addEventListener(MouseEvent.CLICK, onVarAddClick, false, 0, true);
            item.btnDel.addEventListener(MouseEvent.CLICK, onVarDelClick, false, 0, true);
            item.btnAdd.buttonMode = true;
            item.btnDel.buttonMode = true;
            updateEventStack();
        }
        private function initEventStack():void{
            eventStack.adder.addEventListener(MouseEvent.CLICK, onAdderClick);
            eventStack.adder.buttonMode = true;
        }
        public function serverOff(mc:MovieClip):void{
            mc.isOn = false;
            mc.mHi.visible = false;
            mc.mHi.transform.colorTransform = mHiOnCT;
        }
        private function submitClick(e:MouseEvent):void{
            var btn:*;
            btn = MovieClip(e.currentTarget);
            cmd.lastcmd.ti.text = cmd.ti.text;
            if (!rootClass.serialCmd.active){
                assignActiveServers();
                rootClass.serialCmdInit(cmd.ti.text);
            };
            if (!cmd.lastcmd.visible){
                cmd.lastcmd.visible = true;
            };
        }
        private function eventStackPos(e:Event):void{
            if (int((eventStack.y + (eventStack.height / 2))) != eventStackCenter){
                eventStack.y = (eventStack.y - (((eventStack.y - (eventStack.height / 2)) - eventStackCenter) / 4));
                if (Math.abs(((eventStack.y - (eventStack.height / 2)) - eventStackCenter)) < 1){
                    eventStack.y = int((eventStackCenter + (eventStack.height / 2)));
                };
            };
        }
        private function onVarAddClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget.parent as MovieClip);
            addVarToCmd(mc.t1.text, mc.t2.text, mc.t3.text);
        }
        private function assignActiveServers():void{
            var numC:int;
            var i:int;
            var item:MovieClip;
            numC = serverStack.cnt.numChildren;
            rootClass.serialCmd.servers = [];
            i = 0;
            while (i < numC) {
                item = (serverStack.cnt.getChildAt(i) as MovieClip);
                if (((!((item.name == "iproto"))) && (item.isOn))){
                    rootClass.serialCmd.servers.push(item.server);
                    serverPending(item);
                };
                i++;
            };
        }
        private function delVarFromCmd(r:String, n:String, v:String):void{
        }
        public function serverOn(mc:MovieClip):void{
            mc.isOn = true;
            mc.mHi.visible = true;
            mc.mHi.transform.colorTransform = mHiOnCT;
        }
        private function addVarToCmd(r:String, n:String, v:String):void{
            var cmdS:String;
            var cmdA:Array;
            var replaceCmd:Boolean;
            var varFound:Boolean;
            var vars:Array;
            var i:int;
            var params:Array;
            cmdS = cmd.ti.text;
            cmdA = cmd.ti.text.split(" ");
            replaceCmd = false;
            varFound = false;
            if ((((((cmdA.length > 2)) && ((cmdA[1].toLowerCase() == r.toLowerCase())))) && ((cmdS.indexOf("=") > -1)))){
                vars = cmdA[2].split(",");
                i = 0;
                while (i < vars.length) {
                    params = vars[i].split("=");
                    if (params[0].toLowerCase() == n.toLowerCase()){
                        varFound = true;
                        params[1] = v;
                        vars[i] = params.join("=");
                    };
                    i++;
                };
                if (!varFound){
                    vars.push(((n + "=") + v));
                };
                cmdA[2] = vars.join(",");
                cmd.ti.text = ((("/event " + r) + " ") + cmdA[2]);
            }
            else {
                cmd.ti.text = ((((("/event " + r) + " ") + n) + "=") + v);
            };
        }
        private function onAdderClick(e:MouseEvent):void{
            addToEventStack();
        }
        private function updateEventStack():void{
            var cnt:MovieClip;
            var numC:int;
            var item:DisplayObject;
            var i:int;
            cnt = eventStack.cnt;
            numC = cnt.numChildren;
            if (numC > 1){
                i = 1;
                while (i < numC) {
                    item = cnt.getChildAt(i);
                    item.y = int((i * 26));
                    i++;
                };
            };
        }
        private function onCheatClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            cmd.ti.text = mc.ti.text;
        }
        private function toggleServer(mc:MovieClip):void{
            if (mc.isOn){
                serverOff(mc);
            }
            else {
                serverOn(mc);
            };
        }
        public function getServerItemByIP(passedIP:String):MovieClip{
            var mNum:int;
            var item:MovieClip;
            var i:int;
            mNum = serverStack.cnt.numChildren;
            i = 0;
            while (i < mNum) {
                item = (serverStack.cnt.getChildAt(i) as MovieClip);
                if (((((!((item.name.toLowerCase() == "iproto"))) && (!((item.server == null))))) && ((item.server.sIP == passedIP)))){
                    return (item);
                };
                i++;
            };
            return (null);
        }
        public function serversOff(mc:MovieClip):void{
            var servers:Array;
            var i:int;
            servers = rootClass.serialCmd.servers;
            i = 0;
            while (i < servers.length) {
                mc = getServerItemByIP(servers[i].sIP);
                if (mc != null){
                    serverOff(mc);
                };
                i++;
            };
        }
        private function onServerDown(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            toggleServer(mc);
        }
        private function serverPending(mc:MovieClip):void{
            mc.mHi.visible = true;
            mc.mHi.transform.colorTransform = mHiPendingCT;
        }
        private function onServerOver(e:MouseEvent):void{
            if (e.buttonDown){
                serverOn((e.currentTarget as MovieClip));
            };
        }
        private function buildServers():void{
            var arrServers:Array;
            var iproto:*;
            var cnt:MovieClip;
            var n:int;
            var i:int;
            var server:Object;
            var item:MovieClip;
            arrServers = objLogin.servers;
            iproto = serverStack.cnt.iproto.constructor;
            cnt = serverStack.cnt;
            n = 0;
            i = 0;
            while (i < arrServers.length) {
                server = arrServers[i];
                item = (cnt.addChild(new (iproto)()) as MovieClip);
                item.t1.text = server.sName;
                item.t2.text = server.sIP;
                item.isOn = false;
                item.server = arrServers[i];
                item.name = ("i" + i);
                item.buttonMode = true;
                item.addEventListener(MouseEvent.MOUSE_DOWN, onServerDown, false, 0, true);
                item.addEventListener(MouseEvent.MOUSE_OVER, onServerOver, false, 0, true);
                item.mouseChildren = false;
                var _temp1 = n;
                n = (n + 1);
                item.y = (serverStack.cnt.iproto.y - (_temp1 * 24));
                serverOff(item);
                i++;
            };
        }

    }
}//package 

