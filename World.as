// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//World

package {
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.geom.ColorTransform;
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.display.Bitmap;
    import flash.net.URLRequest;
    import flash.utils.getQualifiedClassName;
    import flash.events.IOErrorEvent;
    import flash.geom.Matrix;
    import flash.text.TextFormat;
    import flash.utils.getDefinitionByName;
    import flash.filters.GlowFilter;
    import flash.utils.*;

    public class World extends MovieClip {

        private const TICK_MAX = 24;

        public var WALKSPEED:Number = 8;
        var connTestTimer:Timer;
        private var mapNH:int;
        public var loaderManager:Object;
        var minLatencyOneWay = 20;
        private var mapNW:int;
        public var PVPQueue:Object;
        var mvTimerObj:Object;
        public var loaderContents;
        public var enhShopID:int = -1;
        public var enhShopItems:Array;
        public var guildID:int = -1;
        var actionIDLimit:Number = 30;
        public var tempitems:Array;
        var bitWalk:Boolean = false;
        public var mapLoadInProgress:Boolean = false;
        public var monCT:ColorTransform;
        public var ldr_House:Loader;
        public var mapBoundsMC:MovieClip = null;
        private var tbmd:BitmapData;
        public var EFAO:Object;
        public var enhItem:Object;
        public var cellMap:Object;
        public var shopinfo:Object;
        public var strPad:String = "";
        public var houseitems:Array;
        public var strMapFileName:String;
        public var loaderQueue:Array;
        var FG:MovieClip;
        var autoAction:Object;
        public var arrSolidR:Array;
        public var arrSolid:Array;
        public var arrCopier:Array;
        public var PVPMaps:Array;
        public var monTree:Object;
        public var arrEvent:Array;
        var actionResults:Object;
        var FEATURE_COLLISION:Boolean = true;
        public var enhPatternTree:Object;
        public var mapUI:MovieClip;
        public var actions:Object;
        var actionReady:Boolean = false;
        public var showHPBar:Boolean = false;
        public var intKillCount:int;
        private var fpsTS:Number = 0;
        var SCALE:Number = 1;
        public var lock:Object;
        var actionDamage;
        public var uoTree:Object;
        public var map:MovieClip;
        var preLMC;
        public var loaderContentsFileNames;
        var objQuestList:Object;
        public var objExtra;
        private var bfps:Boolean = false;
        public var areaUsers:Array;
        var lastWalk:Date;
        var autoActionTimer:Timer;
        public var mondef:Array;
        public var avtPCT:ColorTransform;
        var AATestTimer:Timer;
        public var mapEvents:Object;
        var ldr_map:Loader;
        public var objSession:Object;
        public var PVPResults:Object;
        public var friends:Array;
        public var rootClass:MovieClip;
        public var strFrame:String = "";
        public var iBankCount:int;
        var actionID:Number = 0;
        var zManager:MovieClip;
        public var factions:Array;
        public var uiLock:Boolean = false;
        var TcpAckDel = 170;
        public var deathCT:ColorTransform;
        public var combatAnims:Array;
        public var returnInfo:Object;
        var afkTimer:Timer;
        public var strAreaName:String;
        var actionResultsMon:Object;
        var actionResultIDLimit:Number = 30;
        public var playerDomains:Object;
        public var zSortArr:Array;
        public var objQuestString;
        public var myAvatar:Avatar;
        public var waveTree:Object;
        public var bank:Array;
        public var avtMCT:ColorTransform;
        public var objInfo:Object;
        public var avatars:Object;
        var actionResultID:Number = 0;
        public var objResponse:Object;
        var connMsgOut = false;
        var CELL_MODE:String = "normal";
        public var whiteCT:ColorTransform;
        public var GCDO:int = 1500;
        public var adData:Object;
        var actionIDLimitMon:Number = 30;
        public var defaultCT:ColorTransform;
        private var mapH:int = 550;
        private var mapW:int = 960;
        public var partyID:int = -1;
        public var hairshopinfo:Object;
        public var loaderC:LoaderContext;
        public var loaderD:ApplicationDomain;
        public var strMapName:String;
        public var iconCT:ColorTransform;
        var actionTimer:Timer;
        public var staticAnims:Array;
        public var arrEventR:Array;
        public var objLock;
        var SCROLL:Boolean = false;
        public var monmap:Array;
        public var spawnPoint:Object;
        public var GCD:int = 1500;
        public var shopBuyItem:Object;
        public var PVPFactions:Array;
        private var mapBmps:Array;
        var mvTimer:Timer;
        var actionRangeSpamTS:Number = 0;
        public var TRASH:MovieClip;
        public var invTree:Object;
        public var curRoom:int = 1;
        public var arrHouseItemQueue;
        public var statusStoneCT:ColorTransform;
        public var bPvP:Boolean = false;
        private var mapTimer:Timer;
        var actionMap:Array;
        public var rarityCA:Array;
        public var partyMembers:Array;
        public var GCDTS:Number = 0;
        public var partyOwner:String = "";
        var actionIDMon:Number = 0;
        public var statusPoisonCT:ColorTransform;
        public var iBankCountAC:int;
        private var ticksum:Number = 0;
        public var avtCT:ColorTransform;
        public var modID:int = -1;
        public var questTree:Object;
        public var objHouseData;
        public var CHARS:MovieClip;
        public var items:Array;
        public var intType:int;
        public var avtWCT:ColorTransform;
        var restTimer:Timer;
        private var ticklist;
        public var monsters:Array;
        public var monswf:Array;

        public function World(){
            var CHARSO:DisplayObject;
            var mapUIObject:DisplayObject;
            uiLock = false;
            objInfo = new Object();
            objSession = new Object();
            objResponse = new Object();
            FEATURE_COLLISION = true;
            CELL_MODE = "normal";
            SCROLL = false;
            SCALE = 1;
            WALKSPEED = 8;
            bitWalk = false;
            lastWalk = new Date();
            strFrame = "";
            strPad = "";
            spawnPoint = new Object();
            mapBoundsMC = null;
            zSortArr = new Array();
            ldr_map = new Loader();
            EFAO = {
                zc:0,
                zn:1,
                xpc:0,
                xpn:50,
                xpb:false
            };
            avatars = new Object();
            monsters = new Array();
            combatAnims = ["Attack1", "Attack2", "Attack3", "Attack4", "Hit", "Knockout", "Getup", "Stab", "Thrash", "Castgood", "Cast1", "Cast2", "Cast3", "Sword/ShieldFight", "Sword/ShieldAttack1", "Sword/ShieldAttack2", "ShieldBlock", "DuelWield/DaggerFight", "DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2", "FistweaponFight", "FistweaponAttack1", "FistweaponAttack2", "PolearmFight", "PolearmAttack1", "PolearmAttack2", "RangedFight", "RangedAttack1", "UnarmedFight", "UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack", "Dodge", "Blast", "RapidFire", "HealSingle", "HealAll", "HeadBeam"];
            staticAnims = ["Fall", "Knockout", "Die"];
            enhShopID = -1;
            loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            loaderC = new LoaderContext(false, loaderD);
            loaderContents = [];
            loaderContentsFileNames = [];
            loaderQueue = [];
            playerDomains = {};
            loaderManager = {
                i0:{
                    n:"i0",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                },
                i1:{
                    n:"i1",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                },
                i2:{
                    n:"i2",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                },
                i3:{
                    n:"i3",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                },
                i4:{
                    n:"i4",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                },
                i5:{
                    n:"i5",
                    loaderData:null,
                    timer:new Timer(1000, 1),
                    ldr:new Loader(),
                    free:true,
                    url:""
                }
            };
            mapLoadInProgress = false;
            mapW = 960;
            mapH = 550;
            mapNW = mapW;
            mapNH = mapH;
            mapBmps = [];
            mapTimer = new Timer(2000);
            restTimer = new Timer(2000, 1);
            AATestTimer = new Timer(700, 1);
            connTestTimer = new Timer(5000, 1);
            autoActionTimer = new Timer(2000, 1);
            afkTimer = new Timer(120000, 1);
            mvTimer = new Timer(1000, 1);
            actionMap = new Array();
            actionReady = false;
            actionResults = new Object();
            actionResultsMon = new Object();
            actionID = 0;
            actionIDLimit = 30;
            actionIDMon = 0;
            actionIDLimitMon = 30;
            actionRangeSpamTS = 0;
            actionResultID = 0;
            actionResultIDLimit = 30;
            minLatencyOneWay = 20;
            TcpAckDel = 170;
            connMsgOut = false;
            lock = {
                loadShop:{
                    cd:3000,
                    ts:0
                },
                loadEnhShop:{
                    cd:3000,
                    ts:0
                },
                loadHairShop:{
                    cd:3000,
                    ts:0
                },
                equipItem:{
                    cd:1500,
                    ts:0
                },
                unequipItem:{
                    cd:1500,
                    ts:0
                },
                buyItem:{
                    cd:1000,
                    ts:0
                },
                sellItem:{
                    cd:1000,
                    ts:0
                },
                getMapItem:{
                    cd:1000,
                    ts:0
                },
                tryQuestComplete:{
                    cd:1250,
                    ts:0
                },
                acceptQuest:{
                    cd:1000,
                    ts:0
                },
                doIA:{
                    cd:1000,
                    ts:0
                },
                rest:{
                    cd:1900,
                    ts:0
                },
                who:{
                    cd:3000,
                    ts:0
                },
                tfer:{
                    cd:3000,
                    ts:0
                }
            };
            invTree = {};
            uoTree = {};
            monTree = {};
            waveTree = {};
            questTree = {};
            enhPatternTree = {};
            defaultCT = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            whiteCT = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);
            iconCT = new ColorTransform(0.5, 0.5, 0.5, 1, -50, -50, -50, 0);
            rarityCA = [0x666666, 0xFFFFFF, 0x66FF00, 2663679, 0xFF00FF, 0xFFCC00, 0xFF0000];
            deathCT = new ColorTransform(0.7, 0.7, 1, 1, -20, -20, 20, 0);
            monCT = new ColorTransform(1, 1, 1, 1, 30, 0, 0, 0);
            avtCT = new ColorTransform(1, 1, 1, 1, 40, 40, 70, 0);
            avtWCT = new ColorTransform(0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0);
            avtMCT = new ColorTransform(0, 0, 0, 0, 30, 0, 0, 0);
            avtPCT = new ColorTransform(0, 0, 0, 0, 40, 40, 70, 0);
            statusPoisonCT = new ColorTransform(-0.3, -0.3, -0.3, 0, 0, 20, 0, 0);
            statusStoneCT = new ColorTransform(-1.3, -1.3, -1.3, 0, 100, 100, 100, 0);
            GCD = 1500;
            GCDO = 1500;
            GCDTS = 0;
            curRoom = 1;
            modID = -1;
            partyID = -1;
            guildID = -1;
            bPvP = false;
            partyMembers = [];
            partyOwner = "";
            areaUsers = [];
            showHPBar = false;
            PVPMaps = [{
                nam:"It's Us Or Them",
                desc:"This cozy PvP map is ideal for players new to PvP in AQW.",
                warzone:"usorthem",
                label:"usorthem",
                icon:"tower",
                hidden:true
            }, {
                nam:"Bludrut Brawl!",
                desc:"A larger map requiring communication, coordination, and a whole lot of DPS.",
                warzone:"bludrutbrawl",
                label:"bludrutbrawl",
                icon:"swords",
                hidden:false
            }, {
                nam:"Darkovia Brawl!",
                desc:"Join in the ancient war between werewolves and vampires!",
                warzone:"darkoviapvp",
                label:"darkoviapvp",
                icon:"swords",
                hidden:true
            }];
            PVPQueue = {
                warzone:"",
                ts:-1,
                avgWait:-1
            };
            PVPResults = {
                pvpScore:[],
                team:0
            };
            PVPFactions = [];
            arrHouseItemQueue = [];
            ldr_House = new Loader();
            friends = [];
            factions = [];
            tempitems = [];
            objQuestList = new Object();
            ticksum = 0;
            ticklist = new Array();
            bfps = false;
            fpsTS = 0;
            arrCopier = [];
            super();
            rootClass = MovieClip(MovieClip(this).root);
            map = new MovieClip();
            this.addChild(map);
            CHARS = new MovieClip();
            CHARSO = this.addChild(CHARS);
            CHARS.mouseEnabled = false;
            CHARSO.x = 0;
            CHARSO.y = 0;
            mapUI = new MovieClip();
            mapUI.mouseEnabled = false;
            mapUIObject = this.addChild(mapUI);
            mapUIObject.x = 0;
            mapUIObject.y = 0;
            TRASH = new MovieClip();
            this.addChild(TRASH);
            TRASH.mouseEnabled = false;
            TRASH.visible = false;
            TRASH.y = -1000;
            zManager = new MovieClip();
            this.addChild(zManager);
            FG = new MovieClip();
            this.addChild(FG);
            zManager.removeEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame);
            autoActionTimer.removeEventListener("timer", autoActionHandler);
            restTimer.removeEventListener("timer", restRequest);
            AATestTimer.removeEventListener("timer", AATest);
            connTestTimer.removeEventListener("timer", connTest);
            afkTimer.removeEventListener("timer", afkTimerHandler);
            mvTimer.removeEventListener("timer", mvTimerHandler);
            mapTimer.removeEventListener(TimerEvent.TIMER, mapResizeCheck);
            zManager.addEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame, false, 0, true);
            autoActionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, autoActionHandler);
            restTimer.addEventListener("timer", restRequest);
            AATestTimer.addEventListener("timer", AATest);
            connTestTimer.addEventListener("timer", connTest);
            afkTimer.addEventListener("timer", afkTimerHandler);
            mvTimer.addEventListener("timer", mvTimerHandler);
            mapTimer.addEventListener(TimerEvent.TIMER, mapResizeCheck, false, 0, true);
            mapTimer.start();
            initLoaders();
        }
        public function setReturnInfo(strMap:String, strCell:String, strPad:String):void{
            returnInfo = new Object();
            returnInfo.strMap = strMap;
            returnInfo.strCell = strCell;
            returnInfo.strPad = strPad;
        }
        private function buildBoundingRects():void{
            var i:int;
            var r:Rectangle;
            var m:MovieClip;
            i = 0;
            arrEventR = [];
            arrSolidR = [];
            i = 0;
            while (i < arrEvent.length) {
                m = arrEvent[i];
                r = m.getBounds(stage);
                arrEventR.push(r);
                i++;
            };
            i = 0;
            while (i < arrSolid.length) {
                m = arrSolid[i];
                r = m.getBounds(stage);
                arrSolidR.push(r);
                i++;
            };
        }
        private function clearMapBmps():void{
            var o:Object;
            if (mapBmps.length > 0){
                for each (o in mapBmps) {
                    o.bmDO.parent.removeChild(o.bmDO);
                    if (o.bmd != null){
                        o.bmd.dispose();
                    };
                    o.child = null;
                    o.bmd = null;
                    o.bm = null;
                };
            };
            mapBmps = [];
        }
        public function loadHouseItem(item:Object, x:int, y:int):void{
            var item:Object = item;
            var x:int = x;
            var y:int = y;
            try {
                attachHouseItem({
                    item:item,
                    x:x,
                    y:y
                });
            }
            catch(err:Error) {
                arrHouseItemQueue.push({
                    item:item,
                    typ:"A",
                    x:x,
                    y:y
                });
                if (arrHouseItemQueue.length > 0){
                    loadNextHouseItem();
                };
            };
        }
        public function getCopierByCharID(charID:int):AvatarMCCopier{
            var i:int;
            var copier:*;
            i = 0;
            while (i < arrCopier.length) {
                if (arrCopier[i].ID == charID){
                    copier = arrCopier[i].copier;
                    arrCopier.splice(i, 1);
                    return (copier);
                };
                i++;
            };
            return (null);
        }
        public function loadQuestStringData():void{
            rootClass.sfc.sendXtMessage("zm", "loadQuestStringData", [], "str", curRoom);
        }
        public function restRequest(e:TimerEvent){
            var uoLeaf:*;
            uoLeaf = getUoLeafById(myAvatar.uid);
            if (((((((!((uoLeaf.intHP == uoLeaf.intHPMax))) || (!((uoLeaf.intMP == uoLeaf.intMPMax))))) && ((myAvatar.pMC.mcChar.currentLabel == "Rest")))) && ((uoLeaf.intState == 1)))){
                if (coolDown("rest")){
                    rootClass.sfc.sendXtMessage("zm", "restRequest", [""], "str", 1);
                    restTimer.reset();
                    restTimer.start();
                }
                else {
                    restStart();
                };
            }
            else {
                restTimer.reset();
            };
        }
        public function showSpellFXHit(spObj){
            var spFX:*;
            spFX = {};
            switch (spObj.strl){
                case "sp_ef1":
                    spFX.strl = "sp_ef2";
                    break;
            };
            switch (spObj.strl){
                case "sp_ice1":
                    spFX.strl = "sp_ice2";
                    break;
            };
            spFX.fx = "w";
            spFX.avts = [spObj.tMC.pAV];
            castSpellFX(null, spFX, null);
        }
        private function getMonsterDefinition(MonID:int):Object{
            var i:int;
            i = 0;
            while (i < mondef.length) {
                if (mondef[i].MonID == MonID){
                    return (mondef[i]);
                };
                i++;
            };
            return (null);
        }
        public function removeAura(aura:Object, tLeaf:Object):Boolean{
            var foundIt:Boolean;
            var i:int;
            trace(("removeAura > " + aura.nam));
            if (rootClass.sfcSocial){
                foundIt = false;
                i = 0;
                i = 0;
                while (i < tLeaf.auras.length) {
                    if (tLeaf.auras[i].nam == aura.nam){
                        tLeaf.auras.splice(i, 1);
                        i = tLeaf.auras.length;
                        foundIt = true;
                    };
                    i++;
                };
                i = 0;
                while (i < tLeaf.passives.length) {
                    if (tLeaf.passives[i].nam == aura.nam){
                        tLeaf.passives.splice(i, 1);
                        i = tLeaf.passives.length;
                        foundIt = false;
                    };
                    i++;
                };
                trace(("returning " + foundIt));
                return (foundIt);
            };
            trace("Unsocial, returning false");
            return (false);
        }
        public function showResCounter(){
            var mcr:*;
            mcr = MovieClip(rootClass.ui.mcRes);
            mcr.gotoAndPlay("in");
            mcr.resC = 10;
            mcr.counter.ti.text = mcr.resC;
            if (mcr.resTimer == null){
                mcr.resTimer = new Timer(1000);
                mcr.resTimer.addEventListener("timer", resTimer);
            }
            else {
                mcr.resTimer.reset();
            };
            mcr.resTimer.start();
        }
        public function sendForceEquipRequest(intItemID:int):void{
            rootClass.sfc.sendXtMessage("zm", "forceEquipItem", [intItemID], "str", curRoom);
        }
        public function getAvatarByUserName(unm:String):Avatar{
            var s:String;
            for (s in avatars) {
                if (((((!((avatars[s] == null))) && (!((avatars[s].pnm == null))))) && ((avatars[s].pnm.toLowerCase() == unm.toLowerCase())))){
                    return (avatars[s]);
                };
            };
            return (null);
        }
        public function deleteFriend(ID:int):void{
            var i:int;
            i = 0;
            while (i < friends.length) {
                if (friends[i].ID == ID){
                    friends.splice(i, 1);
                    break;
                };
                i++;
            };
            if (rootClass.ui.mcOFrame.currentLabel == "Idle"){
                rootClass.ui.mcOFrame.update();
            };
        }
        public function closeLoader(ldrObj:Object, isOK:Boolean=true, isLoaded:Boolean=true, doNext:Boolean=true):void{
            var l:* = undefined;
            var ldrObj:Object = ldrObj;
            var isOK:Boolean = isOK;
            var isLoaded:Boolean = isLoaded;
            var doNext:Boolean = doNext;
            if (isLoaded){
                try {
                    ldrObj.ldr.unload();
                }
                catch(e:Error) {
                };
            };
            ldrObj.free = true;
            ldrObj.isOpen = false;
            ldrObj.loaderData = null;
            ldrObj.timer.reset();
            l = getFreeLoader();
            if (((!((l == null))) && (doNext))){
                loadNext(l);
            };
        }
        public function loadMultipleCharByID(arrChar:Array, callback:Function){
            var i:*;
            if (((!((arrChar == null))) && (!((callback == null))))){
                if (arrChar.length > 0){
                    if (((!((arrChar[0].mc == null))) && (!((arrChar[0].charID == null))))){
                        i = 0;
                        while (i < arrChar.length) {
                            loadAvatarMCByID(arrChar[i].mc, arrChar[i].charID, callback);
                            i++;
                        };
                    }
                    else {
                        trace("Error: Missing Character MC or ID!");
                    };
                };
            }
            else {
                trace("Error: No Character data was passed!");
            };
        }
        public function unequipItemAtES(sES:String):void{
            var i:int;
            i = 0;
            while (i < items.length) {
                if (items[i].sES == sES){
                    items[i].bEquip = 0;
                };
                i++;
            };
            i = 0;
            while (i < tempitems.length) {
                if (tempitems[i].sES == sES){
                    tempitems[i].bEquip = 0;
                };
                i++;
            };
        }
        public function duelExpire(){
            rootClass.closeModalByStrBody("has challenged you to a duel.");
        }
        public function drawRects(a:Array):void{
            var c:Array;
            var s:Sprite;
            var g:Graphics;
            var r:Rectangle;
            var i:int;
            c = [0xFF0000, 0xFF00, 0xFF];
            s = new Sprite();
            g = s.graphics;
            i = 0;
            i = 0;
            while (i < a.length) {
                r = a[i];
                g.moveTo(r.x, r.y);
                g.beginFill(c[i], 0.3);
                g.lineTo((r.x + r.width), r.y);
                g.lineTo((r.x + r.width), (r.y + r.height));
                g.lineTo(r.x, (r.y + r.height));
                g.lineTo(r.x, r.y);
                g.endFill();
                i++;
            };
        }
        public function addRep(ID:int, rep:int):void{
            var faction:*;
            var iOldRank:int;
            faction = getFaction(ID);
            if (faction != null){
                iOldRank = faction.iRank;
                faction.iRep = (faction.iRep + rep);
                initFaction(faction);
                if ((((faction.iRank > iOldRank)) && (!((myAvatar == null))))){
                    myAvatar.rankUp(faction.sName, faction.iRank);
                    rootClass.FB_showFeedDialog("Rank Up!", (((("reached Rank " + faction.iRank) + " for ") + faction.sName) + " Reputation in AQWorlds!"), "aqw-rankup.jpg");
                };
                if (rep > 0){
                    rootClass.chatF.pushMsg("server", (((("Reputation for " + faction.sName) + " increased by ") + rep) + "."), "SERVER", "", 0);
                }
                else {
                    if (rep < 0){
                        rootClass.chatF.pushMsg("server", (((("Reputation for " + faction.sName) + " decreased by ") + -(rep)) + "."), "SERVER", "", 0);
                    };
                };
            };
        }
        public function onZmanagerEnterFrame(evt:Event){
            var zMC:MovieClip;
            var i:int;
            var j:int;
            var mcIndex:int;
            var now:Number;
            var evt:Event = evt;
            if (bfps){
                calculateFPS();
            };
            zSortArr = [];
            i = 0;
            while (i < CHARS.numChildren) {
                zMC = MovieClip(CHARS.getChildAt(i));
                zSortArr.push({
                    mc:zMC,
                    oy:zMC.y
                });
                i = (i + 1);
            };
            zSortArr.sortOn("oy", Array.NUMERIC);
            j = 0;
            while (j < zSortArr.length) {
                zMC = zSortArr[j].mc;
                mcIndex = CHARS.getChildIndex(zMC);
                if (mcIndex != j){
                    CHARS.swapChildrenAt(mcIndex, j);
                };
                j = (j + 1);
            };
            if (EFAO.xpc++ > EFAO.xpn){
                EFAO.xpc = 0;
                try {
                    if (((!((stage == null))) && (!((myAvatar.objData.iBoostXP == null))))){
                        now = new Date().getTime();
                        if ((rootClass.ui.mcPortrait.iconBoost.boostTS + (rootClass.ui.mcPortrait.iconBoost.iBoostXP * 1000)) < (now + 1000)){
                            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["-", "xpboost"], "str", -1);
                        };
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function hideAllAvatars():void{
            var i:*;
            for (i in avatars) {
                if (((!((avatars[i] == null))) && (!((avatars[i].pMC == null))))){
                    avatars[i].hideMC();
                };
            };
        }
        public function sendRedeemPointRequest(sPackage:String):void{
            rootClass.sfc.sendXtMessage("zm", "redeemPoint", [sPackage], "str", curRoom);
        }
        public function loadBank(){
            if (bank == null){
                rootClass.sfc.sendXtMessage("zm", "loadBank", [], "str", curRoom);
            }
            else {
                rootClass.ui.mcPopup.fOpen("Bank");
            };
        }
        public function getLoaderHost(ldr){
            var i:*;
            for (i in loaderManager) {
                if (loaderManager[i].ldr == ldr){
                    return (loaderManager[i]);
                };
            };
            return (null);
        }
        public function isMyHouse(){
            return (((!((objHouseData == null))) && ((objHouseData.unm == myAvatar.objData.strUsername.toLowerCase()))));
        }
        public function afkTimerHandler(e:Event):void{
            var uoLeaf:*;
            uoLeaf = uoTree[rootClass.sfc.myUserName];
            if (((!((uoLeaf == null))) && (!(uoLeaf.afk)))){
                rootClass.sfc.sendXtMessage("zm", "afk", [true], "str", 1);
            };
        }
        public function initAchievements():void{
            var _local2 = myAvatar.objData;
            with (_local2) {
                ip0 = uint(ip0);
                ia0 = uint(ia0);
                ia1 = uint(ia1);
                ig0 = uint(ig0);
            };
        }
        public function getActionByActID(actID:int):Object{
            var actObj:Object;
            var i:int;
            actObj = null;
            i = 0;
            while (i < actions.active.length) {
                if (actions.active[i].actID == actID){
                    actObj = actions.active[i];
                };
                i++;
            };
            return (actObj);
        }
        public function sendWarVarsRequest():void{
            rootClass.sfc.sendXtMessage("zm", "loadWarVars", [], "str", curRoom);
        }
        public function unequipUseableItem(item:Object=null):void{
            var actionObj:Object;
            var invItem:Object;
            var i:int;
            i = 0;
            i = 0;
            while (i < actions.active.length) {
                if (actions.active[i].ref == "i1"){
                    actionObj = actions.active[i];
                };
                i++;
            };
            actionObj.sArg1 = "";
            actionObj.sArg2 = "";
            rootClass.updateIcons(getActIcons(actionObj), ["icu1"], null);
            if (item == null){
                i = 0;
                while (i < items.length) {
                    invItem = items[i];
                    if (String(invItem.ItemID) == actionObj.sArg1){
                        item = invItem;
                    };
                    i++;
                };
            };
            item.bEquip = 0;
            if (rootClass.ui.mcPopup.mcInventory != null){
                rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
                rootClass.ui.mcPopup.mcInventory.refreshDetail();
            };
        }
        public function toggleHouseEdit():void{
            if (((isMyHouse()) && (!((houseitems == null))))){
                if (rootClass.ui.mcPopup.mcHouseMenu.visible){
                    rootClass.ui.mcPopup.mcHouseMenu.hideEditMenu();
                }
                else {
                    rootClass.ui.mcPopup.mcHouseMenu.showEditMenu();
                };
            };
        }
        public function isFriend(ID:int):Boolean{
            var i:*;
            i = 0;
            while (i < friends.length) {
                if (friends[i].ID == ID){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function getActionResult(actionObj, targets){
            var xtArr:*;
            var cmd:*;
            var tgtStr:String;
            var tAvt:Avatar;
            var i:int;
            var now:Number;
            var icon:*;
            trace(("GAR > " + actionObj.nam));
            xtArr = [];
            cmd = "gar";
            tgtStr = "";
            i = 0;
            xtArr.push(actionID);
            if (targets.length > 0){
                i = 0;
                while (i < targets.length) {
                    tAvt = targets[i].avt;
                    if (i > 0){
                        tgtStr = (tgtStr + ",");
                    };
                    tgtStr = (tgtStr + (actionObj.ref + ">"));
                    if (tAvt.npcType == "monster"){
                        tgtStr = (tgtStr + ("m:" + tAvt.objData.MonMapID));
                    };
                    if (tAvt.npcType == "player"){
                        tgtStr = (tgtStr + ("p:" + tAvt.uid));
                    };
                    i++;
                };
            }
            else {
                tgtStr = (tgtStr + (actionObj.ref + ">"));
            };
            xtArr.push(tgtStr);
            if (actionObj.ref == "i1"){
                xtArr.push(actionObj.sArg1);
            };
            rootClass.sfc.sendXtMessage("zm", cmd, xtArr, "str", 1);
            now = new Date().getTime();
            actionObj.lock = true;
            actionObj.actID = actionID;
            actionObj.lastTS = actionObj.ts;
            actionObj.ts = now;
            if (actionObj.typ != "aa"){
                coolDownAct(actionObj);
                globalCoolDownExcept(actionObj);
                if (((!(autoActionTimer.running)) && ((actionObj.tgt == "h")))){
                    testAction(getAutoAttack());
                };
            }
            else {
                i = 0;
                while (i < actionMap.length) {
                    if (actionMap[i] == actionObj.ref){
                        icon = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))));
                    };
                    i++;
                };
                actionReady = false;
            };
            actionResults[actionResultID] = {};
            actionID++;
            if (actionID > actionIDLimit){
                actionID = 0;
            };
        }
        public function sendUpdateQuestRequest(index:Number, value:Number):void{
            rootClass.sfc.sendXtMessage("zm", "updateQuest", [index, value], "str", curRoom);
        }
        public function sendGetAdRewardRequest():void{
            if (rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap){
                rootClass.sfc.sendXtMessage("zm", "getAdReward", [], "str", curRoom);
            };
        }
        public function sendLoadFriendsListRequest(){
            rootClass.sfc.sendXtMessage("zm", "loadFriendsList", [], "str", curRoom);
        }
        public function updateActBar():void{
            var j:*;
            var icon1:*;
            if (((((!((myAvatar == null))) && (!((myAvatar.dataLeaf == null))))) && (!((myAvatar.dataLeaf.sta == null))))){
                j = 0;
                while (j < rootClass.ui.mcInterface.actBar.numChildren) {
                    icon1 = rootClass.ui.mcInterface.actBar.getChildAt(j);
                    if (((("actObj" in icon1)) && (!((icon1.actObj == null))))){
                        if (myAvatar.dataLeaf.intMP >= Math.round((icon1.actObj.mp * myAvatar.dataLeaf.sta["$cmc"]))){
                            if (icon1.cnt.alpha < 1){
                                icon1.cnt.alpha = 1;
                            };
                        }
                        else {
                            if (icon1.cnt.alpha == 1){
                                icon1.cnt.alpha = 0.4;
                            };
                        };
                    };
                    j++;
                };
            };
        }
        public function showIgnoreList():void{
            var flo:Object;
            if (((!((rootClass.chatF.ignoreList.data.users == null))) && ((rootClass.chatF.ignoreList.data.users.length > 0)))){
                flo = {};
                flo.typ = "userListIgnore";
                rootClass.ui.mcOFrame.fOpenWith(flo);
            }
            else {
                rootClass.chatF.pushMsg("warning", "Your ignore list is empty!.", "SERVER", "", 0);
            };
        }
        public function sendCustomizeRequest(iEyes:int, iMouth:int, iNose:int, Skin:int, Hair:int, Eye:int, Base:int, Trim:int, Accessory:int):void{
            rootClass.sfc.sendXtMessage("zm", "changeArmorColor", [iEyes, iNose, iMouth, Skin, Hair, Eye, Base, Trim, Accessory], "str", curRoom);
        }
        public function killListeners():void{
            zManager.removeEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame);
            removeChild(zManager);
        }
        public function houseItemValidate(mc:MovieClip):void{
            var obj:*;
            var i:int;
            var child:DisplayObject;
            obj = getHouseItem(mc.ItemID);
            if (obj.sType == "Floor Item"){
                mc.isStable = false;
                mc.addEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
            }
            else {
                if (obj.sType == "Wall Item"){
                    mc.isStable = true;
                    i = 0;
                    while (i < map.cell.numChildren) {
                        child = map.cell.getChildAt(i);
                        if ((((((child is MovieClip)) && (MovieClip(child).isFloor))) && (MovieClip(child).hitTestObject(mc)))){
                            mc.isStable = false;
                            break;
                        };
                        i++;
                    };
                    if (!mc.isStable){
                        mc.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 100, 0, 0, 0);
                    }
                    else {
                        mc.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
                    };
                };
            };
        }
        public function countDownAct(e:Event):void{
            var dat:*;
            var ti:*;
            var ct1:*;
            var ct2:*;
            var cd:*;
            var tp:*;
            var mc:*;
            var fr:*;
            var i:*;
            var iMask:*;
            dat = new Date();
            ti = dat.getTime();
            ct1 = MovieClip(e.target);
            ct2 = ct1.icon2;
            cd = Math.round((ct1.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5))));
            tp = ((ti - ct1.ts) / cd);
            mc = Math.floor((tp * 4));
            fr = (int(((tp * 360) % 90)) + 1);
            if (!ct1.actObj.lock){
                if (tp < 0.99){
                    i = 0;
                    while (i < 4) {
                        if (i < mc){
                            ct2.mask[("e" + i)].y = -300;
                        }
                        else {
                            ct2.mask[("e" + i)].y = ct2.mask[(("e" + i) + "oy")];
                            if (i > mc){
                                ct2.mask[("e" + i)].gotoAndStop(0);
                            };
                        };
                        i++;
                    };
                    MovieClip(ct2.mask[("e" + mc)]).gotoAndStop(fr);
                }
                else {
                    iMask = ct2.mask;
                    ct2.mask = null;
                    ct2.parent.removeChild(iMask);
                    ct1.removeEventListener(Event.ENTER_FRAME, countDownAct);
                    ct2.parent.removeChild(ct2);
                    ct2.bitmapData.dispose();
                    ct1.icon2 = null;
                };
            };
        }
        public function sendPVPInviteDecline():void{
            rootClass.sfc.sendXtMessage("zm", "PVPIr", ["0"], "str", rootClass.world.curRoom);
        }
        public function setTarget(avt){
            if (((!((myAvatar == null))) && (!((myAvatar.target == avt))))){
                if (myAvatar.target != null){
                    if (myAvatar.target.npcType == "monster"){
                        if (((((bPvP) && (!((myAvatar.target.dataLeaf.react == null))))) && ((myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)))){
                            myAvatar.target.pMC.modulateColor(avtPCT, "-");
                        }
                        else {
                            myAvatar.target.pMC.modulateColor(avtMCT, "-");
                        };
                    };
                    if (myAvatar.target.npcType == "player"){
                        if (((bPvP) && (!((myAvatar.target.dataLeaf.pvpTeam == myAvatar.dataLeaf.pvpTeam))))){
                            myAvatar.target.pMC.modulateColor(avtMCT, "-");
                        }
                        else {
                            myAvatar.target.pMC.modulateColor(avtPCT, "-");
                        };
                    };
                };
                if (avt != null){
                    if (((!(bPvP)) && ((avt.npcType == "player")))){
                        if (autoActionTimer != null){
                            cancelAutoAttack();
                        };
                    };
                    myAvatar.target = avt;
                    if (myAvatar.target.npcType == "monster"){
                        if (((((bPvP) && (!((myAvatar.target.dataLeaf.react == null))))) && ((myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)))){
                            myAvatar.target.pMC.modulateColor(avtPCT, "+");
                        }
                        else {
                            myAvatar.target.pMC.modulateColor(avtMCT, "+");
                        };
                    };
                    if (myAvatar.target.npcType == "player"){
                        if (((bPvP) && (!((myAvatar.target.dataLeaf.pvpTeam == myAvatar.dataLeaf.pvpTeam))))){
                            myAvatar.target.pMC.modulateColor(avtMCT, "+");
                        }
                        else {
                            myAvatar.target.pMC.modulateColor(avtPCT, "+");
                        };
                    };
                    rootClass.showPortraitTarget(avt);
                }
                else {
                    rootClass.hidePortraitTarget();
                    if (myAvatar.dataLeaf.intState > 0){
                        exitCombat();
                    };
                    myAvatar.target = null;
                };
            };
        }
        public function clickOnEventTest(tx:int, ty:int):Boolean{
            var shadowR:Rectangle;
            var eventR:Rectangle;
            var k:int;
            shadowR = myAvatar.pMC.shadow.getBounds(this);
            eventR = new Rectangle();
            shadowR.x = (tx - (shadowR.width / 2));
            shadowR.y = (ty - (shadowR.height / 2));
            k = 0;
            while (k < arrEvent.length) {
                eventR = arrEvent[k].shadow.getBounds(this);
                if (shadowR.intersects(eventR)){
                    return (true);
                };
                k++;
            };
            return (false);
        }
        public function mvTimerHandler(e:TimerEvent):void{
            var o:Object;
            o = {};
            if (mvTimerObj != null){
                pushMove(mvTimerObj.mc, mvTimerObj.tx, mvTimerObj.ty, mvTimerObj.sp);
                mvTimerObj = null;
                mvTimer.reset();
                mvTimer.start();
            };
        }
        public function sendLoadEnhShopRequest(intShopID:int):void{
            var modal:ModalMC;
            var modalO:Object;
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = "Old enhancement shops are disabled on the PTR.  Please visit Battleon for the new shops.";
            modalO.params = {};
            modalO.btns = "mono";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }
        public function getMonDataById(){
        }
        public function monstersToPads(){
            var i:*;
            var mon:*;
            for (i in monsters) {
                mon = monsters[i];
                if (((!((mon.objData == null))) && ((mon.objData.strFrame == strFrame)))){
                    mon.pMC.walkTo(mon.pMC.ox, mon.pMC.oy, (WALKSPEED * 1.4));
                };
            };
        }
        public function showFriendsList():void{
            var flo:*;
            if (friends != null){
                flo = {};
                flo.typ = "userListFriends";
                flo.ul = friends;
                rootClass.ui.mcOFrame.fOpenWith(flo);
            };
        }
        public function removeMovieFront(){
            var i:int;
            i = 0;
            while ((((FG.numChildren > 0)) && ((i < 100)))) {
                i++;
                FG.removeChildAt(0);
            };
            rootClass.ldrMC.closeHistory();
            rootClass.stage.focus = null;
        }
        public function onHouseItemComplete(e:Event):void{
            var loaderEntry:*;
            loaderEntry = arrHouseItemQueue[0];
            if (loaderEntry.typ == "A"){
                attachHouseItem(loaderEntry);
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0){
                    loadNextHouseItem();
                };
            }
            else {
                rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem(loaderEntry);
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0){
                    loadNextHouseItemB();
                };
            };
        }
        private function actionRangeCheck(actionObj, tAvt:Avatar=null):Boolean{
            var cReg:Point;
            var tReg:Point;
            var a:*;
            var b:*;
            var c:*;
            var softScale:*;
            var range:*;
            var tRect:Rectangle;
            trace("actionRangeCheck >");
            if ((((tAvt == null)) && (!((myAvatar.target == null))))){
                tAvt = myAvatar.target;
            };
            if (((("tgtMin" in actionObj)) && ((actionObj.tgtMin == 0)))){
                return (true);
            };
            if (tAvt == null){
                return (false);
            };
            cReg = myAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
            tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
            if (myAvatar.target.pMC.mcChar.mcAttackBox != null){
                tRect = myAvatar.target.pMC.mcChar.mcAttackBox.getRect(stage);
                tReg.x = (((myAvatar.target.pMC.x)>myAvatar.pMC.x) ? tRect.left : tRect.right);
                tReg.y = tRect.bottom;
            };
            a = Math.abs((tReg.x - cReg.x));
            b = Math.abs((tReg.y - cReg.y));
            c = Math.pow(((a * a) + (b * b)), 0.5);
            softScale = SCALE;
            range = (actionObj.range * softScale);
            if ((((((actionObj.typ == "p")) && ((actionObj.range <= 301)))) || ((actionObj.typ == "aa")))){
                if ((((a <= range)) && ((b <= (30 * SCALE))))){
                    return (true);
                };
                return (false);
            };
            if (c <= range){
                return (true);
            };
            return (false);
        }
        private function actionTimeCheck(actionObj):Boolean{
            var now:Number;
            var hasteCoeff:Number;
            var cd:int;
            trace("actionTimeCheck >");
            now = new Date().getTime();
            hasteCoeff = (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5));
            if (actionObj.auto){
                if (autoActionTimer.running){
                    trace("AA TIMER SELF-CLIPPING");
                    return (false);
                };
                return (true);
            };
            if ((now - GCDTS) < GCD){
                return (false);
            };
            cd = Math.round((actionObj.cd * hasteCoeff));
            if ((now - actionObj.ts) >= cd){
                return (true);
            };
            return (false);
        }
        public function loadHouseInventory(){
            rootClass.sfc.sendXtMessage("zm", "loadHouseInventory", [], "str", curRoom);
        }
        public function getMonstersByCell(s:String):Array{
            var returns:Array;
            var i:int;
            returns = [];
            i = 0;
            while (i < monsters.length) {
                if (((!((monsters[i].dataLeaf == null))) && ((monsters[i].dataLeaf.strFrame == s)))){
                    returns.push(monsters[i]);
                };
                i++;
            };
            return (returns);
        }
        public function equipHouseByID(ID:int):void{
            var j:int;
            j = 0;
            while (j < houseitems.length) {
                houseitems[j].bEquip = (((houseitems[j].ItemID)==ID) ? 1 : 0);
                j++;
            };
        }
        public function mvTimerKill():void{
            mvTimer.reset();
            mvTimerObj = null;
        }
        public function playActionSound(resObj:Object):void{
            var actionResult:Object;
            var v:*;
            trace(resObj.cInf);
            trace(resObj.cInf.charAt(0));
            if ((((resObj.a.length > 0)) && (!((resObj.a[0].type == null))))){
                actionResult = resObj.a[0];
                trace(">>>>>>>>>> playActionSound");
                for (v in actionResult) {
                    trace(((v + ": ") + actionResult[v]));
                };
                trace(myAvatar.pMC.mcChar.currentLabel);
                switch (actionResult.type){
                    case "hit":
                    case "crit":
                    case "miss":
                    case "dodge":
                        if (actionResult.hp < 0){
                            rootClass.mixer.playSound("Heal");
                            break;
                        };
                        if (resObj.cInf.charAt(0) == "p"){
                            if (((!((actionResult.elmt == "Physical"))) && ((myAvatar.pMC.mcChar.currentLabel == "Summon1")))){
                                rootClass.mixer.playSound(actionResult.elmt);
                                break;
                            };
                            if (myAvatar.pMC.mcChar.currentLabel == "SingleShot1"){
                                rootClass.mixer.playSound("SingleShot");
                                break;
                            };
                            if (myAvatar.pMC.mcChar.currentLabel == "MultiShot1"){
                                rootClass.mixer.playSound("MultiShot");
                                break;
                            };
                        };
                        if ((((actionResult.type == "miss")) || ((actionResult.type == "dodge")))){
                            rootClass.mixer.playSound("Miss");
                            break;
                        };
                        if (Math.random() < 0.5){
                            rootClass.mixer.playSound("Hit1");
                        }
                        else {
                            rootClass.mixer.playSound("Hit2");
                        };
                        break;
                    case "miss":
                        rootClass.mixer.playSound("Miss");
                        break;
                    case "none":
                        rootClass.mixer.playSound("Good");
                        break;
                };
            };
        }
        public function getWarzoneByWarzoneName(s:String){
            var i:int;
            i = 0;
            while (i < PVPMaps.length) {
                if (PVPMaps[i].warzone == s){
                    return (PVPMaps[i]);
                };
                i++;
            };
            return (null);
        }
        public function cancelTarget():void{
            if (((!((autoActionTimer == null))) && (autoActionTimer.running))){
                cancelAutoAttack();
                myAvatar.pMC.idle();
                return;
            };
            if (myAvatar.target != null){
                setTarget(null);
                return;
            };
        }
        public function sendSellItemRequest(item:Object):void{
            if (coolDown("sellItem")){
                rootClass.sfc.sendXtMessage("zm", "sellItem", [item.ItemID, item.iQty, item.CharItemID], "str", curRoom);
            };
        }
        public function saveHouseSetup():void{
            var i:int;
            var strNewSetup:String;
            var child:DisplayObject;
            i = 0;
            while (i < objHouseData.arrPlacement.length) {
                if (strFrame == objHouseData.arrPlacement[i].c){
                    objHouseData.arrPlacement.splice(i, 1);
                    i--;
                };
                i++;
            };
            i = 0;
            while (i < CHARS.numChildren) {
                child = CHARS.getChildAt(i);
                if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem))){
                    if (MovieClip(child).isStable){
                        objHouseData.arrPlacement.push({
                            c:strFrame,
                            ID:MovieClip(child).ItemID,
                            x:child.x,
                            y:child.y
                        });
                    }
                    else {
                        unequipHouseItem(MovieClip(child).ItemID);
                        child.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                        CHARS.removeChild(child);
                    };
                };
                i++;
            };
            strNewSetup = createItemPlacementString(objHouseData.arrPlacement);
            trace(objHouseData.sHouseInfo);
            trace(strNewSetup);
            if (objHouseData.sHouseInfo != strNewSetup){
                sendSaveHouseSetup(strNewSetup);
                objHouseData.sHouseInfo = strNewSetup;
            };
            rootClass.ui.mcPopup.mcHouseMenu.showMsg("House Furniture Saved!", "Green");
        }
        public function handleSAR(resObj:Object):void{
            var o:Object;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            o = {};
            cTyp = "";
            cID = -1;
            tTyp = "";
            tID = -1;
            if (resObj.iRes == 1){
                if (resObj.actionResult.typ == "d"){
                    showAuraImpact(resObj.actionResult);
                    o = rootClass.copyObj(resObj.actionResult);
                    o.a = [rootClass.copyObj(resObj.actionResult)];
                }
                else {
                    aggroMap(resObj.actionResult.cInf, resObj.actionResult.tInf, (resObj.actionResult.hp >= 0));
                    cTyp = resObj.actionResult.cInf.split(":")[0];
                    cID = int(resObj.actionResult.cInf.split(":")[1]);
                    tTyp = resObj.actionResult.tInf.split(":")[0];
                    tID = int(resObj.actionResult.tInf.split(":")[1]);
                    o = rootClass.copyObj(resObj.actionResult);
                    o.a = [rootClass.copyObj(resObj.actionResult)];
                    if ((((cTyp == "p")) && ((cID == rootClass.sfc.myUserId)))){
                        showActionResult(o, o.actID);
                    }
                    else {
                        showIncomingAttackResult(o);
                    };
                };
            };
            if (resObj.iRes == 0){
                switch (resObj.actionResult.cInf.split(":")[0]){
                    case "p":
                        showActionResult(null, resObj.actID);
                        break;
                };
            };
        }
        public function killWalkObjects():void{
            var i:int;
            var child:DisplayObject;
            i = 0;
            while (i < map.numChildren) {
                child = map.getChildAt(i);
                if ((((child is MovieClip)) && (MovieClip(child).isEvent))){
                    removeEventListener("enter", MovieClip(child).onEnter);
                };
                i++;
            };
        }
        public function addTempItem(item:Object):void{
            var i:int;
            i = 0;
            while (i < tempitems.length) {
                if (tempitems[i].ItemID == item.ItemID){
                    tempitems[i].iQty = (tempitems[i].iQty + int(item.iQty));
                    return;
                };
                i++;
            };
            tempitems.push(item);
            rootClass.world.invTree[item.ItemID] = item;
        }
        public function AATest(e:Event){
            trace("TIMER AATest > DISABLED");
        }
        public function hideAllPets():void{
            var i:*;
            for (i in avatars) {
                if (avatars[i] != null){
                    avatars[i].unloadPet();
                };
            };
        }
        public function updateFriend(obj:Object):void{
            var i:int;
            if (obj != null){
                i = 0;
                while (i < friends.length) {
                    if (friends[i].ID == obj.ID){
                        friends[i] = obj;
                        break;
                    };
                    i++;
                };
                if (rootClass.ui.mcOFrame.currentLabel == "Idle"){
                    rootClass.ui.mcOFrame.update();
                };
            };
        }
        private function onMapLoadProgress(evt:ProgressEvent):void{
            var percent:int;
            percent = Math.floor(((evt.bytesLoaded / evt.bytesTotal) * 100));
            rootClass.mcConnDetail.showConn((("Loading Map... " + percent) + "%"));
        }
        public function initFriendsList(arrFriends:Array):void{
            if (arrFriends != null){
                friends = arrFriends;
            };
        }
        public function uoTreeLeaf(uoName):Object{
            if (uoTree[uoName.toLowerCase()] == null){
                uoTree[uoName.toLowerCase()] = {};
            };
            return (uoTree[uoName.toLowerCase()]);
        }
        public function setSpawnPoint(strFrame, strPad):void{
            spawnPoint.strFrame = strFrame;
            spawnPoint.strPad = strPad;
        }
        public function createPartyPanel(obj:Object):MovieClip{
            var panelsn:*;
            var panel:*;
            panelsn = (rootClass.ui.mcPartyFrame.numChildren + 1);
            panel = MovieClip(rootClass.ui.mcPartyFrame.addChild(new PartyPanel()));
            panel.strName.text = obj.unm;
            panel.HP.visible = false;
            panel.MP.visible = false;
            panel.txtRange.visible = false;
            panel.addEventListener(MouseEvent.CLICK, onPartyPanelClick, false, 0, true);
            panel.buttonMode = true;
            return (panel);
        }
        public function getAutoAttack():Object{
            var i:*;
            i = 0;
            while (i < actions.active.length) {
                if (((((!((actions.active[i] == null))) && (!((actions.active[i].ref == null))))) && ((actions.active[i].ref == "1")))){
                    return (actions.active[i]);
                };
                i++;
            };
            return (null);
        }
        public function unequipItem(ItemID:int):void{
            var i:int;
            if (((!((items == null))) && ((items.length > 0)))){
                i = 0;
                while (i < items.length) {
                    if (items[i].ItemID == ItemID){
                        items[i].bEquip = 0;
                        return;
                    };
                    i++;
                };
            };
            if (((!((tempitems == null))) && ((tempitems.length > 0)))){
                i = 0;
                while (i < tempitems.length) {
                    if (tempitems[i].ItemID == ItemID){
                        tempitems[i].bEquip = 0;
                        return;
                    };
                    i++;
                };
            };
        }
        public function getActiveQuests():String{
            var str:String;
            var questID:*;
            var quest:*;
            str = "";
            for (questID in questTree) {
                quest = questTree[questID];
                if (quest.status != null){
                    if (str.length){
                        str = (str + ("," + questID));
                    }
                    else {
                        str = (str + questID);
                    };
                };
            };
            return (str);
        }
        public function restStart(){
            afkPostpone();
            restTimer.reset();
            restTimer.start();
        }
        public function initEquippedItems(arrPlacement):void{
            var j:int;
            var i:int;
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].sType != "House"){
                    houseitems[j].bEquip = 0;
                    i = 0;
                    while (i < arrPlacement.length) {
                        if (houseitems[j].ItemID == arrPlacement[i].ID){
                            houseitems[j].bEquip = 1;
                        };
                        i++;
                    };
                };
                j++;
            };
        }
        public function acceptQuest(QuestID:int):void{
            var date:*;
            if (questTree[QuestID] == null){
                getQuests([QuestID]);
            };
            if (questTree[QuestID].status == null){
                questTree[QuestID].status = "p";
            };
            date = new Date();
            questTree[QuestID].ts = date.getTime();
            rootClass.sfc.sendXtMessage("zm", "acceptQuest", [QuestID], "str", curRoom);
        }
        public function toggleFPS():void{
            bfps = (rootClass.ui.mcFPS.visible = !(bfps));
        }
        public function getMCByUserID(uid):AvatarMC{
            if (((!((avatars[uid] == undefined))) && (!((avatars[uid].pMC == null))))){
                return (avatars[uid].pMC);
            };
            return (null);
        }
        public function loadNext(l:Object){
            if (loaderQueue.length > 0){
                loadNextWith(l, loaderQueue.shift());
            };
        }
        public function getMovieFront(){
            if ((((FG.numChildren > 0)) && (!((FG.getChildAt(0) == null))))){
                return (FG.getChildAt(0));
            };
            return (null);
        }
        public function attachMovieFront(strLinkage):MovieClip{
            var mc:MovieClip;
            var AssetClass:Class;
            var addOK:*;
            var tempClass:*;
            AssetClass = (ldr_map.contentLoaderInfo.applicationDomain.getDefinition(strLinkage) as Class);
            addOK = true;
            if (FG.numChildren){
                mc = MovieClip(FG.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass){
                    addOK = false;
                };
            };
            if (addOK){
                removeMovieFront();
                mc = MovieClip(FG.addChild(new (AssetClass)()));
                FG.mouseChildren = true;
            };
            return (mc);
        }
        public function isStatusGone(statusStr:String, tLeaf:Object):Boolean{
            var i:*;
            i = 0;
            while (i < tLeaf.auras.length) {
                if (((!((tLeaf.auras[i].s == null))) && ((tLeaf.auras[i].s == statusStr)))){
                    return (false);
                };
                i++;
            };
            return (true);
        }
        public function getUoLeafById(uid):Object{
            var o:Object;
            for each (o in uoTree) {
                if (o.entID == uid){
                    return (o);
                };
            };
            return (null);
        }
        public function sendLoadFactionRequest(){
            rootClass.sfc.sendXtMessage("zm", "loadFactions", [], "str", curRoom);
        }
        public function onHouseOptionsHouseClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            gotoTown("buyhouse", "Enter", "Spawn");
        }
        public function coolDownAct(actionObj:Object, cd:int=-1, ts:Number=-1){
            var actIcons:Array;
            var icon1:MovieClip;
            var j:int;
            var icon2:*;
            var iMask:MovieClip;
            var bmd:*;
            var bm:*;
            var k:int;
            actIcons = getActIcons(actionObj);
            j = 0;
            while (j < actIcons.length) {
                icon1 = actIcons[j];
                icon2 = null;
                iMask = null;
                if (icon1.icon2 == null){
                    bmd = new BitmapData(50, 50, true, 0);
                    bmd.draw(icon1.mcMask, null, iconCT);
                    bm = new Bitmap(bmd);
                    icon2 = rootClass.ui.mcInterface.actBar.addChild(bm);
                    icon1.icon2 = icon2;
                    if (cd == -1){
                        icon2.transform = icon1.transform;
                        icon1.ts = actionObj.ts;
                        icon1.cd = actionObj.cd;
                    }
                    else {
                        icon2.transform = icon1.transform;
                        icon1.ts = ts;
                        icon1.cd = cd;
                    };
                    iMask = (rootClass.ui.mcInterface.actBar.addChild(new ActMask()) as MovieClip);
                    iMask.scaleX = 0.33;
                    iMask.scaleY = 0.33;
                    iMask.x = int(((icon2.x + (icon2.width / 2)) - (iMask.width / 2)));
                    iMask.y = int(((icon2.y + (icon2.height / 2)) - (iMask.height / 2)));
                    k = 0;
                    while (k < 4) {
                        iMask[(("e" + k) + "oy")] = iMask[("e" + k)].y;
                        k++;
                    };
                    icon2.mask = iMask;
                }
                else {
                    icon2 = icon1.icon2;
                    iMask = icon2.mask;
                    if (cd == -1){
                        icon1.ts = actionObj.ts;
                        icon1.cd = actionObj.cd;
                    }
                    else {
                        icon1.ts = ts;
                        icon1.cd = cd;
                    };
                };
                iMask.e0.stop();
                iMask.e1.stop();
                iMask.e2.stop();
                iMask.e3.stop();
                icon1.removeEventListener(Event.ENTER_FRAME, countDownAct);
                icon1.addEventListener(Event.ENTER_FRAME, countDownAct, false, 0, true);
                j++;
            };
        }
        private function solveTxTy(po:Point, umc:MovieClip):Point{
            var step:int;
            var xs:int;
            var ys:int;
            var pt:Point;
            var pf:Point;
            var pArr:Array;
            var i:int;
            var j:int;
            step = 20;
            xs = (960 / step);
            ys = (550 / step);
            pArr = [];
            i = 0;
            while (i <= xs) {
                j = 0;
                while (j <= ys) {
                    pt = new Point((i * step), (j * step));
                    if (testTxTy(pt, umc)){
                        pArr.push({
                            x:pt.x,
                            y:pt.y,
                            d:Math.abs(Point.distance(po, pt))
                        });
                    };
                    j++;
                };
                i++;
            };
            if (pArr.length){
                pArr.sortOn(["d"], [Array.NUMERIC]);
                pf = new Point(((pArr[0].x + int((Math.random() * 10))) - 5), ((pArr[0].y + int((Math.random() * 10))) - 5));
                while (!(testTxTy(pf, umc))) {
                    pf = new Point(((pArr[0].x + int((Math.random() * 10))) - 5), ((pArr[0].y + int((Math.random() * 10))) - 5));
                };
                return (pf);
            };
            return (null);
        }
        private function getFactionByName(sName:String):Object{
            var i:int;
            i = 0;
            while (i < factions.length) {
                if (factions[i].sName == sName){
                    return (factions[i]);
                };
                i++;
            };
            return (null);
        }
        public function initMonsters(md:Array, mp:Array){
            var i:int;
            var monObj:Object;
            var j:int;
            var Mon:*;
            var prop:*;
            var monLeaf:*;
            i = 0;
            if (((!((md == null))) && (!((mp == null))))){
                monswf = new Array();
                monsters = new Array();
                monObj = null;
                i = 0;
                while (i < mp.length) {
                    j = 0;
                    while (j < md.length) {
                        if (mp[i].MonID == md[j].MonID){
                            monObj = md[j];
                        };
                        j++;
                    };
                    monsters.push(new Avatar());
                    Mon = monsters[(monsters.length - 1)];
                    Mon.npcType = "monster";
                    if (Mon.objData == null){
                        Mon.objData = {};
                    };
                    for (prop in monObj) {
                        Mon.objData[prop] = monObj[prop];
                    };
                    for (prop in mp[i]) {
                        Mon.objData[prop] = mp[i][prop];
                    };
                    monLeaf = monTree[Mon.objData.MonMapID];
                    monLeaf.strFrame = String(Mon.objData.strFrame);
                    if (monLeaf.MonID == Mon.objData.MonID){
                        Mon.dataLeaf = monTree[Mon.objData.MonMapID];
                    }
                    else {
                        Mon.dataLeaf = null;
                    };
                    i++;
                };
                i = 0;
                while (i < md.length) {
                    trace(((((i + "  ") + Game.serverFilePath) + "mon/") + md[i].strMonFileName));
                    rootClass.loadermanager.queueLoad({
                        strFile:((Game.serverFilePath + "mon/") + md[i].strMonFileName),
                        callBackA:onMonLoadComplete
                    });
                    i++;
                };
            };
        }
        public function retrieveMonData(){
            rootClass.sfc.sendXtMessage("zm", "retrieveMonData", [], "str", 1);
        }
        public function unlockActions(){
            var ai:*;
            var actObj:*;
            ai = 0;
            while (ai < actions.active.length) {
                actObj = actions.active[ai];
                actObj.lock = false;
                ai++;
            };
        }
        public function doCastIA(iaState:Object):void{
        }
        public function isHouseEquipped():Boolean{
            var j:int;
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].bEquip == 1){
                    return (true);
                };
                j++;
            };
            return (false);
        }
        public function loadAvatarMCByID(mc:MovieClip, charID:int, callback:Function):void{
            var copier:AvatarMCCopier;
            copier = new AvatarMCCopier(rootClass);
            arrCopier.push({
                copier:copier,
                ID:charID
            });
            copier.loadCharByID(mc, charID, callback);
        }
        public function createItemPlacementString(arrPlacement:Array):String{
            var s:String;
            var i:int;
            var v:*;
            s = "";
            if (arrPlacement.length > 0){
                i = 0;
                while (i < arrPlacement.length) {
                    for (v in arrPlacement[i]) {
                        s = ((((s + v) + ":") + arrPlacement[i][v]) + ",");
                    };
                    s = s.substring(0, (s.length - 1));
                    s = (s + "|");
                    i++;
                };
                s = s.substring(0, (s.length - 1));
            };
            return (s);
        }
        public function getUoLeafByName(unm:String):Object{
            var o:Object;
            unm = unm.toLowerCase();
            for each (o in uoTree) {
                if (o.uoName == unm){
                    return (o);
                };
            };
            return (null);
        }
        public function equipHouse(item:Object):void{
            var modal:*;
            var modalO:*;
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = (("Are you sure you want to equip '" + item.sName) + "'? It will reset your house items?");
            modalO.params = {item:item};
            modalO.callback = equipHouseRequest;
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }
        public function showQuests(strQuestIDs:String, qMode:String):void{
            showQuestList(qMode, strQuestIDs, strQuestIDs);
        }
        public function clearMonstersAndProps():void{
            var i:int;
            var child:DisplayObject;
            var mapChild:DisplayObject;
            var pad:*;
            i = 0;
            if (CHARS != null){
                i = 0;
                while (i < CHARS.numChildren) {
                    child = CHARS.getChildAt(i);
                    if (((child.hasOwnProperty("isProp")) && (MovieClip(child).isProp))){
                        CHARS.removeChild(child);
                        i--;
                    }
                    else {
                        if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem))){
                            child.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                            CHARS.removeChild(child);
                            i--;
                        }
                        else {
                            if (((child.hasOwnProperty("isMonster")) && (MovieClip(child).isMonster))){
                                MovieClip(child).fClose();
                                i--;
                            };
                        };
                    };
                    i++;
                };
            };
            if (mapUI != null){
                i = 0;
                while (i < mapUI.numChildren) {
                    mapChild = mapUI.getChildAt(i);
                    if (((mapChild.hasOwnProperty("isUI")) && (MovieClip(mapChild).isUI))){
                        mapUI.removeChild(mapChild);
                        i--;
                    };
                    i++;
                };
            };
            while (rootClass.ui.mcPadNames.numChildren) {
                pad = rootClass.ui.mcPadNames.getChildAt(0);
                MovieClip(pad).stop();
                rootClass.ui.mcPadNames.removeChild(pad);
            };
        }
        public function gotoQuest(strNewMap:String, strSpawnCell:String, strSpawnPad:String):void{
            gotoTown(strNewMap, strSpawnCell, strSpawnPad);
        }
        public function sendPVPInviteAccept():void{
            rootClass.sfc.sendXtMessage("zm", "PVPIr", ["1"], "str", rootClass.world.curRoom);
        }
        public function getEquippedPowerCount():int{
            var count:int;
            var i:int;
            count = 0;
            i = 0;
            while (i < items.length) {
                if ((((items[i].bEquip == 1)) && ((items[i].sType == "Power")))){
                    count++;
                };
                i++;
            };
            return (count);
        }
        public function objectByIDArray(a:Array){
            var i:int;
            var uid:int;
            var uo:*;
            var unm:String;
            var uoLeaf:Object;
            var strF:String;
            var b:Array;
            trace("** WORLD objectByIDArray >");
            b = [];
            i = 0;
            while (i < a.length) {
                uid = a[i];
                uoLeaf = getUoLeafById(uid);
                unm = uoLeaf.uoName;
                strF = String(uoLeaf.strFrame);
                if (uid == rootClass.sfc.myUserId){
                    strF = strFrame;
                };
                if (avatars[uid] == null){
                    avatars[uid] = new Avatar();
                    avatars[uid].uid = uid;
                    avatars[uid].pnm = unm;
                    if (uid == rootClass.sfc.myUserId){
                        myAvatar = avatars[uid];
                        myAvatar.isMyAvatar = true;
                    };
                };
                avatars[uid].dataLeaf = uoLeaf;
                if ((((avatars[uid].pMC == null)) && ((strF == strFrame)))){
                    avatars[uid].pMC = createAvatarMCArray(uid);
                    b.push(uid);
                };
                updateUserDisplay(uid);
                i++;
            };
            if (b.length > 0){
                getUserDataByIds(b);
            };
        }
        public function getUsersByCell(s:String):Array{
            var returns:Array;
            var aID:String;
            returns = [];
            for (aID in avatars) {
                if (avatars[aID].dataLeaf.strFrame == s){
                    returns.push(avatars[aID]);
                };
            };
            return (returns);
        }
        public function replyToPVPInvite(o:Object):void{
            if (o.accept){
                sendPVPInviteAccept();
            }
            else {
                sendPVPInviteDecline();
            };
        }
        public function getMonsters(MonMapID:int):Array{
            var returns:Array;
            var i:int;
            returns = [];
            i = 0;
            while (i < monsters.length) {
                if (monsters[i].objData.MonMapID == MonMapID){
                    returns.push(monsters[i]);
                };
                i++;
            };
            if (returns.length > 0){
                return (returns);
            };
            return (null);
        }
        public function acceptPartySummon(obj:Object):void{
            if (obj.accept){
                rootClass.sfc.sendXtMessage("zm", "gp", ["psa"], "str", 1);
                if (obj.strF == null){
                    rootClass.sfc.sendXtMessage("zm", "cmd", ["goto", obj.unm], "str", 1);
                }
                else {
                    moveToCell(obj.strF, obj.strP);
                };
            }
            else {
                rootClass.sfc.sendXtMessage("zm", "gp", ["psd", obj.unm], "str", 1);
            };
        }
        public function loadNextHouseItem():void{
            ldr_House.load(new URLRequest(((Game.serverFilePath + "items/house/") + arrHouseItemQueue[0].item.sFile)), loaderC);
            if (!ldr_House.hasEventListener(Event.COMPLETE)){
                ldr_House.contentLoaderInfo.addEventListener(Event.COMPLETE, onHouseItemComplete);
            };
        }
        public function sendEquipItemRequest(item:Object):Boolean{
            var isOK:Boolean;
            isOK = true;
            if (((!((item == null))) && (!(isItemEquipped(item.ItemID))))){
                if (coolDown("equipItem")){
                    rootClass.sfc.sendXtMessage("zm", "equipItem", [item.ItemID], "str", curRoom);
                }
                else {
                    isOK = false;
                };
            }
            else {
                isOK = false;
            };
            return (isOK);
        }
        public function sendLoadShopRequest(intShopID:int):void{
            if ((((shopinfo == null)) || (!((shopinfo.ShopID == intShopID))))){
                if (coolDown("loadShop")){
                    rootClass.sfc.sendXtMessage("zm", "loadShop", [intShopID], "str", curRoom);
                };
            }
            else {
                if (shopinfo.bHouse == 1){
                    rootClass.ui.mcPopup.fOpen("HouseShop");
                }
                else {
                    if (rootClass.isMergeShop(shopinfo)){
                        rootClass.ui.mcPopup.fOpen("MergeShop");
                    }
                    else {
                        rootClass.ui.mcPopup.fOpen("Shop");
                    };
                };
            };
        }
        public function goto(unm){
            var cLeaf:*;
            var tLeaf:*;
            unm = unm.toLowerCase();
            cLeaf = uoTree[rootClass.sfc.myUserName];
            tLeaf = uoTree[String(unm).toLowerCase()];
            if ((((cLeaf.intState == 1)) && ((((cLeaf.pvpTeam == null)) || ((cLeaf.pvpTeam == -1)))))){
                if (((!((tLeaf == null))) && (!((cLeaf.uoName == tLeaf.uoName))))){
                    if (((("nogoto" in map)) && (map.nogoto))){
                        rootClass.chatF.pushMsg("warning", "/goto can't target players within this map.", "SERVER", "", 0);
                        return;
                    };
                    if (cLeaf.strFrame != tLeaf.strFrame){
                        moveToCell(tLeaf.strFrame, tLeaf.strPad);
                    };
                }
                else {
                    rootClass.sfc.sendXtMessage("zm", "cmd", ["goto", unm], "str", 1);
                };
            };
        }
        public function isItemEquipped(ItemID:int):Boolean{
            var item:*;
            item = getItemByID(ItemID);
            if ((((((item == null)) || ((item.bEquip == null)))) || ((item.bEquip == 0)))){
                return (false);
            };
            return (true);
        }
        public function createMonsterMC(monPad:MovieClip, MonID:int):MonsterMC{
            var mondef:*;
            var monMC:MonsterMC;
            var AssetClass:Class;
            mondef = getMonsterDefinition(MonID);
            monMC = new MonsterMC(mondef.strMonName);
            CHARS.addChild(monMC);
            monMC.x = monPad.x;
            monMC.y = monPad.y;
            monMC.ox = monMC.x;
            monMC.oy = monMC.y;
            AssetClass = (rootClass.loadermanager.loaderD.getDefinition(mondef.strLinkage) as Class);
            monMC.removeChildAt(1);
            monMC.addChildAt(new (AssetClass)(), 1);
            monMC.mouseEnabled = false;
            monMC.bubble.mouseEnabled = (monMC.bubble.mouseChildren = false);
            monMC.init();
            if (("strDir" in monPad)){
                if (monPad.strDir == "static"){
                    monMC.isStatic = true;
                };
            };
            return (monMC);
        }
        public function setAchievement(field:String, index:int, value:int=1):void{
            var arrAchievementFields:*;
            arrAchievementFields = ["ia0", "ia1", "ig0"];
            if ((((((arrAchievementFields.indexOf(field) >= 0)) && ((index >= 0)))) && ((index < 32)))){
                rootClass.sfc.sendXtMessage("zm", "setAchievement", [field, index, value], "str", curRoom);
            };
        }
        private function loadNextWith(l:Object, loaderData:Object):void{
            var u:URLRequest;
            var c:LoaderContext;
            c = loaderC;
            if (l != null){
                l.free = false;
                if (loaderData.callBackA != null){
                    l.callBackA = loaderData.callBackA;
                }
                else {
                    l.callBackA = null;
                };
                if (loaderData.callBackB != null){
                    l.callBackB = loaderData.callBackB;
                }
                else {
                    l.callBackB = null;
                };
                if (((((!((loaderData.avt == null))) && ((loaderData.avt == myAvatar)))) && (!((loaderData.sES == null))))){
                    c = mapPlayerAssetClass(loaderData.sES);
                };
                u = new URLRequest(loaderData.strFile);
                l.ldr.load(u, c);
                l.url = u.url;
                l.isOpen = false;
                l.loaderData = loaderData;
                l.timer.reset();
                l.timer.start();
            }
            else {
                trace();
                trace("** No available loader found, event flow may terminate");
                trace();
            };
        }
        public function buyBankSlots(iSlots:int):void{
            rootClass.sfc.sendXtMessage("zm", "buyBankSlots", [iSlots], "str", curRoom);
        }
        public function getRep(arg:Object):int{
            var faction:*;
            faction = getFaction(arg);
            return ((((faction)==null) ? 0 : faction.iRep));
        }
        private function lookAtValue(str:String, index:int):Number{
            return (parseInt(str.charAt(index), 36));
        }
        public function loaderCallback(e:Event){
            var ldr:*;
            var l:*;
            ldr = e.target.loader;
            l = getLoaderHost(ldr);
            if (l != null){
                if (l.callBackA != null){
                    l.callBackA(e);
                };
            };
            closeLoader(l, true);
        }
        public function moveRequest(o:Object):void{
            if (!mvTimer.running){
                pushMove(o.mc, o.tx, o.ty, o.sp);
                mvTimer.reset();
                mvTimer.start();
            }
            else {
                mvTimerObj = o;
            };
        }
        public function aggroMap(cInf:String, tInf:String, isHeal):void{
            var cType:String;
            var cID:String;
            var tType:String;
            var tID:String;
            var unmC:String;
            var unmT:String;
            var cLeaf:Object;
            var tLeaf:Object;
            var mi:*;
            var testMonLeaf:*;
            cType = cInf.split(":")[0];
            cID = cInf.split(":")[1];
            tType = tInf.split(":")[0];
            tID = tInf.split(":")[1];
            unmC = "";
            unmT = "";
            cLeaf = {};
            tLeaf = {};
            if (cType == "p"){
                cLeaf = getUoLeafById(cID);
            }
            else {
                cLeaf = monTree[cID];
            };
            if (tType == "p"){
                tLeaf = getUoLeafById(tID);
            }
            else {
                tLeaf = monTree[tID];
            };
            if (!("targets" in cLeaf)){
                cLeaf.targets = {};
            };
            if (!("targets" in tLeaf)){
                tLeaf.targets = {};
            };
            if (tType == "m"){
                if (!(tID in cLeaf.targets)){
                    cLeaf.targets[tID] = tType;
                };
                if (!(cID in tLeaf.targets)){
                    tLeaf.targets[cID] = cType;
                };
            };
            if ((((((cType == "p")) && ((tType == "p")))) && (isHeal))){
                for (mi in monTree) {
                    testMonLeaf = monTree[mi];
                    if (((!((testMonLeaf.targets[tID] == null))) && (!((cID in testMonLeaf.targets))))){
                        testMonLeaf.targets[cID] = cType;
                    };
                };
            };
        }
        public function resetSpawnPoint():void{
            spawnPoint.strFrame = "Enter";
            spawnPoint.strPad = "Spawn";
        }
        public function attachHouseItem(obj:Object):void{
            var AssetClass:Class;
            var mc:*;
            var child:MovieClip;
            AssetClass = (loaderD.getDefinition(obj.item.sLink) as Class);
            mc = new (AssetClass)();
            mc.x = obj.x;
            mc.y = obj.y;
            mc.ItemID = obj.item.ItemID;
            mc.item = obj.item;
            mc.isHouseItem = true;
            mc.isStable = false;
            mc.addEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick, false, 0, true);
            trace((((((mc + ":") + mc.x) + ":") + mc.y) + "-house Item Info -------------------"));
            child = (CHARS.addChild(mc) as MovieClip);
            child.name = ("mc" + getQualifiedClassName(child));
            houseItemValidate(mc);
        }
        public function partyInvite(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "gp", ["pi", unm], "str", 1);
        }
        public function onPartyPanelClick(e:MouseEvent):void{
            var mc:*;
            var params:*;
            var tAvt:Avatar;
            mc = MovieClip(e.currentTarget);
            params = {};
            params.strUsername = mc.strName.text;
            if (e.shiftKey){
                tAvt = getAvatarByUserName(params.strUsername.toLowerCase());
                if (((((((!((tAvt == null))) && (!((tAvt.pMC == null))))) && (!((tAvt.dataLeaf == null))))) && ((tAvt.dataLeaf.strFrame == myAvatar.dataLeaf.strFrame)))){
                    setTarget(tAvt);
                };
            }
            else {
                rootClass.ui.cMenu.fOpenWith("party", params);
            };
        }
        public function isPartyMember(unm:String):Boolean{
            var i:int;
            unm = unm.toLowerCase();
            if (unm != rootClass.sfc.myUserName){
                i = 0;
                while (i < partyMembers.length) {
                    if (partyMembers[i].toLowerCase() == unm){
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }
        public function iaTrigger(obj:MovieClip){
            var xtArr:*;
            if (coolDown("doIA")){
                xtArr = [];
                xtArr.push(obj.iaType);
                xtArr.push(obj.name);
                if (("iaPathMC" in obj)){
                    xtArr.push(myAvatar.dataLeaf.strFrame);
                }
                else {
                    xtArr.push(obj.iaFrame);
                };
                if (("iaStr" in obj)){
                    xtArr.push(obj.iaStr);
                };
                if (("iaPathMC" in obj)){
                    xtArr.push(obj.iaPathMC);
                };
                rootClass.sfc.sendXtMessage("zm", "ia", xtArr, "str", 1);
            };
        }
        public function getFreeLoader():Object{
            var i:*;
            if (loaderQueue.length > 0){
                for (i in loaderManager) {
                    if (loaderManager[i].free){
                        loaderManager[i].free = false;
                        return (loaderManager[i]);
                    };
                };
                return (null);
            };
            return (null);
        }
        public function sendUseItemRequest(item:Object):void{
            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["+", item.ItemID], "str", -1);
        }
        public function queueLoad(loaderData){
            var l:*;
            loaderData.retries = 1;
            loaderQueue.push(loaderData);
            l = getFreeLoader();
            if (l != null){
                loadNext(l);
            };
        }
        public function testAction(actionObj:Object, forceAARangeError:Boolean=false){
            var a:int;
            var b:int;
            var c:int;
            var cLeaf:Object;
            var tLeaf:Object;
            var cAvt:* = undefined;
            var tAvt:* = undefined;
            var pAvt:* = undefined;
            var tgtMin:int;
            var tgtMax:int;
            var targets:Array;
            var scan:Array;
            var errMsg:String;
            var forceAAloop:Boolean;
            var aura:Object;
            var tgtOK:Boolean;
            var sAvt:Avatar;
            var to:Object;
            var now:Number;
            var actionObj:Object = actionObj;
            var forceAARangeError:Boolean = forceAARangeError;
            trace(("testAction > " + actionObj.nam));
            a = 0;
            b = 0;
            c = 0;
            cLeaf = uoTreeLeaf(rootClass.sfc.myUserName);
            cAvt = myAvatar;
            tAvt = null;
            pAvt = null;
            tgtMin = ((("tgtMin" in actionObj)) ? actionObj.tgtMin : 1);
            tgtMax = ((("tgtMax" in actionObj)) ? actionObj.tgtMax : 1);
            targets = [];
            scan = getAllAvatarsInCell();
            a = 0;
            while (a < scan.length) {
                tAvt = scan[a];
                if ((((((tAvt.dataLeaf == null)) || ((tAvt.dataLeaf.intState == 0)))) || ((((tAvt.pMC == null)) || ((tAvt.pMC.x == null)))))){
                    scan.splice(a, 1);
                    a = (a - 1);
                    if (tAvt == myAvatar.target){
                        setTarget(null);
                    };
                };
                a = (a + 1);
            };
            a = 0;
            tAvt = null;
            if (((!((myAvatar.target == null))) && ((scan.indexOf(myAvatar.target) > -1)))){
                scan.unshift(scan.splice(scan.indexOf(myAvatar.target), 1)[0]);
            };
            afkPostpone();
            errMsg = "none";
            forceAAloop = false;
            if (!actionTimeCheck(actionObj)){
                errMsg = (("Ability '" + actionObj.nam) + "' is not ready yet.");
            };
            if ((((((errMsg == "none")) && (!((actionObj.mp == null))))) && ((Math.round((actionObj.mp * cLeaf.sta["$cmc"])) > cLeaf.intMP)))){
                errMsg = "Not enough energy!";
            };
            if ((((((errMsg == "none")) && ((actionObj.ref == "i1")))) && ((actionObj.sArg1 == "")))){
                errMsg = "No item assigned to that slot!";
            };
            if ((((((((((errMsg == "none")) && (!((myAvatar.target == null))))) && (("filter" in actionObj)))) && (("sRace" in myAvatar.target.objData)))) && (!((myAvatar.target.objData.sRace.toLowerCase() == actionObj.filter.toLowerCase()))))){
                errMsg = (("Target is not a " + actionObj.filter) + "!");
            };
            if (errMsg == "none"){
                for each (aura in cLeaf.auras) {
                    try {
                        if (aura.cat != null){
                            if (aura.cat == "stun"){
                                errMsg = "Cannot act while stunned!";
                            };
                            if (aura.cat == "stone"){
                                errMsg = "Cannot act while petrified!";
                            };
                            if (aura.cat == "disabled"){
                                errMsg = "Cannot act while disabled!";
                            };
                            if (errMsg != "none"){
                                forceAAloop = true;
                            };
                        };
                    }
                    catch(e:Error) {
                        trace(("combat.auraPreFlight > " + e));
                    };
                };
            };
            if ((((errMsg == "none")) || (forceAAloop))){
                if (myAvatar.target != null){
                    tAvt = myAvatar.target;
                    if (myAvatar.target.npcType == "monster"){
                        tLeaf = monTree[tAvt.objData.MonMapID];
                    }
                    else {
                        if (tAvt.npcType == "player"){
                            tLeaf = tAvt.dataLeaf;
                        };
                    };
                };
                switch (actionObj.tgt){
                    case "h":
                        if (tAvt == null){
                            if (tgtMin > 0){
                                for each (tAvt in scan) {
                                    tLeaf = tAvt.dataLeaf;
                                    if (((((!((tLeaf == null))) && (((((((!(bPvP)) && ((tAvt.npcType == "monster")))) || (((((bPvP) && ((tAvt.npcType == "player")))) && (!((cLeaf.pvpTeam == tLeaf.pvpTeam))))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 0)))))))) && (actionRangeCheck(actionObj, tAvt)))){
                                        setTarget(tAvt);
                                        testAction(actionObj);
                                        return;
                                    };
                                };
                                errMsg = "No target selected!";
                                if (actionObj.typ == "aa"){
                                    cancelAutoAttack();
                                };
                            };
                        }
                        else {
                            if (((((((!(bPvP)) && ((tAvt.npcType == "player")))) || (((((bPvP) && ((tAvt.npcType == "player")))) && ((cLeaf.pvpTeam == tLeaf.pvpTeam)))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 1)))))){
                                errMsg = "Can't attack that target!";
                                if (actionObj.typ == "aa"){
                                    cancelAutoAttack();
                                };
                            };
                            if ((((tgtMin > 0)) && ((tAvt.dataLeaf.intState == 0)))){
                                errMsg = "Your target is dead!";
                            };
                        };
                        break;
                    case "f":
                        if (tAvt == null){
                            setTarget(myAvatar);
                            tAvt = myAvatar;
                            tLeaf = tAvt.dataLeaf;
                        };
                        if (((((((!(bPvP)) && ((tAvt.npcType == "monster")))) || (((bPvP) && (!((cLeaf.pvpTeam == tLeaf.pvpTeam))))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 1)))))){
                            tAvt = myAvatar;
                        };
                        tLeaf = tAvt.dataLeaf;
                        break;
                    case "s":
                        if (tAvt == null){
                            setTarget(myAvatar);
                            tAvt = myAvatar;
                        };
                        if (((!((tAvt == null))) && (!((tAvt == myAvatar))))){
                            tAvt = myAvatar;
                        };
                        tLeaf = tAvt.dataLeaf;
                        break;
                };
                pAvt = tAvt;
                if ((((((errMsg == "none")) && (!(actionRangeCheck(actionObj, pAvt))))) || (forceAAloop))){
                    if (!forceAAloop){
                        errMsg = "You are out of range!  Move closer to your target!";
                    };
                    if (actionObj.typ == "aa"){
                        autoActionTimer.delay = 500;
                        autoActionTimer.reset();
                        autoActionTimer.start();
                    };
                };
                tgtOK = true;
                if (errMsg == "none"){
                    while (scan.length > 0) {
                        tAvt = scan[0];
                        tLeaf = tAvt.dataLeaf;
                        tgtOK = true;
                        if (tLeaf.intState == 0){
                            tgtOK = false;
                        };
                        if (((((!((tAvt == null))) && (("filter" in actionObj)))) && (("sRace" in tAvt.objData)))){
                            if (tAvt.objData.sRace.toLowerCase() != actionObj.filter.toLowerCase()){
                                tgtOK = false;
                            };
                        };
                        switch (actionObj.tgt){
                            case "h":
                                if (((((((!(bPvP)) && ((tAvt.npcType == "player")))) || (((((bPvP) && ((tAvt.npcType == "player")))) && ((cLeaf.pvpTeam == tLeaf.pvpTeam)))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 1)))))){
                                    tgtOK = false;
                                };
                                break;
                            case "f":
                                if (((((((!(bPvP)) && ((tAvt.npcType == "monster")))) || (((bPvP) && (!((cLeaf.pvpTeam == tLeaf.pvpTeam))))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 1)))))){
                                    tgtOK = false;
                                };
                                break;
                            case "s":
                                if (((!((tAvt == null))) && (!((tAvt == myAvatar))))){
                                    tgtOK = false;
                                };
                                break;
                        };
                        if (tgtOK){
                            sAvt = myAvatar;
                            if ((((actionObj.fx == "c")) && ((targets.length > 0)))){
                                sAvt = targets[(targets.length - 1)].avt;
                            };
                            a = Math.abs((tAvt.pMC.x - sAvt.pMC.x));
                            b = Math.abs((tAvt.pMC.y - sAvt.pMC.y));
                            c = Math.pow(((a * a) + (b * b)), 0.5);
                            if (c < (actionObj.range * SCALE)){
                                targets.push({
                                    avt:tAvt,
                                    d:c,
                                    hp:tLeaf.intHP
                                });
                            };
                        };
                        scan.shift();
                    };
                };
                targets.sortOn("hp", Array.NUMERIC);
                if (pAvt != null){
                    a = 0;
                    while (a < targets.length) {
                        to = targets[a];
                        if (to.avt == pAvt){
                            targets.unshift(targets.splice(a, 1)[0]);
                        };
                        a = (a + 1);
                    };
                };
                if (targets.length > tgtMax){
                    targets = targets.splice(0, tgtMax);
                };
                if (targets.length > 0){
                    if (pAvt != null){
                        if (((!((targets[0].avt == null))) && (!((targets[0].avt.dataLeaf == null))))){
                            tAvt = targets[0].avt;
                            tLeaf = tAvt.dataLeaf;
                        }
                        else {
                            tAvt = null;
                            tLeaf = null;
                        };
                    }
                    else {
                        tAvt = null;
                        tLeaf = null;
                    };
                };
            };
            if (errMsg == "none"){
                if (cLeaf.intState != 0){
                    if (((((!(actionObj.lock)) && ((((tLeaf == null)) || (!((tLeaf.intState == 0))))))) && ((targets.length >= tgtMin)))){
                        doAction(actionObj, targets);
                    };
                    if ((((myAvatar.target == null)) || ((((tLeaf == null)) || ((tLeaf.intState == 0)))))){
                        exitCombat();
                    };
                };
            }
            else {
                now = new Date().getTime();
                if ((((errMsg == "You are out of range!  Move closer to your target!")) && (((!((actionObj.typ == "aa"))) || (forceAARangeError))))){
                    if ((now - actionRangeSpamTS) > 3000){
                        actionRangeSpamTS = now;
                        rootClass.chatF.pushMsg("warning", errMsg, "SERVER", "", 0);
                    };
                }
                else {
                    if (actionObj.typ != "aa"){
                        rootClass.chatF.pushMsg("warning", errMsg, "SERVER", "", 0);
                    };
                };
            };
        }
        public function getQuestValue(index:Number):Number{
            if (((!((myAvatar == null))) && (!((myAvatar.objData == null))))){
                return (lookAtValue(myAvatar.objData.strQuests, index));
            };
            return (-1);
        }
        public function onHouseOptionsMiscClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            showHouseInventory(73);
        }
        public function flyToggle():void{
            var uoLeaf:*;
            var tarPt:Point;
            if ((((((myAvatar == null)) || ((myAvatar.pMC == null)))) || (myAvatar.pMC.bFlyTransition))){
                return;
            };
            uoLeaf = uoTree[rootClass.sfc.myUserName];
            if ((((int(uoLeaf.intLevel) < 5)) && (!(myAvatar.isUpgraded())))){
                rootClass.MsgBox.notify("Requires membership or level 5 to fly!");
                return;
            };
            if (((!((uoLeaf == null))) && ((uoLeaf.intState == 1)))){
                myAvatar.pMC.fly = !(uoLeaf.fly);
                if (!uoLeaf.fly){
                    tarPt = myAvatar.pMC.simulateJumpUp();
                    myAvatar.pMC.GroundToFly();
                }
                else {
                    tarPt = myAvatar.pMC.simulateJumpDown();
                    myAvatar.pMC.FlyToGround();
                };
                pushMove(myAvatar.pMC, tarPt.x, tarPt.y, 0, int(!(uoLeaf.fly)));
            };
        }
        public function showActionResult(actionResult, actID){
            var dat:*;
            var actObj:*;
            var originTS:*;
            var returnTS:*;
            var latency:*;
            var cd:*;
            var aacd:*;
            dat = new Date();
            actObj = getActionByActID(actID);
            if (actObj != null){
                actObj.lock = false;
                actObj.actID = -1;
                originTS = actObj.ts;
                returnTS = dat.getTime();
                latency = int(((returnTS - originTS) / 2));
                if (actObj.typ == "aa"){
                    cd = Math.round((actObj.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5))));
                    aacd = (cd - int((returnTS - originTS)));
                    if (aacd > cd){
                        aacd = cd;
                    };
                    if (aacd < (cd - 100)){
                        aacd = (cd - 100);
                    };
                    autoActionTimer.delay = aacd;
                    autoActionTimer.reset();
                    autoActionTimer.start();
                };
                if (actionResult == null){
                    actObj.ts = actObj.lastTS;
                }
                else {
                    actObj.ts = Math.max(int((returnTS - latency)), (originTS + minLatencyOneWay));
                    unlockActionsExcept(actObj);
                    rootClass.updateActionObjIcon(actObj);
                };
            };
            if (actionResult != null){
                playActionSound(actionResult);
                if (actionResult.type != "none"){
                    actionResults[actionResultID] = new ActionImpactTimer();
                    actionResults[actionResultID].world = MovieClip(this);
                    actionResults[actionResultID].actionResult = actionResult;
                    actionResults[actionResultID].showImpact(250);
                    if (++actionResultID > actionResultIDLimit){
                        actionResultID = 0;
                    };
                };
            };
        }
        public function actCastTrigger(o:Object):void{
            switch (o.typ){
                case "sia":
                    siaTrigger(o);
                    break;
            };
        }
        public function moveToCell(strF:String, strP:String, silent:Boolean=false):void{
            var xtArr:*;
            var uoLeaf:*;
            afkPostpone();
            if ((((((objLock == null)) || ((objLock[strF] == null)))) || ((objLock[strF] <= intKillCount)))){
                if (uoTree[rootClass.sfc.myUserName].freeze == null){
                    xtArr = [];
                    actionReady = false;
                    bitWalk = false;
                    uoLeaf = {};
                    uoLeaf.strFrame = strF;
                    uoLeaf.strPad = strP;
                    if (strP.toLowerCase() != "none"){
                        uoLeaf.tx = 0;
                        uoLeaf.ty = 0;
                    };
                    uoTreeLeafSet(rootClass.sfc.myUserName, uoLeaf);
                    strFrame = strF;
                    strPad = strP;
                    if (!silent){
                        rootClass.sfc.sendXtMessage("zm", "moveToCell", [strF, strP], "str", curRoom);
                    };
                    exitCell();
                    map.gotoAndPlay("Blank");
                };
            };
        }
        public function killLoaders(){
            var lmi:Object;
            var i:*;
            for (i in loaderManager) {
                lmi = loaderManager[i];
                lmi.free = true;
                lmi.isOpen = false;
                lmi.loaderData = null;
                lmi.timer.reset();
                lmi.callBackA = null;
                lmi.callBackB = null;
            };
            loaderQueue = [];
        }
        public function healByIcon(tAvt:Avatar):void{
            var actObj:Object;
            actObj = getFirstHeal();
            if (actObj != null){
                setTarget(tAvt);
                testAction(actObj);
            };
        }
        public function removeTempItem(ItemID:int, iQty:int):void{
            var i:int;
            i = 0;
            while (i < tempitems.length) {
                if (tempitems[i].ItemID == ItemID){
                    if (tempitems[i].iQty > iQty){
                        tempitems[i].iQty = (tempitems[i].iQty - iQty);
                    }
                    else {
                        tempitems[i].iQty = 0;
                        tempitems.splice(i, 1);
                    };
                    return;
                };
                i++;
            };
        }
        public function removeItem(CharItemID:int):void{
            var item:Object;
            var i:int;
            var j:int;
            item = {};
            i = 0;
            while (i < items.length) {
                item = items[i];
                if (item.CharItemID == CharItemID){
                    if ((((item.sES == "ar")) || ((item.iQty <= 1)))){
                        item.iQty = 0;
                        rootClass.resetInvTreeByItemID(item.ItemID);
                        items.splice(i, 1);
                    }
                    else {
                        item.iQty--;
                    };
                    return;
                };
                i++;
            };
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].CharItemID == CharItemID){
                    if (houseitems[j].iQty > 1){
                        houseitems[j].iQty--;
                    }
                    else {
                        houseitems[j].iQty = 0;
                        houseitems.splice(j, 1);
                    };
                    return;
                };
                j++;
            };
        }
        private function onMonLoadComplete(event:Event){
            monswf.push(MovieClip(Loader(event.target.loader).content));
            trace(((((("      >>>> successful " + Loader(event.target.loader).contentLoaderInfo.url) + " ") + monswf.length) + " / ") + mondef.length));
            if (monswf.length == mondef.length){
                enterMap();
            };
        }
        public function isMovieFront(strLinkage:String):Boolean{
            var mc:MovieClip;
            var AssetClass:Class;
            var isMF:*;
            var tempClass:*;
            AssetClass = (ldr_map.contentLoaderInfo.applicationDomain.getDefinition(strLinkage) as Class);
            isMF = false;
            if (FG.numChildren){
                mc = MovieClip(FG.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass){
                    isMF = true;
                };
            };
            return (isMF);
        }
        public function getMonsterCluster(MonMapID:int):Array{
            var cluster:*;
            var i:int;
            cluster = [];
            i = 0;
            while (i < monsters.length) {
                if (monsters[i].objData.MonMapID == MonMapID){
                    cluster.push(monsters[i]);
                };
                i++;
            };
            return (cluster);
        }
        public function handleAuraEvent(cmd:String, resObj:Object):void{
            var cLeaf:Object;
            var tLeaf:Object;
            var cAvt:Avatar;
            var tAvt:Avatar;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var forceAura:Boolean;
            var cmd:String = cmd;
            var resObj:Object = resObj;
            trace("handleAuraEvent >");
            if (rootClass.sfcSocial){
                forceAura = false;
                if ((((cmd.indexOf("++") > -1)) || ((cmd.indexOf("--") > -1)))){
                    forceAura = true;
                };
                cAvt = null;
                tAvt = null;
                if (resObj.cInf != null){
                    cTyp = String(resObj.cInf.split(":")[0]);
                    cID = int(resObj.cInf.split(":")[1]);
                    switch (cTyp){
                        case "p":
                            cAvt = getAvatarByUserID(cID);
                            cLeaf = getUoLeafById(cID);
                            break;
                        case "m":
                            cAvt = getMonster(cID);
                            cLeaf = monTree[cID];
                            break;
                    };
                };
                if (resObj.tInf != null){
                    tTyp = String(resObj.tInf.split(":")[0]);
                    tID = int(resObj.tInf.split(":")[1]);
                    switch (tTyp){
                        case "p":
                            try {
                                tAvt = getAvatarByUserID(tID);
                                tLeaf = getUoLeafById(tID);
                                if (((forceAura) || ((tLeaf.strFrame == strFrame)))){
                                    if (rootClass.sfcSocial){
                                        showAuraChange(resObj, tAvt, tLeaf);
                                    };
                                };
                            }
                            catch(e:Error) {
                            };
                            break;
                        case "m":
                            try {
                                tAvt = getMonster(tID);
                                tLeaf = monTree[tID];
                                if (((forceAura) || ((((cLeaf == null)) || (((!((cLeaf.targets[tID] == null))) && ((tLeaf.strFrame == strFrame)))))))){
                                    if (rootClass.sfcSocial){
                                        showAuraChange(resObj, tAvt, tLeaf);
                                    };
                                };
                            }
                            catch(e:Error) {
                                trace((" HAE > " + e));
                            };
                            break;
                    };
                };
            };
        }
        public function exitCombat(){
            var i:int;
            actionReady = false;
            if (((!((actions == null))) && (!((actions.active == null))))){
                i = 0;
                while (i < actions.active.length) {
                    actions.active[i].lock = false;
                    i++;
                };
            };
            if (myAvatar != null){
                if (((((((!((myAvatar.pMC == null))) && (!((myAvatar.pMC.mcChar == null))))) && (!(myAvatar.pMC.mcChar.onMove)))) && (!((myAvatar.pMC.mcChar.currentLabel == "Rest"))))){
                    myAvatar.pMC.mcChar.gotoAndStop("Idle");
                };
                if (myAvatar.dataLeaf != null){
                    myAvatar.dataLeaf.targets = {};
                };
                cancelAutoAttack();
            };
        }
        public function getQuestListQS(iSlot:int, callback:Function):void{
            if (objQuestList[iSlot] != null){
                (callback(objQuestList[iSlot]));
            }
            else {
                objQuestList.callbackQS = callback;
                rootClass.sfc.sendXtMessage("zm", "getQuestListQS", [iSlot], "str", curRoom);
            };
        }
        private function mapResizeCheck(e:TimerEvent):void{
            if (((!((map == null))) && ((mapBmps.length > 0)))){
                if (mapNW != stage.stageWidth){
                    rasterize(mapBmps);
                };
            };
        }
        public function canTurnInQuest(questID:int):Boolean{
            var quest:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            quest = questTree[questID];
            if (((!((quest.turnin == null))) && ((quest.turnin.length > 0)))){
                i = 0;
                while (i < quest.turnin.length) {
                    qItemID = quest.turnin[i].ItemID;
                    qItemQ = quest.turnin[i].iQty;
                    if ((((invTree[qItemID] == null)) || ((invTree[qItemID].iQty < qItemQ)))){
                        return (false);
                    };
                    if (isItemEquipped(qItemID)){
                        rootClass.MsgBox.notify("Cannot turn in equipped item(s)!");
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }
        public function addPartyMember(unm:String){
            partyMembers.push(unm);
            updatePartyFrame();
        }
        public function hideHouseOptions():void{
            var mc:MovieClip;
            var i:int;
            mc = rootClass.ui.mcPopup.mcHouseOptions;
            if (mc.visible){
                i = 0;
                while (i < mc.numChildren) {
                    mc.getChildAt(i).x = 190;
                    i++;
                };
            };
            mc.visible = false;
        }
        public function loadHouseItemB(item:Object):void{
            var item:Object = item;
            try {
                rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem({item:item});
            }
            catch(err:Error) {
                rootClass.ui.mcPopup.mcHouseMenu.preview.t2.visible = true;
                rootClass.ui.mcPopup.mcHouseMenu.preview.cnt.visible = false;
                rootClass.ui.mcPopup.mcHouseMenu.preview.bAdd.visible = false;
                arrHouseItemQueue.push({
                    item:item,
                    typ:"B"
                });
                if (arrHouseItemQueue.length > 0){
                    loadNextHouseItemB();
                };
            };
        }
        public function createAvatarMC(uid:Number):AvatarMC{
            var char:AvatarMC;
            trace("** WORLD createAvatarMC >");
            char = new AvatarMC();
            char.name = ("a" + uid);
            char.x = -600;
            char.y = 0;
            char.pAV = avatars[uid];
            char.world = this;
            char.rootClass = this.rootClass;
            getUserDataById(uid);
            return (char);
        }
        public function moveToCellByIDa(id:int):void{
            rootClass.sfc.sendXtMessage("zm", "mtcid", [id], "str", curRoom);
        }
        public function moveToCellByIDb(id:int):void{
            var mc:MovieClip;
            var i:int;
            i = 0;
            while (i < arrEvent.length) {
                mc = (arrEvent[i] as MovieClip);
                if (((((("tID" in mc)) && ((mc.tID == id)))) || ((((mc.name.indexOf("ia") == 0)) && ((int(mc.name.substr(2)) == id)))))){
                    moveToCell(mc.tCell, mc.tPad, true);
                };
                i++;
            };
        }
        public function getFaction(arg:Object):Object{
            return (((isNaN(Number(arg))) ? getFactionByName(String(arg)) : getFactionByID(int(arg))));
        }
        public function setCellMap(o:Object):void{
            cellMap = o;
        }
        public function showAuraChange(resObj:Object, tAvt:Avatar, tLeaf:Object){
            var tMC:MovieClip;
            var actionDamage:* = undefined;
            var cAvt:Avatar;
            var cLeaf:Object;
            var i:int;
            var nc:int;
            var gap:int;
            var child:DisplayObject;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var aura:Object;
            var existingAura:Object;
            var dateObj:Date;
            var isOK:Boolean;
            var auras:* = undefined;
            var resObj:Object = resObj;
            var tAvt:Avatar = tAvt;
            var tLeaf:Object = tLeaf;
            trace("showAuraChange > ");
            tMC = tAvt.pMC;
            actionDamage = null;
            cAvt = null;
            cLeaf = null;
            if (tMC != null){
                i = 0;
                nc = tMC.numChildren;
                gap = 1;
                if (resObj.cInf != null){
                    cTyp = String(resObj.cInf.split(":")[0]);
                    cID = int(resObj.cInf.split(":")[1]);
                    switch (cTyp){
                        case "p":
                            cAvt = getAvatarByUserID(cID);
                            cLeaf = getUoLeafById(cID);
                            break;
                        case "m":
                            cAvt = getMonster(cID);
                            cLeaf = monTree[cID];
                            break;
                    };
                };
                if (resObj.auras != null){
                    gap = resObj.auras.length;
                };
                i = 0;
                while (i < nc) {
                    child = tMC.getChildAt(i);
                    if (((((!((child == null))) && (!((child.toString() == null))))) && ((child.toString().indexOf("auraDisplay") > -1)))){
                        child.y = (child.y - (int((child.height + 3)) * gap));
                    };
                    i = (i + 1);
                };
                aura = {};
                existingAura = {};
                dateObj = new Date();
                isOK = true;
                if (tLeaf.auras == null){
                    tLeaf.auras = [];
                };
                if (tLeaf.passives == null){
                    tLeaf.passives = [];
                };
                switch (resObj.cmd){
                    case "aura+":
                    case "aura++":
                    case "aura+p":
                        i = 0;
                        while (i < resObj.auras.length) {
                            aura = resObj.auras[i];
                            aura.cLeaf = cLeaf;
                            if (resObj.cmd == "aura+p"){
                                aura.passive = true;
                            }
                            else {
                                aura.passive = false;
                            };
                            if (!aura.passive){
                                if (aura.t != null){
                                    aura.ts = dateObj.getTime();
                                };
                                if ((((((((tAvt == myAvatar)) || ((tAvt == myAvatar.target)))) || (((!((tLeaf.targets == null))) && (!((tLeaf.targets[rootClass.sfc.myUserId] == null))))))) || ((resObj.cmd == "aura++")))){
                                    actionDamage = new auraDisplay();
                                    actionDamage.t.ti.text = ("+" + aura.nam);
                                    tMC.addChild(actionDamage);
                                    actionDamage.x = (((tMC.mcChar.scaleX)<0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                    actionDamage.y = ((tMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                                    trace(((("***>>>>> " + aura.skillID) + " ") + getIconBySkillID(aura.skillID)));
                                };
                                if (aura.s != null){
                                    switch (aura.s){
                                        case "s":
                                            if (tMC.mcChar.currentLabel != "Fall"){
                                                tMC.clearQueue();
                                                tMC.mcChar.gotoAndPlay("Fall");
                                            };
                                            break;
                                    };
                                };
                                if (aura.cat != null){
                                    isOK = true;
                                    for each (existingAura in tLeaf.auras) {
                                        try {
                                            if (((!((existingAura.cat == null))) && ((existingAura.cat == aura.cat)))){
                                                isOK = false;
                                            };
                                        }
                                        catch(e:Error) {
                                            trace(("combat.applyAuras > " + e));
                                        };
                                    };
                                    if (isOK){
                                        switch (aura.cat){
                                            case "Stun":
                                                if (tMC.mcChar.currentLabel != "Fall"){
                                                    tMC.clearQueue();
                                                    tMC.mcChar.gotoAndPlay("Fall");
                                                };
                                                break;
                                            case "paralyze":
                                            case "stone":
                                                tMC.modulateColor(statusStoneCT, "+");
                                                tMC.mcChar.stop();
                                                break;
                                        };
                                    };
                                };
                                if (((!((aura.animOn == null))) && ((((cLeaf == null)) || ((cLeaf.intState == 2)))))){
                                    tMC.mcChar.gotoAndPlay(aura.animOn);
                                };
                                if (aura.msgOn != null){
                                    if (aura.msgOn.charAt(0) == "@"){
                                        if (tAvt == myAvatar){
                                            rootClass.addUpdate(aura.msgOn.substr(1));
                                        };
                                    }
                                    else {
                                        rootClass.addUpdate(aura.msgOn);
                                    };
                                };
                                if (aura.isNew){
                                    tLeaf.auras.push(aura);
                                }
                                else {
                                    updateAuraData(cLeaf, aura, tLeaf);
                                };
                            }
                            else {
                                tLeaf.passives.push(aura);
                            };
                            i = (i + 1);
                        };
                        break;
                    case "aura-":
                    case "aura--":
                        auras = [];
                        if (resObj.auras != null){
                            auras = resObj.auras;
                        }
                        else {
                            if (resObj.aura != null){
                                auras = [resObj.aura];
                            };
                        };
                        i = 0;
                        while (i < auras.length) {
                            aura = auras[i];
                            if (removeAura(aura, tLeaf)){
                                if ((((((((tAvt == myAvatar)) || ((tAvt == myAvatar.target)))) || (((!((tLeaf.targets == null))) && (!((tLeaf.targets[rootClass.sfc.myUserId] == null))))))) || ((resObj.cmd == "aura--")))){
                                    actionDamage = new auraDisplay();
                                    actionDamage.t.ti.text = ("-" + aura.nam);
                                    actionDamage.t.ti.textColor = 3407871;
                                    tMC.addChild(actionDamage);
                                    actionDamage.x = (((tMC.mcChar.scaleX)<0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                    actionDamage.y = (tMC.pname.y + 25);
                                    trace(((("***>>>>> " + aura.skillID) + " ") + getIconBySkillID(aura.skillID)));
                                };
                                if (aura.s != null){
                                    switch (aura.s){
                                        case "s":
                                            if (tMC.mcChar.currentLabel == "Fall"){
                                                if (isStatusGone("s", tLeaf)){
                                                    tMC.mcChar.gotoAndPlay("Getup");
                                                };
                                            };
                                            break;
                                    };
                                };
                                if (aura.cat != null){
                                    isOK = true;
                                    for each (existingAura in tLeaf.auras) {
                                        try {
                                            if (((!((existingAura.cat == null))) && ((existingAura.cat == aura.cat)))){
                                                isOK = false;
                                            };
                                        }
                                        catch(e:Error) {
                                            trace(("combat.applyAuras > " + e));
                                        };
                                    };
                                    if (isOK){
                                        switch (aura.cat){
                                            case "Stun":
                                                if (tMC.mcChar.currentLabel == "Fall"){
                                                    tMC.mcChar.gotoAndPlay("Getup");
                                                };
                                                break;
                                            case "stone":
                                                tMC.modulateColor(statusStoneCT, "-");
                                                tMC.mcChar.play();
                                                break;
                                        };
                                    };
                                };
                                if (aura.animOff != null){
                                    tMC.mcChar.gotoAndPlay(aura.animOff);
                                };
                                if (aura.msgOff != null){
                                    if (aura.msgOff.charAt(0) == "@"){
                                        if (tAvt == myAvatar){
                                            rootClass.addUpdate(aura.msgOff.substr(1));
                                        };
                                    }
                                    else {
                                        rootClass.addUpdate(aura.msgOff);
                                    };
                                };
                            };
                            i = (i + 1);
                        };
                        break;
                    case "aura*":
                        actionDamage = new auraDisplay();
                        actionDamage.t.ti.text = "* IMMUNE *";
                        tMC.addChild(actionDamage);
                        actionDamage.x = (((tMC.mcChar.scaleX)<0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                        actionDamage.y = ((tMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                        break;
                };
            };
        }
        public function repairAvatars():void{
            var avt:Avatar;
            var isProblem:Boolean;
            rootClass.chatF.pushMsg("server", "Attempting to repair incomplete Avatars...", "SERVER", "", 0);
            isProblem = false;
            for each (avt in avatars) {
                if (!avt.pMC.isLoaded){
                    isProblem = true;
                    if (avt.objData != null){
                        rootClass.chatF.pushMsg("server", (" > repairing " + avt.objData.strUsername), "SERVER", "", 0);
                        avt.initAvatar(avt.objData);
                    }
                    else {
                        if (avt.pnm != null){
                            rootClass.chatF.pushMsg("warning", ((" *> Data load incomplete for " + avt.pnm) + ", repair cannot continue."), "SERVER", "", 0);
                        }
                        else {
                            rootClass.chatF.pushMsg("warning", " *> Avatar instantiated but no data exists at all!", "SERVER", "", 0);
                        };
                    };
                };
            };
            if (!isProblem){
                rootClass.chatF.pushMsg("server", " > No incomplete Avatars found!", "SERVER", "", 0);
            };
        }
        public function showQuestLink(o:Object):void{
            var itemOpen:String;
            var itemClose:String;
            var msg:String;
            itemOpen = "$({";
            itemClose = "})$";
            msg = "";
            if (o.unm.toLowerCase() != rootClass.sfc.myUserName){
                msg = (msg + ((o.unm + " issues a Call to Arms for ") + itemOpen));
                msg = (msg + ["quest", o.quest.sName, o.quest.QuestID, o.quest.iLvl, o.unm].toString());
                msg = (msg + (itemClose + "!"));
            }
            else {
                msg = (msg + (("You issue a Call to Arms for " + o.quest.sName) + "!"));
            };
            rootClass.chatF.pushMsg("event", msg, "SERVER", "", 0);
        }
        public function destroyAvatar(uid:Number){
            if (avatars[uid] != null){
                if (avatars[uid].pMC != null){
                    if (!avatars[uid].isMyAvatar){
                        avatars[uid].pMC.fClose();
                        delete avatars[uid];
                    };
                };
            };
        }
        public function updateUserDisplay(uid:Number){
            var umc:*;
            var uoLeaf:*;
            var strF:*;
            var intState:*;
            var spawnPad:*;
            var pt:*;
            trace(("** WORLD updateUserDisplay > " + uid));
            umc = getMCByUserID(uid);
            uoLeaf = getUoLeafById(uid);
            strF = String(uoLeaf.strFrame);
            if (strF == strFrame){
                umc.tx = int(uoLeaf.tx);
                umc.ty = int(uoLeaf.ty);
                intState = int(uoLeaf.intState);
                spawnPad = null;
                if (((("strPad" in uoLeaf)) && (!((uoLeaf.strPad.toLowerCase() == "none"))))){
                    if ((uoLeaf.strPad in map)){
                        spawnPad = map[uoLeaf.strPad];
                    };
                    if (spawnPad == null){
                        spawnPad = map.cell[uoLeaf.strPad];
                    };
                };
                if (((!((umc.tx == 0))) || (!((umc.ty == 0))))){
                    if (testTxTy(new Point(umc.tx, umc.ty), umc)){
                        umc.x = umc.tx;
                        umc.y = umc.ty;
                    }
                    else {
                        pt = solveTxTy(new Point(umc.tx, umc.ty), umc);
                        if (pt == null){
                            umc.x = int((960 / 2));
                            umc.y = int((550 / 2));
                        }
                        else {
                            umc.x = pt.x;
                            umc.y = pt.y;
                        };
                    };
                }
                else {
                    if (spawnPad == null){
                        umc.x = int((960 / 2));
                        umc.y = int((550 / 2));
                    }
                    else {
                        umc.x = int(((spawnPad.x + int((Math.random() * 10))) - 5));
                        umc.y = int(((spawnPad.y + int((Math.random() * 10))) - 5));
                    };
                };
                if (umc.pAV.isMyAvatar){
                    mapScrollCheck();
                };
                umc.scale(SCALE);
                if (showHPBar){
                    umc.showHPBar();
                }
                else {
                    umc.hideHPBar();
                };
                if (uid == rootClass.sfc.myUserId){
                    bitWalk = true;
                };
                if ((((CELL_MODE == "normal")) || ((uid == rootClass.sfc.myUserId)))){
                    umc.pAV.showMC();
                }
                else {
                    umc.pAV.hideMC();
                };
                if (((((bPvP) && (!((uoLeaf.pvpTeam == null))))) && ((uoLeaf.pvpTeam > -1)))){
                    umc.mcChar.pvpFlag.visible = true;
                    umc.mcChar.pvpFlag.gotoAndStop(new Array("a", "b", "c")[uoLeaf.pvpTeam]);
                };
                if (umc.isLoaded){
                    umc.gotoAndPlay("in2");
                }
                else {
                    umc.gotoAndPlay("hold");
                };
            };
        }
        public function connTest(e:Event){
            trace("TIMER connTest > Failed!  This should not appear, test was removed.");
        }
        public function sendGetCharDataByID(CharID:int):void{
            rootClass.sfc.sendXtMessage("zm", "getCharDataByID", [CharID], "str", -1);
        }
        public function removePartyMember(unm:String){
            var pi:*;
            if (unm != rootClass.sfc.myUserName){
                pi = partyMembers.indexOf(unm);
                if (pi > -1){
                    partyMembers.splice(pi, 1);
                };
            }
            else {
                partyID = -1;
                partyOwner = "";
                partyMembers = [];
            };
            updatePartyFrame();
        }
        public function getUserDataById(uid){
            trace("** WORLD getUserDataById >");
            rootClass.sfc.sendXtMessage("zm", "retrieveUserData", [uid], "str", curRoom);
        }
        public function getAchievement(field:String, index:int):int{
            var iA:*;
            if ((((index < 0)) || ((index > 31)))){
                return (-1);
            };
            iA = myAvatar.objData[field];
            if (iA == null){
                return (-1);
            };
            return (((((iA & Math.pow(2, index)))==0) ? 0 : 1));
        }
        public function partyPromote(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "gp", ["pp", unm], "str", 1);
        }
        public function doPartyAccept(obj:Object):void{
            if (obj.accept){
                rootClass.sfc.sendXtMessage("zm", "gp", ["pa", obj.pid], "str", 1);
            }
            else {
                rootClass.sfc.sendXtMessage("zm", "gp", ["pd", obj.pid], "str", 1);
            };
        }
        public function bankFromInvRequest(item:Object){
            rootClass.sfc.sendXtMessage("zm", "bankFromInv", [item.ItemID, item.CharItemID], "str", curRoom);
        }
        public function pushMove(mc:MovieClip, tx:int, ty:int, sp:int, fly:int=-1){
            var uoLeafSet:*;
            var request:*;
            uoLeafSet = {};
            uoLeafSet.tx = int(tx);
            uoLeafSet.ty = int(ty);
            uoLeafSet.sp = int(sp);
            request = [tx, ty, sp];
            if (((!((fly == -1))) && (!((myAvatar.dataLeaf.fly == Boolean(fly)))))){
                uoLeafSet.fly = Boolean(fly);
                myAvatar.pMC.fly = uoLeafSet.fly;
                request.push(fly);
            };
            uoTreeLeafSet(rootClass.sfc.myUserName, uoLeafSet);
            rootClass.sfc.sendXtMessage("zm", "mv", request, "str", curRoom);
        }
        public function bankFromInv(ItemID:int):void{
            var i:int;
            i = 0;
            while (i < items.length) {
                if (items[i].ItemID == ItemID){
                    if (items[i].bCoins == 0){
                        iBankCount++;
                    }
                    else {
                        iBankCountAC++;
                    };
                    bank.push(items.splice(i, 1)[0]);
                    return;
                };
                i++;
            };
        }
        public function getUserDataByIds(a:Array){
            trace("** WORLD getUserDataByIds >");
            rootClass.sfc.sendXtMessage("zm", "retrieveUserDatas", a, "str", curRoom);
        }
        public function getLoaderHostByLoaderInfo(_loaderInfo):Object{
            var i:*;
            for (i in loaderManager) {
                if (loaderManager[i].ldr.contentLoaderInfo == _loaderInfo){
                    return (loaderManager[i]);
                };
            };
            return (null);
        }
        public function getEquippedItemBySlot(slot:String):Object{
            var i:int;
            i = 0;
            while (i < items.length) {
                if ((((items[i].bEquip == 1)) && ((items[i].sES == slot)))){
                    return (items[i]);
                };
                i++;
            };
            return (null);
        }
        public function onWalkClick(e:Event=null):void{
            var cLeaf:Object;
            var aura:Object;
            var p:Point;
            var mvPT:* = undefined;
            var e = e;
            cLeaf = myAvatar.dataLeaf;
            for each (aura in cLeaf.auras) {
                try {
                    if (aura.cat != null){
                        if (aura.cat == "stun"){
                            return;
                        };
                        if (aura.cat == "stone"){
                            return;
                        };
                        if (aura.cat == "disabled"){
                            return;
                        };
                    };
                }
                catch(e:Error) {
                    trace(("world.onWalkClick > " + e));
                };
            };
            p = new Point(mouseX, mouseY);
            if (bitWalk){
                afkPostpone();
                if ((((((((mouseX >= 0)) && ((mouseX <= 960)))) && ((mouseY >= 0)))) && ((mouseY <= 500)))){
                    p = CHARS.globalToLocal(p);
                    p.x = Math.round(p.x);
                    p.y = Math.round(p.y);
                    mvPT = myAvatar.pMC.simulateTo(p.x, p.y, WALKSPEED);
                    if (((!((mvPT == null))) && ((Point.distance(mvPT, myAvatar.pMC.location) > 5)))){
                        myAvatar.pMC.walkTo(mvPT.x, mvPT.y, WALKSPEED);
                        if (bPvP){
                            pushMove(myAvatar.pMC, mvPT.x, mvPT.y, WALKSPEED);
                        }
                        else {
                            if (clickOnEventTest(mvPT.x, mvPT.y)){
                                pushMove(myAvatar.pMC, mvPT.x, mvPT.y, WALKSPEED);
                            }
                            else {
                                moveRequest({
                                    mc:myAvatar.pMC,
                                    tx:mvPT.x,
                                    ty:mvPT.y,
                                    sp:WALKSPEED
                                });
                            };
                        };
                    };
                };
            };
        }
        public function removeItemByID(ItemID:int, iQty:int=1):void{
            var i:int;
            i = 0;
            while (i < items.length) {
                if (items[i].ItemID == ItemID){
                    if ((((items[i].sES == "ar")) || ((items[i].iQty <= iQty)))){
                        items[i].iQty = 0;
                        items.splice(i, 1);
                    }
                    else {
                        items[i].iQty = (items[i].iQty - iQty);
                    };
                    return;
                };
                i++;
            };
        }
        public function buyHouseSlots(iSlots:int):void{
            rootClass.sfc.sendXtMessage("zm", "buyHouseSlots", [iSlots], "str", curRoom);
        }
        public function getFirstHeal():Object{
            var i:* = undefined;
            try {
                i = 0;
                while (i < actions.active.length) {
                    if (((((!((actions.active[i] == null))) && (!((actions.active[i].damage == null))))) && ((actions.active[i].damage < 0)))){
                        return (actions.active[i]);
                    };
                    i = (i + 1);
                };
            }
            catch(e:Error) {
            };
            return (null);
        }
        public function loadNextHouseItemB():void{
            var item:Object;
            var s:String;
            trace("loadNextHouseItemB");
            item = arrHouseItemQueue[0].item;
            s = ("items/house/" + item.sFile);
            if (item.sType == "House"){
                s = (("maps/" + item.sFile.substr(0, -4)) + "_preview.swf");
            };
            ldr_House.load(new URLRequest((Game.serverFilePath + s)), loaderC);
            if (!ldr_House.hasEventListener(Event.COMPLETE)){
                ldr_House.contentLoaderInfo.addEventListener(Event.COMPLETE, onHouseItemComplete);
            };
        }
        public function updateHouseItems():void{
            var i:int;
            var houseItem:Object;
            if (objHouseData != null){
                if (isMyHouse()){
                    initEquippedItems(objHouseData.arrPlacement);
                };
                i = 0;
                while (i < objHouseData.arrPlacement.length) {
                    if (strFrame == objHouseData.arrPlacement[i].c){
                        houseItem = getHouseItem(objHouseData.arrPlacement[i].ID);
                        if (houseItem != null){
                            loadHouseItem(houseItem, objHouseData.arrPlacement[i].x, objHouseData.arrPlacement[i].y);
                        };
                    };
                    i++;
                };
            };
        }
        public function showQuestList(qMode:String, strQuestIDs:String, strTurnInIDs:String):void{
            var QFrame:*;
            var qIDs:*;
            var tIDs:*;
            var missing:*;
            var i:*;
            var qID:String;
            if (!rootClass.isGreedyModalInStack()){
                rootClass.clearPopupsQ();
                QFrame = rootClass.attachOnModalStack("QFrameMC");
                qIDs = strQuestIDs.split(",");
                tIDs = strTurnInIDs.split(",");
                QFrame.sIDs = qIDs;
                QFrame.tIDs = tIDs;
                QFrame.world = this;
                QFrame.rootClass = rootClass;
                QFrame.qMode = qMode;
                missing = [];
                i = 0;
                while (i < qIDs.length) {
                    qID = qIDs[i];
                    if (questTree[qID] == null){
                        missing.push(qID);
                    };
                    i++;
                };
                if ((((missing.length > 0)) && (!((strQuestIDs == ""))))){
                    getQuests(missing);
                }
                else {
                    QFrame.open();
                };
            };
        }
        public function initInventory(arrItems:Array):void{
            var i:*;
            trace("** AVATAR initInventory >");
            if (arrItems == null){
                items = [];
            }
            else {
                items = arrItems;
                i = 0;
                while (i < items.length) {
                    items[i].iQty = int(items[i].iQty);
                    rootClass.world.invTree[items[i].ItemID] = items[i];
                    i++;
                };
            };
        }
        private function updateValue(str, index:int, value:Number):String{
            var strChar:String;
            if ((((value >= 0)) && ((value < 10)))){
                strChar = String(value);
            }
            else {
                if ((((value >= 10)) && ((value < 36)))){
                    strChar = String.fromCharCode((value + 55));
                }
                else {
                    strChar = "0";
                };
            };
            return (rootClass.strSetCharAt(str, index, strChar));
        }
        public function isItemInInventory(arg:Object):Boolean{
            var ID:int;
            var i:int;
            var j:int;
            ID = ((isNaN(Number(arg))) ? getItemIDByName(String(arg)) : int(arg));
            if (ID > 0){
                i = 0;
                while (i < items.length) {
                    if (items[i].ItemID == ID){
                        return (true);
                    };
                    i++;
                };
                j = 0;
                while (j < houseitems.length) {
                    if (houseitems[j].ItemID == ID){
                        return (true);
                    };
                    j++;
                };
            };
            return (false);
        }
        public function checkTempItem(ItemID:int, iQty:int):Boolean{
            var i:int;
            i = 0;
            while (i < tempitems.length) {
                if ((((tempitems[i].ItemID == ItemID)) && ((tempitems[i].iQty >= iQty)))){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function cellSetup(intScale:Number, intSpeed:Number, bitScroll:Boolean, strMode:String):void{
            var bmp:Bitmap;
            var bmd:BitmapData;
            var bma:Array;
            var cell:*;
            var i:int;
            var child:DisplayObject;
            var monArr:*;
            var Mons:Array;
            var Mon:Avatar;
            var oref:*;
            var mapChild:DisplayObject;
            var ObjRef:*;
            trace("cellSetup");
            CHARS.x = (CHARS.y = 0);
            map.x = (map.y = 0);
            CELL_MODE = strMode;
            SCALE = intScale;
            WALKSPEED = intSpeed;
            SCROLL = bitScroll;
            arrSolid = new Array();
            arrEvent = new Array();
            bmd = new BitmapData(960, 550, true, 0);
            bma = [];
            cell = map.cell;
            if (cell.walk != null){
                cell.walk.addEventListener(MouseEvent.CLICK, onWalkClick, false, 0, true);
            };
            i = 0;
            while (i < cell.numChildren) {
                child = cell.getChildAt(i);
                if ((((child is MovieClip)) && (MovieClip(child).isSolid))){
                    arrSolid.push(MovieClip(child));
                };
                if ((((child is MovieClip)) && (("walk" in child)))){
                    MovieClip(child).btnWalkingArea.useHandCursor = false;
                    MovieClip(child).btnWalkingArea.addEventListener(MouseEvent.CLICK, onWalkClick, false, 0, true);
                };
                if ((((((child is MovieClip)) && (MovieClip(child).isEvent))) && (!(MovieClip(child).isProp)))){
                    arrEvent.push(MovieClip(child));
                };
                if ((((child is MovieClip)) && (MovieClip(child).isMonster))){
                    monArr = [];
                    Mons = getMonsters(MovieClip(child).MonMapID);
                    for each (Mon in Mons) {
                        if (Mon == null){
                            trace("No Monster Definition found for Pad!");
                        }
                        else {
                            Mon.pMC = createMonsterMC(MovieClip(child), Mon.objData.MonID);
                            Mon.pMC.scale(SCALE);
                            Mon.pMC.pAV = Mon;
                            if (Mon.dataLeaf == null){
                                TRASH.addChild(Mon.pMC);
                            };
                        };
                    };
                };
                if ((((child is MovieClip)) && (MovieClip(child).isProp))){
                    oref = CHARS.addChild(child);
                    if (MovieClip(oref).isEvent){
                        arrEvent.push(MovieClip(oref));
                        MovieClip(oref).isEvent = false;
                    };
                    i--;
                };
                if ((((((((((((child is MovieClip)) && ((child.width > 700)))) && (!(("isSolid" in child))))) && (!(("walk" in child))))) && (!(("btnSkip" in child))))) && (!((child.name == "walk"))))){
                    MovieClip(child).mouseEnabled = false;
                    MovieClip(child).mouseChildren = false;
                };
                if ((((((((((child is MovieClip)) && ((child.width >= 960)))) && (!(("isSolid" in child))))) && (!(("walk" in child))))) && (!(("btnSkip" in child))))){
                };
                i++;
            };
            i = 0;
            while (i < map.numChildren) {
                mapChild = map.getChildAt(i);
                if ((((mapChild is MovieClip)) && (("isUI" in mapChild)))){
                    trace((MovieClip(mapChild).isUI + " is UI STATE +++++++++++++++++"));
                    ObjRef = mapUI.addChild(mapChild);
                    trace((ObjRef + " - Object added to UI map "));
                };
                i++;
            };
            buildBoundingRects();
            if (map.bounds != null){
                mapBoundsMC = (map.getChildByName("bounds") as MovieClip);
            };
            playerInit();
            updateMonsters();
            updatePadNames();
            if (objHouseData != null){
                updateHouseItems();
            };
        }
        public function requestFriend(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "requestFriend", [unm], "str", 1);
        }
        public function sendRemoveItemRequest(item:Object):void{
            rootClass.sfc.sendXtMessage("zm", "removeItem", [item.ItemID, item.CharItemID], "str", curRoom);
        }
        public function addFaction(faction:Object):void{
            if (((!((faction == null))) && (!((factions == null))))){
                factions.push(faction);
                initFaction(faction);
            };
        }
        private function loaderTimerComplete(e:TimerEvent):void{
            var l:*;
            l = getLoaderHostByTimer(Timer(e.currentTarget));
            if (l != null){
                l.timer.reset();
                if (!l.isOpen){
                    if (l.loaderData.retries-- > 0){
                        loaderQueue.push(l.loaderData);
                    };
                    closeLoader(l, false, true);
                };
            };
        }
        private function onMapLoadError(e:IOErrorEvent){
            trace(("Mapload failed: " + e));
            mapLoadInProgress = false;
            rootClass.mcConnDetail.showError("Loading Map Files... Failed!");
        }
        public function getQuestListDaily(callback:Function):void{
            if (objQuestList.daily != null){
                (callback(objQuestList.daily));
            }
            else {
                objQuestList.callbackDaily = callback;
                rootClass.sfc.sendXtMessage("zm", "getQuestListDaily", [], "str", curRoom);
            };
        }
        public function aggroAllMon(){
            var arrMon:*;
            var mID:*;
            arrMon = [];
            for (mID in monTree) {
                if (monTree[mID].strFrame == strFrame){
                    arrMon.push(mID);
                };
            };
            aggroMons(arrMon);
        }
        public function checkAllQuestStatus(specificID=null){
            var a:Array;
            var questID:String;
            var quest:*;
            var cParams:*;
            var p:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            var date:*;
            a = [];
            if (specificID != null){
                a = [String(specificID)];
            }
            else {
                for (questID in questTree) {
                    a.push(questID);
                };
            };
            for each (questID in a) {
                quest = questTree[questID];
                cParams = {};
                if (quest.status != null){
                    if (((!((quest.turnin == null))) && ((quest.turnin.length > 0)))){
                        cParams.sItems = true;
                        i = 0;
                        while (i < quest.turnin.length) {
                            qItemID = quest.turnin[i].ItemID;
                            qItemQ = quest.turnin[i].iQty;
                            if ((((invTree[qItemID] == null)) || ((invTree[qItemID].iQty < qItemQ)))){
                                cParams.sItems = false;
                                break;
                            };
                            i++;
                        };
                    };
                    if (quest.iTime != null){
                        cParams.iTime = false;
                        if (quest.ts != null){
                            date = new Date();
                            if (((date.getTime() - quest.ts) / 1000) >= quest.iTime){
                                cParams.iTime = true;
                            };
                        };
                    };
                    quest.status = "c";
                    for (p in cParams) {
                        if (cParams[p] == false){
                            quest.status = "p";
                        };
                    };
                };
            };
        }
        public function sendRewardReferralRequest(params):void{
            rootClass.sfc.sendXtMessage("zm", "rewardReferral", [], "str", curRoom);
        }
        public function getAllAvatarsInCell():Array{
            var a:Array;
            a = [];
            a = getMonstersByCell(myAvatar.dataLeaf.strFrame);
            a = a.concat(getUsersByCell(myAvatar.dataLeaf.strFrame));
            return (a);
        }
        public function loadMovieFront(strFile:String, strType:String="Game Files"):void{
            removeMovieFront();
            rootClass.ldrMC.loadFile(FG, (rootClass.sFilePath + strFile), strType);
        }
        public function tryQuestComplete(QuestID:int, choiceID:int=-1):void{
            rootClass.sfc.sendXtMessage("zm", "tryQuestComplete", [QuestID, choiceID, "xhs"], "str", curRoom);
        }
        public function addPointer(p:Point){
            var pt:*;
            pt = addChild(new Pointer());
            pt.x = p.x;
            pt.y = p.y;
        }
        public function initMapEvents():void{
            if (((("eventUpdate" in map)) && (!((mapEvents == null))))){
                map.eventUpdate({
                    cmd:"event",
                    args:mapEvents
                });
            };
            mapEvents = null;
        }
        public function showIncomingAttackResult(actionResult:Object):void{
            playActionSound(actionResult);
            actionResultsMon[actionIDMon] = new ActionImpactTimer();
            actionResultsMon[actionIDMon].world = MovieClip(this);
            actionResultsMon[actionIDMon].actionResult = actionResult;
            actionResultsMon[actionIDMon].showImpact(350);
            actionIDMon++;
            if (actionIDMon > actionIDLimitMon){
                actionIDMon = 0;
            };
        }
        public function isQuestInProgress(QuestID:int):Boolean{
            return (((!((questTree[QuestID] == null))) && (!((questTree[QuestID].status == null)))));
        }
        public function exitQuest():void{
            if (returnInfo != null){
                rootClass.sfc.sendXtMessage("zm", "cmd", ["tfer", rootClass.sfc.myUserName, returnInfo.strMap, returnInfo.strCell, returnInfo.strPad], "str", curRoom);
            };
        }
        public function partyKick(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "gp", ["pk", unm], "str", 1);
        }
        public function getMapItem(MergeID:int):void{
            if (coolDown("getMapItem")){
                rootClass.sfc.sendXtMessage("zm", "getMapItem", [MergeID], "str", curRoom);
            };
        }
        public function siaTrigger(o:Object):void{
            rootClass.sfc.sendXtMessage("zm", ["castt"], [], "str", 1);
        }
        public function flickerFrame(e:Event){
            var mc:*;
            mc = MovieClip(e.currentTarget);
            if (((!((mc.parent == null))) && (!((mc.parent.stage == null))))){
                if (mc.curF == 0){
                    mc.parent.modulateColor(avtWCT, "+");
                };
                if (mc.curF == 1){
                    mc.parent.modulateColor(avtWCT, "-");
                };
                if (mc.curF == 2){
                    mc.parent.modulateColor(avtWCT, "+");
                };
                if (mc.curF >= mc.maxF){
                    mc.parent.modulateColor(avtWCT, "-");
                    mc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
                    mc.parent.removeChild(mc);
                };
                mc.curF++;
            }
            else {
                mc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
            };
        }
        public function showHouseInventory(id:int){
            if (houseitems != null){
                sendLoadShopRequest(id);
            };
        }
        public function handlePVPQueue(o:Object):void{
            var mc:MovieClip;
            if (o.bitSuccess == 1){
                PVPQueue.warzone = o.warzone;
                PVPQueue.ts = new Date().getTime();
                PVPQueue.avgWait = o.avgWait;
                rootClass.showMCPVPQueue();
            }
            else {
                PVPQueue.warzone = "";
                PVPQueue.ts = -1;
                PVPQueue.avgWait = -1;
                rootClass.hideMCPVPQueue();
            };
            mc = rootClass.ui.mcPopup;
            if ((((mc.currentLabel == "PVPPanel")) && (!((mc.mcPVPPanel == null))))){
                mc.mcPVPPanel.updateBody();
            };
            rootClass.closeModalByStrBody("A new Warzone battle has started!");
        }
        public function updatePadNames(){
            var i:int;
            var padN:*;
            i = 0;
            while (i < rootClass.ui.mcPadNames.numChildren) {
                padN = MovieClip(rootClass.ui.mcPadNames.getChildAt(i));
                if ((((((objLock == null)) || ((objLock[padN.tCell] == null)))) || ((objLock[padN.tCell] <= intKillCount)))){
                    padN.cnt.lock.visible = false;
                }
                else {
                    padN.cnt.lock.visible = true;
                };
                i++;
            };
        }
        public function createItemPlacementArray(strPlacement:String):Array{
            var arr:Array;
            var arrItems:*;
            var i:int;
            var item:*;
            var pairs:*;
            var j:int;
            arr = [];
            if (strPlacement.length > 0){
                arrItems = strPlacement.split("|");
                i = 0;
                while (i < arrItems.length) {
                    item = {};
                    pairs = arrItems[i].split(",");
                    j = 0;
                    while (j < pairs.length) {
                        item[pairs[j].split(":")[0]] = pairs[j].split(":")[1];
                        j++;
                    };
                    arr.push(item);
                    i++;
                };
            };
            return (arr);
        }
        private function rebuildMapBMP(mc:MovieClip):void{
            var child:MovieClip;
            var i:int;
            i = 0;
            clearMapBmps();
            i = 0;
            while (i < mc.numChildren) {
                child = (mc.getChildAt(i) as MovieClip);
                if ((((((((((((((((((((((((child is MovieClip)) && ((child.width >= 960)))) && ((child.name.toLowerCase().indexOf("bmp") == -1)))) && ((child.name.toLowerCase().indexOf("cs") == -1)))) && ((child.name.toLowerCase().indexOf("bounds") == -1)))) && (((((child as MovieClip) == null)) || ((MovieClip(child).totalFrames < 15)))))) && (!(("isSolid" in child))))) && (!(("isFloor" in child))))) && (!(("isWall" in child))))) && (!(("walk" in child))))) && (!((child.name == "walk"))))) && (!(("btnSkip" in child))))){
                    trace(("RASTERIZING: " + child.name));
                    mapBmps.push({
                        child:child,
                        x:child.x,
                        bmDO:null
                    });
                };
                i++;
            };
            rasterize(mapBmps);
        }
        public function resTimer(e:TimerEvent){
            var mcr:*;
            mcr = MovieClip(rootClass.ui.mcRes);
            mcr.resC--;
            if (mcr.resC > 0){
                mcr.counter.ti.text = mcr.resC;
                if (mcr.counter.ti.text.length < 2){
                    mcr.counter.ti.text = ("0" + mcr.counter.ti.text);
                };
            }
            else {
                e.target.reset();
                mcr.gotoAndPlay("out");
            };
        }
        public function updatePVPAvgWait(i:int):void{
            PVPQueue.avgWait = i;
        }
        public function gotoTown(strNewMap:String, strSpawnCell:String, strSpawnPad:String):void{
            var uoLeaf:*;
            uoLeaf = uoTree[rootClass.sfc.myUserName];
            if (uoLeaf.intState == 0){
                rootClass.chatF.pushMsg("warning", "You are dead!", "SERVER", "", 0);
            }
            else {
                if (coolDown("tfer")){
                    rootClass.MsgBox.notify(("Joining " + strNewMap));
                    setReturnInfo(strNewMap, strSpawnCell, strSpawnPad);
                    rootClass.sfc.sendXtMessage("zm", "cmd", ["tfer", rootClass.sfc.myUserName, strNewMap, strSpawnCell, strSpawnPad], "str", curRoom);
                }
                else {
                    rootClass.MsgBox.notify("You must wait 5 seconds before joining another map.");
                };
            };
        }
        public function initObjExtra(strExtra:String):void{
            var arrExtra:Array;
            var i:int;
            var arrVar:Array;
            objExtra = new Object();
            if (((!((strExtra == null))) && (!((strExtra == ""))))){
                arrExtra = strExtra.split(",");
                i = 0;
                while (i < arrExtra.length) {
                    arrVar = arrExtra[i].split("=");
                    objExtra[arrVar[0]] = arrVar[1];
                    i++;
                };
            };
        }
        public function setHomeTown(strMapName:String):void{
            rootClass.sfc.sendXtMessage("zm", "setHomeTown", [strMapName], "str", curRoom);
            myAvatar.objData.strHomeTown = strMapName;
        }
        public function bankToInvRequest(item:Object){
            rootClass.sfc.sendXtMessage("zm", "bankToInv", [item.ItemID, item.CharItemID], "str", curRoom);
        }
        public function loadMap(strFilename:String){
            trace(((("loadMap: " + Game.serverFilePath) + "maps/") + strFilename));
            rootClass.mcConnDetail.showConn("Loading Map Files...");
            if (map != null){
                map.gotoAndStop("Wait");
                this.removeChild(map);
                map = null;
            };
            ldr_map.contentLoaderInfo.removeEventListener(Event.COMPLETE, onMapLoadComplete);
            ldr_map.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onMapLoadError);
            ldr_map.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onMapLoadProgress);
            ldr_map = new Loader();
            ldr_map.contentLoaderInfo.addEventListener(Event.COMPLETE, onMapLoadComplete, false, 0, true);
            ldr_map.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onMapLoadError, false, 0, true);
            ldr_map.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onMapLoadProgress, false, 0, true);
            ldr_map.load(new URLRequest(((Game.serverFilePath + "maps/") + strFilename)));
            rootClass.clearPopups();
        }
        public function isItemStackMaxed(ItemID:Number):Boolean{
            var i:int;
            i = 0;
            if (bank != null){
                i = 0;
                while (i < bank.length) {
                    if ((((bank[i].ItemID == ItemID)) && ((bank[i].iQty >= bank[i].iStk)))){
                        return (true);
                    };
                    i++;
                };
            };
            if (items != null){
                i = 0;
                while (i < items.length) {
                    if ((((items[i].ItemID == ItemID)) && ((items[i].iQty >= items[i].iStk)))){
                        return (true);
                    };
                    i++;
                };
            };
            if (houseitems != null){
                i = 0;
                while (i < houseitems.length) {
                    if ((((houseitems[i].ItemID == ItemID)) && ((houseitems[i].iQty >= houseitems[i].iStk)))){
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }
        public function sendWhoRequest():void{
            if (coolDown("who")){
                rootClass.sfc.sendXtMessage("zm", "cmd", ["who"], "str", curRoom);
            };
        }
        public function toggleQuestLog():void{
            var mcQFrame:*;
            mcQFrame = rootClass.getInstanceFromModalStack("QFrameMC");
            if (mcQFrame == null){
                showQuests("", "l");
            }
            else {
                mcQFrame.open();
            };
        }
        public function actCastRequest(o:Object):void{
            var xtArr:Array;
            var params:Array;
            var co:Object;
            xtArr = ["castr"];
            params = [];
            switch (o.typ){
                case "sia":
                    if (coolDown("doIA")){
                        co = {};
                        co.typ = "sia";
                        co.callback = actCastTrigger;
                        co.args = o;
                        co.dur = Number(o.sAccessCD);
                        co.txt = o.sMsg;
                        rootClass.ui.mcCastBar.fOpenWith(co);
                        params.push(1);
                        params.push(o.ID);
                    };
                    break;
            };
            if (params.length > 0){
                rootClass.sfc.sendXtMessage("zm", xtArr, params, "str", 1);
            };
        }
        public function sendSaveHouseSetup(sHouseInfo):void{
            rootClass.sfc.sendXtMessage("zm", "cmd", ["saveHouseSetup", myAvatar.objData.strUsername.toLowerCase(), sHouseInfo], "str", 1);
        }
        public function doAction(actionObj, targets){
            var tAvt:Avatar;
            var i:int;
            trace(("doAction > " + actionObj.nam));
            afkPostpone();
            if (targets.length > 0){
                tAvt = targets[0].avt;
                if (tAvt != myAvatar){
                    if ((tAvt.pMC.x - myAvatar.pMC.x) >= 0){
                        myAvatar.pMC.turn("right");
                    }
                    else {
                        myAvatar.pMC.turn("left");
                    };
                };
            };
            i = 0;
            while (i < targets.length) {
                tAvt = targets[i].avt;
                switch (tAvt.npcType){
                    case "monster":
                        if (myAvatar.dataLeaf.targets[tAvt.objData.MonMapID] == null){
                            myAvatar.dataLeaf.targets[tAvt.objData.MonMapID] = "m";
                        };
                        break;
                    case "player":
                        if (myAvatar.dataLeaf.targets[tAvt.objData.uid] == null){
                            myAvatar.dataLeaf.targets[tAvt.objData.uid] = "p";
                        };
                        break;
                };
                i++;
            };
            getActionResult(actionObj, targets);
        }
        public function bankToInv(ItemID:int):void{
            var i:int;
            i = 0;
            while (i < bank.length) {
                if (bank[i].ItemID == ItemID){
                    if (bank[i].bCoins == 0){
                        iBankCount--;
                    }
                    else {
                        iBankCountAC--;
                    };
                    items.push(bank.splice(i, 1)[0]);
                    return;
                };
                i++;
            };
        }
        public function getInventory(uid){
            rootClass.sfc.sendXtMessage("zm", "retrieveInventory", [uid], "str", curRoom);
        }
        public function addFriend(obj:Object):void{
            if (obj != null){
                friends.push(obj);
                if (rootClass.ui.mcOFrame.currentLabel == "Idle"){
                    rootClass.ui.mcOFrame.update();
                };
            };
        }
        public function updateAchievement(field:String, index:int, value:int):void{
            if (value == 0){
                myAvatar.objData[field] = (myAvatar.objData[field] & ~(Math.pow(2, index)));
            }
            else {
                if (value == 1){
                    myAvatar.objData[field] = (myAvatar.objData[field] | Math.pow(2, index));
                };
            };
            rootClass.readIA1Preferences();
        }
        public function manageAreaUser(unm:String, op:String):void{
            var i:int;
            unm = unm.toLowerCase();
            if (op == "+"){
                if (areaUsers.indexOf(unm) == -1){
                    areaUsers.push(unm);
                };
            }
            else {
                i = areaUsers.indexOf(unm);
                if (i > -1){
                    areaUsers.splice(i, 1);
                };
            };
            rootClass.updateAreaName();
        }
        private function rasterize(a:Array, moveChild:Boolean=false):void{
            var r:Number;
            var n:int;
            var o:Object;
            var regP:Point;
            var tMatrix:Matrix;
            var bmpName:String;
            var bmpBG:DisplayObject;
            mapNW = stage.stageWidth;
            r = (mapNW / mapW);
            n = 0;
            mapNH = Math.round((mapH * r));
            for each (o in a) {
                o.child.x = o.x;
                if (o.bmd != null){
                    o.bmd.dispose();
                };
                o.bmd = new BitmapData(mapNW, mapNH, true, 0x999999);
                regP = new Point(0, 0);
                regP = o.child.globalToLocal(regP);
                tMatrix = new Matrix((r * o.child.transform.matrix.a), 0, 0, (r * o.child.transform.matrix.d), -(((regP.x * r) * o.child.transform.matrix.a)), -(((regP.y * r) * o.child.transform.matrix.d)));
                o.bmd.draw(o.child, tMatrix, o.child.transform.colorTransform, null, new Rectangle(0, 0, mapNW, mapNH), false);
                o.bm = new Bitmap(o.bmd);
                bmpName = String(("bmp" + n));
                bmpBG = o.child.parent.getChildByName(bmpName);
                if (bmpBG != null){
                    o.child.parent.removeChild(bmpBG);
                };
                o.bmDO = o.child.parent.addChildAt(o.bm, (o.child.parent.getChildIndex(o.child) + 1));
                o.bmDO.name = bmpName;
                o.bmDO.width = mapW;
                o.bmDO.height = mapH;
                o.child.visible = false;
                if (moveChild){
                    o.child.x = (o.child.x + 1200);
                };
                n++;
            };
        }
        public function onHouseItemClick(e:Event):void{
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            if (((isMyHouse()) && (rootClass.ui.mcPopup.mcHouseMenu.visible))){
                rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(MovieClip(e.currentTarget));
                rootClass.ui.mcPopup.mcHouseMenu.onHandleMoveClick(e.clone());
            }
            else {
                if ((((mc.btnButton == null)) || (!(mc.btnButton.hasEventListener(MouseEvent.CLICK))))){
                    onWalkClick();
                };
            };
        }
        public function showAllPets():void{
            var i:*;
            var uoLeaf:Object;
            var strF:*;
            for (i in avatars) {
                uoLeaf = getUoLeafById(i);
                strF = String(uoLeaf.strFrame);
                if (strF == strFrame){
                    avatars[i].loadPet();
                };
            };
        }
        private function getFactionByID(ID:int):Object{
            var i:int;
            i = 0;
            while (i < factions.length) {
                if (factions[i].FactionID == ID){
                    return (factions[i]);
                };
                i++;
            };
            return (null);
        }
        public function pull(unm){
            unm = unm.toLowerCase();
            rootClass.sfc.sendXtMessage("zm", "cmd", ["pull", unm], "str", 1);
        }
        public function killTimers():void{
            autoActionTimer.reset();
            restTimer.reset();
            AATestTimer.reset();
            connTestTimer.reset();
            afkTimer.reset();
            rootClass.chatF.mute.timer.reset();
            autoActionTimer.removeEventListener("timer", autoActionHandler);
            restTimer.removeEventListener("timer", restRequest);
            AATestTimer.removeEventListener("timer", AATest);
            connTestTimer.removeEventListener("timer", connTest);
            afkTimer.removeEventListener("timer", afkTimerHandler);
            mvTimer.removeEventListener("timer", mvTimerHandler);
            rootClass.chatF.mute.timer.removeEventListener("timer", rootClass.chatF.unmuteMe);
        }
        public function updateMonster(monmapo:Object):void{
            var mondef:*;
            var Mon:*;
            var monLeaf:*;
            mondef = getMonsterDefinition(monmapo.MonID);
            Mon = getMonster(monmapo.MonMapID);
            Mon.objData.intMPMax = int(Mon.objData.intMPMax);
            Mon.objData.intHPMax = int(Mon.objData.intMPMax);
            monLeaf = monTree[monmapo.MonMapID];
            if (((!((monLeaf.MonID == Mon.objData.MonID))) || ((monLeaf.intState == 0)))){
                Mon.pMC.visible = false;
            };
            if ((Mon.pMC.x - myAvatar.pMC.x) >= 0){
                Mon.pMC.turn("left");
            };
            Mon.pMC.updateNamePlate();
        }
        public function getAvatarByUserID(uid:int):Avatar{
            var sID:String;
            sID = String(uid);
            if ((sID in avatars)){
                return (avatars[sID]);
            };
            return (null);
        }
        public function autoActionHandler(e:TimerEvent){
            trace("* autoActionHandler >");
            if (((((((((!((myAvatar.dataLeaf == null))) && (!((myAvatar.dataLeaf.intState == 0))))) && (!((myAvatar.target == null))))) && (!((myAvatar.target.dataLeaf == null))))) && (!((myAvatar.target.dataLeaf.intState == 0))))){
                testAction(getAutoAttack(), true);
            }
            else {
                exitCombat();
            };
        }
        public function isItemInBank(ItemID:Number):Boolean{
            var i:int;
            if (bank != null){
                i = 0;
                while (i < bank.length) {
                    if (bank[i].ItemID == ItemID){
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }
        public function getItemByID(ID:int):Object{
            var i:int;
            var j:int;
            var k:int;
            i = 0;
            while (i < items.length) {
                if (items[i].ItemID == ID){
                    return (items[i]);
                };
                i++;
            };
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].ItemID == ID){
                    return (houseitems[j]);
                };
                j++;
            };
            k = 0;
            while (k < tempitems.length) {
                if (tempitems[k].ItemID == ID){
                    return (tempitems[k]);
                };
                k++;
            };
            return (null);
        }
        public function showActionImpact(resObj){
            var actionFX:*;
            var actionDamage:*;
            var tMC:MovieClip;
            var entType:String;
            var entID:int;
            var elmtClass:Class;
            var elmtMC:MovieClip;
            var results:Array;
            var resultsT:Array;
            var resultsF:Array;
            var resultsI:int;
            var tf:TextFormat;
            var i:int;
            var a:Array;
            var o:Object;
            actionFX = null;
            actionDamage = null;
            entType = "";
            entID = 0;
            results = ["GOOD", "GREAT!", "MASSIVE!!"];
            resultsT = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
            resultsF = [2381688, 0, 0];
            resultsI = 0;
            tf = new TextFormat();
            i = 0;
            a = resObj.a;
            o = {};
            i = 0;
            while (i < a.length) {
                o = a[i];
                entType = o.tInf.split(":")[0];
                entID = int(o.tInf.split(":")[1]);
                switch (entType){
                    case "p":
                        tMC = avatars[entID].pMC;
                        break;
                    case "m":
                        tMC = getMonster(entID).pMC;
                        break;
                };
                if (((((!((tMC == null))) && (!((tMC.pAV == null))))) && (!((tMC.pAV.dataLeaf == null))))){
                    switch (o.type){
                        case "hit":
                            if (o.elmt != "Physical"){
                                elmtClass = (getDefinitionByName((o.elmt + "Element")) as Class);
                                elmtMC = new (elmtClass)();
                                elmtMC.scaleX = -(tMC.mcChar.scaleX);
                                tMC.addChild(elmtMC);
                            };
                            if (o.hp >= 0){
                                actionDamage = new hitDisplay();
                                actionDamage.t.ti.autoSize = "center";
                                resultsI = 0;
                                actionDamage.t.ti.text = o.hp;
                                actionDamage.t.ti.textColor = resultsT[resultsI];
                                actionDamage.t.ti.filters = [new GlowFilter(0, 1, 5, 5, 5, 1, false, false)];
                                actionDamage.t.ti.setTextFormat(tf);
                            }
                            else {
                                if (o.hp < 0){
                                    actionDamage = new healDisplay();
                                    actionDamage.t.ti.text = (("+" + -(o.hp)) + "+");
                                    actionDamage.t.ti.textColor = 65450;
                                    elmtMC = new HealElement();
                                    tMC.addChild(elmtMC);
                                };
                            };
                            wound(tMC, "damage");
                            break;
                        case "crit":
                            if (o.elmt != "Physical"){
                                elmtClass = (getDefinitionByName((o.elmt + "Element")) as Class);
                                elmtMC = new (elmtClass)();
                                elmtMC.scaleX = -(tMC.mcChar.scaleX);
                                tMC.addChild(elmtMC);
                            };
                            if (o.hp >= 0){
                                actionDamage = new critDisplay();
                                actionDamage.t.ti.autoSize = "center";
                                actionDamage.t.ti.text = o.hp;
                                actionDamage.t.ti.textColor = 16750916;
                                actionDamage.t.ti.filters = [new GlowFilter(0x330000, 1, 5, 5, 5, 1, false, false)];
                            }
                            else {
                                if (o.hp < 0){
                                    actionDamage = new critHealDisplay();
                                    actionDamage.t.ti.text = -(o.hp);
                                    actionDamage.t.ti.textColor = 65450;
                                    elmtMC = new HealElement();
                                    tMC.addChild(elmtMC);
                                };
                            };
                            wound(tMC, "damage");
                            break;
                        case "miss":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Miss!";
                            break;
                        case "dodge":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Dodge!";
                            break;
                        case "parry":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Parry!";
                            break;
                        case "block":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Block!";
                            break;
                        case "none":
                    };
                    if (actionDamage != null){
                        tMC.addChild(actionDamage);
                        actionDamage.x = (tMC.mcChar.x - ((Math.random() * 40) * tMC.mcChar.scaleX));
                        actionDamage.y = (tMC.pname.y + (Math.random() * 30));
                    };
                    if (actionFX != null){
                        tMC.addChild(actionFX);
                        actionFX.x = tMC.mcChar.x;
                        actionFX.y = (tMC.pname.y + (tMC.mcChar.height / 2));
                    };
                };
                i++;
            };
        }
        public function getQuests(QuestIDs:Array):void{
            rootClass.sfc.sendXtMessage("zm", "getQuests", QuestIDs, "str", curRoom);
        }
        public function unequipHouseItem(ID:int):void{
            var j:int;
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].ItemID == ID){
                    houseitems[j].bEquip = 0;
                };
                j++;
            };
        }
        public function updateQuestProgress(typ:String, o:Object):void{
            var questID:*;
            var quest:*;
            var cParams:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            var item:*;
            for (questID in questTree) {
                quest = questTree[questID];
                cParams = {};
                if (((!((quest.status == null))) && ((quest.status == "p")))){
                    if ((((((typ == "item")) && (!((quest.turnin == null))))) && ((quest.turnin.length > 0)))){
                        cParams.sItems = true;
                        i = 0;
                        while (i < quest.turnin.length) {
                            qItemID = quest.turnin[i].ItemID;
                            qItemQ = quest.turnin[i].iQty;
                            if ((((((o.ItemID == qItemID)) && (!((invTree[qItemID] == null))))) && ((invTree[qItemID].iQty <= qItemQ)))){
                                item = invTree[qItemID];
                                rootClass.addUpdate(((((((quest.sName + ": ") + item.sName) + " ") + invTree[qItemID].iQty) + "/") + qItemQ));
                            };
                            i++;
                        };
                    };
                    checkAllQuestStatus(questID);
                    if (quest.status == "c"){
                        rootClass.addUpdate((quest.sName + " complete!"));
                        rootClass.mixer.playSound("Good");
                    };
                };
            };
        }
        public function getActionByRef(actRef:String):Object{
            var actObj:Object;
            for each (actObj in actions.active) {
                if ((((actObj.ref == actRef)) && (actObj.isOK))){
                    return (actObj);
                };
            };
            return (null);
        }
        public function cancelAutoAttack(){
            var icon:MovieClip;
            var i:* = undefined;
            if (autoActionTimer != null){
                autoActionTimer.reset();
            };
            if (AATestTimer != null){
                AATestTimer.reset();
            };
            i = 0;
            while (i < actionMap.length) {
                try {
                    if (actionMap[i] == "aa"){
                        icon = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))));
                        icon.bg.gotoAndStop(1);
                    };
                }
                catch(e:Error) {
                    trace(e);
                };
                i = (i + 1);
            };
        }
        public function initFaction(faction):void{
            faction.iRep = int(faction.iRep);
            faction.iRank = rootClass.getRankFromPoints(faction.iRep);
            faction.iRepToRank = 0;
            if (faction.iRank < rootClass.iRankMax){
                faction.iRepToRank = (rootClass.arrRanks[faction.iRank] - rootClass.arrRanks[(faction.iRank - 1)]);
            };
            faction.iSpillRep = (faction.iRep - rootClass.arrRanks[(faction.iRank - 1)]);
        }
        public function sendReport(args:Array):void{
            rootClass.sfc.sendXtMessage("zm", "cmd", args, "str", rootClass.world.curRoom);
        }
        public function removeSelectedItem():void{
            var mc:MovieClip;
            if (objHouseData.selectedMC == null){
                rootClass.MsgBox.notify("Please select an item to be removed.");
            }
            else {
                mc = objHouseData.selectedMC;
                mc.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                unequipHouseItem(mc.ItemID);
                CHARS.removeChild(mc);
                delete objHouseData.selectedMC;
            };
        }
        public function showHouseOptions(mode:String):void{
            var mc:MovieClip;
            mc = rootClass.ui.mcPopup.mcHouseOptions;
            switch (mode){
                case "default":
                case "save":
                default:
                    mc.visible = true;
                    mc.bg.x = 0;
                    mc.cnt.x = 0;
                    mc.tTitle.x = 5;
                    mc.bExpand.x = 190;
                    mc.bg.visible = true;
                    mc.cnt.visible = true;
                    mc.tTitle.visible = true;
                    mc.bExpand.visible = false;
                    break;
                case "hide":
                    mc.visible = true;
                    mc.bg.x = 181;
                    mc.cnt.x = 181;
                    mc.tTitle.x = 186;
                    mc.bExpand.x = 120;
                    mc.bg.visible = false;
                    mc.cnt.visible = false;
                    mc.tTitle.visible = false;
                    mc.bExpand.visible = true;
            };
        }
        public function tryUseItem(item:Object):void{
            if (item.sType.toLowerCase() == "clientuse"){
                switch (item.sLink){
                };
            }
            else {
                if (item.sType.toLowerCase() == "serveruse"){
                    sendUseItemRequest(item);
                };
            };
        }
        public function doCTAClick(e:MouseEvent):void{
            var mc:MovieClip;
            var modal:ModalMC;
            var modalO:Object;
            mc = (e.currentTarget as MovieClip);
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = (("Would you like to join the next avabilable party for " + mc.sName) + "?");
            modalO.callback = doCTAAccept;
            modalO.params = {
                QuestID:mc.QuestID,
                unm:mc.unm
            };
            modalO.btns = "dual";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }
        public function getItemIDByName(sName:String):int{
            var i:int;
            var j:int;
            var k:int;
            i = 0;
            while (i < items.length) {
                if (items[i].sName == sName){
                    return (items[i].ItemID);
                };
                i++;
            };
            j = 0;
            while (j < houseitems.length) {
                if (houseitems[j].sName == sName){
                    return (houseitems[j].ItemID);
                };
                j++;
            };
            k = 0;
            while (k < tempitems.length) {
                if (tempitems[k].sName == sName){
                    return (tempitems[k].ItemID);
                };
                k++;
            };
            return (-1);
        }
        public function getMCByUserName(unm):AvatarMC{
            var s:String;
            for (s in avatars) {
                if (((((!((avatars[s] == null))) && (!((avatars[s].pnm == null))))) && ((avatars[s].pnm.toLowerCase() == unm.toLowerCase())))){
                    if (avatars[s].pMC != null){
                        return (avatars[s].pMC);
                    };
                };
            };
            return (null);
        }
        public function onHouseOptionsHideClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            showHouseOptions("hide");
        }
        public function doDuelAccept(obj:Object):void{
            if (obj.accept){
                rootClass.sfc.sendXtMessage("zm", "da", [obj.unm], "str", 1);
            }
            else {
                rootClass.sfc.sendXtMessage("zm", "dd", [obj.unm], "str", 1);
            };
        }
        public function aggroMons(arrMon){
            if (arrMon.length){
                rootClass.sfc.sendXtMessage("zm", "aggroMon", arrMon, "str", curRoom);
            };
        }
        public function initFactions(arrFactions:Array):void{
            var i:int;
            if (arrFactions == null){
                factions = [];
            }
            else {
                factions = arrFactions;
                i = 0;
                while (i < factions.length) {
                    initFaction(factions[i]);
                    i++;
                };
            };
        }
        public function sendLoadHairShopRequest(intHairShopID:int):void{
            if ((((hairshopinfo == null)) || (!((hairshopinfo.HairShopID == intHairShopID))))){
                rootClass.sfc.sendXtMessage("zm", "loadHairShop", [intHairShopID], "str", curRoom);
            }
            else {
                rootClass.openCharacterCustomize();
            };
        }
        public function isFriendName(unm:String):Boolean{
            var i:*;
            i = 0;
            while (i < friends.length) {
                if (friends[i].sName.toLowerCase() == unm.toLowerCase()){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function initObjInfo(sInfo:String):void{
            var arrInfo:Array;
            var i:int;
            var arrVar:Array;
            objInfo = new Object();
            if (((!((sInfo == null))) && (!((sInfo == ""))))){
                arrInfo = sInfo.split(",");
                i = 0;
                while (i < arrInfo.length) {
                    arrVar = arrInfo[i].split("=");
                    objInfo[arrVar[0]] = arrVar[1];
                    i++;
                };
            };
        }
        public function toggleHPBar():void{
            var uid:String;
            var umc:MovieClip;
            var avt:Avatar;
            showHPBar = !(showHPBar);
            for (uid in avatars) {
                avt = avatars[uid];
                if (avt.pMC != null){
                    umc = avt.pMC;
                    if (showHPBar){
                        umc.showHPBar();
                    }
                    else {
                        umc.hideHPBar();
                    };
                };
            };
        }
        public function getIconBySkillID(ID:int):String{
            var i:int;
            i = 0;
            while (i < actions.active.length) {
                if (actions.active[i].ref == ID){
                    return (actions.active[i].icon);
                };
                i++;
            };
            return ("");
        }
        public function wound(obj, typ){
            var flickermc:*;
            if (typ == "damage"){
                flickermc = new MovieClip();
                flickermc.name = "flickermc";
                flickermc.maxF = 3;
                flickermc.curF = 0;
                flickermc.addEventListener(Event.ENTER_FRAME, flickerFrame);
                if (obj.contains(flickermc)){
                    obj.flickermc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
                    obj.removeChild(flickermc);
                };
                obj.addChild(flickermc);
            };
        }
        public function getUserByName(str){
            var rl:Array;
            var i:*;
            var r:*;
            var j:*;
            var tuo:*;
            rl = rootClass.sfc.getAllRooms();
            for (i in rl) {
                r = rl[i];
                for (j in r.getUserList()) {
                    tuo = r.getUserList()[j];
                    if (String(tuo.getName()) == str){
                        return (tuo);
                    };
                };
            };
            return (null);
        }
        public function sendChangeColorRequest(intColorSkin:int, intColorHair:int, intColorEye:int, HairID:int):void{
            rootClass.sfc.sendXtMessage("zm", "changeColor", [intColorSkin, intColorHair, intColorEye, HairID, hairshopinfo.HairShopID], "str", curRoom);
        }
        public function getActIcons(actionObj:Object):Array{
            var actIcons:Array;
            var icon1:MovieClip;
            var i:*;
            actIcons = [];
            i = 0;
            while (i < actionMap.length) {
                if (actionMap[i] == actionObj.ref){
                    icon1 = (rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))) as MovieClip);
                    if (icon1 != null){
                        actIcons.push(icon1);
                    };
                };
                i++;
            };
            return (actIcons);
        }
        public function globalCoolDownExcept(exemptAction:Object):void{
            var now:Number;
            var actIcon:MovieClip;
            var actionObj:Object;
            var exemptAction:Object = exemptAction;
            now = new Date().getTime();
            for each (actionObj in actions.active) {
                actIcon = getActIcons(actionObj)[0];
                if (actIcon != null){
                    try {
                        if (((((!((actionObj == exemptAction))) && (!((actionObj.ref == "aa"))))) && (((((!(("icon2" in actIcon))) || ((actIcon.icon2 == null)))) || (((((actionObj.ts + actionObj.cd) > now)) && ((((actionObj.ts + actionObj.cd) - now) < GCD)))))))){
                            coolDownAct(actionObj, GCD, now);
                        };
                    }
                    catch(e:Error) {
                    };
                };
            };
            GCDTS = now;
        }
        public function getQuest(QuestID:int):void{
        }
        public function sendEnhItemRequestLocal(item:Object, enh:Object):void{
            if (coolDown("buyItem")){
                enhItem = item;
                rootClass.sfc.sendXtMessage("zm", "enhanceItemLocal", [item.ItemID, enh.ItemID], "str", curRoom);
            };
        }
        public function doCTAAccept(obj:Object):void{
            if (obj.accept){
                rootClass.sfc.sendXtMessage("zm", "gp", ["ctaa", obj.unm], "str", 1);
                showQuests(obj.QuestID, "q");
            };
        }
        public function aggroMon(mID){
            var arrMon:*;
            arrMon = [];
            arrMon.push(mID);
            aggroMons(arrMon);
        }
        public function handleSARS(resObj:Object):void{
            var o:Object;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var cInf:String;
            var actionResult:Object;
            var a:Array;
            var i:int;
            o = {};
            cTyp = "";
            cID = -1;
            tTyp = "";
            tID = -1;
            cInf = resObj.cInf;
            cInf = resObj.cInf;
            cTyp = cInf.split(":")[0];
            cID = int(cInf.split(":")[1]);
            actionResult = {};
            if (resObj.iRes == 1){
                a = [];
                i = 0;
                while (i < resObj.a.length) {
                    actionResult = resObj.a[i];
                    aggroMap(cInf, actionResult.tInf, (actionResult.hp >= 0));
                    i++;
                };
                if ((((cTyp == "p")) && ((cID == rootClass.sfc.myUserId)))){
                    showActionResult(rootClass.copyObj(resObj), resObj.actID);
                }
                else {
                    showIncomingAttackResult(rootClass.copyObj(resObj));
                };
            };
            if (resObj.iRes == 0){
                switch (cInf.split(":")[0]){
                    case "p":
                        showActionResult(null, resObj.actID);
                        break;
                };
            };
        }
        public function completeQuest(questID:int):void{
            if (questTree[questID] != null){
                questTree[questID].status = null;
            };
        }
        public function blockerHit(p:Point):Boolean{
            var j:*;
            j = 0;
            while (j < arrSolid.length) {
                if (arrSolid[j].shadow.getRect(stage).contains(p.x, p.y)){
                    return (true);
                };
                j++;
            };
            return (false);
        }
        public function showPreL(){
            if ((((preLMC == null)) || (!(MovieClip(this).contains(preLMC))))){
                preLMC = new PreL();
                addChild(preLMC);
                preLMC.x = ((960 / 2) - (preLMC.width / 2));
                preLMC.y = ((550 / 2) - (preLMC.height / 2));
            };
        }
        public function myLeaf():Object{
            return (uoTreeLeaf(rootClass.sfc.myUserName));
        }
        public function sendEnhItemRequest(item:Object):void{
            enhItem = item;
            rootClass.sfc.sendXtMessage("zm", "enhanceItem", [item.ItemID, item.EnhID, enhShopID], "str", curRoom);
        }
        public function initHouseInventory(resObj):void{
            houseitems = (((resObj.items)==null) ? [] : resObj.items);
            initEquippedItems(createItemPlacementArray(resObj.sHouseInfo));
        }
        public function createAvatarMCArray(uid:Number):AvatarMC{
            var char:AvatarMC;
            trace("** WORLD createAvatarMCArray >");
            char = new AvatarMC();
            char.name = ("a" + uid);
            char.x = -600;
            char.y = 0;
            char.pAV = avatars[uid];
            char.world = this;
            char.rootClass = this.rootClass;
            return (char);
        }
        public function isMoveOK(tLeaf:Object):Boolean{
            var isOK:Boolean;
            var aura:Object;
            var tLeaf:Object = tLeaf;
            isOK = true;
            aura = {};
            if (tLeaf.auras != null){
                for each (aura in tLeaf.auras) {
                    try {
                        if (aura.cat != null){
                            if (aura.cat == "stun"){
                                isOK = false;
                            };
                            if (aura.cat == "stone"){
                                isOK = false;
                            };
                            if (aura.cat == "disabled"){
                                isOK = false;
                            };
                        };
                    }
                    catch(e:Error) {
                        trace(("doAnim > " + e));
                    };
                };
                return (isOK);
            };
            return (false);
        }
        public function receivePVPInvite(o:Object){
            var modal:*;
            var modalO:*;
            var w:*;
            modal = new ModalMC();
            modalO = {};
            w = getWarzoneByWarzoneName(o.warzone);
            modalO.strBody = (("A new Warzone battle has started!  Will you join " + w.nam) + "?");
            modalO.greedy = true;
            modalO.params = {};
            modalO.callback = replyToPVPInvite;
            rootClass.ui.ModalStack.addChild(modal);
            rootClass.ui.mcPopup.onClose();
            rootClass.hideMCPVPQueue();
            modal.init(modalO);
        }
        public function onHouseOptionsDesignClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            toggleHouseEdit();
        }
        public function sendBuyItemRequest(item:Object):void{
            if (coolDown("buyItem")){
                if ((((item.bStaff == 1)) && ((myAvatar.objData.intAccessLevel < 40)))){
                    rootClass.MsgBox.notify("Test Item: Cannot be purchased yet!");
                }
                else {
                    if (((!((shopinfo.sField == ""))) && (!((getAchievement(shopinfo.sField, shopinfo.iIndex) == 1))))){
                        rootClass.MsgBox.notify("Item Locked: Special requirement not met.");
                    }
                    else {
                        if ((((item.bUpg == 1)) && (!(myAvatar.isUpgraded())))){
                            rootClass.showUpgradeWindow();
                        }
                        else {
                            if ((((item.FactionID > 1)) && ((getRep(item.FactionID) < item.iReqRep)))){
                                rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                            }
                            else {
                                if ((((item.iQSindex >= 0)) && ((getQuestValue(item.iQSindex) < int(item.iQSvalue))))){
                                    rootClass.MsgBox.notify("Item Locked: Quest Requirement not met.");
                                }
                                else {
                                    if (((((isItemInInventory(item.ItemID)) || (isItemInBank(item.ItemID)))) && (isItemStackMaxed(item.ItemID)))){
                                        rootClass.MsgBox.notify((("You cannot have more than " + item.iStk) + " of that item!"));
                                    }
                                    else {
                                        if ((((((item.bCoins == 0)) && ((item.iCost > myAvatar.objData.intGold)))) || ((((item.bCoins == 1)) && ((item.iCost > myAvatar.objData.intCoins)))))){
                                            rootClass.MsgBox.notify("Insufficient Funds!");
                                        }
                                        else {
                                            if (((((!(rootClass.isHouseItem(item))) && ((items.length >= myAvatar.objData.iBagSlots)))) || (((rootClass.isHouseItem(item)) && ((houseitems.length >= myAvatar.objData.iHouseSlots)))))){
                                                rootClass.MsgBox.notify("Inventory Full!");
                                            }
                                            else {
                                                if ((((shopBuyItem == null)) || (!((shopBuyItem.ItemID == item.ItemID))))){
                                                    shopBuyItem = item;
                                                };
                                                rootClass.sfc.sendXtMessage("zm", "buyItem", [shopBuyItem.ItemID, shopinfo.ShopID], "str", curRoom);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        public function mapScrollCheck():void{
            var map:*;
            var p:Point;
            var bounds:Rectangle;
            var cd:int;
            var left:int;
            var right:int;
            var cdy:int;
            var i:int;
            var xd:int;
            var xdy:int;
            var bottom:int;
            var child:DisplayObject;
            var cb:*;
            if (SCROLL){
                map = map.cell;
                p = myAvatar.pMC.location;
                bounds = map.walk.getRect(stage);
                cd = (960 / 2);
                left = 0;
                right = Math.round((960 - bounds.width));
                if ((((p.x > cd)) && ((p.x < (bounds.width - cd))))){
                    xd = Math.round((cd - (bounds.x + p.x)));
                    if (xd != 0){
                        map.x = (map.x + xd);
                        CHARS.x = (CHARS.x + xd);
                    };
                }
                else {
                    if (p.x < cd){
                        if (map.x != left){
                            map.x = left;
                        };
                        if (CHARS.x != left){
                            CHARS.x = left;
                        };
                    }
                    else {
                        if (p.x > (bounds.width - cd)){
                            if (map.x != right){
                                map.x = right;
                            };
                            if (CHARS.x != right){
                                CHARS.x = right;
                            };
                        };
                    };
                };
                cdy = ((550 / 2) - 50);
                if ((((p.y > cdy)) && ((p.y < (bounds.height - (550 - cdy)))))){
                    xdy = Math.round((cdy - (bounds.y + p.y)));
                    if (xdy != 0){
                        map.y = (map.y + xdy);
                        CHARS.y = (CHARS.y + xdy);
                    };
                }
                else {
                    if (p.y < cdy){
                        if (map.y != 0){
                            map.y = 0;
                        };
                        if (CHARS.y != 0){
                            CHARS.y = 0;
                        };
                    }
                    else {
                        if (p.y > (bounds.height - (550 - cdy))){
                            bottom = Math.floor((550 - bounds.height));
                            if (map.y != bottom){
                                map.y = bottom;
                            };
                            if (CHARS.y != bottom){
                                CHARS.y = bottom;
                            };
                        };
                    };
                };
                i = 0;
                while (i < CHARS.numChildren) {
                    child = CHARS.getChildAt(i);
                    cb = child.getBounds(stage);
                    child.visible = (((((((((cb.left < 960)) && ((cb.right > 0)))) && ((cb.top < 550)))) && ((cb.bottom > 0)))) && ((((MovieClip(child).mcChar == null)) || (!((MovieClip(child).mcChar.currentLabel == "Dead"))))));
                    i++;
                };
            };
        }
        public function addToBank(item):void{
            var i:int;
            if ((((bank == null)) || ((bank.length == 0)))){
                return;
            };
            i = 0;
            while (i < bank.length) {
                if (bank[i].ItemID == item.ItemID){
                    bank[i].iQty = (bank[i].iQty + int(item.iQty));
                    return;
                };
                i++;
            };
        }
        public function approachTarget(){
            var clickOK:Boolean;
            var cLeaf:Object;
            var tLeaf:Object;
            var actionObj:Object;
            var moveOK:Boolean;
            var xBuffer:int;
            var yBuffer:int;
            var tReg:Point;
            var tMon:Point;
            var tRect:Rectangle;
            var tWalk:Point;
            var cAvt:*;
            var tAvt:*;
            var pAvt:*;
            var tgtMin:int;
            var tgtMax:int;
            var targets:Array;
            var scan:Array;
            clickOK = true;
            cLeaf = uoTree[rootClass.sfc.myUserName];
            actionObj = getAutoAttack();
            if (myAvatar.target != null){
                if (myAvatar.target.npcType == "monster"){
                    tLeaf = monTree[myAvatar.target.objData.MonMapID];
                }
                else {
                    if (myAvatar.target.npcType == "player"){
                        tLeaf = myAvatar.target.dataLeaf;
                    };
                };
                if ((((((tLeaf == null)) || ((cLeaf.intState == 0)))) || ((tLeaf.intState == 0)))){
                    clickOK = false;
                };
                trace(("bPvP ? " + bPvP));
                trace(("myAvatar.target.npcType ? " + (myAvatar.target.npcType == "player")));
                if (((((bPvP) && (((((!((tLeaf.react == null))) && ((tLeaf.react[cLeaf.pvpTeam] == 1)))) || ((cLeaf.pvpTeam == tLeaf.pvpTeam)))))) || (((!(bPvP)) && ((myAvatar.target.npcType == "player")))))){
                    clickOK = false;
                };
                if (clickOK){
                    rootClass.mixer.playSound("ClickBig");
                    if (actionObj != null){
                        if (actionRangeCheck(actionObj)){
                            testAction(actionObj);
                        }
                        else {
                            moveOK = true;
                            xBuffer = ((100 + (Math.random() * 20)) * SCALE);
                            yBuffer = (((Math.random() * 40) - 20) * SCALE);
                            tReg = new Point();
                            if (myAvatar.target.pMC.mcChar.mcAttackBox == null){
                                tMon = myAvatar.target.pMC.mcChar.localToGlobal(new Point(0, 0));
                                tReg.x = (((myAvatar.target.pMC.x)>myAvatar.pMC.x) ? (tMon.x - xBuffer) : (tMon.x + xBuffer));
                                tReg.y = (tMon.y + yBuffer);
                                if (blockerHit(tReg)){
                                    tReg.x = (((myAvatar.target.pMC.x)>myAvatar.pMC.x) ? (tMon.x + xBuffer) : (tMon.x - xBuffer));
                                    if (blockerHit(tReg)){
                                        moveOK = false;
                                    };
                                };
                            }
                            else {
                                tRect = myAvatar.target.pMC.mcChar.mcAttackBox.getRect(stage);
                                tReg.x = (((myAvatar.target.pMC.x)>myAvatar.pMC.x) ? (tRect.left - xBuffer) : (tRect.right + xBuffer));
                                tReg.y = (tRect.bottom + yBuffer);
                                if (blockerHit(tReg)){
                                    tReg.x = (((myAvatar.target.pMC.x)>myAvatar.pMC.x) ? (tRect.right + xBuffer) : (tRect.left - xBuffer));
                                    if (blockerHit(tReg)){
                                        moveOK = false;
                                    };
                                };
                            };
                            tReg = CHARS.globalToLocal(tReg);
                            tReg.x = Math.round(tReg.x);
                            tReg.y = Math.round(tReg.y);
                            if (moveOK){
                                tWalk = myAvatar.pMC.simulateTo(tReg.x, tReg.y, 8);
                                moveOK = (Point.distance(tReg, tWalk) == 0);
                            };
                            if (moveOK){
                                actionReady = true;
                                myAvatar.pMC.walkTo(tReg.x, tReg.y, 32);
                                pushMove(myAvatar.pMC, tReg.x, tReg.y, 32);
                            }
                            else {
                                rootClass.chatF.pushMsg("server", "No path found!", "SERVER", "", 0);
                            };
                        };
                    };
                };
            }
            else {
                cAvt = myAvatar;
                tAvt = null;
                pAvt = null;
                tgtMin = ((("tgtMin" in actionObj)) ? actionObj.tgtMin : 1);
                tgtMax = ((("tgtMax" in actionObj)) ? actionObj.tgtMax : 1);
                targets = [];
                scan = getAllAvatarsInCell();
                for each (tAvt in scan) {
                    tLeaf = tAvt.dataLeaf;
                    if (((((!((tLeaf == null))) && (((((((!(bPvP)) && ((tAvt.npcType == "monster")))) || (((((bPvP) && ((tAvt.npcType == "player")))) && (!((cLeaf.pvpTeam == tLeaf.pvpTeam))))))) || (((((((bPvP) && ((tAvt.npcType == "monster")))) && (!((tLeaf.react == null))))) && ((tLeaf.react[cLeaf.pvpTeam] == 0)))))))) && (actionRangeCheck(actionObj, tAvt)))){
                        setTarget(tAvt);
                        testAction(actionObj);
                        return;
                    };
                };
                rootClass.chatF.pushMsg("warning", "No target selected!", "SERVER", "", 0);
            };
        }
        public function setMapEvents(evtArgs:Object):void{
            mapEvents = evtArgs;
        }
        public function sendGetAdDataRequest():void{
            if (rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap){
                rootClass.sfc.sendXtMessage("zm", "getAdData", [], "str", curRoom);
            };
        }
        public function getPartyPanelByName(unm:String):MovieClip{
            var panelsn:*;
            var panel:MovieClip;
            var i:int;
            panelsn = rootClass.ui.mcPartyFrame.numChildren;
            panel = null;
            i = 0;
            while (i < panelsn) {
                panel = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(i));
                if (panel.strName.text == unm){
                    return (panel);
                };
                i++;
            };
            return (createPartyPanel({unm:unm}));
        }
        public function partyUpdate(nam:String, val:String):void{
        }
        public function danceRequest(params){
            var obj:*;
            if (params.accept){
                rootClass.chatF.submitMsg(params.emote1, "emote", rootClass.sfc.myUserName);
            }
            else {
                obj = {};
                obj.typ = "danceDenied";
                obj.cell = strFrame;
                rootClass.sfc.sendObjectToGroup(obj, [params.sender.getId()], curRoom);
            };
        }
        private function enterMap():void{
            var uoLeaf:*;
            uoLeaf = uoTreeLeaf(rootClass.sfc.myUserName);
            if ((((intType == 0)) || ((returnInfo == null)))){
                moveToCell(uoLeaf.strFrame, uoLeaf.strPad);
            }
            else {
                moveToCell(returnInfo.strCell, returnInfo.strPad);
                returnInfo = null;
            };
            initMapEvents();
            rootClass.mcConnDetail.hideConn();
            rootClass.ui.mcInterface.areaList.visible = true;
            if (myAvatar != null){
                rootClass.showPortrait(myAvatar);
            };
        }
        public function setPVPFactionData(a:Array):void{
            if (a != null){
                PVPFactions = a;
            }
            else {
                PVPFactions = [];
            };
        }
        public function equipItem(ItemID:int):void{
            var i:int;
            rootClass.world.afkPostpone();
            if (((!((items == null))) && ((items.length > 0)))){
                i = 0;
                while (i < items.length) {
                    if (items[i].ItemID == ItemID){
                        if (items[i].sType != "Power"){
                            unequipItemAtES(items[i].sES);
                        };
                        items[i].bEquip = 1;
                        return;
                    };
                    i++;
                };
            };
            if (((!((tempitems == null))) && ((tempitems.length > 0)))){
                i = 0;
                while (i < tempitems.length) {
                    if (tempitems[i].ItemID == ItemID){
                        if (items[i].sType != "Power"){
                            unequipItemAtES(tempitems[i].sES);
                        };
                        tempitems[i].bEquip = 1;
                        return;
                    };
                    i++;
                };
            };
        }
        public function partySummon(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "gp", ["ps", unm], "str", 1);
        }
        public function sendChangeClassRequest(ClassID:int):void{
            rootClass.sfc.sendXtMessage("zm", "changeClass", [ClassID], "str", curRoom);
        }
        private function getMonID(MonMapID:int):int{
            var i:String;
            var monLeaf:*;
            for (i in monTree) {
                monLeaf = monTree[i];
                if (monLeaf.MonMapID == MonMapID){
                    return (monLeaf.MonID);
                };
            };
            return (-1);
        }
        public function setHomeTownCurrent():void{
            rootClass.sfc.sendXtMessage("zm", "setHomeTown", [], "str", curRoom);
            myAvatar.objData.strHomeTown = myAvatar.objData.strMapName;
        }
        public function addItem(item:Object):void{
            var arrItems:Array;
            var i:int;
            if (Boolean(item.bBank)){
                addToBank(item);
                return;
            };
            arrItems = (((item.bHouse)==1) ? houseitems : items);
            i = 0;
            while (i < arrItems.length) {
                if (arrItems[i].ItemID == item.ItemID){
                    arrItems[i].iQty = (arrItems[i].iQty + int(item.iQty));
                    return;
                };
                i++;
            };
            item.iQty = int(item.iQty);
            rootClass.world.invTree[item.ItemID] = item;
            arrItems.push(item);
        }
        public function abandonQuest(QuestID:int):void{
            questTree[QuestID].status = null;
        }
        public function gotoHouse(unm:String):void{
            unm = unm.toLowerCase();
            if (!isMyHouse()){
                rootClass.sfc.sendXtMessage("zm", "cmd", ["house", unm], "str", 1);
            };
        }
        public function onHouseOptionsWallClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            showHouseInventory(72);
        }
        public function updatePortrait(avt:Avatar){
            var avtPortraits:Array;
            var avtPortrait:MovieClip;
            var i:int;
            var j:int;
            var numStars:int;
            var dataLeaf:*;
            var pVal:*;
            var pMax:*;
            var pBar:*;
            i = 0;
            j = 0;
            if (avt != myAvatar){
                avtPortraits = [rootClass.ui.mcPortraitTarget];
            }
            else {
                if (avt == myAvatar.target){
                    avtPortraits = [rootClass.ui.mcPortraitTarget, rootClass.ui.mcPortrait];
                }
                else {
                    avtPortraits = [rootClass.ui.mcPortrait];
                };
            };
            i = 0;
            while (i < avtPortraits.length) {
                dataLeaf = {};
                avtPortrait = avtPortraits[i];
                if (avt.npcType == "monster"){
                    dataLeaf = monTree[avt.objData.MonMapID];
                    avtPortrait.strName.text = avt.objData.strMonName.toUpperCase();
                    if (("stars" in avtPortrait)){
                        numStars = Math.round((Math.pow((avt.objData.intLevel * 1.3), 0.5) / 2));
                        j = 1;
                        while (j < 6) {
                            if (j <= numStars){
                                avtPortrait.stars.getChildByName(("s" + j)).visible = true;
                            }
                            else {
                                avtPortrait.stars.getChildByName(("s" + j)).visible = false;
                            };
                            j++;
                        };
                    };
                };
                if (avt.npcType == "player"){
                    dataLeaf = uoTree[avt.pnm];
                    avtPortrait.strName.text = avt.objData.strUsername.toUpperCase();
                    if (("stars" in avtPortrait)){
                        j = 1;
                        while (j < 6) {
                            avtPortrait.stars.getChildByName(("s" + j)).visible = false;
                            j++;
                        };
                    };
                };
                if ((((avt.npcType == "monster")) || ((avt.npcType == "player")))){
                    avtPortrait.strLevel.text = avt.objData.intLevel;
                    pVal = 0;
                    pMax = 0;
                    pBar = null;
                    pVal = dataLeaf.intHP;
                    pMax = dataLeaf.intHPMax;
                    if (avt == myAvatar){
                        pMax = (pMax + dataLeaf.sta.$shb);
                    };
                    pBar = avtPortrait.HP;
                    if (dataLeaf.intHP >= 0){
                        pBar.strIntHP.text = (pBar.strIntHPs.text = String(dataLeaf.intHP));
                    }
                    else {
                        pBar.strIntHP.text = (pBar.strIntHPs.text = "X");
                    };
                    if (pVal < 0){
                        pVal = 0;
                    };
                    if (pVal > pMax){
                        pVal = pMax;
                    };
                    pBar.intHPbar.x = Math.min(-((pBar.intHPbar.width * (1 - (pVal / pMax)))), 0);
                    pVal = dataLeaf.intMP;
                    pMax = dataLeaf.intMPMax;
                    if (avt == myAvatar){
                        pMax = (pMax + dataLeaf.sta.$smb);
                    };
                    pBar = avtPortrait.MP;
                    if (dataLeaf.intMP >= 0){
                        pBar.strIntMP.text = (pBar.strIntMPs.text = String(dataLeaf.intMP));
                    }
                    else {
                        pBar.strIntMP.text = (pBar.strIntMPs.text = "X");
                    };
                    if (pVal < 0){
                        pVal = 0;
                    };
                    if (pVal > pMax){
                        pVal = pMax;
                    };
                    pBar.intMPbar.x = Math.min(-((pBar.intMPbar.width * (1 - (pVal / pMax)))), 0);
                };
                i++;
            };
        }
        public function selfMute(dur:int=1):void{
            rootClass.sfc.sendXtMessage("zm", "cmd", ["mute", dur, myAvatar.objData.strUsername.toLowerCase()], "str", rootClass.world.curRoom);
        }
        public function clearAllAvatars():void{
            var i:String;
            for (i in avatars) {
                destroyAvatar(Number(i));
            };
            avatars = new Object();
        }
        public function getWarzoneByName(nam:String){
            var i:int;
            i = 0;
            while (i < PVPMaps.length) {
                if (PVPMaps[i].nam == nam){
                    return (PVPMaps[i]);
                };
                i++;
            };
            return (null);
        }
        public function partyLeave():void{
            rootClass.sfc.sendXtMessage("zm", "gp", ["pl"], "str", 1);
        }
        public function copyAvatarMC(mcChar:MovieClip):void{
            var copier:AvatarMCCopier;
            copier = new AvatarMCCopier(rootClass);
            copier.copyTo(mcChar);
        }
        public function initLoaders():void{
            var lmi:Object;
            var i:*;
            for (i in loaderManager) {
                lmi = loaderManager[i];
                lmi.timer.addEventListener(TimerEvent.TIMER_COMPLETE, loaderTimerComplete, false, 0, true);
                lmi.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCallback, false, 0, true);
                lmi.ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler, false, 0, true);
                lmi.ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler, false, 0, true);
            };
        }
        public function updateCellMap(o:Object):void{
            var cell:Object;
            var s:String;
            var mc:MovieClip;
            var p:String;
            var o:Object = o;
            cell = {};
            for (s in cellMap) {
                cell = cellMap[s];
                if (((!((cell.ias == null))) && (!((cell.ias[o.ID] == null))))){
                    for (p in o) {
                        cell.ias[o.ID][p] = o[p];
                    };
                };
            };
            mc = MovieClip(CHARS.getChildByName(("ia" + o.ID)));
            mc.update();
            return;
            e = e;
            try {
                mc = MovieClip(map.getChildByName(("ia" + o.ID)));
                mc.update();
            }
            catch(e:Error) {
            };
        }
        public function showAuraImpact(auraObj){
            var tMC:MovieClip;
            var entType:*;
            var entID:*;
            var actionDamage:*;
            entType = auraObj.tInf.split(":")[0];
            entID = int(auraObj.tInf.split(":")[1]);
            actionDamage = null;
            switch (entType){
                case "p":
                    if (((((!((avatars[entID] == null))) && (("pMC" in avatars[entID])))) && (!((avatars[entID].pMC == null))))){
                        tMC = avatars[entID].pMC;
                    };
                    break;
                case "m":
                    if (((((!((getMonster(entID) == null))) && (("pMC" in getMonster(entID))))) && (!((getMonster(entID).pMC == null))))){
                        tMC = getMonster(entID).pMC;
                    };
                    break;
            };
            if (tMC != null){
                if (auraObj.hp >= 0){
                    actionDamage = new hitDisplay();
                    actionDamage.t.ti.text = Math.abs(auraObj.hp);
                }
                else {
                    actionDamage = new healDisplay();
                    actionDamage.t.ti.text = (("+" + Math.abs(auraObj.hp)) + "+");
                };
                actionDamage.scaleX = (actionDamage.scaleY = 0.5);
                if (auraObj.hp >= 0){
                    actionDamage.t.ti.textColor = 0xEE9900;
                };
                tMC.addChild(actionDamage);
                actionDamage.x = (tMC.mcChar.x - ((20 + (Math.random() * 40)) * tMC.mcChar.scaleX));
                actionDamage.y = ((tMC.pname.y - 10) - (Math.random() * 30));
            };
        }
        public function playerInit(){
            var userList:*;
            var i:*;
            var a:Array;
            var uid:int;
            trace("------------------------------ Player Init");
            trace((" > " + rootClass.sfc.ipAddress));
            userList = rootClass.sfc.getRoom(curRoom).getUserList();
            a = [];
            uid = 0;
            for (i in userList) {
                a.push(userList[i].getId());
            };
            if (a.length > 0){
                objectByIDArray(a);
            };
            myAvatar.pMC.disablePNameMouse();
            rootClass.sfcSocial = true;
        }
        public function coolDown(eventStr:String):Boolean{
            var event:*;
            var dat:*;
            var ct:*;
            var delta:*;
            event = lock[eventStr];
            dat = new Date();
            ct = dat.getTime();
            delta = (ct - event.ts);
            if (delta < event.cd){
                rootClass.chatF.pushMsg("warning", "Action taken too quickly, try again in a moment.", "SERVER", "", 0);
                return (false);
            };
            event.ts = ct;
            return (true);
        }
        public function reloadCurrentMap():void{
            clearMonstersAndProps();
            loadMap(((strMapFileName + "?") + Math.random()));
        }
        public function equipHouseRequest(params):void{
            if (params.accept){
                rootClass.world.sendEquipItemRequest(params.item);
                rootClass.world.equipHouseByID(params.item.ItemID);
            };
        }
        public function resPlayer(){
            afkPostpone();
            rootClass.sfc.sendXtMessage("zm", "resPlayerTimed", [rootClass.sfc.myUserId], "str", curRoom);
        }
        public function afkPostpone():void{
            var now:*;
            var uoLeaf:*;
            afkTimer.reset();
            afkTimer.start();
            now = new Date().getTime();
            uoLeaf = uoTree[rootClass.sfc.myUserName];
            if (((((!((uoLeaf == null))) && (uoLeaf.afk))) && ((((uoLeaf.afkts == null)) || ((now > (uoLeaf.afkts + 500))))))){
                rootClass.sfc.sendXtMessage("zm", "afk", [false], "str", 1);
                uoLeaf.afkts = now;
            };
        }
        public function getLoaderHostByTimer(t:Timer):Object{
            var i:*;
            for (i in loaderManager) {
                if (loaderManager[i].timer == t){
                    return (loaderManager[i]);
                };
            };
            return (null);
        }
        public function exitCell():void{
            mvTimerKill();
            exitCombat();
            rootClass.clearPopups(["House"]);
            if (myAvatar != null){
                myAvatar.targets = {};
                if (myAvatar.pMC != null){
                    myAvatar.pMC.stopWalking();
                };
                if (myAvatar.target != null){
                    setTarget(null);
                };
            };
            if (strFrame != "Wait"){
                clearMonstersAndProps();
                hideAllAvatars();
            };
            rootClass.sfcSocial = false;
            rootClass.ui.mcInterface.areaList.gotoAndStop("init");
        }
        public function onHouseOptionsFloorClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            showHouseInventory(70);
        }
        public function unlockActionsExcept(ao){
            var actIcons:*;
            var ai:*;
            var j:*;
            var actObj:*;
            var i:*;
            var icon1:*;
            actIcons = [];
            ai = 0;
            ai = 0;
            while (ai < actions.active.length) {
                actObj = actions.active[ai];
                if (((((!((actObj.ref == ao.ref))) && ((actObj.lock == true)))) && ((actObj.ts < ao.ts)))){
                    i = 0;
                    while (i < actionMap.length) {
                        if (actionMap[i] == actObj.ref){
                            actIcons.push(("i" + (i + 1)));
                        };
                        i++;
                    };
                };
                ai++;
            };
            j = 0;
            while (j < actIcons.length) {
                icon1 = rootClass.ui.mcInterface.actBar.getChildByName(actIcons[j]);
                if (icon1.actObj != null){
                    icon1.actObj.lock = false;
                };
                j++;
            };
        }
        public function getMonster(MonMapID:int):Avatar{
            var i:int;
            i = 0;
            while (i < monsters.length) {
                if ((((monsters[i].objData.MonMapID == MonMapID)) && ((monsters[i].objData.MonID == monTree[MonMapID].MonID)))){
                    return (monsters[i]);
                };
                i++;
            };
            return (null);
        }
        private function mapPlayerAssetClass(sES:String):LoaderContext{
            if (playerDomains[sES] == null){
                playerDomains[sES] = {};
                playerDomains[sES].loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
                playerDomains[sES].loaderC = new LoaderContext(false, playerDomains[sES].loaderD);
            };
            return (playerDomains[sES].loaderC);
        }
        public function sendUseItemArrayRequest(arr:Array):void{
            rootClass.sfc.sendXtMessage("zm", "serverUseItem", arr, "str", -1);
        }
        public function setQuestValue(index:Number, value:Number):void{
            myAvatar.objData.strQuests = updateValue(myAvatar.objData.strQuests, index, value);
        }
        public function onHouseOptionsSaveClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            saveHouseSetup();
        }
        public function requestPVPQueue(warzone:String, factionID:int=-1):void{
            rootClass.sfc.sendXtMessage("zm", "PVPQr", [warzone, factionID], "str", rootClass.world.curRoom);
        }
        public function clearLoaders(clearPlayerDomains:Boolean=false){
            var lmi:Object;
            var i:* = undefined;
            var clearPlayerDomains:Boolean = clearPlayerDomains;
            for (i in loaderManager) {
                lmi = loaderManager[i];
                try {
                    lmi.ldr.close();
                }
                catch(e:Error) {
                };
                try {
                    lmi.ldr.unload();
                }
                catch(e:Error) {
                };
                lmi.free = true;
                lmi.isOpen = false;
                lmi.loaderData = null;
                lmi.timer.reset();
                lmi.callBackA = null;
                lmi.callBackB = null;
            };
            if (clearPlayerDomains){
                playerDomains = {};
            };
            loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            loaderC = new LoaderContext(false, loaderD);
            loaderQueue = [];
        }
        public function castSpellFX(cAvt, spFX, spell){
            var tAvt:Avatar;
            var AssetClass:Class;
            var spellFX:*;
            var targetMCs:Array;
            var i:int;
            if (spFX.avts != null){
                targetMCs = [];
                i = 0;
                if (spFX.fx == "c"){
                    if (spFX.strl == "lit1"){
                        targetMCs.push(cAvt.pMC.mcChar);
                        i = 0;
                        while (i < spFX.avts.length) {
                            tAvt = spFX.avts[i];
                            if (((((!((tAvt == null))) && (!((tAvt.pMC == null))))) && (!((tAvt.pMC.mcChar == null))))){
                                targetMCs.push(tAvt.pMC.mcChar);
                            };
                            i++;
                        };
                        if (targetMCs.length > 1){
                            AssetClass = (getClass("sp_C1") as Class);
                            if (AssetClass != null){
                                spellFX = new (AssetClass)();
                                spellFX.mouseEnabled = false;
                                spellFX.mouseChildren = false;
                                spellFX.visible = true;
                                spellFX.world = rootClass.world;
                                spellFX.strl = spFX.strl;
                                rootClass.drawChainsLinear(targetMCs, 33, MovieClip(CHARS.addChild(spellFX)));
                            };
                        };
                    };
                }
                else {
                    if (spFX.fx == "f"){
                        targetMCs.push(cAvt.pMC.mcChar);
                        tAvt = spFX.avts[0];
                        if (((((!((tAvt == null))) && (!((tAvt.pMC == null))))) && (!((tAvt.pMC.mcChar == null))))){
                            targetMCs.push(tAvt.pMC.mcChar);
                        };
                        if (targetMCs.length > 1){
                            spellFX = new MovieClip();
                            spellFX.mouseEnabled = false;
                            spellFX.mouseChildren = false;
                            spellFX.visible = true;
                            spellFX.world = rootClass.world;
                            spellFX.strl = spFX.strl;
                            rootClass.drawFunnel(targetMCs, MovieClip(CHARS.addChild(spellFX)));
                        };
                    }
                    else {
                        i = 0;
                        while (i < spFX.avts.length) {
                            tAvt = spFX.avts[i];
                            AssetClass = (getClass(spFX.strl) as Class);
                            if (AssetClass != null){
                                spellFX = new (AssetClass)();
                                if (spell != null){
                                    spellFX.transform = spell.transform;
                                };
                                CHARS.addChild(spellFX);
                                spellFX.mouseEnabled = false;
                                spellFX.mouseChildren = false;
                                spellFX.visible = true;
                                spellFX.world = rootClass.world;
                                spellFX.strl = spFX.strl;
                                spellFX.tMC = tAvt.pMC;
                                switch (spFX.fx){
                                    case "p":
                                        spellFX.x = cAvt.pMC.x;
                                        spellFX.y = (cAvt.pMC.y - (cAvt.pMC.mcChar.height * 0.5));
                                        spellFX.dir = ((((tAvt.pMC.x - cAvt.pMC.x))>=0) ? 1 : -1);
                                        break;
                                    case "w":
                                        spellFX.x = spellFX.tMC.x;
                                        spellFX.y = (spellFX.tMC.y + 3);
                                        break;
                                };
                            }
                            else {
                                trace();
                                trace(("*>*>*> Could not load class " + spFX.strl));
                                trace();
                            };
                            i++;
                        };
                    };
                };
            };
        }
        public function sendRemoveTempItemRequest(ItemID:int, count:int):void{
            rootClass.sfc.sendXtMessage("zm", "removeTempItem", [ItemID, count], "str", curRoom);
            removeTempItem(ItemID, count);
        }
        public function getHouseItem(ID:int):Object{
            var j:int;
            var i:int;
            if (isMyHouse()){
                j = 0;
                while (j < houseitems.length) {
                    if (houseitems[j].ItemID == ID){
                        return (houseitems[j]);
                    };
                    j++;
                };
            }
            else {
                i = 0;
                while (i < objHouseData.items.length) {
                    if (objHouseData.items[i].ItemID == ID){
                        return (objHouseData.items[i]);
                    };
                    i++;
                };
            };
            return (null);
        }
        public function openApop(obj){
            var apopmc:MovieClip;
            if (((isMovieFront("Apop")) || (((!(("frame" in obj))) || (((("frame" in obj)) && (("cnt" in obj)))))))){
                apopmc = attachMovieFront("Apop");
                apopmc.update(obj);
            };
        }
        public function getClass(assetLinkageID:String):Class{
            var o:Object;
            var c:Class;
            var sES:String;
            var assetLinkageID:String = assetLinkageID;
            o = {};
            try {
                c = (getDefinitionByName(assetLinkageID) as Class);
                if (c != null){
                    return (c);
                };
            }
            catch(e:Error) {
            };
            try {
                c = (loaderD.getDefinition(assetLinkageID) as Class);
                if (c != null){
                    return (c);
                };
            }
            catch(e:Error) {
            };
            for (sES in playerDomains) {
                if (playerDomains[sES].loaderD.hasDefinition(assetLinkageID)){
                    return ((playerDomains[sES].loaderD.getDefinition(assetLinkageID) as Class));
                };
            };
            trace((("getClass() could not find " + assetLinkageID) + "!"));
            return (null);
        }
        public function updateAuraData(cLeaf:Object, aura:Object, tLeaf:Object):void{
            var existingAura:Object;
            for each (existingAura in tLeaf.auras) {
                if ((((existingAura.nam == aura.nam)) && ((existingAura.cLeaf == cLeaf)))){
                    existingAura.dur = aura.dur;
                };
            };
        }
        public function equipUseableItem(item:Object):void{
            var actionObj:Object;
            var i:int;
            var invItem:Object;
            i = 0;
            i = 0;
            while (i < actions.active.length) {
                if (actions.active[i].ref == "i1"){
                    actionObj = actions.active[i];
                };
                i++;
            };
            actionObj.sArg1 = String(item.ItemID);
            actionObj.sArg2 = String(item.sDesc);
            rootClass.updateIcons(getActIcons(actionObj), [item.sFile], item);
            rootClass.updateActionObjIcon(actionObj);
            i = 0;
            while (i < items.length) {
                invItem = items[i];
                if ((((invItem.sType.toLowerCase() == "item")) && (!((invItem.sLink.toLowerCase() == "none"))))){
                    if (invItem.ItemID == item.ItemID){
                        invItem.bEquip = 1;
                        rootClass.sfc.sendXtMessage("zm", "geia", [invItem.sLink], "str", rootClass.world.curRoom);
                    }
                    else {
                        invItem.bEquip = 0;
                    };
                };
                i++;
            };
            if (rootClass.ui.mcPopup.mcInventory != null){
                rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
                rootClass.ui.mcPopup.mcInventory.refreshDetail();
            };
        }
        private function calculateFPS():void{
            var now:Number;
            var delta_t:int;
            var temp:int;
            var avg_fps:*;
            if (fpsTS != 0){
                now = new Date().getTime();
                delta_t = (now - fpsTS);
                temp = 0;
                if (ticklist.length == TICK_MAX){
                    temp = ticklist.shift();
                };
                ticklist.push(delta_t);
                ticksum = ((ticksum + delta_t) - temp);
                avg_fps = (1000 / (ticksum / ticklist.length));
                rootClass.ui.mcFPS.txtFPS.text = avg_fps.toPrecision(4);
            };
            fpsTS = new Date().getTime();
        }
        public function getLoaderHostByURL(u:String):Object{
            var i:*;
            for (i in loaderManager) {
                if (u.indexOf(loaderManager[i].url) > -1){
                    return (loaderManager[i]);
                };
            };
            return (null);
        }
        public function getUserById(uid:Number){
            return (rootClass.sfc.getRoom(curRoom).getUser(Number(uid)));
        }
        public function uoTreeLeafSet(uoName, uoLeafSet:Object){
            var uoLeaf:*;
            var xtArr:*;
            var prop:*;
            var avt:*;
            if (uoTree[uoName.toLowerCase()] == null){
                uoTree[uoName.toLowerCase()] = {};
            };
            uoLeaf = uoTree[uoName.toLowerCase()];
            xtArr = [];
            for (prop in uoLeafSet) {
                uoLeaf[prop] = uoLeafSet[prop];
                avt = getAvatarByUserName(uoName);
                if (((!((avt == null))) && (!((avt.objData == null))))){
                    avt.objData[prop] = uoLeafSet[prop];
                };
                xtArr.push(((prop + ":") + String(uoLeafSet[prop])));
            };
        }
        public function initBank(arrItems:Array):void{
            var i:int;
            iBankCount = 0;
            iBankCountAC = 0;
            if (arrItems == null){
                bank = [];
            }
            else {
                bank = arrItems;
                i = 0;
                while (i < bank.length) {
                    if (bank[i].bCoins == 0){
                        iBankCount++;
                    }
                    else {
                        iBankCountAC++;
                    };
                    bank[i].iQty = int(bank[i].iQty);
                    i++;
                };
            };
        }
        public function initHouseData(obj:Object):void{
            objHouseData = obj;
            if (objHouseData != null){
                objHouseData.arrPlacement = createItemPlacementArray(objHouseData.sHouseInfo);
                verifyItemQty();
            };
        }
        public function rest():void{
            if (!restTimer.running){
                myAvatar.pMC.mcChar.gotoAndPlay("Rest");
                rootClass.sfc.sendXtMessage("zm", "emotea", ["rest"], "str", 1);
                restStart();
            };
        }
        public function loaderErrorHandler(e:IOErrorEvent){
            var s:String;
            var u:String;
            var l:*;
            s = e.toString();
            u = s.substr((s.indexOf("URL: ") + 5));
            u = u.substr(0, (u.length - 1));
            l = getLoaderHostByURL(u);
            if (l != null){
                if (l.callBackB != null){
                    l.callBackB(e);
                };
            };
            closeLoader(l, false, false);
        }
        public function objectByID(uid:Number){
            var uoLeaf:*;
            var unm:*;
            var strF:*;
            trace("** WORLD objectByID >");
            uoLeaf = getUoLeafById(uid);
            if (uoLeaf != null){
                unm = uoLeaf.uoName;
                trace((" unm : " + unm));
                strF = String(uoLeaf.strFrame);
                if (uid == rootClass.sfc.myUserId){
                    strF = strFrame;
                };
                if (avatars[uid] == null){
                    avatars[uid] = new Avatar();
                    avatars[uid].uid = uid;
                    avatars[uid].pnm = unm;
                };
                avatars[uid].dataLeaf = uoLeaf;
                if ((((avatars[uid].pMC == null)) && ((strF == strFrame)))){
                    avatars[uid].pMC = createAvatarMC(uid);
                };
                updateUserDisplay(uid);
            };
        }
        public function afkToggle():void{
            var uoLeaf:*;
            uoLeaf = uoTree[rootClass.sfc.myUserName];
            if (uoLeaf != null){
                rootClass.sfc.sendXtMessage("zm", "afk", [!(uoLeaf.afk)], "str", 1);
            };
        }
        private function testTxTy(pt:Point, umc:MovieClip):Boolean{
            var sw:int;
            var sh:int;
            var sx:int;
            var sy:int;
            var rs:Rectangle;
            var rb:Rectangle;
            var mc:MovieClip;
            var pass:Boolean;
            var i:int;
            sw = umc.shadow.width;
            sh = umc.shadow.height;
            sx = (pt.x - (sw / 2));
            sy = (pt.y - (sh / 2));
            rs = new Rectangle(sx, sy, sw, sh);
            rb = null;
            mc = null;
            pass = false;
            i = 0;
            while (i < arrSolid.length) {
                mc = MovieClip(arrSolid[i].shadow);
                rb = new Rectangle(mc.x, mc.y, mc.width, mc.height);
                pass = !(rb.intersects(rs));
                i++;
            };
            return (pass);
        }
        public function updatePartyFrame(obj:Object=null){
            var panel:MovieClip;
            var pVal:int;
            var pMax:int;
            var pBar:MovieClip;
            var i:int;
            var dataLeaf:Object;
            var members:Array;
            var range:Boolean;
            var reposition:Boolean;
            var pm:String;
            var panels:*;
            var panelName:*;
            panel = null;
            pVal = 0;
            pMax = 0;
            pBar = null;
            i = 0;
            dataLeaf = null;
            members = [];
            range = true;
            reposition = false;
            if (((((!((obj == null))) && (!((obj.range == null))))) && ((obj.range == false)))){
                range = false;
            };
            if (obj != null){
                members = [obj.unm];
            }
            else {
                reposition = true;
                members = partyMembers;
            };
            if (members.length > 0){
                pm = "";
                if (obj == null){
                    panels = [];
                    i = 0;
                    i = 0;
                    while (i < rootClass.ui.mcPartyFrame.numChildren) {
                        panels.push(MovieClip(rootClass.ui.mcPartyFrame.getChildAt(i)));
                        i++;
                    };
                    i = 0;
                    i = 0;
                    while (i < panels.length) {
                        panel = panels[i];
                        panelName = panel.strName.text;
                        if (partyMembers.indexOf(panelName) == -1){
                            panel.removeEventListener(MouseEvent.CLICK, onPartyPanelClick);
                            rootClass.ui.mcPartyFrame.removeChild(panel);
                        };
                        i++;
                    };
                };
                i = 0;
                while (i < members.length) {
                    pm = members[i];
                    panel = getPartyPanelByName(pm);
                    dataLeaf = uoTree[pm.toLowerCase()];
                    if (dataLeaf == null){
                        panel.HP.visible = false;
                        panel.MP.visible = false;
                        panel.txtRange.visible = true;
                    }
                    else {
                        if (range){
                            pVal = dataLeaf.intHP;
                            pMax = dataLeaf.intHPMax;
                            pBar = panel.HP;
                            if (pVal >= 0){
                                pBar.strIntHP.text = (pBar.strIntHPs.text = String(dataLeaf.intHP));
                            }
                            else {
                                pBar.strIntHP.text = (pBar.strIntHPs.text = "X");
                            };
                            if (pVal < 0){
                                pVal = 0;
                            };
                            pBar.intHPbar.x = -((pBar.intHPbar.width * (1 - (pVal / pMax))));
                            pVal = dataLeaf.intMP;
                            pMax = dataLeaf.intMPMax;
                            pBar = panel.MP;
                            if (pVal >= 0){
                                pBar.strIntMP.text = (pBar.strIntMPs.text = String(dataLeaf.intMP));
                            }
                            else {
                                pBar.strIntMP.text = (pBar.strIntMPs.text = "X");
                            };
                            if (pVal < 0){
                                pVal = 0;
                            };
                            pBar.intMPbar.x = -((pBar.intMPbar.width * (1 - (pVal / pMax))));
                            panel.HP.visible = true;
                            panel.MP.visible = true;
                            panel.txtRange.visible = false;
                        }
                        else {
                            panel.HP.visible = false;
                            panel.MP.visible = false;
                            panel.txtRange.visible = true;
                        };
                    };
                    if (reposition){
                        panel.y = int(((panel.height + 2) * i));
                    };
                    panel.partyLead.visible = (pm.toLowerCase() == partyOwner.toLowerCase());
                    i++;
                };
            }
            else {
                i = 0;
                while ((((rootClass.ui.mcPartyFrame.numChildren > 0)) && ((i < 10)))) {
                    panel = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(0));
                    panel.removeEventListener(MouseEvent.CLICK, onPartyPanelClick);
                    rootClass.ui.mcPartyFrame.removeChildAt(0);
                    i++;
                };
            };
            rootClass.ui.mcPortrait.partyLead.visible = (partyOwner.toLowerCase() == rootClass.sfc.myUserName);
        }
        public function buyBagSlots(iSlots:int):void{
            rootClass.sfc.sendXtMessage("zm", "buyBagSlots", [iSlots], "str", curRoom);
        }
        public function onHouseItemEnterFrame(e:Event):void{
            var mc:MovieClip;
            var i:int;
            var child:DisplayObject;
            var childGlobalPoint:Point;
            var localPoint:Point;
            var r:Rectangle;
            mc = (e.currentTarget as MovieClip);
            i = 0;
            while (i < map.cell.numChildren) {
                child = map.cell.getChildAt(i);
                childGlobalPoint = new Point();
                childGlobalPoint.x = mc.x;
                childGlobalPoint.y = mc.y;
                childGlobalPoint = mc.localToGlobal(childGlobalPoint);
                localPoint = new Point();
                localPoint = child.globalToLocal(childGlobalPoint);
                if ((((((child is MovieClip)) && (MovieClip(child).isFloor))) && (MovieClip(child).hitTestPoint(localPoint.x, localPoint.y)))){
                    mc.removeEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
                    mc.isStable = true;
                    break;
                };
                i++;
            };
            if (!mc.isStable){
                r = mc.getBounds(stage);
                if ((r.y + (r.height / 2)) > 495){
                    mc.isStable = true;
                    mc.y = Math.ceil((r.y - (r.y - mc.y)));
                    mc.removeEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
                }
                else {
                    mc.y = (mc.y + 10);
                };
                if (rootClass.ui.mcPopup.mcHouseMenu.visible){
                    rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(mc);
                };
            };
        }
        private function loaderProgressHandler(e:Event){
            var loaderInfo:*;
            var l:*;
            loaderInfo = e.currentTarget;
            l = getLoaderHostByLoaderInfo(loaderInfo);
            if (l != null){
                l.isOpen = true;
            };
        }
        private function onMapLoadComplete(e:Event){
            trace(("Mapload complete: " + e));
            trace(e.target.url);
            rootClass.ui.visible = true;
            mapLoadInProgress = false;
            map = MovieClip(ldr_map.content);
            addChildAt(map, 0).x = 0;
            resetSpawnPoint();
            if (((!((mondef == null))) && (mondef.length))){
                initMonsters(mondef, monmap);
            }
            else {
                enterMap();
            };
            if (isMyHouse()){
                rootClass.ui.mcPopup.fOpen("House");
            };
        }
        public function updateMonsters(){
            var i:int;
            if (monmap != null){
                i = 0;
                while (i < monmap.length) {
                    if (monmap[i].strFrame == strFrame){
                        updateMonster(monmap[i]);
                    };
                    i++;
                };
            };
        }
        public function sendDeleteFriend(ID:int, unm):void{
            rootClass.sfc.sendXtMessage("zm", "deleteFriend", [ID, unm], "str", 1);
        }
        public function sendDuelInvite(unm:String):void{
            rootClass.sfc.sendXtMessage("zm", "duel", [unm], "str", 1);
        }
        public function sendUnequipItemRequest(item:Object):void{
            if (((!((item == null))) && (isItemEquipped(item.ItemID)))){
                if (coolDown("unequipItem")){
                    rootClass.sfc.sendXtMessage("zm", "unequipItem", [item.ItemID], "str", curRoom);
                };
            };
        }
        public function onHouseOptionsExpandClick(e:MouseEvent):void{
            rootClass.mixer.playSound("Click");
            showHouseOptions("default");
        }
        public function sendEnhItemRequestShop(item:Object, enh:Object):void{
            if (coolDown("buyItem")){
                enhItem = item;
                rootClass.sfc.sendXtMessage("zm", "enhanceItemShop", [item.ItemID, enh.ItemID, shopinfo.ShopID], "str", curRoom);
            };
        }
        public function updateAreaUserCount():void{
        }
        public function sendAddFriend(params:Object):void{
            if (params.accept){
                rootClass.sfc.sendXtMessage("zm", "addFriend", [params.unm], "str", 1);
            }
            else {
                rootClass.sfc.sendXtMessage("zm", "declineFriend", [params.unm], "str", 1);
            };
        }
        public function verifyItemQty():void{
            var placementQty:*;
            var i:int;
            var ID:*;
            var item:*;
            placementQty = {};
            i = 0;
            while (i < objHouseData.arrPlacement.length) {
                ID = objHouseData.arrPlacement[i].ID;
                if (placementQty[ID] == null){
                    placementQty[ID] = 1;
                }
                else {
                    var _local5 = placementQty;
                    var _local6 = ID;
                    var _local7 = (_local5[_local6] + 1);
                    _local5[_local6] = _local7;
                };
                item = getHouseItem(ID);
                if ((((item == null)) || ((item.iQty < placementQty[ID])))){
                    objHouseData.sHouseInfo = "";
                    objHouseData.arrPlacement = [];
                };
                i++;
            };
        }
        public function toggleName(uid, state:String){
            if (state == "on"){
                getMCByUserID(uid).pname.visible = true;
            };
            if (state == "off"){
                getMCByUserID(uid).pname.visible = false;
            };
        }

    }
}//package 

