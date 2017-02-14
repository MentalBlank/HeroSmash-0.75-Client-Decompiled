// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//QFrameMC

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.filters.GlowFilter;
    import flash.display.DisplayObject;
    import flash.text.*;

    public class QFrameMC extends MovieClip {

        var mhY:int = 0;
        var choiceID:int = -1;
        var isOpen:Boolean = false;
        public var qIDs:Array;
        var mDown:Boolean = false;
        var qdy:int = 58;
        var hRun:int = 0;
        var mbD:int = 0;
        var mbY:int = 0;
        public var cnt:MovieClip;
        public var sIDs:Array;
        var dRun:int = 0;
        public var world:MovieClip;
        var mc:MovieClip;
        var qla:Array;
        var qlb:Array;
        var qMode:String = null;
        public var rootClass:MovieClip;
        public var qData:Object = null;
        var qly:int = 70;
        public var tIDs:Array;

        public function QFrameMC():void{
            qData = null;
            qMode = null;
            choiceID = -1;
            isOpen = false;
            mDown = false;
            hRun = 0;
            dRun = 0;
            mbY = 0;
            mhY = 0;
            mbD = 0;
            qly = 70;
            qdy = 58;
            qla = [];
            qlb = [];
            qIDs = [];
            sIDs = [];
            tIDs = [];
            super();
            addFrameScript(6, frame7, 11, frame12, 15, frame16);
            mc = MovieClip(this);
            mc.x = 0;
            mc.y = 65;
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
        private function qListClick(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
            qData = world.questTree[item.QuestID];
            item.removeEventListener(MouseEvent.CLICK, qListClick);
            item.removeEventListener(MouseEvent.MOUSE_OVER, iMouseOver);
            item.removeEventListener(MouseEvent.MOUSE_OUT, iMouseOut);
            mc.cnt.gotoAndPlay("out");
            if (mc.cnt.qList.hasEventListener(Event.ENTER_FRAME)){
                mc.cnt.qList.removeEventListener(Event.ENTER_FRAME, dEF);
            };
            mc.cnt.qList.mouseEnabled = false;
            mc.cnt.qList.mouseChildren = false;
        }
        public function showQuestList(){
            var x:int;
            var y:int;
            if ((((((qMode == "l")) && (!((world.getActiveQuests() == ""))))) || ((qMode == "q")))){
                if (qMode == "l"){
                    qIDs = world.getActiveQuests().split(",");
                }
                else {
                    qIDs = new Array();
                    x = 0;
                    while (x < sIDs.length) {
                        qIDs.push(sIDs[x]);
                        x++;
                    };
                    y = 0;
                    while (y < tIDs.length) {
                        if (((world.isQuestInProgress(tIDs[y])) && ((qIDs.indexOf(tIDs[y]) == -1)))){
                            qIDs.push(tIDs[y]);
                        };
                        y++;
                    };
                };
                world.checkAllQuestStatus();
                buildQuestList();
            }
            else {
                showEmptyList();
            };
            if (qMode == "l"){
                mc.cnt.strTitle.htmlText = 'Current Missions<font color="#FF0000">:</font>';
            };
            if (qMode == "q"){
                mc.cnt.strTitle.htmlText = 'Available Missions<font color="#FF0000">:</font>';
            };
            mc.cnt.qList.visible = true;
            mc.cnt.qList.mHi.visible = false;
            mc.cnt.mouseChildren = true;
        }
        public function killDetailUI(){
            if (mc.cnt.core.hasEventListener(Event.ENTER_FRAME)){
                mc.cnt.core.removeEventListener(Event.ENTER_FRAME, dEF);
            };
        }
        public function open(){
            rootClass = MovieClip(this.stage.getChildAt(0));
            world = rootClass.world;
            mc = MovieClip(this);
            mc.cnt.bg.fx.visible = false;
            if (rootClass.isDialoqueUp()){
                mc.cnt.bg.fx.visible = true;
            };
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
        private function setCT(obj, col){
            var ct:*;
            ct = obj.transform.colorTransform;
            ct.color = col;
            obj.transform.colorTransform = ct;
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
        private function btnAbandon(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            world.questTree[qData.QuestID].status = null;
            setCT(btn.bg, 0xFF0000);
            btn.removeEventListener(MouseEvent.CLICK, btnAbandon);
            btn.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
            btn.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
            qData = null;
            mc.cnt.gotoAndPlay("back");
        }
        private function btnAccept(e:MouseEvent){
            var strValid:*;
            var btn:*;
            strValid = getQuestValidationString(qData);
            if (strValid != ""){
                MovieClip(Game.root).MsgBox.notify(strValid);
            }
            else {
                if (world.coolDown("acceptQuest")){
                    btn = MovieClip(e.currentTarget);
                    setCT(btn.bg, 43775);
                    btn.removeEventListener(MouseEvent.CLICK, btnAccept);
                    btn.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
                    btn.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
                    world.acceptQuest(qData.QuestID);
                    qData = null;
                    mc.cnt.gotoAndPlay("back");
                };
            };
        }
        public function showQuestDetail(){
            var i:int;
            var s:String;
            var o:Object;
            var p:Object;
            var display:* = undefined;
            var strRewards:String;
            var nextY:Number;
            var btns:* = undefined;
            var btno:* = undefined;
            var b:* = undefined;
            var scr:* = undefined;
            var bMask:* = undefined;
            var strItems:String;
            var localItem:* = undefined;
            var itemN:* = undefined;
            var itemQ:* = undefined;
            var tY:int;
            var rFrameClass:Class;
            var rFrame:MovieClip;
            var mcFilter:GlowFilter;
            var qat:Array;
            var rewardType:String;
            var rewards:Object;
            var rCnt:MovieClip;
            var item:Object;
            var iQty:int;
            var sIcon:String;
            var AssetClass:Class;
            var mcIcon:DisplayObject;
            var btn:* = undefined;
            i = 0;
            choiceID = -1;
            world.checkAllQuestStatus();
            mc.cnt.mouseChildren = true;
            mc.cnt.strTitle.text = qData.sName;
            display = mc.cnt.core;
            display.strNote.autoSize = "left";
            display.strNote.text = getQuestValidationString(qData);
            display.strDesc.mouseWheelEnabled = false;
            display.strReq.mouseWheelEnabled = false;
            display.rewards.strRew.mouseWheelEnabled = false;
            display.strDesc.autoSize = "left";
            display.strReq.autoSize = "left";
            display.rewards.strRew.autoSize = "left";
            if ((((((qData.status == "c")) && ((tIDs.indexOf(qData.QuestID) >= 0)))) && (!((qData.sEndText == ""))))){
                display.strDesc.text = qData.sEndText;
            }
            else {
                display.strDesc.text = qData.sDesc;
            };
            display.strReq.htmlText = "";
            if (((!((qData.turnin == null))) && ((qData.turnin.length > 0)))){
                strItems = "";
                i = 0;
                while (i < qData.turnin.length) {
                    localItem = world.invTree[qData.turnin[i].ItemID];
                    itemN = localItem.sName;
                    itemQ = int(qData.turnin[i].iQty);
                    if (i > 0){
                        strItems = (strItems + ",<br>");
                    };
                    if (localItem.iQty < itemQ){
                        strItems = (strItems + ((((itemN + ' <font color="#888888">') + localItem.iQty) + "/</font>") + itemQ));
                    }
                    else {
                        strItems = (strItems + (((((('<font color="#888888">' + itemN) + " ") + localItem.iQty) + "/") + itemQ) + "</font>"));
                    };
                    i = (i + 1);
                };
                display.strReq.htmlText = strItems;
            };
            strRewards = (qData.iGold + '<font color="#95C4E1"> fame</font><br>');
            strRewards = (strRewards + (qData.iExp + '<font color="#FF00FF"> xp</font>'));
            if ((((qData.FactionID > 1)) && ((qData.iRep > 0)))){
                strRewards = (strRewards + (((("<br>" + qData.iRep) + " <font color='#00FF66'>rep : ") + qData.sFaction) + "</font>"));
            };
            display.rewards.strRew.htmlText = strRewards;
            if (display.strNote.text == ""){
                display.descTitle.y = 0;
            }
            else {
                display.descTitle.y = ((display.strNote.y + display.strNote.textHeight) + 10);
            };
            display.strDesc.y = (display.descTitle.y + 15);
            display.reqTitle.y = Math.round(((display.strDesc.y + display.strDesc.textHeight) + 10));
            display.strReq.y = (display.reqTitle.y + 15);
            display.rewards.y = Math.round(((display.strReq.y + display.strReq.textHeight) + 10));
            nextY = ((display.rewards.y + display.rewards.height) + 15);
            if (qData.oRewards != null){
                rFrameClass = world.getClass("DFrameMCcnt");
                qat = ["itemsS", "itemsC", "itemsR"];
                i = 0;
                while (i < qat.length) {
                    rewardType = qat[i];
                    switch (rewardType){
                        case "itemsS":
                        default:
                            rCnt = display.rewardsStatic;
                            tY = 16;
                            break;
                        case "itemsC":
                            rCnt = display.rewardsChoice;
                            tY = 16;
                            break;
                        case "itemsR":
                            rCnt = display.rewardsRandom;
                            tY = 16;
                    };
                    rCnt.visible = false;
                    if (qData.oRewards[rewardType] != null){
                        rewards = qData.oRewards[rewardType];
                        rCnt.visible = true;
                        for (s in rewards) {
                            item = rewards[s];
                            iQty = item.iQty;
                            rFrame = (rCnt.addChild(new (rFrameClass)()) as MovieClip);
                            rFrame.ItemID = item.ItemID;
                            rFrame.strName.autoSize = "left";
                            rFrame.strName.text = item.sName;
                            rFrame.strName.width = (rFrame.strName.textWidth + 6);
                            rFrame.strType.text = item.sType;
                            rFrame.bg.width = (int(rFrame.strName.textWidth) + 75);
                            if (rFrame.bg.width < 175){
                                rFrame.bg.width = 175;
                            };
                            rFrame.fx1.width = rFrame.bg.width;
                            if (iQty > 1){
                                rFrame.strQ.text = ("x" + iQty);
                                rFrame.strQ.x = ((rFrame.bg.width - rFrame.strQ.width) - 7);
                                rFrame.strQ.visible = true;
                            }
                            else {
                                rFrame.strQ.x = 0;
                                rFrame.strQ.visible = false;
                            };
                            mcFilter = new GlowFilter(world.rarityCA[item.iRty], 1, 8, 8, 2, 1, false, false);
                            rFrame.bg.filters = [mcFilter];
                            rFrame.icon.removeAllChildren();
                            sIcon = "";
                            if (item.sType.toLowerCase() == "enhancement"){
                                sIcon = rootClass.getIconBySlot(item.sES);
                            }
                            else {
                                if ((((((item.sIcon == null)) || ((item.sIcon == "")))) || ((item.sIcon == "none")))){
                                    if (item.sLink.toLowerCase() != "none"){
                                        sIcon = "iidesign";
                                    }
                                    else {
                                        sIcon = "iibag";
                                    };
                                }
                                else {
                                    sIcon = item.sIcon;
                                };
                            };
                            try {
                                AssetClass = (world.getClass(sIcon) as Class);
                                mcIcon = rFrame.icon.addChild(new (AssetClass)());
                                mcIcon.scaleX = (mcIcon.scaleY = 0.5);
                                mcFilter = new GlowFilter(world.rarityCA[item.iRty], 1, 8, 8, 2, 1, false, false);
                                rFrame.icon.filters = [mcFilter];
                            }
                            catch(e:Error) {
                            };
                            rFrame.y = tY;
                            tY = (tY + Math.round((rFrame.height + 8)));
                            if ((((((((((rewardType == "itemsC")) && (!((qMode == "l"))))) && (!((qData.status == null))))) && ((qData.status == "c")))) && ((tIDs.indexOf(qData.QuestID) >= 0)))){
                                rFrame.mouseEnabled = true;
                                rFrame.mouseChildren = false;
                                rFrame.buttonMode = true;
                                rFrame.addEventListener(MouseEvent.CLICK, btnRewardClick, false, 0, true);
                            };
                        };
                    };
                    if (rCnt.visible){
                        rCnt.y = nextY;
                        nextY = ((rCnt.y + rCnt.height) + 15);
                    };
                    i = (i + 1);
                };
            };
            btns = null;
            btno = {};
            if (qMode != "l"){
                if (qData.status == null){
                    btns = mc.cnt.btns.dual;
                    mc.cnt.btns.tri.visible = false;
                    btno = {
                        b1:{
                            txt:"Accept",
                            fn:btnAccept
                        },
                        b2:{
                            txt:"Decline",
                            fn:btnBack
                        }
                    };
                }
                else {
                    if ((((qData.status == "c")) && ((tIDs.indexOf(qData.QuestID) >= 0)))){
                        btns = mc.cnt.btns.tri;
                        mc.cnt.btns.dual.visible = false;
                        btno = {
                            b1:{
                                txt:"Back",
                                fn:btnBack
                            },
                            b2:{
                                txt:"Turn in!",
                                fn:btnComplete
                            },
                            b3:{
                                txt:"Abandon",
                                fn:btnAbandon
                            }
                        };
                    }
                    else {
                        btns = mc.cnt.btns.dual;
                        mc.cnt.btns.tri.visible = false;
                        btno = {
                            b1:{
                                txt:"Back",
                                fn:btnBack
                            },
                            b2:{
                                txt:"Abandon",
                                fn:btnAbandon
                            }
                        };
                    };
                };
            }
            else {
                btns = mc.cnt.btns.dual;
                mc.cnt.btns.tri.visible = false;
                btno = {
                    b1:{
                        txt:"Back",
                        fn:btnBack
                    },
                    b2:{
                        txt:"Abandon",
                        fn:btnAbandon
                    }
                };
            };
            for (b in btno) {
                btn = btns[b];
                btn.buttonMode = true;
                btn.fx.visible = false;
                btn.ti.mouseEnabled = false;
                btn.addEventListener(MouseEvent.MOUSE_OVER, bMouseOver, false, 0, true);
                btn.addEventListener(MouseEvent.MOUSE_OUT, bMouseOut, false, 0, true);
                btn.ti.text = btno[b].txt;
                btn.addEventListener(MouseEvent.CLICK, btno[b].fn, false, 0, true);
            };
            scr = mc.cnt.scr;
            bMask = mc.cnt.bMask;
            scr.h.height = int(((scr.b.height / display.height) * scr.b.height));
            hRun = (scr.b.height - scr.h.height);
            dRun = ((display.height - scr.b.height) + 20);
            scr.h.y = 0;
            display.oy = (display.y = qdy);
            scr.visible = false;
            scr.hit.alpha = 0;
            mDown = false;
            if (display.height > scr.b.height){
                scr.visible = true;
                scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, scrDown, false, 0, true);
                scr.h.addEventListener(Event.ENTER_FRAME, hEF, false, 0, true);
                display.addEventListener(Event.ENTER_FRAME, dEF, false, 0, true);
            };
        }
        private function iMouseOver(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
            item.parent.mHi.visible = true;
            item.parent.mHi.y = item.y;
        }
        private function bMouseOver(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.fx.visible = true;
        }
        private function bMouseOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.fx.visible = false;
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
        private function showEmptyList(){
            var itemClass:*;
            var item:*;
            itemClass = (mc.cnt.qList.iproto.constructor as Class);
            item = mc.cnt.qList.addChild(new (itemClass)());
            item.ti.htmlText = '<font color="#DDDDDD">You are not on any mission!</font>';
            item.hit.alpha = 0;
            item.x = 10;
            mc.cnt.qList.iproto.visible = false;
            mc.cnt.scr.visible = false;
        }
        public function turninResult(result:String){
            getQuestListB();
            qData = null;
            if (mc.cnt.currentLabel == "hold"){
                if (result == "pass"){
                    qData = nextQuestAvailable();
                };
                mc.cnt.gotoAndPlay("back");
            };
        }
        public function fClose():void{
            mc.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK, xClick);
            stage.focus = stage;
            mc.parent.removeChild(mc);
        }
        private function getQuestValidationString(qData:Object):String{
            var iFactionRank:int;
            var iSpillRep:*;
            var strText:String;
            var i:int;
            var obj:Object;
            var iQty:int;
            var iClassRank:int;
            var iSpillClassPoints:*;
            if (((!((qData.sField == null))) && (!((world.getAchievement(qData.sField, qData.iIndex) == 0))))){
                return ("Daily Quests are only available once per day.");
            };
            if ((((qData.bUpg == 1)) && (!(world.myAvatar.isUpgraded())))){
                return ("Upgrade is required for this quest!");
            };
            if ((((qData.iSlot >= 0)) && ((world.getQuestValue(qData.iSlot) < (qData.iValue - 1))))){
                return ("Quest has not been unlocked!");
            };
            if (qData.iLvl > world.myAvatar.objData.intLevel){
                return ((("Unlocks at Level " + qData.iLvl) + "."));
            };
            if ((((qData.FactionID > 1)) && ((world.getRep(qData.FactionID) < qData.iReqRep)))){
                iFactionRank = rootClass.getRankFromPoints(qData.iReqRep);
                iSpillRep = (qData.iReqRep - rootClass.arrRanks[(iFactionRank - 1)]);
                if (iSpillRep > 0){
                    return ((((((("Requires " + iSpillRep) + " Reputation for ") + qData.sFaction) + ", Rank ") + iFactionRank) + "."));
                };
                return ((((("Requires " + qData.sFaction) + ", Rank ") + iFactionRank) + "."));
            };
            if (((!((qData.reqd == null))) && (!(hasRequiredItemsForQuest(qData))))){
                strText = "Required Item(s): ";
                i = 0;
                while (i < qData.reqd.length) {
                    obj = world.invTree[qData.reqd[i].ItemID];
                    iQty = qData.reqd[i].iQty;
                    if (obj.sES == "ar"){
                        iClassRank = rootClass.getRankFromPoints(iQty);
                        iSpillClassPoints = (iQty - rootClass.arrRanks[(iClassRank - 1)]);
                        if (iSpillClassPoints > 0){
                            strText = (strText + (iSpillClassPoints + " Class Points on "));
                        };
                        strText = (strText + ((obj.sName + ", Rank ") + iClassRank));
                    }
                    else {
                        strText = (strText + obj.sName);
                        if (iQty > 1){
                            strText = (strText + ("x" + iQty));
                        };
                    };
                    strText = (strText + ", ");
                    i++;
                };
                strText = (strText.substr(0, (strText.length - 2)) + ".");
                return (strText);
            };
            return ("");
        }
        private function btnBack(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            setCT(btn.bg, 0xAAAAAA);
            btn.removeEventListener(MouseEvent.CLICK, btnBack);
            btn.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
            btn.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
            mc.cnt.mouseChildren = false;
            qData = null;
            mc.cnt.gotoAndPlay("back");
        }
        private function getQuestListA():void{
            var i:int;
            var quest:*;
            qla = [];
            i = 0;
            while (i < qIDs.length) {
                quest = world.questTree[qIDs[i]];
                qla.push(isQuestAvailable(quest));
                i++;
            };
        }
        private function getQuestListB():void{
            var i:int;
            var quest:*;
            qlb = [];
            i = 0;
            while (i < qIDs.length) {
                quest = world.questTree[qIDs[i]];
                qlb.push(isQuestAvailable(quest));
                i++;
            };
        }
        private function hasRequiredItemsForQuest(quest:Object):Boolean{
            var i:int;
            var qItemID:*;
            var qItemQ:int;
            if (((!((quest.reqd == null))) && ((quest.reqd.length > 0)))){
                i = 0;
                while (i < quest.reqd.length) {
                    qItemID = quest.reqd[i].ItemID;
                    qItemQ = int(quest.reqd[i].iQty);
                    if ((((rootClass.world.invTree[qItemID] == null)) || ((int(rootClass.world.invTree[qItemID].iQty) < qItemQ)))){
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }
        private function btnRewardClick(e:MouseEvent):void{
            var mc:MovieClip;
            var mcp:MovieClip;
            var mci:MovieClip;
            var f:Array;
            var i:int;
            mc = (e.currentTarget as MovieClip);
            mcp = (mc.parent as MovieClip);
            choiceID = mc.ItemID;
            i = 1;
            while (i < mcp.numChildren) {
                mci = (mcp.getChildAt(i) as MovieClip);
                f = mci.bg.filters;
                if ((((choiceID == mci.ItemID)) && ((f.length == 1)))){
                    f.push(new GlowFilter(16763955, 1, 5, 5, 2, 1, true, false));
                    mci.bg.filters = f;
                };
                if (((!((choiceID == mci.ItemID))) && ((f.length > 1)))){
                    f.pop();
                    mci.bg.filters = f;
                };
                i++;
            };
        }
        private function btnComplete(e:MouseEvent){
            var btn:*;
            if (((world.coolDown("tryQuestComplete")) && (world.canTurnInQuest(qData.QuestID)))){
                if (((!((qData.oRewards.itemsC == null))) && ((choiceID == -1)))){
                    rootClass.addUpdate("Please choose a reward before turning the quest in!");
                    rootClass.chatF.pushMsg("warning", "Please choose a reward before turning the quest in!", "SERVER", "", 0);
                    return;
                };
                btn = MovieClip(e.currentTarget);
                setCT(btn.bg, 0xFF00);
                btn.removeEventListener(MouseEvent.CLICK, btnAbandon);
                btn.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
                btn.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
                mc.cnt.gotoAndPlay("hold");
                getQuestListA();
                world.tryQuestComplete(qData.QuestID, choiceID);
            };
        }
        private function isOneTimeQuestDone(quest):Boolean{
            return ((((quest.bOnce == 1)) && ((((quest.iSlot < 0)) || ((world.getQuestValue(quest.iSlot) >= quest.iValue))))));
        }
        private function isQuestAvailable(qData:Object):Boolean{
            if (qData != null){
                if (((((((((((!((qData.sField == null))) && (!((world.getAchievement(qData.sField, qData.iIndex) == 0))))) || ((qData.iLvl > world.myAvatar.objData.intLevel)))) || ((((qData.bUpg == 1)) && (!(world.myAvatar.isUpgraded())))))) || ((((qData.iSlot >= 0)) && ((world.getQuestValue(qData.iSlot) < (qData.iValue - 1))))))) || ((((qData.FactionID > 1)) && ((world.getRep(qData.FactionID) < qData.iReqRep)))))){
                    return (false);
                };
                return (true);
            };
            return (false);
        }
        private function buildQuestList(){
            var i:*;
            var scr:*;
            var bMask:*;
            var display:*;
            var quest:*;
            var itemClass:*;
            var item:*;
            i = 0;
            while (i < qIDs.length) {
                quest = world.questTree[qIDs[i]];
                if (((!((quest == null))) && (!(isOneTimeQuestDone(quest))))){
                    itemClass = (mc.cnt.qList.iproto.constructor as Class);
                    item = mc.cnt.qList.addChild(new (itemClass)());
                    if (isQuestAvailable(quest)){
                        item.ti.htmlText = (("<font color='#009900'><b>" + quest.sName) + "</b></font>");
                    }
                    else {
                        item.ti.htmlText = (("<font color='#990000'><b>" + quest.sName) + "</b></font>");
                    };
                    item.addEventListener(MouseEvent.CLICK, qListClick);
                    item.QuestID = quest.QuestID;
                    if (quest.sTyp != null){
                        item.ti.htmlText = (item.ti.htmlText + ((' <font color="#888888">' + quest.sTyp) + "</font>"));
                    };
                    if (quest.status != null){
                        switch (quest.status){
                            case "p":
                                item.ti.htmlText = (item.ti.htmlText + "<font color='#888888'> - In progress</font>");
                                break;
                            case "c":
                                item.ti.htmlText = (item.ti.htmlText + "<font color='#99FF00'> - <b>Complete!</b></font>");
                                break;
                        };
                    };
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
            display = mc.cnt.qList;
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
            mc.cnt.qList.iproto.visible = false;
        }
        private function nextQuestAvailable():Object{
            var obj:Object;
            var i:int;
            obj = null;
            i = 0;
            while (i < qIDs.length) {
                if ((((qla[i] == false)) && ((qlb[i] == true)))){
                    obj = world.questTree[qIDs[i]];
                };
                i++;
            };
            return (obj);
        }
        private function scrDown(e:MouseEvent){
            mbY = int(mouseY);
            mhY = int(MovieClip(e.currentTarget.parent).h.y);
            mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, scrUp, false, 0, true);
        }
        private function xClick(e:MouseEvent){
            fClose();
        }
        private function iMouseOut(e:MouseEvent){
            var item:*;
            item = MovieClip(e.currentTarget);
            item.parent.mHi.visible = false;
        }

    }
}//package 

