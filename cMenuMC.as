// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//cMenuMC

package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.text.*;

    public class cMenuMC extends MovieClip {

        var fMode:String;
        var fData:Object = null;
        var iSel:Number = -1;
        public var cnt:MovieClip;
        var iHi:Number = -1;
        var world:MovieClip;
        var iCT:ColorTransform;
        var mc:MovieClip;
        var isOpen:Boolean = false;
        var rootClass:MovieClip;

        public function cMenuMC(){
            fData = null;
            isOpen = false;
            iHi = -1;
            iSel = -1;
            super();
            addFrameScript(0, frame1, 4, frame5, 9, frame10);
            mc = MovieClip(this);
            rootClass = MovieClip(stage.getChildAt(0));
            mc.cnt.iproto.visible = false;
            mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOn);
            mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
            fData = {};
            fData.params = {};
            fData.user = ["Char Page", "Whisper", "Add Friend", "Go To", "Invite", "Report", "Delete Friend", "Ignore", "Close"];
            fData.party = ["Char Page", "Whisper", "Add Friend", "Go To", "Remove", "Summon", "Promote", "Report", "Delete Friend", "Ignore", "Close"];
            fData.self = ["Char Page", "Reputation", "Leave Party", "Close"];
            fData.pvpqueue = ["Leave Queue", "Close"];
            fData.offline = ["Delete Friend", "Close"];
            fData.ignored = ["Unignore", "Close"];
            fData.cl = [];
            fData.clc = [];
        }
        public function fClose(){
            isOpen = false;
            if (mc.currentFrame != 1){
                if (mc.currentFrame == 10){
                    mc.gotoAndPlay("out");
                }
                else {
                    mc.gotoAndStop("hold");
                };
            };
        }
        private function itemClick(e:MouseEvent){
            var ti:*;
            var action:String;
            var strUsername:String;
            var _local5:String;
            var _local6:int;
            ti = MovieClip(e.currentTarget);
            iSel = int(ti.name.substr(1));
            iCT = mc.cnt.mHi.transform.colorTransform;
            iCT.color = 16763955;
            mc.cnt.mHi.transform.colorTransform = iCT;
            fClose();
            action = fData.cl[iSel];
            strUsername = fData.params.strUsername;
            switch (action.toLowerCase()){
                case "char page":
                    rootClass.mixer.playSound("Click");
                    navigateToURL(new URLRequest(("http://www.herosmash.com/hs-character.asp?id=" + strUsername)), "_blank");
                    break;
                case "reputation":
                    rootClass.mixer.playSound("Click");
                    rootClass.showFactionInterface();
                    break;
                case "whisper":
                    rootClass.chatF.openPMsg(strUsername);
                    break;
                case "ignore":
                    rootClass.chatF.ignore(strUsername);
                    rootClass.chatF.pushMsg("server", (("You are now ignoring user " + strUsername) + "."), "SERVER", "", 0);
                    break;
                case "unignore":
                    rootClass.chatF.unignore(strUsername);
                    rootClass.chatF.pushMsg("server", (("User " + strUsername) + " is no longer being ignored."), "SERVER", "", 0);
                    break;
                case "report":
                    rootClass.ui.mcPopup.fOpen("Report", {unm:strUsername});
                    break;
                case "close":
                    if ((((fMode == "user")) || ((fMode == "party")))){
                        rootClass.world.cancelTarget();
                    };
                    break;
                case "add friend":
                    if (rootClass.world.friends.length >= 30){
                        rootClass.chatF.pushMsg("server", "You are too popular! (30 friends max)", "SERVER", "", 0);
                    }
                    else {
                        rootClass.world.requestFriend(strUsername);
                    };
                    break;
                case "delete friend":
                    rootClass.world.sendDeleteFriend(fData.params.ID, strUsername);
                    break;
                case "go to":
                    rootClass.world.goto(strUsername);
                    break;
                case "invite":
                    rootClass.world.partyInvite(strUsername);
                    break;
                case "remove":
                    rootClass.world.partyKick(strUsername);
                    break;
                case "leave party":
                    rootClass.world.partyLeave();
                    break;
                case "private: on":
                case "private: off":
                    _local5 = action.toLowerCase().split(": ")[0];
                    _local6 = (((action.toLowerCase().split(": ")[1])=="on") ? 1 : 0);
                    rootClass.world.partyUpdate(_local5, _local6);
                    break;
                case "promote":
                    rootClass.world.partyPromote(strUsername);
                    break;
                case "summon":
                    rootClass.world.partySummon(strUsername);
                    break;
                case "leave queue":
                    rootClass.world.requestPVPQueue("none");
                    break;
            };
        }
        function frame10(){
            stop();
        }
        private function mouseOn(e:MouseEvent){
            MovieClip(e.currentTarget).cnt.gotoAndStop("hold");
        }
        private function mouseOut(e:MouseEvent){
            MovieClip(e.currentTarget).cnt.gotoAndPlay("out");
        }
        private function itemMouseOver(e:MouseEvent){
            var ti:*;
            var i:int;
            var item:*;
            ti = MovieClip(e.currentTarget);
            iHi = int(ti.name.substr(1));
            i = 0;
            i = 0;
            while (i < fData.cl.length) {
                item = mc.cnt.getChildByName(("i" + i));
                iCT = item.transform.colorTransform;
                if (i == iHi){
                    if (ti.hasEventListener(MouseEvent.CLICK)){
                        iCT.color = 0xFFFFFF;
                        cnt.mHi.visible = true;
                        cnt.mHi.y = (item.y + 3);
                    }
                    else {
                        cnt.mHi.visible = false;
                    };
                }
                else {
                    iCT.color = fData.clc[i];
                };
                item.transform.colorTransform = iCT;
                i++;
            };
        }
        function frame5(){
            visible = true;
        }
        function frame1(){
            visible = false;
            stop();
        }
        public function fOpenWith(typ, resObj){
            var i:int;
            var tw:*;
            var tunm:*;
            var tLeaf:*;
            var rItem:*;
            var itemClass:*;
            var item:*;
            var linkOK:*;
            isOpen = true;
            fMode = typ.toLowerCase();
            fData.params = resObj;
            mc.cnt.mHi.visible = false;
            iCT = mc.cnt.mHi.transform.colorTransform;
            iCT.color = 13434675;
            mc.cnt.mHi.transform.colorTransform = iCT;
            i = 0;
            i = 0;
            while (i < 9) {
                rItem = mc.cnt.getChildByName(("i" + i));
                if (rItem != null){
                    rItem.removeEventListener(MouseEvent.CLICK, itemClick);
                    rItem.removeEventListener(MouseEvent.MOUSE_OVER, itemMouseOver);
                    mc.cnt.removeChild(rItem);
                };
                i++;
            };
            tw = 0;
            delete fData.cl;
            delete fData.clc;
            tunm = fData.params.strUsername.toLowerCase();
            tLeaf = rootClass.world.uoTree[tunm];
            fData.cl = rootClass.copyObj(fData[fMode]);
            fData.clc = [];
            i = 0;
            while (i < fData.cl.length) {
                if ((((fData.cl[i] == "Add Friend")) && (rootClass.world.isFriend(fData.params.ID)))){
                    fData.cl.splice(i, 1);
                    i--;
                };
                if ((((fData.cl[i] == "Delete Friend")) && (!(rootClass.world.isFriend(fData.params.ID))))){
                    fData.cl.splice(i, 1);
                    i--;
                };
                i++;
            };
            i = 0;
            while (i < fData.cl.length) {
                if (tunm == rootClass.sfc.myUserName){
                };
                if ((((fData.cl[i] == "Ignore")) && (rootClass.chatF.isIgnored(tunm)))){
                    fData.cl[i] = "Unignore";
                };
                itemClass = (mc.cnt.iproto.constructor as Class);
                item = mc.cnt.addChild(new (itemClass)());
                item.name = ("i" + i);
                item.y = (mc.cnt.iproto.y + (i * 14));
                iCT = item.transform.colorTransform;
                linkOK = true;
                switch (fData.cl[i].toLowerCase()){
                    case "add friend":
                        if (((((!((rootClass.world.getAvatarByUserName(tunm) == null))) && (!((rootClass.world.getAvatarByUserName(tunm).objData == null))))) && ((rootClass.world.getAvatarByUserName(tunm).objData.intAccessLevel > rootClass.world.myAvatar.objData.intAccessLevel)))){
                            linkOK = false;
                        };
                        break;
                    case "go to":
                        if (!((rootClass.world.isPartyMember(tunm)) || (rootClass.world.isFriend(fData.params.ID)))){
                            linkOK = false;
                        };
                        break;
                    case "ignore":
                    case "unignore":
                        if (tunm == rootClass.sfc.myUserName){
                            linkOK = false;
                        };
                        break;
                    case "invite":
                        if ((((((((((((((tunm == rootClass.sfc.myUserName)) || ((tLeaf == null)))) || (((((!((rootClass.world.getAvatarByUserName(tunm) == null))) && (!((rootClass.world.getAvatarByUserName(tunm).objData == null))))) && ((rootClass.world.getAvatarByUserName(tunm).objData.intAccessLevel > rootClass.world.myAvatar.objData.intAccessLevel)))))) || ((rootClass.world.partyMembers.length > 4)))) || (rootClass.world.isPartyMember(fData.params.strUsername)))) || (((rootClass.world.bPvP) && (!((tLeaf.pvpTeam == rootClass.world.myAvatar.dataLeaf.pvpTeam))))))) || ((((rootClass.world.partyMembers.length > 0)) && (!((rootClass.world.partyOwner.toLowerCase() == rootClass.sfc.myUserName))))))){
                            linkOK = false;
                        };
                        break;
                    case "leave party":
                        if (rootClass.world.partyMembers.length == 0){
                            linkOK = false;
                        };
                        break;
                    case "remove":
                        if (rootClass.world.partyOwner.toLowerCase() != rootClass.sfc.myUserName){
                            fData.cl[i] = "Leave Party";
                        };
                        break;
                    case "private: on":
                    case "private: off":
                    case "promote":
                        if (rootClass.world.partyOwner != rootClass.world.myAvatar.objData.strUsername){
                            linkOK = false;
                        };
                        break;
                    case "inspect":
                        if ((((tLeaf == null)) || (!((tLeaf.strFrame == rootClass.world.strFrame))))){
                            linkOK = false;
                        };
                        break;
                };
                if (linkOK){
                    iCT.color = 0x999999;
                    item.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
                    item.buttonMode = true;
                }
                else {
                    iCT.color = 0x666666;
                };
                item.addEventListener(MouseEvent.MOUSE_OVER, itemMouseOver, false, 0, true);
                fData.clc.push(iCT.color);
                item.ti.text = fData.cl[i];
                if (item.ti.textWidth > tw){
                    tw = item.ti.textWidth;
                };
                item.transform.colorTransform = iCT;
                item.ti.width = (item.ti.textWidth + 5);
                item.hit.width = ((item.ti.x + item.ti.textWidth) + 2);
                i++;
            };
            mc.cnt.bg.height = (mc.cnt.getChildByName(String(("i" + (fData.cl.length - 1)))).y + 26);
            mc.cnt.bg.width = (tw + 20);
            mc.x = (MovieClip(parent).mouseX - 5);
            mc.y = (MovieClip(parent).mouseY - 5);
            if ((mc.x + mc.cnt.bg.width) > 960){
                mc.x = (MovieClip(parent).mouseX - mc.cnt.bg.width);
            };
            if ((mc.y + mc.cnt.bg.height) > 500){
                mc.y = (500 - mc.cnt.bg.height);
            };
            mc.gotoAndPlay("in");
        }

    }
}//package 

