// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game

package {
    import flash.display.MovieClip;
    import it.gotoandplay.smartfoxserver.SmartFoxClient;
    import flash.system.LoaderContext;
    import flash.net.URLLoader;
    import flash.filters.GlowFilter;
    import flash.system.ApplicationDomain;
    import flash.net.SharedObject;
    import flash.filters.BitmapFilterQuality;
    import it.gotoandplay.smartfoxserver.SFSEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.system.System;
    import flash.system.Security;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.events.KeyboardEvent;
    import flash.events.FocusEvent;
    import flash.ui.Keyboard;
    import flash.net.navigateToURL;
    import flash.display.Loader;
    import flash.events.IOErrorEvent;
    import flash.display.DisplayObject;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import flash.external.ExternalInterface;
    import flash.geom.ColorTransform;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Rectangle;
    import flash.display.StageDisplayState;
    import flash.text.*;
    import it.gotoandplay.smartfoxserver.*;

    public class Game extends MovieClip {

        public static var root:MovieClip;
        public static var serverFilePath:String = "";
        public static var serverURL:String = "";
        public static var serverName:String;
        public static var cLoginZone:String = "zone_master";
        public static var serverPort:int = 5588;
        public static var clientToken:String = "N7B5W8W1Y5B1R5O7B2";
        public static var mcUpgradeWindow:MovieClip;
        public static var bPTR:Boolean = false;

        public const EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;

        public var GstRatio:Number;
        public var mixer:SoundFX;
        public var baseResistValue:Number;
        public var GstGoal:int;
        public var orderedStats:Array;
        public var loadermanager:LoaderManager;
        public var baseBlock:Number;
        public var baseCrit:Number;
        public var statsExponent:Number = 1.33;
        public var sfc:SmartFoxClient;
        public var PCstBase:int;
        public var stats:Array;
        public var baseEventValue:Number;
        private var assetsContext:LoaderContext;
        public var objLogin:Object;
        public var curveExponent:Number = 0.66;
        public var PCstGoal:int;
        public var mcConnDetail:ConnDetailMC;
        public var PCstRatio:Number;
        public var loginLoader:URLLoader;
        public var iRankMax:int = 10;
        public var ldrMC:LoaderMC;
        public var classCatMap:Object;
        public var sFilePath:String = "";
        public var serialCmdMode:Boolean = false;
        public var GlowFilterBlue:GlowFilter;
        public var GlowFilterGold:GlowFilter;
        public var params:Object;
        public var haldroidApp:String = null;
        public var sfcA:Array;
        public var arrNose:Array;
        public var mcExtSWF:MovieClip;
        public var intSPtoDPS:int;
        public var PChpGoal1:int;
        public var PChpBase1:int;
        public var baseResist:Number;
        public var resistRating:Number;
        public var assetsDomain:ApplicationDomain;
        public var PChpDelta:int;
        public var baseHaste:Number;
        public var baseParry:Number;
        public var arrEyes:Array;
        public var aaaloop:int = 0;
        public var intHPperEND:int;
        public var I0pct:Number = 0.8;
        public var ui:MovieClip;
        public var baseBlockValue:Number;
        public var ts_login_server:Number;
        public var serialCmd:Object;
        public var MsgBox:MovieClip;
        public var pingCount:int = 0;
        public var totalPingTime:Number = 0;
        public var intLevelCap:int;
        public var PChpBase100:int;
        public var querystring:Object;
        public var bigNumberBase:int;
        public var ratiosBySlot:Object;
        public var objServerInfo:Object;
        public var arrMouth:Array;
        public var baseHit:Number;
        public var userPreference:SharedObject;
        public var ts_login_client:Number;
        public var arrHP:Array;
        public var I2pct:Number = 1.25;
        public var modRating:Number;
        public var PChpGoal100:int;
        public var intAPtoDPS:int;
        public var baseMiss:Number;
        public var mcLogin:MovieClip;
        public var baseDodge:Number;
        public var world:World;
        public var loginInfo:Object;
        public var GstBase:int;
        public var uoPref:Object;
        public var arrRanks:Array;
        public var baseCritValue:Number;
        public var PCDPSMod:Number = 0.85;
        public var songMixer:MusicPlayer;
        public var chatF:Chat;
        public var sfcSocial:Boolean = false;

        {
            MovieClip.prototype.removeAllChildren = function ():void{
                var i:*;
                i = (this.numChildren - 1);
                while (i >= 0) {
                    this.removeChildAt(i);
                    i--;
                };
            };
        }
        public function Game(){
            var onConnectionHandler:Function;
            var onConnectionLostHandler:Function;
            var onLoginHandler:Function;
            var onLogoutHandler:Function;
            var onMultiConnectionHandler:Function;
            var onMultiConnectionLostHandler:Function;
            var onMultiLogoutHandler:Function;
            var onMultiLoginHandler:Function;
            var onJoinRoomHandler:Function;
            var onUserEnterRoomHandler:Function;
            var onUserLeaveRoomHandler:Function;
            var onUserVariablesUpdateHandler:Function;
            var onRoomListUpdateHandler:Function;
            var onRoomVariablesUpdateHandler:Function;
            var onRoomAddedHandler:Function;
            var onPublicMessageHandler:Function;
            var onPrivateMessageHandler:Function;
            var onModeratorMessage:Function;
            var onObjectReceivedHandler:Function;
            var onRoundTripResponseHandler:Function;
            var onExtensionResponseHandler:Function;
            var multiO:Object;
            var sfcMulti:SmartFoxClient;
            var sfcO:Object;
            var sfci:int;
            loginInfo = new Object();
            loadermanager = new LoaderManager();
            mixer = new SoundFX();
            sFilePath = "";
            params = {};
            uoPref = {};
            loginLoader = new URLLoader();
            sfcSocial = false;
            ldrMC = new LoaderMC(MovieClip(this));
            querystring = {};
            aaaloop = 0;
            totalPingTime = 0;
            pingCount = 0;
            arrRanks = [0];
            iRankMax = 10;
            arrHP = [];
            PCDPSMod = 0.85;
            curveExponent = 0.66;
            statsExponent = 1.33;
            stats = ["STR", "END", "DEX", "INT", "WIS", "LCK"];
            orderedStats = ["STR", "INT", "DEX", "WIS", "END", "LCK"];
            ratiosBySlot = {
                he:0.25,
                ar:0.25,
                ba:0.2,
                Weapon:0.33
            };
            I0pct = 0.8;
            I2pct = 1.25;
            classCatMap = {
                M1:{ratios:[0.27, 0.3, 0.22, 0.05, 0.1, 0.06]},
                M2:{ratios:[0.2, 0.22, 0.33, 0.05, 0.1, 0.1]},
                M3:{ratios:[0.24, 0.2, 0.2, 0.24, 0.07, 0.05]},
                M4:{ratios:[0.3, 0.18, 0.3, 0.02, 0.06, 0.14]},
                C1:{ratios:[0.06, 0.2, 0.11, 0.33, 0.15, 0.15]},
                C2:{ratios:[0.08, 0.27, 0.1, 0.3, 0.1, 0.15]},
                C3:{ratios:[0.18, 0.23, 0.24, 0.2, 0.05, 0.1]},
                S1:{ratios:[0.04, 0.15, 0.05, 0.03, 0.03, 0.7]}
            };
            serialCmdMode = false;
            serialCmd = {
                cmd:"",
                si:0,
                servers:[],
                callBack:serialCmdDone,
                active:false
            };
            sfcA = [{
                sIP:"74.53.22.41",
                sLogin:"aqwserial01",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.22.42",
                sLogin:"aqwserial02",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.22.43",
                sLogin:"aqwserial03",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.22.44",
                sLogin:"aqwserial04",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.22.45",
                sLogin:"aqwserial05",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.196",
                sLogin:"aqwserial06",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.197",
                sLogin:"aqwserial07",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.198",
                sLogin:"aqwserial08",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.199",
                sLogin:"aqwserial09",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.200",
                sLogin:"aqwserial10",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.201",
                sLogin:"aqwserial11",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.202",
                sLogin:"aqwserial12",
                sPass:"",
                sfc:null
            }, {
                sIP:"74.53.7.203",
                sLogin:"aqwserial13",
                sPass:"",
                sfc:null
            }];
            arrNose = new Array("nose01", "nose02", "nose03", "nose04", "nose05", "Nose1", "Nose3", "Nose4", "Nose5", "Nose6", "Nose7", "Nose10", "Nose11", "Nose12", "Nose14");
            arrEyes = new Array("EYES1a", "EYES1b", "EYES1c", "EYES1d", "EYES1e", "EYES2a", "EYES2b", "EYES2c", "EYES2e", "EYES3a", "EYES3b", "EYES3c", "EYES3e", "EYES4a", "EYES4b", "EYES4c", "EYES4e");
            arrMouth = new Array("mouth01", "mouth02", "mouth03", "mouth04", "mouth05", "mouth06", "mouth07", "Mouth6", "Mouth10", "Mouth11", "Mouth13", "Mouth14", "Mouth15", "Mouth17", "Mouth20", "Mouth21");
            GlowFilterBlue = new GlowFilter(13158, 1, 5, 5, 2, BitmapFilterQuality.LOW);
            GlowFilterGold = new GlowFilter(0xFFCC00, 1, 5, 5, 2, BitmapFilterQuality.LOW);
            haldroidApp = null;
            assetsDomain = new ApplicationDomain();
            assetsContext = new LoaderContext(false, assetsDomain);
            super();
            onConnectionHandler = function (e:SFSEvent){
                var sNick:String;
                var sPass:String;
                if (e.params.success){
                    sNick = ((((encodeSpecialChars(loginInfo.strUsername) + "~") + encodeSpecialChars(loginInfo.strPassword)) + "~") + objLogin.charID);
                    sPass = ((clientToken + "~") + loginInfo.strToken);
                    sfc.login(cLoginZone, sNick, sPass);
                    if (world != null){
                        world.uiLock = true;
                    };
                }
                else {
                    trace("failed");
                };
            };
            onConnectionLostHandler = function (e:SFSEvent){
                if (!serialCmdMode){
                    if (world != null){
                        world.exitCombat();
                        world.setTarget(null);
                        world.killTimers();
                    };
                    if (sfc.isConnected){
                        sfc.disconnect();
                    };
                    gotoAndStop("Login");
                };
            };
            onLoginHandler = function (e:SFSEvent){
            };
            onLogoutHandler = function (e:SFSEvent){
                if (!serialCmdMode){
                    if (world != null){
                        world.exitCombat();
                        world.setTarget(null);
                        world.killTimers();
                        world.clearLoaders(true);
                    };
                    if (sfc.isConnected){
                        sfc.disconnect();
                    };
                    gotoAndStop("Login");
                }
                else {
                    if (sfc.isConnected){
                        sfc.disconnect();
                    };
                    serialCmdNext();
                };
            };
            onMultiConnectionHandler = function (e:SFSEvent){
                if (e.params.success){
                    this.sfc.login(cLoginZone, ((clientToken + "~") + this.sLogin), loginInfo.strToken);
                }
                else {
                    trace("failed");
                };
            };
            onMultiConnectionLostHandler = function (e:SFSEvent){
                trace("");
                trace("** A MULTI CONNECTION WAS LOST");
                trace("");
            };
            onMultiLogoutHandler = function (e:SFSEvent){
                trace("");
                trace("** A MULTI CONNECTION WAS LOGGED OUT");
                trace("");
            };
            onMultiLoginHandler = function (e:SFSEvent){
            };
            onJoinRoomHandler = function (e:SFSEvent){
            };
            onUserEnterRoomHandler = function (e:SFSEvent){
            };
            onUserLeaveRoomHandler = function (e:SFSEvent){
            };
            onUserVariablesUpdateHandler = function (e:SFSEvent){
            };
            onRoomListUpdateHandler = function (e:SFSEvent){
            };
            onRoomVariablesUpdateHandler = function (e:SFSEvent){
            };
            onRoomAddedHandler = function (e:SFSEvent){
            };
            onPublicMessageHandler = function (e:SFSEvent){
            };
            onPrivateMessageHandler = function (e:SFSEvent){
            };
            onModeratorMessage = function (e:SFSEvent){
                var msg:*;
                var muo:*;
                msg = e.params.message;
                muo = e.params.sender;
            };
            onObjectReceivedHandler = function (e:SFSEvent){
                var uo:*;
                var rObj:*;
                var pMC:MovieClip;
                var modal:*;
                var modalO:*;
                trace("OBJ HANDLER");
                if (sfcSocial){
                    uo = e.params.sender;
                    rObj = e.params.obj;
                    switch (rObj.typ){
                        case "flourish":
                            if (world.CHARS.getChildByName(rObj.oName) != null){
                                MovieClip(world.CHARS.getChildByName(rObj.oName)).userName = uo.getName();
                                MovieClip(world.CHARS.getChildByName(rObj.oName)).gotoAndPlay(rObj.oFrame);
                            };
                            break;
                        case "danceRequest":
                            if (rObj.cell == world.strFrame){
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = "Would you care to dance?";
                                modalO.params = {};
                                modalO.params.emote1 = "/dance";
                                modalO.params.sender = uo;
                                modalO.callback = world.danceRequest;
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "danceDenied":
                            if (rObj.cell == world.strFrame){
                                chatF.submitMsg("/cry", "emotea", sfc.myUserName);
                            };
                            break;
                    };
                };
            };
            onRoundTripResponseHandler = function (evt:SFSEvent):void{
                var time:int;
                var avg:int;
                time = evt.params.elapsed;
                totalPingTime = (totalPingTime + (time / 2));
                pingCount++;
                avg = Math.round((totalPingTime / pingCount));
                trace((("Average lag: " + avg) + " milliseconds"));
            };
            onExtensionResponseHandler = function (e:SFSEvent){
                var resObj:* = undefined;
                var protocol:* = undefined;
                var i:int;
                var s:String;
                var j:int;
                var o:Object;
                var a:Array;
                var b:Array;
                var mc:MovieClip;
                var tuo:* = undefined;
                var typ:String;
                var nam:String;
                var val:* = undefined;
                var msg:String;
                var msgT:String;
                var snd:String;
                var rcp:String;
                var org:* = undefined;
                var cmd:String;
                var anims:Array;
                var animIndex:uint;
                var monAvt:Avatar;
                var avtAvt:Avatar;
                var Mon:Avatar;
                var avt:Avatar;
                var pMC:MovieClip;
                var unm:String;
                var uid:int;
                var rmId:int;
                var MonMapID:int;
                var MonID:int;
                var prop:String;
                var updated:Object;
                var uoName:* = undefined;
                var uoLeaf:Object;
                var monLeaf:Object;
                var cLeaf:Object;
                var tLeaf:Object;
                var actObj:Object;
                var cell:String;
                var st:int;
                var sta:String;
                var evt:String;
                var modal:MovieClip;
                var modalO:Object;
                var modalRR:* = undefined;
                var modalORR:Object;
                var silentMute:int;
                var filter:int;
                var cInf:String;
                var tInf:String;
                var cTyp:String;
                var cID:int;
                var tTyp:String;
                var tID:int;
                var ul:Array;
                var updateID:String;
                var updateA:Array;
                var updateN:String;
                var updateO:Object;
                var iSel:Object;
                var eSel:Object;
                var dat:Date;
                var now:Number;
                var newmon:Object;
                var cluster:* = undefined;
                var strMsg:* = undefined;
                var strLabel:* = undefined;
                var str:* = undefined;
                var dt:* = undefined;
                var motd:* = undefined;
                var MonMapIDs:* = undefined;
                var id:* = undefined;
                var clMon:* = undefined;
                var tAvt:Avatar;
                var cAvt:Avatar;
                var strF:String;
                var ulo:* = undefined;
                var myLeaf:* = undefined;
                var deltaGold:* = undefined;
                var deltaXP:* = undefined;
                var deltaCP:* = undefined;
                var dropitem:* = undefined;
                var ai:int;
                var slot:int;
                var supressMupltiples:* = undefined;
                var isYou:* = undefined;
                var sMsg:* = undefined;
                var bi:int;
                var branchA:Object;
                var mID:String;
                var xp:* = undefined;
                var xpB:* = undefined;
                var gold:* = undefined;
                var item:* = undefined;
                var dID:* = undefined;
                var dItem:* = undefined;
                var ItemID:* = undefined;
                var itemObj:* = undefined;
                var fi:* = undefined;
                var iobj:* = undefined;
                var itemArr:* = undefined;
                var dropindex:* = undefined;
                var dropID:* = undefined;
                var dropQty:int;
                var qi:String;
                var qr:String;
                var qj:String;
                var qk:String;
                var qat:Array;
                var fgWin:* = undefined;
                var m:* = undefined;
                var blanki:* = undefined;
                var actBar:* = undefined;
                var delIcon:* = undefined;
                var actIconClass:Class;
                var actIcon:* = undefined;
                var actIconMC:* = undefined;
                var blankMC:* = undefined;
                var stuS:String;
                var hasteCoeff:Number;
                var cd:* = undefined;
                var mcPath:* = undefined;
                var e:SFSEvent = e;
                resObj = e.params.dataObj;
                protocol = e.params.type;
                i = 0;
                s = "";
                j = 0;
                prop = "";
                updated = {};
                silentMute = 0;
                filter = 0;
                cInf = "";
                tInf = "";
                cTyp = "";
                cID = -1;
                tTyp = "";
                tID = -1;
                ul = [];
                dat = new Date();
                now = dat.getTime();
                if (protocol == "str"){
                    cmd = resObj[0];
                    trace(("responseObject STR: " + cmd));
                    switch (cmd){
                        default:
                            break;
                        case "tokenValidation":
                            break;
                        case "loginResponse":
                            if ((((resObj[2] == 1)) || ((resObj[2] == "true")))){
                                mcConnDetail.showConn("Loading Character Data...");
                                sfc.myUserId = Number(resObj[3]);
                                sfc.myUserName = String(resObj[4]);
                                ts_login_client = now;
                                dt = stringToDate(resObj[6]);
                                ts_login_server = dt.getTime();
                                trace(date_server);
                                motd = ("Message of The Day: " + String(resObj[5]));
                                sfc.sendXtMessage("zm", "firstJoin", [], "str", 1);
                                if (chatF.ignoreList.data.users.length > 0){
                                    sfc.sendXtMessage("zm", "cmd", ["ignoreList", chatF.ignoreList.data.users], "str", 1);
                                }
                                else {
                                    sfc.sendXtMessage("zm", "cmd", ["ignoreList", "$clearAll"], "str", 1);
                                };
                                mcConnDetail.showConn("Joining Lobby..");
                                chatF.pushMsg("moderator", motd, "SERVER", "", 0);
                                world.initObjInfo(resObj[7]);
                            }
                            else {
                                mcConnDetail.showError(resObj[5]);
                            };
                            break;
                        case "loginIterator":
                            if ((((resObj[2] == 1)) || ((resObj[2] == "true")))){
                                sfc.myUserId = Number(resObj[3]);
                                sfc.myUserName = String(resObj[4]);
                                chatF.submitMsg(serialCmd.cmd, "serialCmd", sfc.myUserName);
                                sfc.logout();
                            }
                            else {
                                mcConnDetail.showError("Login Failed!");
                            };
                            break;
                        case "loginMulti":
                            if (!(((resObj[2] == 1)) || ((resObj[2] == "true")))){
                                mcConnDetail.showError("Login Failed!");
                            };
                            break;
                        case "logoutWarning":
                            userPreference.data.logoutWarning = String(resObj[2]);
                            userPreference.data.logoutWarningDur = Number(resObj[3]);
                            userPreference.data.logoutWarningTS = now;
                            userPreference.flush();
                            break;
                        case "server":
                            typ = "server";
                            msg = resObj[2];
                            msg = chatF.cleanChars(msg);
                            msg = chatF.cleanStr(msg);
                            chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            break;
                        case "serverf":
                            msg = String(resObj[2]);
                            typ = "server";
                            str = chatF.cleanStr(msg);
                            unm = String(resObj[3]);
                            uid = int(resObj[4]);
                            rmId = int(resObj[5]);
                            msg = chatF.cleanChars(msg);
                            msgT = stripWhite(msg.toLowerCase());
                            if (chatF.strContains(msgT, chatF.illegalStrings)){
                                silentMute = 1;
                            };
                            msgT = stripWhiteStrict(msg.toLowerCase());
                            if (chatF.strContains(msgT, ["email"])){
                                silentMute = 1;
                            };
                            if (!silentMute){
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "moderator":
                            if (sfcSocial){
                                typ = "moderator";
                                msg = resObj[2];
                                msg = chatF.cleanChars(msg);
                                msg = chatF.cleanStr(msg);
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "warning":
                            typ = "warning";
                            msg = resObj[2];
                            msg = chatF.cleanChars(msg);
                            msg = chatF.cleanStr(msg);
                            chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            break;
                        case "respawnMon":
                            if (sfcSocial){
                                MonMapIDs = resObj[2].split(",");
                                for (id in MonMapIDs) {
                                    Mon = world.getMonster(MonMapIDs[id]);
                                    monLeaf = world.monTree[MonMapIDs[id]];
                                    if (((((!((monLeaf == null))) && (!((Mon.objData == null))))) && ((Mon.objData.strFrame == world.strFrame)))){
                                        monLeaf.targets = {};
                                        Mon.pMC.respawn();
                                        Mon.pMC.x = Mon.pMC.ox;
                                        Mon.pMC.y = Mon.pMC.oy;
                                        if ((((Mon.objData.bRed == 1)) && ((world.myAvatar.dataLeaf.intState > 0)))){
                                            world.aggroMon(MonMapIDs[id]);
                                        };
                                    };
                                };
                            };
                            break;
                        case "resTimed":
                            if ((((((resObj.length > 2)) && (!((String(resObj[2]) == null))))) && (!((String(resObj[3]) == null))))){
                                world.moveToCell(String(resObj[2]), String(resObj[3]));
                            }
                            else {
                                world.moveToCell(world.spawnPoint.strFrame, world.spawnPoint.strPad);
                            };
                            world.map.transform.colorTransform = world.defaultCT;
                            world.CHARS.transform.colorTransform = world.defaultCT;
                            break;
                        case "exitArea":
                            uid = int(resObj[2]);
                            unm = String(resObj[3]);
                            world.manageAreaUser(String(resObj[3]), "-");
                            avt = world.avatars[uid];
                            if (avt != null){
                                if (avt == world.myAvatar.target){
                                    world.setTarget(null);
                                };
                                if (((!((avt.objData == null))) && (world.isPartyMember(avt.objData.strUsername)))){
                                    world.updatePartyFrame({
                                        unm:avt.objData.strUsername,
                                        range:false
                                    });
                                };
                                world.destroyAvatar(uid);
                                delete world.uoTree[unm];
                            };
                            break;
                        case "uotls":
                            o = {};
                            a = resObj[3].split(",");
                            i = 0;
                            while (i < a.length) {
                                o[a[i].split(":")[0]] = a[i].split(":")[1];
                                i = (i + 1);
                            };
                            userTreeWrite(String(resObj[2]), o);
                            break;
                        case "mtls":
                            o = {};
                            a = resObj[3].split(",");
                            i = 0;
                            while (i < a.length) {
                                o[a[i].split(":")[0]] = a[i].split(":")[1];
                                i = (i + 1);
                            };
                            monsterTreeWrite(int(resObj[2]), o);
                            break;
                        case "spcs":
                            MonMapID = int(resObj[2]);
                            MonID = int(resObj[3]);
                            monLeaf = world.monTree[MonMapID];
                            newmon = {};
                            i = 0;
                            while (i < world.mondef.length) {
                                if (world.mondef[i].MonID == MonID){
                                    newmon = world.mondef[i];
                                    i = world.mondef.length;
                                };
                                i = (i + 1);
                            };
                            monLeaf.intHP = 0;
                            monLeaf.intMP = 0;
                            monLeaf.intHPMax = newmon.intHPMax;
                            monLeaf.intMPMax = newmon.intMPMax;
                            monLeaf.intState = 0;
                            monLeaf.iLvl = newmon.iLvl;
                            monLeaf.MonID = MonID;
                            cluster = world.getMonsterCluster(MonMapID);
                            i = 0;
                            while (i < cluster.length) {
                                clMon = cluster[i];
                                if (monLeaf.MonID == clMon.objData.MonID){
                                    if (monLeaf.strFrame == world.strFrame){
                                        world.CHARS.addChild(clMon.pMC);
                                    };
                                    clMon.dataLeaf = monLeaf;
                                }
                                else {
                                    if (monLeaf.strFrame == world.strFrame){
                                        world.TRASH.addChild(clMon.pMC);
                                    };
                                    clMon.dataLeaf = null;
                                };
                                i = (i + 1);
                            };
                            break;
                        case "cc":
                            strMsg = chatF.getCCText(resObj[2]);
                            unm = String(resObj[3]);
                            if (chatF.ignoreList.data.users != undefined){
                                if (chatF.ignoreList.data.users.indexOf(unm) > -1){
                                    filter = 1;
                                };
                            };
                            if (filter == 0){
                                chatF.pushMsg("zone", strMsg, unm, "", 0);
                            };
                            break;
                        case "emotea":
                            strLabel = String(resObj[2]);
                            uid = int(resObj[3]);
                            pMC = world.getMCByUserID(uid);
                            if (pMC != null){
                                pMC.mcChar.gotoAndPlay(strToProperCase(strLabel));
                            };
                            break;
                        case "em":
                            unm = String(resObj[2]);
                            msg = chatF.cleanStr(String(resObj[3]));
                            while (msg.indexOf("  ") > -1) {
                                msg = msg.split("  ").join(" ");
                            };
                            msg = chatF.cleanChars(msg);
                            msgT = stripWhiteStrict(msg.toLowerCase());
                            if (chatF.strContains(msgT, chatF.illegalStrings)){
                                silentMute = 1;
                            };
                            if (!silentMute){
                                chatF.pushMsg("event", msg, unm, "", 0);
                            };
                            break;
                        case "chatm":
                            str = String(resObj[2]);
                            str = chatF.cleanStr(str);
                            unm = String(resObj[3]);
                            uid = int(resObj[4]);
                            rmId = int(resObj[5]);
                            typ = str.substr(0, str.indexOf("~"));
                            msg = str.substr((str.indexOf("~") + 1));
                            msg = chatF.cleanChars(msg);
                            if (chatF.ignoreList.data.users != undefined){
                                if (chatF.ignoreList.data.users.indexOf(unm.toLowerCase()) > -1){
                                    filter = 1;
                                };
                            };
                            if (!filter){
                                chatF.pushMsg(typ, msg, unm, uid, 0);
                            };
                            break;
                        case "whisper":
                            typ = "whisper";
                            msg = resObj[2];
                            snd = String(resObj[3]);
                            rcp = String(resObj[4]);
                            org = resObj[5];
                            msg = chatF.cleanStr(msg);
                            msg = chatF.cleanChars(msg);
                            silentMute = 0;
                            if (msg.indexOf(":=sm") > -1){
                                msg = msg.substr(0, msg.indexOf(":=sm"));
                                if (unm != sfc.myUserName){
                                    silentMute = 1;
                                };
                            };
                            if (chatF.ignoreList.data.users != undefined){
                                if (chatF.ignoreList.data.users.indexOf(snd.toLowerCase()) > -1){
                                    filter = 1;
                                };
                            };
                            if (((!(filter)) && (((!(silentMute)) || (((silentMute) && ((snd == rcp)))))))){
                                if (snd.toLowerCase() != sfc.myUserName.toLowerCase()){
                                    chatF.pmSourceA = [snd];
                                    if (chatF.pmSourceA.length > 20){
                                        chatF.pmSourceA.splice(0, (chatF.pmSourceA.length - 20));
                                    };
                                };
                                if (org == 1){
                                    chatF.pushMsg(typ, msg, snd, rcp, 0);
                                    chatF.pushMsg(typ, msg, snd, rcp, 1);
                                }
                                else {
                                    chatF.pushMsg(typ, msg, snd, rcp, org);
                                };
                            };
                            break;
                        case "mute":
                            chatF.muteMe(int(resObj[2]));
                            break;
                        case "unmute":
                            chatF.unmuteMe();
                            break;
                        case "mvna":
                            if ((((world.uoTree[sfc.myUserName].freeze == null)) || (!(world.uoTree[sfc.myUserName].freeze)))){
                                world.uoTree[sfc.myUserName].freeze = true;
                            };
                            break;
                        case "mvnb":
                            if (world.uoTree[sfc.myUserName].freeze != null){
                                delete world.uoTree[sfc.myUserName].freeze;
                            };
                            break;
                        case "gtc":
                            if (((!((String(resObj[2]) == null))) && (!((String(resObj[3]) == null))))){
                                world.moveToCell(String(resObj[2]), String(resObj[3]));
                            };
                            break;
                        case "mtcid":
                            if (resObj.length > 2){
                                world.moveToCellByIDb(Number(resObj[2]));
                            };
                            break;
                        case "hi":
                            trace("");
                            trace("****> SFS Ping response, unlocking all actions, canceling logout timer");
                            trace("");
                            world.connMsgOut = false;
                            world.connTestTimer.reset();
                            world.unlockActions();
                    };
                };
                if (protocol == "json"){
                    cmd = resObj.cmd;
                    trace(("responseObject JSON: " + cmd));
                    strF = "";
                    switch (cmd){
                        default:
                            trace("*>> Unhandled CMD <<*");
                            break;
                        case "who":
                            ulo = {};
                            ulo.typ = "userListA";
                            ulo.ul = resObj.users;
                            ui.mcOFrame.fOpenWith(ulo);
                            break;
                        case "al":
                            areaListShow(resObj);
                            break;
                        case "getinfo":
                            for (prop in resObj) {
                                if (prop != "cmd"){
                                    trace(((("USER INFO >  " + prop) + " : ") + resObj[prop]));
                                };
                            };
                            break;
                        case "mapreload":
                            if (world.strMapName == resObj.sName){
                                world.setMapEvents(resObj.event);
                                world.strMapFileName = resObj.sFileName;
                                world.reloadCurrentMap();
                            };
                            break;
                        case "moveToArea":
                            world.mapLoadInProgress = true;
                            world.strAreaName = resObj.areaName;
                            world.initObjExtra(resObj.sExtra);
                            world.areaUsers = [];
                            myLeaf = null;
                            world.modID = -1;
                            if (world.uoTreeLeaf(sfc.myUserName) != null){
                                myLeaf = copyObj(world.uoTreeLeaf(sfc.myUserName));
                            };
                            world.uoTree = {};
                            if (myLeaf != null){
                                world.uoTree[sfc.myUserName] = myLeaf;
                            };
                            if (resObj.pvpTeam != null){
                                myLeaf.pvpTeam = resObj.pvpTeam;
                                world.bPvP = true;
                                ui.mcPortrait.pvpIcon.visible = true;
                                ui.mcPortrait.partyLead.y = 18;
                                world.setPVPFactionData(resObj.PVPFactions);
                                updatePVPScore(resObj.pvpScore);
                                showPVPScore();
                            }
                            else {
                                ui.mcPortrait.pvpIcon.visible = false;
                                ui.mcPortrait.partyLead.y = 0;
                                delete myLeaf.pvpTeam;
                                world.bPvP = false;
                                hidePVPScore();
                                world.setPVPFactionData(null);
                            };
                            if (resObj.pvpScore != null){
                                updatePVPScore(resObj.pvpScore);
                            };
                            bi = 0;
                            while (bi < resObj.uoBranch.length) {
                                branchA = resObj.uoBranch[bi];
                                unm = branchA.uoName;
                                uoLeaf = {};
                                for (s in branchA) {
                                    nam = s;
                                    val = branchA[s];
                                    if ((((((((((nam.toLowerCase().indexOf("int") > -1)) || ((nam.toLowerCase() == "tx")))) || ((nam.toLowerCase() == "ty")))) || ((nam.toLowerCase() == "sp")))) || ((nam.toLowerCase() == "pvpTeam")))){
                                        val = int(val);
                                    };
                                    uoLeaf[nam] = val;
                                };
                                if (unm != sfc.myUserName){
                                    uoLeaf.auras = [];
                                };
                                uoLeaf.targets = {};
                                world.uoTreeLeafSet(unm, uoLeaf);
                                world.manageAreaUser(unm, "+");
                                bi = (bi + 1);
                            };
                            world.monTree = {};
                            world.monsters = [];
                            bi = 0;
                            while (bi < resObj.monBranch.length) {
                                branchA = resObj.monBranch[bi];
                                monLeaf = {};
                                mID = "1";
                                for (s in branchA) {
                                    nam = s;
                                    val = branchA[s];
                                    if (nam.toLowerCase().indexOf("monmapid") > -1){
                                        mID = val;
                                    };
                                    if ((((((nam.toLowerCase().indexOf("int") > -1)) || ((nam.toLowerCase().indexOf("monid") > -1)))) || ((nam.toLowerCase().indexOf("monmapid") > -1)))){
                                        val = int(val);
                                    };
                                    monLeaf[nam] = val;
                                };
                                monLeaf.auras = [];
                                monLeaf.targets = {};
                                monLeaf.strBehave = "walk";
                                world.monTree[mID] = monLeaf;
                                bi = (bi + 1);
                            };
                            if (("event" in resObj)){
                                world.setMapEvents(resObj.event);
                            }
                            else {
                                world.setMapEvents(null);
                            };
                            if (("cellMap" in resObj)){
                                world.setCellMap(resObj.cellMap);
                            }
                            else {
                                world.setCellMap(null);
                            };
                            if (world.strFrame != ""){
                                world.exitCell();
                            };
                            world.killLoaders();
                            world.clearMonstersAndProps();
                            world.clearAllAvatars();
                            world.avatars[sfc.myUserId] = world.myAvatar;
                            world.strMapName = resObj.strMapName;
                            world.strMapFileName = resObj.strMapFileName;
                            world.intType = resObj.intType;
                            world.intKillCount = resObj.intKillCount;
                            world.objLock = (((resObj.objLock)!=null) ? resObj.objLock : null);
                            world.mondef = resObj.mondef;
                            world.monmap = resObj.monmap;
                            world.curRoom = Number(resObj.areaId);
                            world.actionResultsMon = {};
                            world.actionResults = {};
                            world.mapBoundsMC = null;
                            chatF.chn.zone.rid = world.curRoom;
                            if (("houseData" in resObj)){
                                world.initHouseData(resObj.houseData);
                            }
                            else {
                                world.initHouseData(null);
                            };
                            world.updatePartyFrame();
                            world.clearLoaders();
                            s = resObj.strMapFileName.toLowerCase();
                            world.loadMap(s);
                            break;
                        case "initUserData":
                            try {
                                avt = world.getAvatarByUserID(resObj.uid);
                                uoLeaf = avt.dataLeaf;
                                if (((!((avt == null))) && (!((uoLeaf == null))))){
                                    unm = uoLeaf.uoName;
                                    resObj.data.intState = uoLeaf.intState;
                                    resObj.data.intHPcur = uoLeaf.intHP;
                                    resObj.data.intMPcur = uoLeaf.intMP;
                                    avt.initAvatar({data:resObj.data});
                                    if (avt.isMyAvatar){
                                        avt.objData.strHomeTown = avt.objData.strMapName;
                                        if (avt.objData.iUpg > 0){
                                            if (avt.objData.iUpgDays < 0){
                                                chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                                            }
                                            else {
                                                if (avt.objData.iUpgDays < 7){
                                                    chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                                };
                                            };
                                        };
                                        if (((!((avt.objData.dRefReset == null))) && ((((avt.objData.iRefGold > 0)) || ((avt.objData.iRefExp > 0)))))){
                                            modalRR = new ModalMC();
                                            modalORR = {};
                                            modalORR.strBody = (((("You earned <font color='#FFCC00'><b>" + Math.ceil(avt.objData.iRefGold)) + " Gold</b></font> and <font color='#990099'><b>") + Math.ceil(avt.objData.iRefExp)) + " XP</b></font><br/> from Referred Friends.");
                                            modalORR.callback = world.sendRewardReferralRequest;
                                            modalORR.btns = "mono";
                                            ui.ModalStack.addChild(modalRR);
                                            modalRR.init(modalORR);
                                        };
                                        updateXPBar();
                                        ui.mcPortrait.strGold.text = avt.objData.intGold;
                                        if (ui.mcPopup.currentLabel == "Inventory"){
                                            MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({eventType:"refreshCoins"});
                                        };
                                        world.getInventory(resObj.uid);
                                        world.initAchievements();
                                        readIA1Preferences();
                                    };
                                };
                            }
                            catch(e:Error) {
                                trace("initUserData > ");
                                trace(e);
                            };
                            break;
                        case "initUserDatas":
                            a = resObj.a;
                            i = 0;
                            while (i < a.length) {
                                o = a[i];
                                try {
                                    avt = world.getAvatarByUserID(o.uid);
                                    uoLeaf = avt.dataLeaf;
                                    if (((!((avt == null))) && (!((uoLeaf == null))))){
                                        unm = uoLeaf.uoName;
                                        o.data.intState = uoLeaf.intState;
                                        o.data.intHPcur = uoLeaf.intHP;
                                        o.data.intMPcur = uoLeaf.intMP;
                                        avt.initAvatar({data:o.data});
                                        if (avt.isMyAvatar){
                                            avt.objData.strHomeTown = avt.objData.strMapName;
                                            if (avt.objData.iUpg > 0){
                                                if (avt.objData.iUpgDays < 0){
                                                    chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                                                }
                                                else {
                                                    if (avt.objData.iUpgDays < 7){
                                                        chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                                    };
                                                };
                                            };
                                            updateXPBar();
                                            setHaldroidState();
                                            if (((!((world.map == null))) && (("eventTrigger" in MovieClip(world.map))))){
                                                world.map.eventTrigger({cmd:"userLoaded"});
                                            };
                                        };
                                    };
                                }
                                catch(e:Error) {
                                    trace("initUserDatas > ");
                                    trace(e);
                                };
                                i = (i + 1);
                            };
                            break;
                        case "changeColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!((avt == null))) && (avt.bitData))){
                                if (!avt.isMyAvatar){
                                    if (resObj.HairID != null){
                                        avt.objData.HairID = resObj.HairID;
                                        avt.objData.strHairName = resObj.strHairName;
                                        avt.objData.strHairFilename = resObj.strHairFilename;
                                        if (((!((avt.pMC == null))) && (!((avt.pMC.stage == null))))){
                                            avt.pMC.loadHair();
                                        };
                                    };
                                    avt.objData.intColorSkin = resObj.intColorSkin;
                                    avt.objData.intColorHair = resObj.intColorHair;
                                    avt.objData.intColorEye = resObj.intColorEye;
                                    if (((!((avt.pMC == null))) && (!((avt.pMC.stage == null))))){
                                        avt.pMC.updateColor();
                                    };
                                };
                            }
                            else {
                                trace("can't set data!");
                            };
                            break;
                        case "changeArmorColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!((avt == null))) && (avt.bitData))){
                                if (!avt.isMyAvatar){
                                    avt.objData.intColorBase = resObj.intColorBase;
                                    avt.objData.intColorTrim = resObj.intColorTrim;
                                    avt.objData.intColorAccessory = resObj.intColorAccessory;
                                    if (((!((avt.pMC == null))) && (!((avt.pMC.stage == null))))){
                                        avt.pMC.updateColor();
                                    };
                                };
                            }
                            else {
                                trace("can't set data!");
                            };
                            break;
                        case "addGoldExp":
                            deltaGold = (resObj.intGold - world.myAvatar.objData.intGold);
                            deltaXP = (resObj.intExp - world.myAvatar.objData.intExp);
                            deltaCP = (resObj.iCP - world.myAvatar.objData.iCP);
                            if (deltaXP > 0){
                                world.myAvatar.objData.intExp = resObj.intExp;
                                updateXPBar();
                                xp = new xpDisplay();
                                xp.t.ti.text = (deltaXP + "xp");
                                xpB = null;
                                if (("bonusExp" in resObj)){
                                    xpB = new xpDisplayBonus();
                                    xpB.t.ti.text = String((("+ " + resObj.bonusExp) + "xp!"));
                                    xp.t.ti.text = ((deltaXP - resObj.bonusExp) + "xp");
                                };
                                if (((!((resObj.typ == null))) && ((resObj.typ == "m")))){
                                    Mon = world.getMonster(resObj.id);
                                    xp.x = Mon.pMC.mcChar.x;
                                    xp.y = (Mon.pMC.mcChar.y - 40);
                                    Mon.pMC.addChild(xp);
                                    if (xpB != null){
                                        xpB.x = xp.x;
                                        xpB.y = xp.y;
                                        Mon.pMC.addChild(xpB);
                                    };
                                }
                                else {
                                    xp.x = world.myAvatar.pMC.mcChar.x;
                                    xp.y = (world.myAvatar.pMC.pname.y + 10);
                                    world.myAvatar.pMC.addChild(xp);
                                    if (xpB != null){
                                        xpB.x = xp.x;
                                        xpB.y = xp.y;
                                        world.myAvatar.pMC.addChild(xpB);
                                    };
                                };
                            };
                            if (deltaGold > 0){
                                mixer.playSound("Coins");
                                world.myAvatar.objData.intGold = resObj.intGold;
                                ui.mcPortrait.strGold.text = world.myAvatar.objData.intGold;
                                if (ui.mcPopup.currentLabel == "Inventory"){
                                    ui.mcPopup.mcInventory.updateGoldCoin();
                                };
                                gold = new goldDisplay();
                                gold.t.ti.text = deltaGold;
                                gold.tMask.ti.text = deltaGold;
                                if (((!((resObj.typ == null))) && ((resObj.typ == "m")))){
                                    Mon = world.getMonster(resObj.id);
                                    gold.x = Mon.pMC.mcChar.x;
                                    gold.y = (Mon.pMC.mcChar.y - 20);
                                    Mon.pMC.addChild(gold);
                                }
                                else {
                                    gold.x = world.myAvatar.pMC.mcChar.x;
                                    gold.y = (world.myAvatar.pMC.pname.y - 30);
                                    world.myAvatar.pMC.addChild(gold);
                                };
                            };
                            if (resObj.FactionID != null){
                                world.addRep(resObj.FactionID, resObj.iRep);
                            };
                            if (resObj.OppFacID != null){
                                world.addRep(resObj.OppFacID, -(resObj.iOppRep));
                            };
                            break;
                        case "levelUp":
                            trace(("levelUp! : " + resObj.intLevel));
                            world.myAvatar.objData.intLevel = resObj.intLevel;
                            world.myAvatar.objData.intExpToLevel = resObj.intExpToLevel;
                            world.myAvatar.objData.intExp = 0;
                            updateXPBar();
                            showPortraitBox(world.myAvatar, ui.mcPortrait);
                            world.myAvatar.levelUp();
                            if (("updatePStats" in world.map)){
                                world.map.updatePStats();
                            };
                            showSkillUp();
                            break;
                        case "loadInventoryBig":
                            world.initInventory(resObj.items);
                            world.houseitems = (((resObj.hitems)==null) ? [] : resObj.hitems);
                            world.initFactions(resObj.factions);
                            world.initFriendsList(resObj.friends);
                            world.uiLock = false;
                            break;
                        case "house":
                            MsgBox.notify(resObj.msg);
                            break;
                        case "buyBagSlots":
                            world.dispatchEvent(new Event("buyBagSlots"));
                            if (resObj.bitSuccess == 1){
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iBagSlots = (world.myAvatar.objData.iBagSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * 200));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iBagSlots) + " inventory spaces!"));
                                if (ui.mcPopup.currentLabel == "Inventory"){
                                    ui.mcPopup.mcInventory.updateGoldCoin();
                                };
                                if (ui.mcPopup.currentLabel == "Shop"){
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({eventType:"refreshSlots"});
                                };
                            };
                            break;
                        case "buyBankSlots":
                            world.dispatchEvent(new Event("buyBankSlots"));
                            if (resObj.bitSuccess == 1){
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iBankSlots = (world.myAvatar.objData.iBankSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * 200));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iBankSlots) + " bank spaces!"));
                                if (ui.mcPopup.currentLabel == "Inventory"){
                                    ui.mcPopup.mcInventory.updateGoldCoin();
                                };
                                if (ui.mcPopup.currentLabel == "Shop"){
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({eventType:"refreshSlots"});
                                };
                            };
                            break;
                        case "buyHouseSlots":
                            world.dispatchEvent(new Event("buyHouseSlots"));
                            if (resObj.bitSuccess == 1){
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iHouseSlots = (world.myAvatar.objData.iHouseSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * 200));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iHouseSlots) + " house inventory spaces!"));
                                if (ui.mcPopup.currentLabel == "Inventory"){
                                    ui.mcPopup.mcInventory.updateGoldCoin();
                                };
                                if (ui.mcPopup.currentLabel == "Shop"){
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({eventType:"refreshSlots"});
                                };
                            };
                            break;
                        case "loadBank":
                            world.initBank(resObj.items);
                            ui.mcPopup.fOpen("Bank");
                            break;
                        case "bankFromInv":
                            world.bankFromInv(resObj.ItemID);
                            ui.mcPopup.mcBank.refreshBank();
                            ui.mcPopup.mcBank.refreshInventory();
                            break;
                        case "bankToInv":
                            world.bankToInv(resObj.ItemID);
                            ui.mcPopup.mcBank.refreshBank();
                            ui.mcPopup.mcBank.refreshInventory();
                            break;
                        case "loadShop":
                            world.shopinfo = resObj.shopinfo;
                            if (resObj.shopinfo.bHouse == 1){
                                trace("House Shop");
                                ui.mcPopup.fOpen("HouseShop");
                            }
                            else {
                                if (isMergeShop(resObj.shopinfo)){
                                    ui.mcPopup.fOpen("MergeShop");
                                }
                                else {
                                    ui.mcPopup.fOpen("Shop");
                                };
                            };
                            break;
                        case "loadEnhShop":
                            world.enhShopID = resObj.shopinfo.ShopID;
                            world.enhShopItems = resObj.shopinfo.items;
                            ui.mcPopup.fOpen("EnhShop");
                            break;
                        case "enhanceItemShop":
                            if (resObj.iCost != null){
                                world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold - Number(resObj.iCost));
                                ui.mcPortrait.strGold.text = world.myAvatar.objData.intGold;
                                if (ui.mcPopup.currentLabel == "Inventory"){
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({eventType:"refreshCoins"});
                                };
                                if (ui.mcPopup.currentLabel == "Shop"){
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({eventType:"refreshCoins"});
                                };
                            };
                            iSel = null;
                            eSel = null;
                            for each (o in world.items) {
                                if (o.ItemID == resObj.ItemID){
                                    iSel = o;
                                };
                            };
                            iSel.iEnh = resObj.EnhID;
                            iSel.EnhID = resObj.EnhID;
                            iSel.EnhPatternID = resObj.EnhPID;
                            iSel.EnhLvl = resObj.EnhLvl;
                            iSel.EnhDPS = resObj.EnhDPS;
                            iSel.EnhRng = resObj.EnhRng;
                            iSel.EnhRty = resObj.EnhRty;
                            mixer.playSound("Good");
                            if (ui.mcPopup.currentLabel == "Inventory"){
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                    eventType:"refreshItems",
                                    sInstruction:"previewEquipOnly"
                                });
                            };
                            if (ui.mcPopup.currentLabel == "Shop"){
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                    eventType:"refreshItems",
                                    sInstruction:"closeWindows"
                                });
                            };
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (((((("You have upgraded <b>" + iSel.sName) + "</b> with <b>") + resObj.EnhName) + "</b>, level <b>") + resObj.EnhLvl) + "</b>!");
                            modalO.params = {};
                            modalO.glow = "white,medium";
                            modalO.btns = "mono";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "enhanceItemLocal":
                            iSel = null;
                            eSel = null;
                            for each (o in world.items) {
                                if (o.ItemID == resObj.ItemID){
                                    iSel = o;
                                };
                            };
                            iSel.iEnh = resObj.EnhID;
                            iSel.EnhID = resObj.EnhID;
                            iSel.EnhPatternID = resObj.EnhPID;
                            iSel.EnhLvl = resObj.EnhLvl;
                            iSel.EnhDPS = resObj.EnhDPS;
                            iSel.EnhRng = resObj.EnhRng;
                            iSel.EnhRty = resObj.EnhRty;
                            mixer.playSound("Good");
                            if (ui.mcPopup.currentLabel == "Inventory"){
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                    eventType:"refreshItems",
                                    sInstruction:"previewEquipOnly"
                                });
                            };
                            if (ui.mcPopup.currentLabel == "Shop"){
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                    eventType:"refreshItems",
                                    sInstruction:"closeWindows"
                                });
                            };
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (((((("You have upgraded " + iSel.sName) + " with ") + resObj.EnhName) + ", level ") + resObj.EnhLvl) + "!");
                            modalO.params = {};
                            modalO.glow = "white,medium";
                            modalO.btns = "mono";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "loadHairShop":
                            world.hairshopinfo = resObj;
                            openCharacterCustomize();
                            break;
                        case "buyItem":
                            if (resObj.CharItemID == -1){
                                MsgBox.notify(resObj.strMessage);
                            }
                            else {
                                item = copyObj(world.shopBuyItem);
                                item.CharItemID = resObj.CharItemID;
                                if (item.bCoins == 0){
                                    world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold - Number(item.iCost));
                                    ui.mcPortrait.strGold.text = world.myAvatar.objData.intGold;
                                    if (ui.mcPopup.currentLabel == "Inventory"){
                                        ui.mcPopup.mcInventory.updateGoldCoin();
                                    };
                                }
                                else {
                                    item.iHrs = 0;
                                    world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - Number(item.iCost));
                                };
                                showItemDrop(item, false);
                                if (world.invTree[item.ItemID] == null){
                                    world.invTree[item.ItemID] = copyObj(resObj);
                                    world.invTree[item.ItemID].iQty = 0;
                                };
                                world.addItem(item);
                                if (item.bHouse == 1){
                                    ui.mcPopup.mcHouseShop.refreshList();
                                    ui.mcPopup.mcHouseShop.updateGoldCoin();
                                }
                                else {
                                    if (ui.mcPopup.currentLabel == "Shop"){
                                        ui.mcPopup.mcShop.refreshList();
                                        ui.mcPopup.mcShop.updateGoldCoin();
                                    };
                                };
                                world.updateQuestProgress("item", item);
                            };
                            break;
                        case "sellItem":
                            world.removeItem(resObj.CharItemID);
                            if (resObj.bCoins == 1){
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins + resObj.intAmount);
                            }
                            else {
                                if (world.myAvatar.objData.intGold < 2000000){
                                    world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold + resObj.intAmount);
                                    ui.mcPortrait.strGold.text = world.myAvatar.objData.intGold;
                                };
                            };
                            if (ui.mcPopup.currentLabel == "Shop"){
                                ui.mcPopup.mcShop.refreshList();
                                ui.mcPopup.mcShop.updateGoldCoin();
                            }
                            else {
                                if (ui.mcPopup.currentLabel == "HouseShop"){
                                    ui.mcPopup.mcHouseShop.refreshList();
                                    ui.mcPopup.mcHouseShop.updateGoldCoin();
                                };
                            };
                            world.checkAllQuestStatus();
                            break;
                        case "removeItem":
                            world.removeItem(resObj.CharItemID);
                            if (ui.mcPopup.currentLabel == "Inventory"){
                                ui.mcPopup.mcInventory.refreshList();
                                ui.mcPopup.mcInventory.updateGoldCoin();
                            };
                            world.checkAllQuestStatus();
                            break;
                        case "equipItem":
                            avt = world.getAvatarByUserID(resObj.uid);
                            tLeaf = world.getUoLeafById(resObj.uid);
                            if (avt != null){
                                if (((!((avt.pMC == null))) && (!((avt.objData == null))))){
                                    avt.objData.eqp[resObj.strES] = {};
                                    avt.objData.eqp[resObj.strES].sFile = (((resObj.sFile)=="undefined") ? "" : resObj.sFile);
                                    avt.objData.eqp[resObj.strES].sLink = resObj.sLink;
                                    if (("sType" in resObj)){
                                        avt.objData.eqp[resObj.strES].sType = resObj.sType;
                                    };
                                    if (("ItemID" in resObj)){
                                        avt.objData.eqp[resObj.strES].ItemID = resObj.ItemID;
                                    };
                                    avt.pMC.loadMovieAtES(resObj.strES, resObj.sFile, resObj.sLink);
                                };
                                if (avt.isMyAvatar){
                                    world.equipItem(resObj.ItemID);
                                    if (ui.mcPopup.mcInventory != null){
                                        ui.mcPopup.mcInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcInventory.refreshDetail();
                                    };
                                    if (ui.mcPopup.mcTempInventory != null){
                                        ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcTempInventory.refreshDetail();
                                    };
                                };
                            };
                            break;
                        case "unequipItem":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (avt != null){
                                if (avt.pMC != null){
                                    delete avt.objData.eqp[resObj.strES];
                                    avt.pMC.unloadMovieAtES(resObj.strES);
                                };
                                if (avt.isMyAvatar){
                                    world.unequipItem(resObj.ItemID);
                                    if (ui.mcPopup.mcInventory != null){
                                        ui.mcPopup.mcInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcInventory.refreshDetail();
                                    };
                                    if (ui.mcPopup.mcTempInventory != null){
                                        ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcTempInventory.refreshDetail();
                                    };
                                };
                            };
                            break;
                        case "dropItem":
                            for (dID in resObj.items) {
                                dItem = null;
                                if (world.invTree[dID] == null){
                                    world.invTree[dID] = copyObj(resObj.items[dID]);
                                    world.invTree[dID].iQty = 0;
                                    dItem = resObj.items[dID];
                                }
                                else {
                                    dItem = copyObj(world.invTree[dID]);
                                    dItem.iQty = int(resObj.items[dID].iQty);
                                };
                                showItemDrop(dItem, true);
                            };
                            break;
                        case "getDrop":
                            dropitem = copyObj(world.invTree[resObj.ItemID]);
                            dropitem.CharItemID = resObj.CharItemID;
                            dropitem.bBank = resObj.bBank;
                            dropitem.iQty = int(resObj.iQty);
                            dropitem.iEnh = 0;
                            world.addItem(dropitem);
                            world.updateQuestProgress("item", dropitem);
                            break;
                        case "addItems":
                            for (ItemID in resObj.items) {
                                if (world.invTree[ItemID] == null){
                                    itemObj = copyObj(resObj.items[ItemID]);
                                }
                                else {
                                    itemObj = copyObj(world.invTree[ItemID]);
                                    itemObj.iQty = int(resObj.items[ItemID].iQty);
                                };
                                showItemDrop(itemObj, true);
                                world.addTempItem(itemObj);
                                world.updateQuestProgress("item", itemObj);
                            };
                            break;
                        case "forceAddItem":
                            for (fi in resObj.items) {
                                iobj = copyObj(resObj.items[fi]);
                                world.addItem(iobj);
                            };
                            break;
                        case "enhp":
                            for each (o in resObj.o) {
                                world.enhPatternTree[o.ID] = o;
                            };
                            break;
                        case "getQuestListQS":
                            world.objQuestList[resObj.ql.iSlot] = resObj.ql.quests;
                            if (world.objQuestList.callbackQS != null){
                                world.objQuestList.callbackQS(world.objQuestList[resObj.ql.iSlot]);
                            };
                            break;
                        case "getQuestListDaily":
                            world.objQuestList.daily = resObj.ql.quests;
                            if (world.objQuestList.callbackDaily != null){
                                world.objQuestList.callbackDaily(world.objQuestList.daily);
                            };
                            break;
                        case "turnIn":
                            if (((!((resObj.sItems == null))) && ((resObj.sItems.length >= 3)))){
                                itemArr = resObj.sItems.split(",");
                                dropindex = 0;
                                while (dropindex < itemArr.length) {
                                    dropID = itemArr[dropindex].split(":")[0];
                                    dropQty = int(itemArr[dropindex].split(":")[1]);
                                    if (world.invTree[dropID].bTemp == 0){
                                        world.removeItemByID(dropID, dropQty);
                                    }
                                    else {
                                        world.removeTempItem(dropID, dropQty);
                                    };
                                    dropindex = (dropindex + 1);
                                };
                            };
                            if (ui.mcPopup.currentLabel == "Inventory"){
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({eventType:"refreshItems"});
                            };
                            break;
                        case "getQuest":
                            break;
                        case "getQuests":
                            for (qi in resObj.quests) {
                                if (world.questTree[qi] == null){
                                    o = resObj.quests[qi];
                                    world.questTree[qi] = o;
                                    for (qr in o.oReqd) {
                                        if (world.invTree[qr] == null){
                                            world.invTree[qr] = o.oReqd[qr];
                                            world.invTree[qr].iQty = 0;
                                        };
                                    };
                                    for (qj in o.oItems) {
                                        if (world.invTree[qj] == null){
                                            world.invTree[qj] = o.oItems[qj];
                                            world.invTree[qj].iQty = 0;
                                        };
                                    };
                                    qk = "";
                                    qat = ["itemsS", "itemsC", "itemsR"];
                                    i = 0;
                                    while (i < qat.length) {
                                        s = qat[i];
                                        if (o.oRewards[s] != null){
                                            for (qk in o.oRewards[s]) {
                                                if (world.invTree[qk] == null){
                                                    world.invTree[qk] = o.oRewards[s][qk];
                                                    world.invTree[qk].iQty = 0;
                                                };
                                            };
                                        };
                                        i = (i + 1);
                                    };
                                };
                            };
                            if (ui.ModalStack.numChildren > 0){
                                MovieClip(ui.ModalStack.getChildAt(0)).open();
                            };
                            break;
                        case "ccqr":
                            if (resObj.bSuccess == 0){
                                MsgBox.notify("Quest Complete Failed!");
                            }
                            else {
                                if (("eventTrigger" in MovieClip(world.map))){
                                    world.map.eventTrigger({
                                        cmd:"questComplete",
                                        args:resObj.QuestID
                                    });
                                };
                                world.completeQuest(resObj.QuestID);
                                if (ui.ModalStack.numChildren){
                                    fgWin = ui.ModalStack.getChildAt(0);
                                    if (((!((fgWin == null))) && ((fgWin.toString().indexOf("QFrameMC") > -1)))){
                                        fgWin.turninResult(resObj.QuestID);
                                    };
                                };
                                showQuestpopup(resObj);
                            };
                            break;
                        case "updateQuest":
                            world.setQuestValue(resObj.iIndex, resObj.iValue);
                            break;
                        case "showQuestLink":
                            world.showQuestLink(resObj);
                            break;
                        case "initMonData":
                            for (m in resObj.mon) {
                                world.updateMonster(resObj.mon[m]);
                            };
                            break;
                        case "aura+":
                        case "aura*":
                        case "aura-":
                        case "aura--":
                        case "aura++":
                        case "aura+p":
                            world.handleAuraEvent(cmd, resObj);
                            break;
                        case "clearAuras":
                            tAvt = world.myAvatar;
                            tLeaf = tAvt.dataLeaf;
                            world.showAuraChange({
                                cmd:"aura-",
                                auras:tLeaf.auras
                            }, tAvt, tLeaf);
                            tLeaf.auras = [];
                            break;
                        case "uotls":
                            userTreeWrite(resObj.unm, resObj.o);
                            break;
                        case "mtls":
                            monsterTreeWrite(resObj.id, resObj.o);
                            break;
                        case "cb":
                            if (resObj.m != null){
                                for (updateID in resObj.m) {
                                    monsterTreeWrite(int(updateID), resObj.m[updateID]);
                                };
                            };
                            if (resObj.p != null){
                                for (updateID in resObj.p) {
                                    userTreeWrite(updateID, resObj.p[updateID]);
                                };
                            };
                            if (resObj.anims != null){
                                if (sfcSocial){
                                    for each (o in resObj.anims) {
                                        doAnim(o);
                                    };
                                };
                            };
                            if (resObj.a != null){
                                i = 0;
                                while (i < resObj.a.length) {
                                    world.handleAuraEvent(resObj.a[i].cmd, resObj.a[i]);
                                    i = (i + 1);
                                };
                            };
                            break;
                        case "ct":
                            if (resObj.anims != null){
                                if (sfcSocial){
                                    for each (o in resObj.anims) {
                                        doAnim(o);
                                    };
                                };
                            };
                            if (resObj.m != null){
                                for (updateID in resObj.m) {
                                    monsterTreeWrite(int(updateID), resObj.m[updateID]);
                                };
                            };
                            if (resObj.p != null){
                                for (updateID in resObj.p) {
                                    userTreeWrite(updateID, resObj.p[updateID]);
                                };
                            };
                            if (resObj.a != null){
                                j = 0;
                                while (j < resObj.a.length) {
                                    world.handleAuraEvent(resObj.a[j].cmd, resObj.a[j]);
                                    j = (j + 1);
                                };
                            };
                            if (resObj.sara != null){
                                for each (o in resObj.sara) {
                                    world.handleSAR(o);
                                };
                            };
                            if (resObj.sarsa != null){
                                for each (o in resObj.sarsa) {
                                    world.handleSARS(o);
                                };
                            };
                            if (resObj.pvp != null){
                                switch (resObj.pvp.cmd){
                                    case "PVPS":
                                        updatePVPScore(resObj.pvp.pvpScore);
                                        break;
                                    case "PVPC":
                                        world.PVPResults.pvpScore = resObj.pvp.pvpScore;
                                        world.PVPResults.team = resObj.pvp.team;
                                        updatePVPScore(resObj.pvp.pvpScore);
                                        togglePVPPanel("results");
                                        break;
                                };
                            };
                            break;
                        case "sar":
                            world.handleSAR(resObj);
                            break;
                        case "sars":
                            world.handleSARS(resObj);
                            break;
                        case "showAuraResult":
                            world.showAuraImpact(resObj);
                            break;
                        case "anim":
                            if (sfcSocial){
                                doAnim(resObj);
                            };
                            break;
                        case "sAct":
                            world.actions = {};
                            world.actions.active = [];
                            world.actions.passive = [];
                            world.actionMap = [null, null, null, null, null, null];
                            blanki = 0;
                            while (blanki < 6) {
                                ui.mcInterface.actBar.getChildByName(("blank" + blanki)).visible = true;
                                actBar = ui.mcInterface.actBar;
                                delIcon = actBar.getChildByName(("i" + (blanki + 1)));
                                if (delIcon != null){
                                    delIcon.removeEventListener(MouseEvent.CLICK, actIconClick);
                                    delIcon.removeEventListener(MouseEvent.MOUSE_OVER, actIconOver);
                                    delIcon.removeEventListener(MouseEvent.MOUSE_OUT, actIconOut);
                                    if (delIcon.icon2 != null){
                                        delIcon.removeEventListener(Event.ENTER_FRAME, world.countDownAct);
                                        if (delIcon.icon2.mask != null){
                                            actBar.removeChild(delIcon.icon2.mask);
                                            delIcon.icon2.mask = null;
                                        };
                                        actBar.removeChild(delIcon.icon2);
                                    };
                                    actBar.removeChild(delIcon);
                                };
                                blanki = (blanki + 1);
                            };
                            ai = 0;
                            slot = 0;
                            ai = 0;
                            while (ai < resObj.actions.active.length) {
                                actObj = resObj.actions.active[ai];
                                actObj.sArg1 = "";
                                actObj.sArg2 = "";
                                world.actions.active.push(actObj);
                                actObj.ts = 0;
                                actObj.actID = -1;
                                actObj.lock = false;
                                world.actionMap[ai] = actObj.ref;
                                actIconClass = (getDefinitionByName("ib2") as Class);
                                actIcon = new (actIconClass)();
                                actIconMC = ui.mcInterface.actBar.addChild(actIcon);
                                slot = ai;
                                blankMC = ui.mcInterface.actBar.getChildByName(("blank" + slot));
                                actIconMC.x = blankMC.x;
                                actIconMC.y = blankMC.y;
                                actIconMC.name = String(("i" + (ai + 1)));
                                actIconMC.actionIndex = ai;
                                actIconMC.actObj = actObj;
                                actIconMC.icon2 = null;
                                actIconMC.tQty.visible = false;
                                updateIcons([actIconMC], actObj.icon.split(","), null);
                                blankMC.visible = false;
                                actIconMC.addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                                actIconMC.addEventListener(MouseEvent.MOUSE_OVER, actIconOver, false, 0, true);
                                actIconMC.addEventListener(MouseEvent.MOUSE_OUT, actIconOut, false, 0, true);
                                actIconMC.cnt.mouseEnabled = false;
                                actIconMC.cnt.mouseChildren = false;
                                if (((!((actObj.auto == null))) && ((actObj.auto == true)))){
                                    world.actions.auto = world.actions.active[ai];
                                }
                                else {
                                    world.actions.active[ai].auto = false;
                                };
                                ai = (ai + 1);
                            };
                            if (resObj.actions.passive != null){
                                ai = 0;
                                while (ai < resObj.actions.passive.length) {
                                    actObj = copyObj(resObj.actions.passive[ai]);
                                    actObj.sArg1 = "";
                                    actObj.sArg2 = "";
                                    world.actions.passive.push(actObj);
                                    ai = (ai + 1);
                                };
                            };
                            break;
                        case "seia":
                            if (resObj.iRes == 1){
                                ai = 0;
                                while (ai < world.actions.active.length) {
                                    o = world.actions.active[ai];
                                    if (o.ref == "i1"){
                                        if (("tgtMax" in o)){
                                            delete o.tgtMax;
                                        };
                                        if (("tgtMin" in o)){
                                            delete o.tgtMin;
                                        };
                                        if (("auras" in o)){
                                            delete o.auras;
                                        };
                                        for (s in resObj.o) {
                                            if (((((((((!((s == "nam"))) && (!((s == "ref"))))) && (!((s == "desc"))))) && (!((s == "typ"))))) && (!((s == "cd"))))){
                                                o[s] = resObj.o[s];
                                            };
                                        };
                                    };
                                    ai = (ai + 1);
                                };
                            };
                            break;
                        case "stu":
                            avt = world.myAvatar;
                            unm = sfc.myUserName;
                            uoLeaf = world.uoTreeLeaf(unm);
                            if (resObj.wDPS != null){
                                uoLeaf.wDPS = resObj.wDPS;
                            };
                            if (resObj.mDPS != null){
                                uoLeaf.mDPS = resObj.mDPS;
                            };
                            if (uoLeaf.sta == null){
                                uoLeaf.sta = {};
                            };
                            for (stuS in resObj.sta) {
                                uoLeaf.sta[stuS] = resObj.sta[stuS];
                                if (stats.indexOf(stuS.substr(1)) > -1){
                                    uoLeaf.sta[stuS] = int(uoLeaf.sta[stuS]);
                                }
                                else {
                                    uoLeaf.sta[stuS] = Number(uoLeaf.sta[stuS]);
                                };
                                if ((((stuS.toLowerCase().indexOf("$tha") > -1)) && (!((world.actions == null))))){
                                    actObj = world.getAutoAttack();
                                    if (((((!((actObj == null))) && (!((uoLeaf == null))))) && (!((uoLeaf.sta == null))))){
                                        cd = Math.round((actObj.cd * (1 - Math.min(Math.max(uoLeaf.sta.$tha, -1), 0.5))));
                                        if (world.autoActionTimer.running){
                                            world.autoActionTimer.delay = (world.autoActionTimer.delay - (world.autoActionTimer.delay - cd));
                                            world.autoActionTimer.delay = (world.autoActionTimer.delay + 100);
                                            world.autoActionTimer.reset();
                                            world.autoActionTimer.start();
                                        }
                                        else {
                                            world.autoActionTimer.delay = cd;
                                        };
                                    }
                                    else {
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("Login event order error");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                    };
                                    hasteCoeff = (1 - Math.min(Math.max(uoLeaf.sta.$tha, -1), 0.5));
                                    world.GCD = Math.round((hasteCoeff * world.GCDO));
                                    for each (actObj in world.actions.active) {
                                        if (((((((actObj.isOK) && (!((world.getActIcons(actObj)[0] == null))))) && ((world.getActIcons(actObj)[0].icon2 == null)))) && (((now - actObj.ts) < (actObj.cd * hasteCoeff))))){
                                            world.coolDownAct(actObj, ((actObj.cd * hasteCoeff) - (now - actObj.ts)), now);
                                        };
                                    };
                                };
                                if (stuS.toLowerCase().indexOf("$cmc") > -1){
                                    world.updateActBar();
                                };
                            };
                            if (resObj.tempSta != null){
                                uoLeaf.tempSta = resObj.tempSta;
                                if (("updatePStats" in world.map)){
                                    world.map.updatePStats();
                                };
                            };
                            if (avt != null){
                                world.updatePortrait(avt);
                            };
                            break;
                        case "cvu":
                            updateCoreValues(resObj.o);
                            break;
                        case "event":
                            world.map.eventTrigger(resObj);
                            break;
                        case "modinfo":
                            world.map.showModInfo(resObj);
                            break;
                        case "modinc":
                            if (resObj.bSuccess){
                                world.map.hideLoading();
                                world.map.show(resObj.events);
                                world.modID = int(resObj.mID);
                            }
                            else {
                                chatF.pushMsg("warning", resObj.msg, "SERVER", "", 0);
                            };
                            break;
                        case "ia":
                            if (!("iaPathMC" in resObj)){
                                mc = MovieClip(world.CHARS.getChildByName(resObj.oName));
                            }
                            else {
                                try {
                                    mc = world;
                                    mcPath = resObj.iaPathMC.split(".");
                                    while (mcPath.length > 0) {
                                        s = String(mcPath.shift());
                                        if (mc.getChildByName(s) != null){
                                            mc = (mc.getChildByName(s) as MovieClip);
                                        }
                                        else {
                                            mc = mc[s];
                                        };
                                    };
                                }
                                catch(e:Error) {
                                };
                            };
                            if (((!((mc == null))) && (!((mc == world))))){
                                try {
                                    switch (resObj.typ){
                                        case "rval":
                                            mc.userName = resObj.unm;
                                            mc.iaF(resObj);
                                            break;
                                        case "str":
                                            mc.userName = resObj.unm;
                                            mc.iaF(resObj);
                                            break;
                                        case "flourish":
                                            mc.userName = resObj.unm;
                                            mc.gotoAndPlay(resObj.oFrame);
                                            break;
                                    };
                                }
                                catch(e:Error) {
                                };
                            };
                            break;
                        case "siau":
                            world.updateCellMap(resObj);
                            break;
                        case "umsg":
                            addUpdate(resObj.s);
                            break;
                        case "pi":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.owner + " has invited you to join their group.  Do you accept?");
                            modalO.callback = world.doPartyAccept;
                            modalO.params = {pid:resObj.pid};
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.owner + " has invited you to a group."), "SERVER", "", 0);
                            break;
                        case "pa":
                            if (world.partyOwner == ""){
                                world.partyOwner = resObj.owner;
                            };
                            supressMupltiples = false;
                            if (world.partyID == -1){
                                world.partyID = resObj.pid;
                                chatF.chn.party.act = 1;
                                if (resObj.owner.toLowerCase() != sfc.myUserName){
                                    chatF.pushMsg("server", "You have joined the party.", "SERVER", "", 0);
                                    supressMupltiples = true;
                                };
                            };
                            i = 0;
                            while (i < resObj.ul.length) {
                                unm = resObj.ul[i];
                                if (unm.toLowerCase() != sfc.myUserName){
                                    world.addPartyMember(unm);
                                    if (!supressMupltiples){
                                        chatF.pushMsg("server", (unm + " has joined the party."), "SERVER", "", 0);
                                    };
                                };
                                i = (i + 1);
                            };
                            break;
                        case "pr":
                            isYou = false;
                            nam = world.partyOwner;
                            world.partyOwner = resObj.owner;
                            if (nam != world.partyOwner){
                                chatF.pushMsg("server", (world.partyOwner + " is now the party leader."), "SERVER", "", 0);
                            };
                            if (resObj.unm.toLowerCase() == sfc.myUserName.toLowerCase()){
                                isYou = true;
                                chatF.chn.party.act = 0;
                            };
                            if (resObj.typ == "k"){
                                if (isYou){
                                    chatF.pushMsg("server", "You have been removed from the party", "SERVER", "", 0);
                                }
                                else {
                                    chatF.pushMsg("server", (resObj.unm + " has been removed from the party"), "SERVER", "", 0);
                                };
                            }
                            else {
                                if (resObj.typ == "l"){
                                    if (isYou){
                                        chatF.pushMsg("server", "You have left the party", "SERVER", "", 0);
                                    }
                                    else {
                                        chatF.pushMsg("server", (resObj.unm + " has left the party"), "SERVER", "", 0);
                                    };
                                };
                            };
                            world.removePartyMember(String(resObj.unm).toLowerCase());
                            break;
                        case "pp":
                            nam = world.partyOwner;
                            world.partyOwner = resObj.owner;
                            if (nam != world.partyOwner){
                                chatF.pushMsg("server", (world.partyOwner + " is now the party leader."), "SERVER", "", 0);
                            };
                            world.updatePartyFrame();
                            break;
                        case "ps":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.unm + " wants to summon you to them.  Do you accept?");
                            modalO.callback = world.acceptPartySummon;
                            modalO.params = resObj;
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.unm + " is trying to summon you to them."), "SERVER", "", 0);
                            break;
                        case "pd":
                            chatF.pushMsg("server", (resObj.unm + " has declined your invitation."), "SERVER", "", 0);
                            break;
                        case "pc":
                            if (world.partyID > -1){
                                chatF.pushMsg("server", "Your party has been disbanded", "SERVER", "", 0);
                            };
                            world.partyID = -1;
                            world.partyOwner = "";
                            world.partyMembers = [];
                            world.updatePartyFrame();
                            chatF.chn.party.act = 0;
                            if (chatF.chn.cur == chatF.chn.party){
                                chatF.chn.cur = chatF.chn.zone;
                            };
                            if (chatF.chn.lastPublic == chatF.chn.party){
                                chatF.chn.lastPublic = chatF.chn.zone;
                            };
                            break;
                        case "PVPQ":
                            world.handlePVPQueue(resObj);
                            break;
                        case "PVPI":
                            world.receivePVPInvite(resObj);
                            break;
                        case "PVPE":
                            relayPVPEvent(resObj);
                            break;
                        case "PVPS":
                            updatePVPScore(resObj.pvpScore);
                            break;
                        case "PVPC":
                            world.PVPResults.pvpScore = resObj.pvpScore;
                            world.PVPResults.team = resObj.team;
                            updatePVPScore(resObj.pvpScore);
                            togglePVPPanel("results");
                            break;
                        case "pvpbreakdown":
                            break;
                        case "loadFactions":
                            world.initFactions(resObj.factions);
                            break;
                        case "addFaction":
                            world.addFaction(resObj.faction);
                            break;
                        case "loadFriendsList":
                            world.initFriendsList(resObj.friends);
                            break;
                        case "requestFriend":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.unm + " has invited you to be friends. Do you accept?");
                            modalO.callback = world.sendAddFriend;
                            modalO.params = {
                                ID:resObj.ID,
                                unm:resObj.unm
                            };
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.unm + " has invited you to be friends."), "SERVER", "", 0);
                            break;
                        case "addFriend":
                            world.addFriend(resObj.friend);
                            break;
                        case "updateFriend":
                            world.updateFriend(resObj.friend);
                            break;
                        case "deleteFriend":
                            world.deleteFriend(resObj.ID);
                            break;
                        case "loadWarVars":
                            world.objResponse["loadWarVars"] = resObj;
                            world.dispatchEvent(new Event("loadWarVars"));
                            break;
                        case "setAchievement":
                            world.updateAchievement(resObj.field, resObj.index, resObj.value);
                            break;
                        case "loadQuestStringData":
                            world.objQuestString = resObj.obj;
                            world.dispatchEvent(new Event("QuestStringData_Complete"));
                            break;
                        case "getAdData":
                            if (resObj.bSuccess == 1){
                                world.adData = resObj.bh;
                                world.dispatchEvent(new Event("getAdData"));
                            };
                            break;
                        case "getAdReward":
                            world.myAvatar.objData.iDailyAds = (world.myAvatar.objData.iDailyAds + 1);
                            world.adData = null;
                            if (world.myAvatar.objData.iDailyAds < world.myAvatar.objData.iDailyAdCap){
                                world.sendGetAdDataRequest();
                            };
                            world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold + int(resObj.iGold));
                            ui.mcPortrait.strGold.text = world.myAvatar.objData.intGold;
                            if (ui.mcPopup.currentLabel == "Inventory"){
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({eventType:"refreshCoins"});
                            };
                            world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins + int(resObj.iCoins));
                            sMsg = (("Congratulations! You just received <font color='#FFCC00'><b>" + resObj.iGold) + " Gold</b></font>");
                            if (resObj.iCoins > 0){
                                sMsg = (sMsg + ((" and <font color='#990099'><b>" + resObj.iCoins) + " Adventure Coins</b></font>"));
                            };
                            sMsg = (sMsg + " from Ballyhoo.");
                            showMessageBox(sMsg);
                            break;
                        case "xpboost":
                            manageXPBoost(resObj);
                            break;
                        case "gettimes":
                            a = [];
                            for (s in resObj.o) {
                                o = resObj.o[s];
                                o.s = s;
                                a.push(o);
                            };
                            s = "";
                            a.sortOn("t", (Array.NUMERIC | Array.DESCENDING));
                            i = 0;
                            while (i < a.length) {
                                o = a[i];
                                s = (s + (((((((((o.s + "> t:") + strNumWithCommas(o.t)) + ", n:") + strNumWithCommas(o.n)) + ", d:") + Math.round(o.d)) + ", a:") + numToStr((o.t / o.n))) + "\n"));
                                chatF.pushMsg("server", ((((((((o.s + "> t:") + strNumWithCommas(o.t)) + ", n:") + strNumWithCommas(o.n)) + ", d:") + Math.round(o.d)) + ", a:") + numToStr((o.t / o.n))), "SERVER", "", 0);
                                i = (i + 1);
                            };
                            System.setClipboard(s);
                            break;
                        case "clockTick":
                            if (("eventTrigger" in MovieClip(world.map))){
                                world.map.eventTrigger(resObj);
                            };
                            break;
                        case "getCharDataByID":
                            world.getCopierByCharID(resObj.objData.ID).onCharacterDataLoaded(resObj.objData);
                            break;
                        case "redeemPoint":
                            if (resObj.status == 1){
                                world.myAvatar.objData.dUpgExp = stringToDate(resObj.data.dUpgExp);
                                world.myAvatar.objData.iUpgDays = resObj.data.iUpgDays;
                                world.myAvatar.objData.intCoins = resObj.data.intCoins;
                                objLogin.iPoints = resObj.data.intPoints;
                            };
                            world.dispatchEvent(new SmashEvent("redeemPoint", resObj));
                    };
                };
            };
            addFrameScript(0, frame1, 9, frame10, 17, frame18);
            System.useCodePage = true;
            Security.allowDomain("cdn.aqworlds.com");
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            sfc = new SmartFoxClient();
            sfc.debug = true;
            sfc.addEventListener(SFSEvent.onConnection, onConnectionHandler);
            sfc.addEventListener(SFSEvent.onConnectionLost, onConnectionLostHandler);
            sfc.addEventListener(SFSEvent.onLogin, onLoginHandler);
            sfc.addEventListener(SFSEvent.onLogout, onLogoutHandler);
            sfc.addEventListener(SFSEvent.onObjectReceived, onObjectReceivedHandler);
            sfc.addEventListener(SFSEvent.onRoundTripResponse, onRoundTripResponseHandler);
            sfc.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponseHandler);
            for each (multiO in sfcA) {
            };
            sfci = 0;
            while (sfci < sfcA.length) {
                var _local2 = sfcA[sfci];
                sfcO = _local2;
                _local2;
                (sfcO.sfc = new SmartFoxClient());
                (sfcO.sfc.debug = true);
                (sfcO.rootClass = this);
                (sfcO.cLoginZone = cLoginZone);
                (sfcO.clientToken = clientToken);
                (sfcO.serverPort = serverPort);
                (sfcO.loginInfo = {});
                (sfcO.onMultiConnectionHandler = function (e:SFSEvent):void{
                    var o:Object;
                    if (e.params.success){
                        o = getSfcBySFC(e.currentTarget);
                        trace(((("MULTI.onMultiConnectionHandler > " + o.sLogin) + " on ") + o.sIP));
                        o.sfc.login(o.cLoginZone, ((o.clientToken + "~") + o.sLogin), o.strToken);
                    }
                    else {
                        trace("failed");
                    };
                });
                (sfcO.onMultiConnectionLostHandler = onMultiConnectionLostHandler);
                (sfcO.onMultiLogoutHandler = onMultiLogoutHandler);
                (sfcO.loginLoader = new URLLoader());
                (sfcO.login = function ():void{
                    var rand:Number;
                    var url:String;
                    var request:URLRequest;
                    var variables:URLVariables;
                    rand = Math.random();
                    url = ("cf-userlogin.asp?ran=" + rand);
                    var _local2 = ("http://game.aqworlds.com/game/" + url);
                    url = _local2;
                    _local2;
                    request = new URLRequest(url);
                    variables = new URLVariables();
                    (variables.strUsername = this.sLogin);
                    (variables.strPassword = this.sPass);
                    (request.data = variables);
                    (request.method = URLRequestMethod.POST);
                    this.loginLoader.addEventListener(Event.COMPLETE, sfcO.onLoginComplete);
                    try {
                        this.loginLoader.load(request);
                    }
                    catch(e:Error) {
                        trace("Unable to load URL");
                    };
                });
                (sfcO.onLoginComplete = function (e:Event):void{
                    var o:Object;
                    var objLogin:Object;
                    o = getSfcByLoader(e.currentTarget);
                    if (o != null){
                        trace(((("MULTI.onLoginComplete > " + o.sLogin) + " on ") + o.sIP));
                        objLogin = XMLtoObject(new XML(e.target.data));
                        o.loginLoader.removeEventListener(Event.COMPLETE, o.onLoginComplete);
                        (o.strToken = objLogin.sToken);
                        o.sfc.connect(o.sIP, o.serverPort);
                    }
                    else {
                        trace("MULTI.onLoginComplete > Unable to resolve host object");
                    };
                });
                sfcO.sfc.addEventListener(SFSEvent.onConnection, sfcO.onMultiConnectionHandler);
                sfcO.sfc.addEventListener(SFSEvent.onConnectionLost, sfcO.onMultiConnectionLostHandler);
                sfcO.sfc.addEventListener(SFSEvent.onLogout, sfcO.onMultiLogoutHandler);
                sfci = (sfci + 1);
            };
            (userPreference = SharedObject.getLocal("AQWUserPref", "/"));
            inituoPref();
            if (((!((userPreference.data.bSoundOn == null))) && ((userPreference.data.bSoundOn == false)))){
                (mixer.bSoundOn = false);
            };
            (uoPref.bSoundOn = mixer.bSoundOn);
            (mcExtSWF = MovieClip(addChild(new MovieClip())));
            initArrRep();
            (chatF = new Chat());
            (chatF.rootClass = this);
        }
        public static function XMLtoObject(objXML:XML){
            var objTarget:*;
            var a:*;
            var o:*;
            var strChildName:*;
            objTarget = {};
            for (a in objXML.attributes()) {
                objTarget[String(objXML.attributes()[a].name())] = String(objXML.attributes()[a]);
            };
            for (o in objXML.children()) {
                strChildName = objXML.children()[o].name();
                if (objTarget[strChildName] == undefined){
                    objTarget[strChildName] = [];
                };
                objTarget[strChildName].push(XMLtoObject(objXML.children()[o]));
            };
            return (objTarget);
        }

        public function key_actBar(e:KeyboardEvent){
            var actMapID:int;
            var action:String;
            if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                switch (e.charCode){
                    case 49:
                        actMapID = 0;
                        world.approachTarget();
                        break;
                    default:
                        if ((((e.charCode > 49)) && ((e.charCode < 55)))){
                            actMapID = (e.charCode - 49);
                            if (world.actionMap[actMapID] != null){
                                world.testAction(world.getActionByRef(world.actionMap[actMapID]));
                            };
                        };
                };
            };
        }
        public function coeffToPct(c:Number):String{
            return (Number((c * 100)).toFixed(2));
        }
        private function addPortraitStatusIcon(mcPortraitBox:MovieClip, statusIcon:String):MovieClip{
            var AssetClass:Class;
            var iconPosition:Number;
            var newMC:MovieClip;
            var statusBox:*;
            var lastIcon:*;
            newMC = null;
            if (((!((mcPortraitBox == null))) && (!((statusIcon == null))))){
                statusBox = mcPortraitBox.pStatus;
                iconPosition = (statusBox.numChildren - 1);
                iconPosition;
                AssetClass = loadermanager.getClass(statusIcon);
                AssetClass;
                if (AssetClass != null){
                    newMC = statusBox.addChild(new (AssetClass)());
                    newMC;
                    resizeStatusIcons(newMC);
                    if (iconPosition > -1){
                        lastIcon = statusBox.getChildAt(iconPosition);
                        (newMC.x = ((lastIcon.x + lastIcon.width) + 5));
                    }
                    else {
                        (newMC.x = 0);
                    };
                }
                else {
                    trace(("No Icon found under this name:" + statusIcon));
                };
            };
            return (newMC);
        }
        public function onMCPVPQueueClick(e:MouseEvent):void{
            var params:* = undefined;
            var e:MouseEvent = e;
            params = {};
            try {
                (params.strUsername = world.myAvatar.objData.strUsername);
                ui.cMenu.fOpenWith("pvpqueue", params);
            }
            catch(e:Error) {
            };
        }
        public function dropStackReset():void{
            (ui.dropStack.y = 493);
        }
        public function initAreaList():void{
            var mcAreaList:MovieClip;
            var bm:MovieClip;
            var bMinMaxMouseOver:Function;
            var bMinMaxMouseOut:Function;
            bMinMaxMouseOver = function (e:MouseEvent){
                (bm.filters = [GlowFilterGold]);
            };
            bMinMaxMouseOut = function (e:MouseEvent){
                (bm.filters = [GlowFilterBlue]);
            };
            mcAreaList = ui.mcInterface.areaList;
            bm = mcAreaList.title.bMinMax;
            (mcAreaList.title.t1.mouseEnabled = false);
            (bm.buttonMode = true);
            (bm.a1.visible = false);
            (bm.a2.visible = true);
            (bm.filters = [GlowFilterBlue]);
            bm.addEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            bm.addEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
        }
        public function getRarityString(n:int):String{
            var aRarity:Array;
            var o:Object;
            var i:int;
            aRarity = [{
                val:10,
                sName:"Unknown"
            }, {
                val:11,
                sName:"Common"
            }, {
                val:12,
                sName:"Weird"
            }, {
                val:13,
                sName:"Awesome"
            }, {
                val:14,
                sName:"1% Drop"
            }, {
                val:15,
                sName:"5% Drop"
            }, {
                val:16,
                sName:"Boss Drop"
            }, {
                val:17,
                sName:"Secret"
            }, {
                val:18,
                sName:"Junk"
            }, {
                val:19,
                sName:"Impossible"
            }, {
                val:20,
                sName:"Artifact"
            }, {
                val:21,
                sName:"Broken"
            }, {
                val:22,
                sName:"Dumb"
            }, {
                val:23,
                sName:"Crazy"
            }, {
                val:24,
                sName:"Expensive"
            }, {
                val:30,
                sName:"Rare"
            }, {
                val:35,
                sName:"Epic"
            }, {
                val:40,
                sName:"Import Item"
            }, {
                val:50,
                sName:"Seasonal Item"
            }, {
                val:55,
                sName:"Seasonal Rare"
            }, {
                val:60,
                sName:"Event Item"
            }, {
                val:65,
                sName:"Event Rare"
            }, {
                val:70,
                sName:"Limited Rare"
            }, {
                val:75,
                sName:"Collector's Rare"
            }, {
                val:80,
                sName:"Promotional Item"
            }, {
                val:90,
                sName:"Ultra Rare"
            }, {
                val:95,
                sName:"Super Mega Ultra Rare"
            }, {
                val:100,
                sName:"Legendary Item"
            }];
            i = (aRarity.length - 1);
            while (i > -1) {
                o = aRarity[i];
                if (n >= o.val){
                    return (o.sName);
                };
                i--;
            };
            return ("Common");
        }
        public function actIconClick(e:MouseEvent){
            var actObj:*;
            actObj = MovieClip(e.currentTarget).actObj;
            if (((!((actObj.auto == null))) && ((actObj.auto == true)))){
                world.approachTarget();
            }
            else {
                world.testAction(actObj);
            };
        }
        public function showSmashCoinWindow():void{
            var mc:MovieClip;
            (mcUpgradeWindow = new MCSmashCoinPopup());
            mc = (mcUpgradeWindow as MovieClip);
            mc.btnClose.addEventListener(MouseEvent.CLICK, hideUpgradeWindow, false, 0, true);
            mc.btnBuy.addEventListener(MouseEvent.CLICK, onUpgradeClick, false, 0, true);
            addChild(mcUpgradeWindow);
        }
        public function trim(p_string:String):String{
            if (p_string == null){
                return ("");
            };
            return (p_string.replace(/^\s+|\s+$/g, ""));
        }
        private function onLoginComplete(event:Event):void{
            var i:*;
            var char:*;
            var j:*;
            trace(("LoginComplete:" + event.target.data));
            loginLoader.removeEventListener(Event.COMPLETE, onLoginComplete);
            (objLogin = convertXMLtoObject(new XML(event.target.data)));
            if (!(objLogin.servers is Array)){
                (objLogin.servers = [objLogin.servers]);
            };
            if (!(objLogin.chars is Array)){
                if (objLogin.chars == null){
                    (objLogin.chars = []);
                }
                else {
                    (objLogin.chars = [objLogin.chars]);
                };
            };
            i = 0;
            while (i < objLogin.chars.length) {
                char = objLogin.chars[i];
                (char.eqp = {});
                if (char.items != null){
                    if (!(char.items is Array)){
                        (char.items = [char.items]);
                    };
                    j = 0;
                    while (j < char.items.length) {
                        (char.eqp[char.items[j].sES] = {});
                        (char.eqp[char.items[j].sES].sType = char.items[j].sType);
                        (char.eqp[char.items[j].sES].sFile = char.items[j].sFile);
                        (char.eqp[char.items[j].sES].sLink = char.items[j].sLink);
                        j++;
                    };
                };
                i++;
            };
            if (objLogin.bSuccess == 1){
                mcConnDetail.showConn("Loading Game Assets...");
                (loginInfo.strToken = objLogin.sToken);
                loadGameAssets();
            }
            else {
                if (objLogin.status == 5){
                    loginMAS(loginInfo.strUsername, loginInfo.strPassword);
                }
                else {
                    mcConnDetail.showError(objLogin.sMsg);
                };
            };
        }
        public function monsterTreeWrite(MonMapID:int, monLeafO:Object):void{
            var i:int;
            var typ:String;
            var nam:String;
            var val:*;
            var monAvt:Avatar;
            var avtAvt:Avatar;
            var Mon:Avatar;
            var avt:Avatar;
            var pMC:MovieClip;
            var prop:String;
            var updated:Object;
            var monLeaf:Object;
            var intStateO:int;
            var s:String;
            var ri:int;
            var tx:*;
            var ty:*;
            i = 0;
            prop = "";
            updated = {};
            monLeaf = world.monTree[MonMapID];
            if (monLeaf != null){
                intStateO = -1;
                if (((!((monLeaf == null))) && (!((monLeaf.intState == null))))){
                    intStateO = monLeaf.intState;
                };
                for (s in monLeafO) {
                    nam = s;
                    val = monLeafO[s];
                    updated[nam] = val;
                    if (nam.toLowerCase().indexOf("int") > -1){
                        val = int(val);
                    };
                    if (nam == "react"){
                        val = val.split(",");
                        ri = 0;
                        while (ri < val.length) {
                            val[ri] = int(val[ri]);
                            ri++;
                        };
                    };
                    monLeaf[nam] = val;
                };
                prop = "";
                for (prop in updated) {
                    nam = prop;
                    val = updated[prop];
                    if (nam.toLowerCase().indexOf("evt:") < 0){
                        Mon = world.getMonster(MonMapID);
                        if (Mon != null){
                            if (nam.toLowerCase().indexOf("hp") > -1){
                                if (((!((Mon == null))) && (!((Mon.objData == null))))){
                                    val = int(val);
                                    Mon.objData[prop] = val;
                                    if (world.myAvatar.target == Mon){
                                        world.updatePortrait(Mon);
                                    };
                                    if (((!((world.objLock == null))) && ((((nam == "intHP")) && ((val <= 0)))))){
                                        world.intKillCount++;
                                        world.updatePadNames();
                                    };
                                    if (((!((Mon.objData == null))) && ("boolean"))){
                                        if (Mon.objData.strFrame == world.strFrame){
                                            if (val <= 0){
                                                Mon.pMC.stopWalking();
                                                Mon.pMC.die();
                                                monLeaf.auras = [];
                                                monLeaf.targets = {};
                                                Mon.target = null;
                                                if (("eventTrigger" in MovieClip(world.map))){
                                                    world.map.eventTrigger({
                                                        cmd:"monDeath",
                                                        args:MonMapID
                                                    });
                                                };
                                                if (Mon == world.myAvatar.target){
                                                };
                                                if (world.myAvatar.dataLeaf.targets[Mon.objData.MonMapID] != null){
                                                    delete world.myAvatar.dataLeaf.targets[Mon.objData.MonMapID];
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                            if (nam.toLowerCase().indexOf("state") > -1){
                                if (((!((Mon == null))) && (!((Mon.objData == null))))){
                                    val = int(val);
                                    Mon.objData[prop] = val;
                                    if (val != 2){
                                        Mon.dataLeaf.auras = [];
                                    };
                                    if (((!((Mon.objData.strFrame == null))) && ((Mon.objData.strFrame == world.strFrame)))){
                                        if ((((((val == 1)) && (!((Mon.pMC == null))))) && (((!((Mon.pMC.x == Mon.pMC.ox))) || (!((Mon.pMC.y == Mon.pMC.oy))))))){
                                            Mon.pMC.walkTo(Mon.pMC.ox, Mon.pMC.oy, world.WALKSPEED);
                                        };
                                    };
                                    if (val != 2){
                                        monLeaf.targets = {};
                                    };
                                };
                            };
                            if (nam.toLowerCase().indexOf("dx") > -1){
                                val = int(val);
                                if (((((!((Mon.objData == null))) && (!((Mon.objData.strFrame == null))))) && ((Mon.objData.strFrame == world.strFrame)))){
                                    tx = int(world.monTree[MonMapID].dx);
                                    ty = int(world.monTree[MonMapID].dy);
                                    Mon.pMC.walkTo(tx, ty, world.WALKSPEED);
                                };
                            };
                        };
                    };
                };
            };
        }
        public function toggleFaction():void{
            if (ui.mcPopup.currentLabel != "Faction"){
                ui.mcPopup.fOpen("Faction");
            }
            else {
                if (("cnt" in MovieClip(ui.mcPopup))){
                    MovieClip(MovieClip(ui.mcPopup).cnt).xClick();
                };
            };
        }
        public function initLogin():void{
            var curTS:Number;
            var iDiff:Number;
            if (querystring.mode == "signup"){
                mcLogin.gotoAndPlay("CharNew");
            };
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            mcLogin.ni.removeEventListener(FocusEvent.FOCUS_IN, onUserFocus);
            mcLogin.ni.removeEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.pi.removeEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.btnLogin.removeEventListener(MouseEvent.CLICK, onLoginClick);
            mcLogin.mcForgotPassword.removeEventListener(MouseEvent.CLICK, onForgotPassword);
            (mcLogin.t1.mouseEnabled = false);
            (mcLogin.mcForgotPassword.txt.htmlText = "<u>Forgot your password?</u>");
            (mcLogin.mcForgotPassword.buttonMode = true);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            mcLogin.ni.addEventListener(FocusEvent.FOCUS_IN, onUserFocus);
            mcLogin.ni.addEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.pi.addEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.btnLogin.addEventListener(MouseEvent.CLICK, onLoginClick);
            mcLogin.mcForgotPassword.addEventListener(MouseEvent.CLICK, onForgotPassword);
            loadUserPreference();
            (mcLogin.warning.s = String(mcLogin.warning.ti.text));
            (mcLogin.warning.visible = false);
            (mcLogin.warning.alpha = 0);
            if (("logoutWarningTS" in userPreference.data)){
                curTS = new Date().getTime();
                iDiff = ((userPreference.data.logoutWarningTS + (userPreference.data.logoutWarningDur * 1000)) - curTS);
                if (iDiff > 60000){
                    (userPreference.data.logoutWarningDur = 60);
                    (userPreference.data.logoutWarningTS = curTS);
                    userPreference.flush();
                };
                if (iDiff > 1000){
                    initLoginWarning();
                };
            };
        }
        public function stringToDate(strODBC:String):Date{
            var numYear:*;
            var numMonth:*;
            var numDate:*;
            var numHour:*;
            var numMins:*;
            var numSecs:*;
            numYear = Number(strODBC.substr(0, 4));
            numMonth = (Number(strODBC.substr(5, 2)) - 1);
            numDate = Number(strODBC.substr(8, 2));
            numHour = Number(strODBC.substr(11, 2));
            numMins = Number(strODBC.substr(14, 2));
            numSecs = Number(strODBC.substr(17));
            return (new Date(numYear, numMonth, numDate, numHour, numMins, numSecs));
        }
        public function key_TextLogin(e:KeyboardEvent){
            if (e.target != stage){
                if ((e.charCode == Keyboard.ENTER)){
                    onLoginClick(null);
                };
            };
        }
        public function callHaldroid(app:String=null){
            if (ui.mcPopup.currentLabel == "Book"){
                ui.mcPopup.onClose();
            }
            else {
                if (app != null){
                    (haldroidApp = app);
                };
                ui.mcPopup.fOpen("Book");
            };
        }
        public function isHouseItem(obj:Object):Boolean{
            return ((((((obj.sType == "House")) || ((obj.sType == "Floor Item")))) || ((obj.sType == "Wall Item"))));
        }
        private function onSoundLoadError(e:Event):void{
            trace("*** Game SoundFX could not be loaded ***");
        }
        public function strToProperCase(str:String):String{
            str = (str.slice(0, 1).toUpperCase() + str.slice(1, str.length).toLowerCase());
            return (str);
        }
        public function showAddSpaceInterface():void{
            world.loadMovieFront("interface/bagspace.swf", "Inline Asset");
        }
        public function onUpgradeClick(evt:Event=null):void{
            mixer.playSound("Click");
            if (mcUpgradeWindow != null){
                hideUpgradeWindow();
            };
            if (objLogin.iPoints > 0){
                showPointsUI();
            }
            else {
                navigateToURL(new URLRequest("http://portal.battleon.com/store/packages/herosmash.asp"), "_blank");
            };
        }
        function frame10(){
            init();
            stop();
        }
        function frame18(){
            initInterface();
            stop();
        }
        public function getAssetClass(assetLinkageID:String):Class{
            return ((assetsDomain.getDefinition(assetLinkageID) as Class));
        }
        public function areaListShow(ul:Object):void{
            var mc:MovieClip;
            var ind:int;
            var i:String;
            var itemClass:*;
            var item:*;
            mc = ui.mcInterface.areaList;
            ind = 0;
            for (var _local9 in ul) {
                i = _local9;
                _local9;
                itemClass = (mc.cnt.iproto.constructor as Class);
                item = mc.cnt.addChild(new (itemClass)());
                (item.objData = ul[i]);
                (item.txtName.text = ul[i].strUsername);
                (item.txtLevel.text = ul[i].intLevel);
                item.addEventListener(MouseEvent.CLICK, areaListNameClick, false, 0, true);
                (item.buttonMode = true);
                (item.y = int((ind * 14)));
                ind++;
            };
            (mc.cnt.iproto.visible = false);
            (mc.visible = true);
        }
        public function catCodeToName(cat:String):String{
            switch (cat){
                case "M1":
                    return ("Fighter");
                case "M2":
                    return ("Thief");
                case "M3":
                    return ("Hybrid");
                case "M4":
                    return ("Armsman");
                case "C1":
                    return ("Wizard");
                case "C2":
                    return ("Healer");
                case "C3":
                    return ("spellbreaker");
                case "S1":
                    return ("Lucky");
                default:
                    return (null);
            };
        }
        function frame1(){
            stop();
        }
        public function tryEnhance(item:Object, enh:Object, shopRequest:Boolean=false):void{
            if (((!((item == null))) && (!((enh == null))))){
                if (enh.iLvl > world.myAvatar.objData.intLevel){
                    MsgBox.notify("Level requirement not met!");
                }
                else {
                    if (item.EnhID == enh.ItemID){
                        MsgBox.notify("Selected Enhancement already applied to item!");
                    }
                    else {
                        if (shopRequest){
                            world.sendEnhItemRequestShop(item, enh);
                        }
                        else {
                            world.sendEnhItemRequestLocal(item, enh);
                        };
                    };
                };
            };
        }
        public function togglePVPPanel(typ:String=""):void{
            var mc:MovieClip;
            mc = ui.mcPopup;
            if (!isGreedyModalInStack()){
                if (mc.currentLabel != "PVPPanel"){
                    clearPopups();
                    clearPopupsQ();
                    (mc.fData = {typ:typ});
                    (mc.visible = true);
                    mc.gotoAndPlay("PVPPanel");
                }
                else {
                    mc.onClose();
                };
            };
        }
        public function onRepBarMouseOut(e:MouseEvent){
            (MovieClip(e.currentTarget).strRep.visible = false);
        }
        public function isGreedyModalInStack():Boolean{
            var i:int;
            var child:MovieClip;
            i = 0;
            i = 0;
            while (i < ui.ModalStack.numChildren) {
                child = (ui.ModalStack.getChildAt(i) as MovieClip);
                child;
                if (((((("greedy" in child)) && (!((child.greedy == null))))) && ((child.greedy == true)))){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function multiSFCConnect():void{
            var o:Object;
            for each (var _local4 in sfcA) {
                o = _local4;
                _local4;
                trace(("MULTI connecting to:" + o.sIP));
                o.sfc.connect(o.sIP, serverPort);
            };
        }
        public function removeAuraEffect(e, o){
            switch (e.typ){
                case "+":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] - Number(e.val));
                    break;
                case "-":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] + Number(e.val));
                    break;
                case "*":
                    o[("$" + e.sta)] = Math.round((o[("$" + e.sta)] / Number(e.val)));
            };
        }
        public function areaListGet():void{
            var ul:Object;
            var userList:Object;
            var i:String;
            var tuoLeaf:*;
            ul = {};
            userList = sfc.getRoom(world.curRoom).getUserList();
            for (var _local7 in userList) {
                i = _local7;
                _local7;
                tuoLeaf = world.uoTree[userList[i].getName()];
                if (tuoLeaf != null){
                    (ul[i] = {
                        strUsername:tuoLeaf.strUsername,
                        intLevel:tuoLeaf.intLevel
                    });
                };
            };
            areaListShow(ul);
        }
        private function onLoginMASComplete(event:Event):void{
            trace(("LoginComplete:" + event.target.data));
            loginLoader.removeEventListener(Event.COMPLETE, onLoginMASComplete);
            (objLogin = convertXMLtoObject(new XML(event.target.data)));
            if (objLogin.bSuccess == 1){
                login(loginInfo.strUsername, loginInfo.strPassword);
            }
            else {
                mcConnDetail.showError(objLogin.sMsg);
            };
        }
        public function cleanDropStack():void{
            var itemA:MovieClip;
            var itemB:MovieClip;
            var i:*;
            itemA = null;
            itemB = null;
            i = (ui.dropStack.numChildren - 2);
            while (i > -1) {
                itemA = (ui.dropStack.getChildAt(i) as MovieClip);
                itemA;
                itemB = (ui.dropStack.getChildAt((i + 1)) as MovieClip);
                itemB;
                (itemA.fY = (itemA.y = (itemB.fY - (itemB.fHeight + 8))));
                i--;
            };
        }
        public function updateAreaName():void{
            var strAreaText:String;
            strAreaText = (String(world.areaUsers.length) + " player");
            if (world.areaUsers.length > 1){
                strAreaText = (strAreaText + "s");
                strAreaText;
            };
            strAreaText = (strAreaText + " in <font color ='#00FFFF'>");
            strAreaText;
            if (world.strAreaName.indexOf(":") > -1){
                strAreaText = (strAreaText + (world.strAreaName.split(":")[0] + " (party)"));
                strAreaText;
            }
            else {
                strAreaText = (strAreaText + world.strAreaName);
                strAreaText;
            };
            strAreaText = (strAreaText + "</font>");
            strAreaText;
            (ui.mcInterface.areaList.title.t1.htmlText = strAreaText);
        }
        public function getServerTime():Date{
            var date_now:Date;
            var ts:*;
            date_now = new Date();
            ts = (ts_login_server + (date_now.getTime() - ts_login_client));
            return (new Date(ts));
        }
        private function loadSoundAsset():void{
            var l:Loader;
            var u:*;
            l = new Loader();
            u = new URLRequest((serverFilePath + "assets/SHQ_SoundFX_05062011.swf"));
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, onSoundAssetLoaded, false, 0, true);
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onSoundLoadError, false, 0, true);
            l.load(u, new LoaderContext(false, ApplicationDomain.currentDomain));
        }
        public function talk(params){
            if (params.accept){
                chatF.submitMsg(params.emote1, "emote", sfc.myUserName);
            }
            else {
                chatF.submitMsg(params.emote2, "emote", sfc.myUserName);
            };
        }
        public function updateActionObjIcon(actionObj:Object):void{
            var actIcons:Array;
            var icon1:MovieClip;
            var item:Object;
            var j:*;
            var iQty:int;
            var i:int;
            actIcons = world.getActIcons(actionObj);
            j = 0;
            while (j < actIcons.length) {
                icon1 = actIcons[j];
                item = icon1.item;
                if (item != null){
                    iQty = 0;
                    while (i < world.items.length) {
                        if (world.items[i].ItemID == item.ItemID){
                            iQty = int(world.items[i].iQty);
                        };
                        i++;
                    };
                    if (iQty > 0){
                        icon1.tQty.visible = true;
                        icon1.tQty.text = iQty;
                    }
                    else {
                        world.unequipUseableItem(item);
                    };
                };
                j++;
            };
        }
        private function onUserFocus(event:FocusEvent){
            if (mcLogin.ni.text == "click here"){
                (mcLogin.ni.text = "");
            };
        }
        public function clamp(val:Number, mn:Number, mx:Number):Number{
            if (val < mn){
                return (mn);
            };
            if (val > mx){
                return (mx);
            };
            return (val);
        }
        public function getIconBySlot(slot:String):String{
            var iconStr:String;
            iconStr = "";
            switch (slot.toLowerCase()){
                case "weapon":
                    iconStr = "iwsword";
                    break;
                case "back":
                case "ba":
                    iconStr = "iicape";
                    break;
                case "head":
                case "he":
                    iconStr = "iihelm";
                    break;
                case "armor":
                case "ar":
                    iconStr = "iiclass";
                    break;
                case "class":
                    iconStr = "iiclass";
                    break;
                case "pet":
                case "pe":
                    iconStr = "iipet";
                    break;
                default:
                    iconStr = "iibag";
            };
            return (iconStr);
        }
        public function resetHaldroidApp(){
            (haldroidApp = null);
        }
        public function addUpdate(str:String, isBad:Boolean=false):void{
            var mcu:MovieClip;
            var uClass:*;
            var mc:MovieClip;
            var i:int;
            mcu = ui.mcUpdates;
            uClass = (mcu.uproto.constructor as Class);
            mc = (mcu.addChildAt(new (uClass)(), 1) as MovieClip);
            (mc.y = 0);
            (mc.x = mcu.uproto.x);
            (mc.t1.ti.text = str);
            if (isBad){
                (mc.t1.ti.textColor = 0xFF0000);
            };
            mc.gotoAndPlay("in");
            i = 2;
            if (mcu.numChildren > 2){
                i = 2;
                while (i < mcu.numChildren) {
                    if (i < 4){
                        (mcu.getChildAt(i).y = (mcu.getChildAt(i).y - 18));
                    }
                    else {
                        MovieClip(mcu.getChildAt(i)).stop();
                        mcu.removeChildAt(i);
                        i--;
                    };
                    i++;
                };
            };
        }
        public function showPointsUI():void{
            ui.mcPopup.fOpen("Points");
        }
        public function serialCmdInit(cmd:String):void{
            var sl:*;
            var cmdBar:*;
            trace("serialCmdInit >");
            sl = mcLogin.il;
            cmdBar = sl.cmd;
            (cmdBar.btnGo.visible = false);
            (serialCmd.si = 0);
            (serialCmd.cmd = cmd);
            (serialCmd.active = true);
            serialCmdNext();
        }
        function getIBudget(lvl:int, iRty:int):int{
            var b:int;
            if (lvl < 1){
                lvl = 1;
            };
            if (lvl > intLevelCap){
                lvl = intLevelCap;
            };
            if (iRty < 1){
                iRty = 1;
            };
            lvl = Math.round(((lvl + iRty) - 1));
            b = Math.round((GstBase + (Math.pow(((lvl - 1) / (intLevelCap - 1)), statsExponent) * (GstGoal - GstBase))));
            return (b);
        }
        private function onTargetPortraitCloseClick(evt:MouseEvent):void{
            world.cancelTarget();
        }
        public function clearPopupsQ():void{
            if (((!((ui.mcPopup.currentLabel == "House"))) && (!((ui.mcPopup.currentLabel == "HouseShop"))))){
                ui.mcPopup.onClose();
            };
        }
        function traceObject(obj, n=1){
            var s:*;
            var i:*;
            var v:*;
            s = "";
            while (s.length < n) {
                s = (s + " ");
            };
            n++;
            if ((((typeof(obj) == "object")) && (!((obj.length == null))))){
                i = 0;
                while (i < obj.length) {
                    trace((((s + i) + ": ") + obj[i]));
                    i++;
                };
            }
            else {
                for (v in obj) {
                    trace((((s + v) + ": ") + obj[v]));
                    if (typeof(obj[v]) == "object"){
                        traceObject(obj[v], n);
                    };
                };
            };
        }
        public function inituoPref():void{
            (uoPref.bCloak = true);
            (uoPref.bHelm = true);
            (uoPref.bPet = true);
            (uoPref.bWAnim = true);
            (uoPref.bGoto = true);
            (uoPref.bSoundOn = true);
            (uoPref.bMusicOn = true);
            (uoPref.bFriend = true);
            (uoPref.bParty = true);
            (uoPref.bGuild = true);
            (uoPref.bWhisper = true);
            (uoPref.bTT = true);
        }
        public function hidePVPScore():void{
            (ui.mcPVPScore.visible = false);
            (ui.mcPVPScore.y = -300);
        }
        private function showPortraitBox(avt:Avatar, mcPortraitBox:MovieClip){
            var AssetClass:Class;
            var mc:MovieClip;
            var child:DisplayObject;
            var bBackHair:Boolean;
            trace("showPortraitBox >");
            mc = (mcPortraitBox.mcHead as MovieClip);
            bBackHair = false;
            (mcPortraitBox.pAV = avt);
            if (avt.npcType == "monster"){
                AssetClass = loadermanager.getClass((avt.objData.strLinkage + "Head"));
                AssetClass;
                mc.head.face.removeChildAt(0);
                mc.head.face.addChild(new (AssetClass)());
                (mc.head.mcHair.visible = false);
                (mc.head.mcHelm.visible = false);
                (mc.head.mcScar.visible = false);
                (mc.head.mcMask.visible = false);
                (mc.backhair.visible = false);
                (mc.head.mcEyes.visible = false);
                (mc.head.mcNose.visible = false);
                (mc.head.mcMouth.visible = false);
            }
            else {
                AssetClass = (loadermanager.getClass(("DefaultHead" + avt.objData.strGender)) as Class);
                AssetClass;
                mc.head.face.removeChildAt(0);
                mc.head.face.addChild(new (AssetClass)());
                AssetClass = (loadermanager.getClass((this["arrEyes"][avt.objData.iEye] + avt.objData.strGender)) as Class);
                AssetClass;
                mc.head.mcEyes.removeChildAt(0);
                mc.head.mcEyes.addChild(new (AssetClass)());
                (mc.head.mcEyes.visible = true);
                AssetClass = (loadermanager.getClass(this.arrNose[avt.objData.iNose]) as Class);
                AssetClass;
                mc.head.mcNose.removeChildAt(0);
                mc.head.mcNose.addChild(new (AssetClass)());
                (mc.head.mcNose.visible = true);
                AssetClass = (loadermanager.getClass(this.arrMouth[avt.objData.iMouth]) as Class);
                AssetClass;
                mc.head.mcMouth.removeChildAt(0);
                mc.head.mcMouth.addChild(new (AssetClass)());
                (mc.head.mcMouth.visible = true);
                (mc.head.mcHelm.visible = false);
                AssetClass = (avt.pMC.mcChar.head.mcHair.getChildAt(0).constructor as Class);
                AssetClass;
                mc.head.mcHair.removeChildAt(0);
                mc.head.mcHair.addChild(new (AssetClass)());
                (mc.head.mcHair.visible = true);
                if (avt.pMC.mcChar.backhair.visible){
                    AssetClass = (avt.pMC.mcChar.backhair.getChildAt(0).constructor as Class);
                    AssetClass;
                    mc.backhair.removeChildAt(0);
                    mc.backhair.addChild(new (AssetClass)());
                    (mc.backhair.visible = true);
                }
                else {
                    (mc.backhair.visible = false);
                };
                if (avt.objData.eqp.ma == null){
                    (mc.head.mcMask.visible = false);
                }
                else {
                    AssetClass = (avt.pMC.mcChar.head.mcMask.getChildAt(0).constructor as Class);
                    AssetClass;
                    mc.head.mcMask.removeChildAt(0);
                    mc.head.mcMask.addChild(new (AssetClass)());
                    (mc.head.mcMask.visible = true);
                };
                if (avt.objData.eqp.sc == null){
                    (mc.head.mcScar.visible = false);
                }
                else {
                    AssetClass = (avt.pMC.mcChar.head.mcScar.getChildAt(0).constructor as Class);
                    AssetClass;
                    mc.head.mcScar.removeChildAt(0);
                    mc.head.mcScar.addChild(new (AssetClass)());
                    (mc.head.mcScar.visible = true);
                };
            };
            (mcPortraitBox.visible = true);
        }
        public function connectTo(strIP:String){
            trace(("connecting to:" + strIP));
            mixer.playSound("ClickBig");
            mcConnDetail.showConn("Connecting to game server...");
            if (sfc.isConnected){
                sfc.disconnect();
            };
            sfc.connect(strIP, serverPort);
            gotoAndPlay("Game");
        }
        public function setHaldroidState(strState:String=null){
            var mentorInd:*;
            mentorInd = world.getQuestValue(40);
            trace((strState + " - Called Haldroid on Root"));
            trace((mentorInd + " - mentor Index "));
            if (strState == null){
                if (mentorInd == 0){
                    ui.mcInterface.mcMenu.mcHal.gotoAndPlay("On");
                }
                else {
                    ui.mcInterface.mcMenu.mcHal.gotoAndStop("Off");
                };
            }
            else {
                if (strState == "On"){
                    ui.mcInterface.mcMenu.mcHal.gotoAndPlay(strState);
                }
                else {
                    ui.mcInterface.mcMenu.mcHal.gotoAndStop(strState);
                };
            };
        }
        public function key_StageLogin(e:KeyboardEvent){
            if (e.target == stage){
                if ((e.charCode == Keyboard.ENTER)){
                    stage.focus = mcLogin.ni;
                };
            };
        }
        public function init():void{
            (MsgBox.visible = false);
            readQueryString();
        }
        public function removePortraitStatus(sIcon:MovieClip){
            removePortraitStatusIcon(ui.mcPortraitTarget, sIcon);
        }
        private function onPageClick(event:MouseEvent):void{
            mixer.playSound("Click");
            navigateToURL(new URLRequest(("http://www.herosmash.com/hs-character.asp?id=" + objLogin.chars[objLogin.charindex].sName)), "_blank");
        }
        public function MCPVPQueueEF(e:Event):void{
            var now:Number;
            var mins:*;
            now = new Date().getTime();
            mins = Math.ceil(((((world.PVPQueue.avgWait * 1000) - (now - world.PVPQueue.ts)) / 1000) / 60));
            (ui.mcPVPQueue.t2.htmlText = (('<font color="#FFFFFF"' + mins) + '</font><font color="#999999"m</font>'));
            if (mins <= 1){
                (ui.mcPVPQueue.t2.htmlText = ("<" + ui.mcPVPQueue.t2.htmlText));
            };
        }
        public function showMap():void{
            (ui.mcInterface.mcMenu.mcMenuButtons.visible = true);
            ui.mcPopup.fOpen("Map");
        }
        private function initLoginWarning():void{
            var mc:MovieClip;
            var ts:Number;
            var lts:Number;
            var ldur:Number;
            mc = (mcLogin.warning as MovieClip);
            (mc.visible = true);
            (mc.alpha = 100);
            (mcLogin.t1.visible = false);
            (mcLogin.btnLogin.visible = false);
            (mcLogin.mcForgotPassword.visible = false);
            ts = new Date().getTime();
            lts = userPreference.data.logoutWarningTS;
            ldur = userPreference.data.logoutWarningDur;
            (mc.n = Math.round((((lts + (ldur * 1000)) - ts) / 1000)));
            (mc.ti.text = ((mc.s.split("$s")[0] + mc.n) + mc.s.split("$s")[1]));
            (mc.timer = new Timer(1000));
            mc.timer.addEventListener(TimerEvent.TIMER, loginWarningTimer, false, 0, true);
            mc.timer.start();
        }
        public function getFullStatName(s:String):String{
            var statName:String;
            statName = "";
            s = s.toLowerCase();
            if (s.indexOf("str") > -1){
                statName = "Strength";
            };
            if (s.indexOf("int") > -1){
                statName = "Intellect";
            };
            if (s.indexOf("dex") > -1){
                statName = "Dexterity";
            };
            if (s.indexOf("wis") > -1){
                statName = "Wisdom";
            };
            if (s.indexOf("end") > -1){
                statName = "Endurance";
            };
            if (s.indexOf("lck") > -1){
                statName = "Luck";
            };
            if (s.indexOf("tha") > -1){
                statName = "Haste";
            };
            if (s.indexOf("thi") > -1){
                statName = "Hit";
            };
            if (s.indexOf("tcr") > -1){
                statName = "Critcal Hit";
            };
            if (s.indexOf("tcm") > -1){
                statName = "Crit Value";
            };
            if (s.indexOf("tdo") > -1){
                statName = "Evasion";
            };
            return (statName);
        }
        public function showUpgradeWindow(tempObjData:Object=null):void{
            var mc:MovieClip;
            var objData:* = undefined;
            var renewDate:String;
            var txt:String;
            var tempObjData = tempObjData;
            (mcUpgradeWindow = new MCUpgradeWindow());
            mc = (mcUpgradeWindow as MovieClip);
            objData = (((tempObjData)!=null) ? tempObjData : world.myAvatar.objData);
            if (int(objData.iUpg) > 0){
                renewDate = (objData.dUpgExp.toDateString() + ".");
                txt = "Renew your account to get full access to Herosmash! Your membership will enable chat and give you access to exclusive areas, weapons, armors, super-powers and more.";
                var _local3 = (txt + (('<font color="#F6E565">Your Membership expired on ' + renewDate) + "</font>"));
                txt = _local3;
                _local3;
                (mc.txtBody.htmlText = txt);
            }
            else {
                (mc.txtBody.htmlText = "Become a VIP member and get full access to Herosmash! Your membership will enable chat and give you access to exclusive areas, weapons, armors, super-powers and more.");
            };
            mc.btnClose.addEventListener(MouseEvent.CLICK, hideUpgradeWindow, false, 0, true);
            mc.btnBuy.addEventListener(MouseEvent.CLICK, onUpgradeClick, false, 0, true);
            addChild(mcUpgradeWindow);
            try {
                (ui.mouseChildren = false);
                (world.mouseChildren = false);
            }
            catch(e:Error) {
            };
            try {
                (mcLogin.sl.mouseChildren = false);
            }
            catch(e:Error) {
            };
        }
        private function removePortraitStatusIcon(mcPortraitBox:MovieClip, statusIcon:MovieClip):void{
            var statusBox:MovieClip;
            var sIcon:* = undefined;
            var i:* = undefined;
            var sLastIcon:* = undefined;
            var posX:* = undefined;
            var mcPortraitBox:MovieClip = mcPortraitBox;
            var statusIcon:MovieClip = statusIcon;
            if (mcPortraitBox != null){
                statusBox = mcPortraitBox.pStatus;
                try {
                    statusBox.removeChild(statusIcon);
                }
                catch(e:Error) {
                    trace(e);
                };
                if (statusBox.numChildren > 0){
                    sIcon = statusBox.getChildAt(0);
                    (sIcon.x = 0);
                    i = 1;
                    while (i < statusBox.numChildren) {
                        var _local4 = statusBox.getChildAt(i);
                        sIcon = _local4;
                        _local4;
                        sLastIcon = statusBox.getChildAt((i - 1));
                        posX = ((sLastIcon.x * sLastIcon.width) + 5);
                        (sIcon.x = posX);
                        i = (i + 1);
                    };
                };
            };
        }
        public function loginMAS(strUsername:String, strPassword:String){
            var url:String;
            var request:URLRequest;
            var variables:URLVariables;
            var strUsername:String = strUsername;
            var strPassword:String = strPassword;
            mcConnDetail.showConn("Authenticating Account Info...");
            url = ("cf-userlogin-MAS.asp?ran=" + Math.random());
            if (this.loaderInfo.url.toLowerCase().indexOf("battleon.com") == -1){
                var _local4 = ("http://herosmash.battleon.com/game/" + url);
                url = _local4;
                _local4;
            }
            else {
                _local4 = (params.sURL + url);
                url = _local4;
                _local4;
            };
            trace(("loader: " + this.loaderInfo.url));
            trace(("url: " + url));
            request = new URLRequest(url);
            variables = new URLVariables();
            (variables.strUsername = strUsername);
            (variables.strPassword = strPassword);
            trace(("Sending: " + variables));
            (request.data = variables);
            (request.method = URLRequestMethod.POST);
            loginLoader.removeEventListener(Event.COMPLETE, onLoginMASComplete);
            loginLoader.addEventListener(Event.COMPLETE, onLoginMASComplete);
            loginLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoginMASError, false, 0, true);
            try {
                loginLoader.load(request);
            }
            catch(error:Error) {
                trace("Unable to load URL");
            };
        }
        public function multiSFCLogin(strPassword:String):void{
            var o:Object;
            for each (var _local5 in sfcA) {
                o = _local5;
                _local5;
                trace(("MULTI logging in for:" + o.sLogin));
                (o.sPass = strPassword);
                o.login();
            };
        }
        private function resizeStatusIcons(sIcon:MovieClip){
            var newPixleSize:Number;
            var newPercent:Number;
            newPixleSize = 20;
            if (sIcon.width > sIcon.height){
                newPercent = (newPixleSize / sIcon.width);
                newPercent;
            }
            else {
                newPercent = (newPixleSize / sIcon.height);
                newPercent;
            };
            (sIcon.scaleX = newPercent);
            (sIcon.scaleY = newPercent);
        }
        public function doAnim(anim:Object):void{
            var i:int;
            var anims:Array;
            var animIndex:uint;
            var animStr:String;
            var pMC:MovieClip;
            var cLeaf:Object;
            var tLeaf:Object;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var tAvt:Avatar;
            var cAvt:Avatar;
            var tAvts:Array;
            var tInfA:Array;
            var strF:String;
            var cReg:Point;
            var tReg:Point;
            var aura:Object;
            var buffer:* = undefined;
            var xBuffer:* = undefined;
            var yBuffer:* = undefined;
            var anim:Object = anim;
            i = 0;
            cTyp = "";
            cID = -1;
            tTyp = "";
            tID = -1;
            tAvts = [];
            tInfA = [];
            strF = "";
            cAvt = null;
            tAvt = null;
            cReg = new Point(0, 0);
            tReg = new Point(0, 0);
            if (((!((anim.cInf == null))) && (!((anim.tInf == null))))){
                cTyp = String(anim.cInf.split(":")[0]);
                cID = int(anim.cInf.split(":")[1]);
                switch (cTyp){
                    case "p":
                        cAvt = world.getAvatarByUserID(cID);
                        cLeaf = world.getUoLeafById(cID);
                        break;
                    case "m":
                        cAvt = world.getMonster(cID);
                        cLeaf = world.monTree[cID];
                        if (anim.msg != null){
                            if (anim.msg.indexOf("<mon>") > -1){
                                anim.msg = anim.msg.split("<mon>").join(cAvt.objData.strMonName);
                            };
                            addUpdate(anim.msg);
                        };
                        break;
                };
                tInfA = anim.tInf.split(",");
                i = 0;
                while (i < tInfA.length) {
                    tTyp = String(tInfA[i].split(":")[0]);
                    tID = int(tInfA[i].split(":")[1]);
                    switch (tTyp){
                        case "p":
                            tAvt = world.getAvatarByUserID(tID);
                            tLeaf = world.getUoLeafById(tID);
                            break;
                        case "m":
                            tAvt = world.getMonster(tID);
                            tLeaf = world.monTree[tID];
                            break;
                    };
                    tAvts.push(tAvt);
                    i = (i + 1);
                };
                if (tAvts[0] != null){
                    tAvt = tAvts[0];
                };
                if (tAvt != null){
                    tLeaf = tAvt.dataLeaf;
                };
                if (((((((((((!((cAvt == null))) && (!((cAvt.pMC == null))))) && (!((tAvt == null))))) && (!((tAvt.pMC == null))))) && (!((cLeaf == null))))) && (!((tLeaf == null))))){
                    aura = {};
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
                            trace(("doAnim > " + e));
                        };
                    };
                    animStr = anim.animStr;
                    switch (cTyp){
                        case "p":
                            if (cAvt.objData != null){
                                if (cAvt != world.myAvatar){
                                    cAvt.target = tAvt;
                                };
                                strF = String(cLeaf.strFrame);
                                if (((((!((strF == null))) && ((strF == world.strFrame)))) && ((cLeaf.intState > 0)))){
                                    if (cAvt != tAvt){
                                        if ((tAvt.pMC.x - cAvt.pMC.x) >= 0){
                                            cAvt.pMC.turn("right");
                                        }
                                        else {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (anim.strl != null){
                                        cAvt.pMC.spFX.strl = anim.strl;
                                    };
                                    if (anim.fx != null){
                                        cAvt.pMC.spFX.fx = anim.fx;
                                    };
                                    if (tAvts != null){
                                        cAvt.pMC.spFX.avts = tAvts;
                                        anim.tAvts = tAvts;
                                    };
                                    if (animStr.indexOf(",") > -1){
                                        animStr = animStr.split(",")[Math.floor((Math.random() * animStr.split(",").length))];
                                    };
                                    if (((!((animStr == "Thrash"))) || (!((cAvt.pMC.mcChar.currentLabel == "Thrash"))))){
                                        cAvt.pMC.queueAnim(anim);
                                    };
                                };
                            };
                            break;
                        case "m":
                            if (cAvt.objData != null){
                                if (cAvt != world.myAvatar){
                                    cAvt.target = tAvt;
                                };
                                strF = String(cLeaf.strFrame);
                                cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                cReg = world.CHARS.globalToLocal(cReg);
                                tReg = world.CHARS.globalToLocal(tReg);
                                if (((((!((strF == null))) && ((strF == world.strFrame)))) && ((cLeaf.intState > 0)))){
                                    if (cAvt != tAvt){
                                        if ((tReg.x - cReg.x) >= 0){
                                            cAvt.pMC.turn("right");
                                        }
                                        else {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (((((((!((anim.fx == "p"))) && (!((anim.fx == "w"))))) && (!((anim.fx == ""))))) && ((((distanceO(cAvt.pMC, tAvt.pMC) > (200 * world.SCALE))) || ((distanceO(cAvt.pMC, tAvt.pMC) < 49)))))){
                                        buffer = int((150 + (Math.random() * 20)));
                                        xBuffer = ((((tReg.x - cReg.x))>=0) ? -(buffer) : buffer);
                                        xBuffer = int((xBuffer * world.SCALE));
                                        trace(xBuffer);
                                        if (((((tReg.x + xBuffer) < 0)) || (((tReg.x + xBuffer) > world.map.cell.walk.width)))){
                                            xBuffer = (xBuffer * -1);
                                        };
                                        buffer = int(((Math.random() * 30) - 15));
                                        yBuffer = (((Math.abs((cAvt.pMC.y - tAvt.pMC.y)) > 15)) ? ((((tAvt.pMC.y - cAvt.pMC.y) >= 0)) ? -(buffer) : buffer) : 0);
                                        yBuffer = int((yBuffer * (world.SCALE * 0.7)));
                                        cAvt.pMC.walkTo((tAvt.pMC.x + xBuffer), (tAvt.pMC.y + yBuffer), 32);
                                    };
                                    if (cAvt.pMC.spFX != null){
                                        cAvt.pMC.spFX.avt = cAvt.target;
                                    };
                                    cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    if (cAvt != tAvt){
                                        if ((tReg.x - cReg.x) >= 0){
                                            cAvt.pMC.turn("right");
                                        }
                                        else {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (animStr.length > 1){
                                        if (animStr.indexOf(",") > -1){
                                            anims = animStr.split(",");
                                            animIndex = Math.round((Math.random() * (anims.length - 1)));
                                            MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(anims[animIndex]);
                                        }
                                        else {
                                            MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animStr);
                                        };
                                    };
                                };
                            };
                            break;
                    };
                };
            };
        }
        public function getDisplaysType(item:Object){
            var s:String;
            var t:String;
            s = (((item.sType)!=null) ? item.sType : "Unknown");
            t = s.toLowerCase();
            if ((((t == "clientuse")) || ((t == "serveruse")))){
                s = "Item";
            };
            return (s);
        }
        public function copyObj(obj:Object):Object{
            var objB:ByteArray;
            objB = new ByteArray();
            objB.writeObject(obj);
            objB.position = 0;
            return (objB.readObject());
        }
        public function isMergeShop(shopInfo:Object):Boolean{
            var item:Object;
            for each (item in shopInfo.items) {
                if (("turnin" in item)){
                    return (true);
                };
            };
            return (false);
        }
        public function FB_showFeedDialog(header:String, job:String, image:String):void{
            if (params.strSourceID == "FACEBOOK"){
                ExternalInterface.call("showFeedDialog", header, job, image);
            };
        }
        public function get date_server():Date{
            return (getServerTime());
        }
        public function copyConstructor(obj){
            var objB:ByteArray;
            objB = new ByteArray();
            objB.writeObject(obj);
            objB.position = 0;
            return ((objB.readObject() as Class));
        }
        public function showServerList():void{
            sfc.disconnect();
            login(loginInfo.strUsername, loginInfo.strPassword);
        }
        public function max(num1:int, num2:int):int{
            if (num1 > num2){
                return (num1);
            };
            return (num2);
        }
        public function Decrypt(theText:String):String{
            var output:*;
            var i:*;
            var nTextLength:*;
            var v1:*;
            var v2:*;
            output = new String();
            nTextLength = theText.length;
            i = 0;
            while (i < nTextLength) {
                v1 = parseInt(theText.substr(i, 2), 27);
                v2 = parseInt(theText.substr((i + 2), 2), 27);
                output = (output + String.fromCharCode((v1 - v2)));
                i = (i + 4);
            };
            return (output);
        }
        public function stripWhiteStrictB(str:String):String{
            var i:int;
            str = stripWhite(str);
            i = 0;
            while (i < chatF.strictComparisonCharsB.length) {
                str = str.split(chatF.strictComparisonCharsB.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }
        public function showPortraitTarget(avt:Avatar){
            showPortraitBox(avt, ui.mcPortraitTarget);
            (ui.mcPortraitTarget.pvpIcon.visible = world.bPvP);
            world.updatePortrait(avt);
            (ui.btnTargetPortraitClose.visible = true);
        }
        public function updatePVPScore(a:Array):void{
            var o:Object;
            var mc:MovieClip;
            var i:int;
            var dx:int;
            o = {};
            i = 0;
            while (i < a.length) {
                o = a[i];
                o;
                mc = (ui.mcPVPScore.getChildByName(("bar" + i)) as MovieClip);
                mc;
                if (mc != null){
                    (mc.ti.text = (o.v + "/1000"));
                    dx = int(((o.v / 1000) * mc.bar.width));
                    dx = Math.max(Math.min(dx, mc.bar.width), 0);
                    dx;
                    (mc.bar.x = (-(mc.bar.width) + dx));
                };
                i++;
            };
        }
        public function isItemEnhanceable(item:Object):Boolean{
            return ((["Weapon", "he", "ba", "pe", "ar"].indexOf(item.sES) >= 0));
        }
        public function areaListClick(e:MouseEvent):void{
            var mc:*;
            mc = MovieClip(e.currentTarget.parent.parent);
            switch (mc.currentLabel){
                case "init":
                    mc.gotoAndPlay("in");
                    break;
                case "hold":
                    mc.gotoAndPlay("out");
                    break;
            };
        }
        public function drawChainsSmooth(entities:Array, c:int, spfxMC:MovieClip):void{
            var pSrc:Point;
            var pTgt:Point;
            var ei:int;
            var steps:Array;
            var i:int;
            var j:int;
            var n:int;
            var p:Point;
            var fxArr:Array;
            var mc:MovieClip;
            var sign:int;
            var b:int;
            ei = 1;
            while (ei < entities.length) {
                pSrc = new Point(0, 0);
                pTgt = new Point(0, 0);
                pSrc = entities[(ei - 1)].localToGlobal(pSrc);
                pTgt = entities[ei].localToGlobal(pTgt);
                steps = [];
                i = 0;
                j = 0;
                n = Math.ceil((Point.distance(pSrc, pTgt) / c));
                if ((n % 2) == 1){
                    n = (n + 1);
                };
                p = new Point();
                fxArr = [spfxMC.fx0, spfxMC.fx1, spfxMC.fx2];
                sign = -1;
                i = 0;
                while (i < fxArr.length) {
                    steps = [];
                    sign = (((Math.random())>0.5) ? 1 : -1);
                    b = 0;
                    j = 1;
                    while (j < n) {
                        p = Point.interpolate(pSrc, pTgt, (1 - (j / n)));
                        ++b;
                        if ((b % 2) == 1){
                            p.x = (p.x + (sign * Math.round((Math.random() * 30))));
                            p.y = (p.y + (sign * Math.round((Math.random() * 30))));
                            sign = -(sign);
                        };
                        steps.push(p);
                        j++;
                    };
                    steps.push(pTgt);
                    mc = fxArr[i];
                    mc.graphics.lineStyle(2, 0xFFFFFF, 1);
                    mc.graphics.moveTo(pSrc.x, pSrc.y);
                    j = 0;
                    while (j < steps.length) {
                        mc.graphics.curveTo(steps[j].x, steps[j].y, steps[(j + 1)].x, steps[(j + 1)].y);
                        j = (j + 2);
                    };
                    i++;
                };
                ei++;
            };
        }
        public function modColor(col, amt, op){
            var out:*;
            var a:*;
            var b:*;
            var c:*;
            var i:*;
            out = "";
            i = 0;
            while (i < 3) {
                a = hexDec(col.substr((i * 2), 2));
                b = hexDec(amt.substr((i * 2), 2));
                switch (op){
                    case "-":
                    default:
                        c = (a - b);
                        if (c < 0){
                            c = 0;
                        };
                        c = decHex(c);
                        break;
                    case "+":
                        c = (a + b);
                        if (c > 0xFF){
                            c = 0xFF;
                        };
                        c = decHex(c);
                };
                out = (out + String((((c.length)<2) ? ("0" + c) : c)));
                i++;
            };
            return (out);
        }
        public function logout():void{
            if (sfc.isConnected){
                sfc.disconnect();
            };
            (loginInfo = new Object());
            gotoAndStop("Login");
        }
        private function loadUserPreference(){
            if (userPreference.data.bitCheckedUsername){
                (mcLogin.ni.text = userPreference.data.strUsername);
                (mcLogin.chkUserName.bitChecked = true);
            };
            if (userPreference.data.bitCheckedPassword){
                (mcLogin.pi.text = userPreference.data.strPassword);
                (mcLogin.chkPassword.bitChecked = true);
            };
            (mcLogin.chkUserName.checkmark.visible = mcLogin.chkUserName.bitChecked);
            (mcLogin.chkPassword.checkmark.visible = mcLogin.chkPassword.bitChecked);
            (userPreference.data.bSoundOn = (((userPreference.data.bSoundOn)==null) ? true : Boolean(userPreference.data.bSoundOn)));
        }
        private function changeColor(mc:MovieClip, intColor:Number, strShade:String, op:String=""):void{
            var newCT:ColorTransform;
            newCT = new ColorTransform();
            if (op == ""){
                (newCT.color = intColor);
            };
            switch (strShade.toUpperCase()){
                case "LIPS":
                    (newCT.redOffset = (newCT.redOffset - 15));
                    (newCT.greenOffset = (newCT.greenOffset - 86));
                    (newCT.blueOffset = (newCT.blueOffset - 66));
                    break;
                case "LIGHT":
                    (newCT.redOffset = (newCT.redOffset + 100));
                    (newCT.greenOffset = (newCT.greenOffset + 100));
                    (newCT.blueOffset = (newCT.blueOffset + 100));
                    break;
                case "DARK":
                    (newCT.redOffset = (newCT.redOffset - 50));
                    (newCT.greenOffset = (newCT.greenOffset - 50));
                    (newCT.blueOffset = (newCT.blueOffset - 50));
                    break;
                case "DARKER":
                    (newCT.redOffset = (newCT.redOffset - 125));
                    (newCT.greenOffset = (newCT.greenOffset - 125));
                    (newCT.blueOffset = (newCT.blueOffset - 125));
                    break;
            };
            if (op == "-"){
                (newCT.redOffset = (newCT.redOffset * -1));
                (newCT.greenOffset = (newCT.greenOffset * -1));
                (newCT.blueOffset = (newCT.blueOffset * -1));
            };
            if ((((((op == "")) && (!((mc.transform.colorTransform.color == newCT.color))))) || (!((mc.transform.colorTransform.redOffset == newCT.redOffset))))){
                (mc.transform.colorTransform = newCT);
            };
        }
        private function selectCharacter(charindex:int):void{
            (mcLogin.mcDeleteConfirm.visible = false);
            if (objLogin.charindex >= 0){
                mcLogin[("mcCharacter" + objLogin.charindex)].gotoAndStop("On");
            };
            (objLogin.charindex = charindex);
            if (charindex == -1){
                if (objLogin.iAccess < 30){
                    if ((((((objLogin.chars.length == 1)) && (!((objLogin.iEmailStatus == 5))))) && ((objLogin.iUpg <= 0)))){
                        MsgBox.notify("To unlock this character slot, you must verify your email address.");
                        return;
                    };
                    if ((((objLogin.chars.length == 2)) && ((objLogin.iUpg <= 0)))){
                        MsgBox.notify("To unlock this character slot, you must support the game with a membership or coin purchase.");
                        return;
                    };
                };
                mcLogin.gotoAndPlay("CharNew");
            }
            else {
                mcLogin[("mcCharacter" + charindex)].gotoAndStop("Light");
                (objLogin.charID = objLogin.chars[charindex].charID);
                mcLogin.btnPlay.gotoAndStop("On");
                mcLogin.pMC.gotoAndPlay("hold");
                (mcLogin.pMC.pAV = new Avatar());
                (mcLogin.pMC.pAV.objData = objLogin.chars[charindex]);
                (mcLogin.pMC.rootClass = this);
                mcLogin.pMC.init();
            };
        }
        public function resetInvTreeByItemID(ItemID:int){
            var item:Object;
            var ItemID:int = ItemID;
            try {
                item = world.invTree[ItemID];
                if (("EnhID" in item)){
                    item.EnhID = -1;
                };
                if (("EnhRty" in item)){
                    item.EnhRty = -1;
                };
                if (("EnhDPS" in item)){
                    item.EnhDPS = -1;
                };
                if (("EnhRng" in item)){
                    item.EnhRng = -1;
                };
                if (("EnhLvl" in item)){
                    item.EnhLvl = -1;
                };
                if (("EnhPatternID" in item)){
                    item.EnhPatternID = -1;
                };
            }
            catch(e:Error) {
                trace(e);
            };
        }
        public function onRepBarMouseOver(e:MouseEvent){
            (MovieClip(e.currentTarget).strRep.visible = true);
        }
        public function distanceXY(ax, ay, bx, by):Object{
            return ({
                dx:(bx - ax),
                dy:(by - ay)
            });
        }
        public function clearUpdates():void{
            var mcu:MovieClip;
            mcu = ui.mcUpdates;
            while (mcu.numChildren > 1) {
                mcu.removeChildAt(1);
            };
        }
        public function showExternalPaymentOptions():void{
            if (objLogin != null){
                ExternalInterface.call("upgradeNow", objLogin.userid, objLogin.sToken, "membership");
            };
        }
        public function stripDuplicateVowels(s:String):String{
            s = s.replace(chatF.regExpA, "a");
            s = s.replace(chatF.regExpE, "e");
            s = s.replace(chatF.regExpI, "i");
            s = s.replace(chatF.regExpO, "o");
            s = s.replace(chatF.regExpU, "u");
            s = s.replace(chatF.regExpSPACE, " ");
            return (s);
        }
        public function resetTableValues(o:Object):void{
            o._ap = 0;
            o.$ap = 0;
            o._sp = 0;
            o.$sp = 0;
            o._tbl = 0;
            o._tpa = 0;
            o._tdo = 0;
            o._tcr = 0;
            o._thi = 0;
            o._tha = 0;
            o._tre = 0;
            o.$tbl = baseBlock;
            o.$tpa = baseParry;
            o.$tdo = baseDodge;
            o.$tcr = baseCrit;
            o.$thi = baseHit;
            o.$tha = baseHaste;
            o.$tre = baseResist;
            o._cpo = 1;
            o._cpi = 1;
            o._cao = 1;
            o._cai = 1;
            o._cmo = 1;
            o._cmi = 1;
            o._cdo = 1;
            o._cdi = 1;
            o._cho = 1;
            o._chi = 1;
            o._cmc = 1;
            o.$cpo = 1;
            o.$cpi = 1;
            o.$cao = 1;
            o.$cai = 1;
            o.$cmo = 1;
            o.$cmi = 1;
            o.$cdo = 1;
            o.$cdi = 1;
            o.$cho = 1;
            o.$chi = 1;
            o.$cmc = 1;
            o._scm = baseCritValue;
            o._sbm = baseBlockValue;
            o._srm = baseResistValue;
            o._sem = baseEventValue;
            o.$scm = baseCritValue;
            o.$sbm = baseBlockValue;
            o.$srm = baseResistValue;
            o.$sem = baseEventValue;
            o._shb = 0;
            o._smb = 0;
            o.$shb = 0;
            o.$smb = 0;
        }
        public function isValidEmail(email:String):Boolean{
            return (Boolean(email.match(EMAIL_REGEX)));
        }
        private function onGameAssetsLoadError(e:Event):void{
            trace("*** Game Assets could not be loaded ***");
        }
        public function showPortrait(avt:Avatar){
            trace("Show Portrait");
            showPortraitBox(avt, ui.mcPortrait);
            world.updatePortrait(avt);
        }
        public function numToStr(n:Number, decimals:int=2):String{
            var s:String;
            var a:Array;
            s = n.toString();
            if (s.indexOf(".") == -1){
                s = (s + ".");
            };
            a = s.split(".");
            while (a[1].length < decimals) {
                a[1] = (a[1] + "0");
            };
            if (a[1].length > decimals){
                a[1] = a[1].substr(0, decimals);
            };
            if (decimals > 0){
                s = ((a[0] + ".") + a[1]);
            }
            else {
                s = a[0];
            };
            return (s);
        }
        function saveUserPreference(){
            (userPreference.data.bitCheckedUsername = mcLogin.chkUserName.bitChecked);
            (userPreference.data.bitCheckedPassword = mcLogin.chkPassword.bitChecked);
            if (mcLogin.chkUserName.bitChecked){
                (userPreference.data.strUsername = mcLogin.ni.text);
            }
            else {
                (userPreference.data.strUsername = "");
            };
            if (mcLogin.chkPassword.bitChecked){
                (userPreference.data.strPassword = mcLogin.pi.text);
            }
            else {
                (userPreference.data.strPassword = "");
            };
            userPreference.flush();
        }
        public function loadExternalSWF(strFilename:String):void{
            if (strFilename.indexOf("http://") == -1){
                strFilename = ("maps/" + strFilename);
                strFilename;
            };
            ldrMC.loadFile(mcExtSWF, strFilename, "Game Files");
            hideInterface();
            (world.visible = false);
        }
        public function convertBubbleText(str:String):String{
            var s:String;
            s = world.myAvatar.objData.strUsername;
            if (str.indexOf("@name")){
                str = str.split("@name").join(s);
            };
            s = String(world.myAvatar.objData.intLevel);
            if (str.indexOf("@level")){
                str = str.split("@level").join(s);
            };
            s = world.myAvatar.objData.strClassName;
            if (str.indexOf("@class")){
                str = str.split("@class").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "Mr." : "Mrs.");
            if (str.indexOf("@prefix")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "He" : "She");
            if (str.indexOf("@He")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "Him" : "Her");
            if (str.indexOf("@Him")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "His" : "Her");
            if (str.indexOf("@His")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "he" : "she");
            if (str.indexOf("@he")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "him" : "her");
            if (str.indexOf("@him")){
                str = str.split("@prefix").join(s);
            };
            s = (((world.myAvatar.objData.strGender.toLowerCase())=="m") ? "his" : "her");
            if (str.indexOf("@his")){
                str = str.split("@prefix").join(s);
            };
            return (str);
        }
        public function clearPopups(exemptLabels:Array=null):void{
            if (ui.mcPopup.currentLabel == "House"){
                ui.mcPopup.mcHouseMenu.hideItemHandle();
            };
            if ((((exemptLabels == null)) || ((exemptLabels.indexOf(ui.mcPopup.currentLabel) < 0)))){
                ui.mcPopup.onClose();
            };
            world.removeMovieFront();
            clearModalStack();
        }
        public function key_ChatEntry(e:KeyboardEvent){
            if (e.charCode == Keyboard.ENTER){
                chatF.submitMsg(ui.mcInterface.te.text, chatF.chn.cur.typ, chatF.pmNm);
            };
            if (e.charCode == Keyboard.ESCAPE){
                chatF.closeMsgEntry();
            };
        }
        public function attachOnModalStack(strLinkage:String):MovieClip{
            var mc:MovieClip;
            var AssetClass:Class;
            var addOK:*;
            var tempClass:*;
            AssetClass = (world.getClass(strLinkage) as Class);
            addOK = true;
            if (ui.ModalStack.numChildren){
                mc = MovieClip(ui.ModalStack.getChildAt(0));
                mc;
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass){
                    addOK = false;
                    addOK;
                };
            };
            if (addOK){
                clearModalStack();
                mc = MovieClip(ui.ModalStack.addChild(new (AssetClass)()));
                mc;
                (ui.ModalStack.mouseChildren = true);
            };
            return (mc);
        }
        public function getIconByType(sType:String):String{
            var iconStr:String;
            iconStr = "";
            switch (sType.toLowerCase()){
                case "axe":
                case "bow":
                case "dagger":
                case "gun":
                case "mace":
                case "polearm":
                case "staff":
                case "sword":
                case "wand":
                case "armor":
                    iconStr = ("iw" + sType.toLowerCase());
                    break;
                case "cape":
                case "helm":
                case "pet":
                case "class":
                    iconStr = ("ii" + sType.toLowerCase());
                    break;
                default:
                    iconStr = "iibag";
            };
            return (iconStr);
        }
        public function strSetCharAt(str:String, index:int, strChar:String):String{
            return (((str.substring(0, index) + strChar) + str.substring((index + 1), str.length)));
        }
        public function clearModalStack():Boolean{
            var i:int;
            if (isGreedyModalInStack()){
                return (false);
            };
            i = 0;
            while ((((ui.ModalStack.numChildren > 0)) && ((i < 100)))) {
                i++;
                ui.ModalStack.removeChildAt(0);
            };
            (stage.focus = null);
            return (true);
        }
        private function initInterface(){
            (ui.mcBattleToolTip.visible = false);
            (ui.mcFPS.visible = false);
            (ui.mcRes.visible = false);
            (ui.mcPopup.visible = false);
            (ui.mcPortrait.visible = false);
            (ui.mcPortrait.iconBoost.visible = false);
            (ui.mcPopup.visible = false);
            hidePortraitTarget();
            (ui.visible = false);
            (ui.mcInterface.mcXPBar.mcXP.scaleX = 0);
            (ui.mcUpdates.uproto.visible = false);
            (ui.mcUpdates.uproto.y = -400);
            hideMCPVPQueue();
            stage.removeEventListener(KeyboardEvent.KEY_UP, key_actBar);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_StageGame);
            ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OVER, xpBarMouseOver);
            ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OUT, xpBarMouseOut);
            ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.removeEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.iconBoost.removeEventListener(MouseEvent.MOUSE_OVER, onIconBoostOver);
            ui.mcPortrait.iconBoost.removeEventListener(MouseEvent.MOUSE_OUT, onIconBoostOut);
            ui.btnTargetPortraitClose.removeEventListener(MouseEvent.CLICK, onTargetPortraitCloseClick);
            ui.mcPVPQueue.removeEventListener(MouseEvent.CLICK, onMCPVPQueueClick);
            chatF.init();
            (world.rootClass = this);
            stage.addEventListener(KeyboardEvent.KEY_UP, key_actBar);
            (ui.mcInterface.mcXPBar.strXP.visible = false);
            ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OVER, xpBarMouseOver);
            ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OUT, xpBarMouseOut);
            ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.addEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.iconBoost.addEventListener(MouseEvent.MOUSE_OVER, onIconBoostOver);
            ui.mcPortrait.iconBoost.addEventListener(MouseEvent.MOUSE_OUT, onIconBoostOut);
            ui.btnTargetPortraitClose.addEventListener(MouseEvent.CLICK, onTargetPortraitCloseClick);
            ui.mcPVPQueue.addEventListener(MouseEvent.CLICK, onMCPVPQueueClick);
            (ui.mcInterface.areaList.mouseEnabled = false);
            (ui.mcInterface.areaList.title.mouseEnabled = false);
            ui.mcInterface.areaList.title.bMinMax.addEventListener(MouseEvent.CLICK, areaListClick);
        }
        public function key_StageGame(e:KeyboardEvent){
            if (!("text" in e.target)){
                if ((((e.charCode == Keyboard.ENTER)) || ((String.fromCharCode(e.charCode) == "/")))){
                    chatF.openMsgEntry();
                };
                if (String.fromCharCode(e.charCode) == "t"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        if (((((!((world.myAvatar.target == null))) && (!((world.myAvatar.target.target == null))))) && (!((world.myAvatar.target == world.myAvatar.target.target))))){
                            world.setTarget(world.myAvatar.target.target);
                        };
                    };
                };
                if ((String.fromCharCode(e.charCode) == ">")){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        if (((!((chatF.pmSourceA[0] == null))) && ((chatF.pmSourceA[0].length >= 1)))){
                            chatF.openPMsg(chatF.pmSourceA[0]);
                            ui.mcInterface.te.text = "> ";
                        };
                    };
                };
                if (String.fromCharCode(e.charCode) == "i"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        ui.mcInterface.mcMenu.toggleInventory();
                    };
                };
                if (String.fromCharCode(e.charCode) == "l"){
                    if (stage.focus != ui.mcInterface.te){
                        world.toggleQuestLog();
                    };
                };
                if (String.fromCharCode(e.charCode) == "f"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        if (ui.mcOFrame.isOpen){
                            ui.mcOFrame.fClose();
                        }
                        else {
                            world.showFriendsList();
                        };
                    };
                };
                if (String.fromCharCode(e.charCode) == "v"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        world.toggleHPBar();
                    };
                };
                if (String.fromCharCode(e.charCode) == "o"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        if (ui.mcPopup.currentLabel == "Option"){
                            ui.mcPopup.onClose();
                        }
                        else {
                            ui.mcPopup.fOpen("Option");
                        };
                    };
                };
                if (String.fromCharCode(e.charCode) == "u"){
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus))))))){
                        if (!ui.mcOFrame.isOpen){
                            world.sendWhoRequest();
                        }
                        else {
                            ui.mcOFrame.fClose();
                        };
                    };
                };
                if (e.charCode == Keyboard.SPACE){
                    if (((!((stage.focus == ui.mcInterface.te))) && (!(world.myAvatar.pMC.fly)))){
                        world.myAvatar.pMC.mcChar.gotoAndPlay("Jump");
                    };
                };
                if (e.charCode == Keyboard.ESCAPE){
                    if (e.target != ui.mcInterface.te){
                        world.cancelTarget();
                    };
                };
            };
        }
        public function getInstanceFromModalStack(sClassName:String):MovieClip{
            var i:int;
            i = 0;
            while (i < ui.ModalStack.numChildren) {
                if (getQualifiedClassName((ui.ModalStack.getChildAt(i) == sClassName))){
                    return (ui.ModalStack.getChildAt(i));
                };
                i++;
            };
            return (null);
        }
        public function stripWhiteStrict(str:String):String{
            var i:int;
            str = stripWhite(str);
            i = 0;
            while (i < chatF.strictComparisonChars.length) {
                str = str.split(chatF.strictComparisonChars.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }
        public function hideInterface():void{
            (ui.visible = false);
        }
        public function drawFunnel(targetMCs:Array, cnt:MovieClip):void{
            var g:MovieClip;
            var glowI:int;
            var lineI:int;
            var fi:int;
            cnt.numLines = 3;
            cnt.lineThickness = 3;
            cnt.lineColors = [0x9900AA, 0, 0x220066];
            cnt.glowColors = [0];
            cnt.glowStrength = 4;
            cnt.glowSize = 4;
            cnt.dur = 500;
            cnt.del = 100;
            cnt.p1StartingValue = 0.12;
            cnt.p2StartingValue = 0.24;
            cnt.p3StartingValue = 0.36;
            cnt.p1EndingValue = 0.66;
            cnt.p2EndingValue = 0.825;
            cnt.p3EndingValue = 0.99;
            cnt.p1ScaleFactor = 0.5;
            cnt.p3ScaleFactor = 0.5;
            cnt.easingExponent = 1.5;
            cnt.targetMCs = targetMCs;
            cnt.filterArr = [];
            cnt.fxArr = [];
            cnt.ts = new Date().getTime();
            glowI = 0;
            lineI = 0;
            glowI = 0;
            while (glowI < cnt.glowColors.length) {
                cnt.filterArr.push([new GlowFilter(cnt.glowColors[glowI], 1, cnt.glowSize, cnt.glowSize, cnt.glowStrength, 1, false, false)]);
                glowI++;
            };
            glowI = 0;
            lineI = 0;
            fi = 0;
            while (fi < cnt.numLines) {
                g = (cnt.addChild(new MovieClip()) as MovieClip);
                g.filters = cnt.filterArr[glowI];
                ++glowI;
                if (glowI >= cnt.glowColors.length){
                    glowI = 0;
                };
                g.lineColor = cnt.lineColors[lineI];
                ++lineI;
                if (lineI >= cnt.lineColors.length){
                    lineI = 0;
                };
                cnt.fxArr.push(g);
                fi++;
            };
            cnt.addEventListener(Event.ENTER_FRAME, funnelEF, false, 0, true);
        }
        public function strNumWithCommas(num:Number):String{
            var s:String;
            var n:String;
            var i:int;
            var j:int;
            s = "";
            n = num.toString();
            i = 0;
            j = 0;
            i = (n.length - 1);
            while (i > -1) {
                if (j == 3){
                    j = 0;
                    s = ((n.charAt(i) + ",") + s);
                }
                else {
                    s = (n.charAt(i) + s);
                };
                j++;
                i--;
            };
            return (s);
        }
        public function initSelect():void{
            var i:int;
            (mcLogin.mcDeleteConfirm.visible = false);
            (mcLogin.txtNews.text = objLogin.news);
            mcLogin.btnDelete.gotoAndStop("On");
            mcLogin.btnCharacterPage.gotoAndStop("On");
            mcLogin.btnPlay.gotoAndStop("Off");
            mcLogin.btnUpgrade.gotoAndStop("On");
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            mcLogin.btnPlay.addEventListener(MouseEvent.CLICK, onPlayClick);
            mcLogin.btnDelete.addEventListener(MouseEvent.CLICK, onDeleteClick);
            mcLogin.btnCharacterPage.addEventListener(MouseEvent.CLICK, onPageClick);
            mcLogin.btnUpgrade.addEventListener(MouseEvent.CLICK, onUpgradeClick);
            mcLogin.btnMember.addEventListener(MouseEvent.CLICK, onMemberACClick, false, 0, true);
            mcLogin.btnCoins.addEventListener(MouseEvent.CLICK, onMemberACClick, false, 0, true);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            i = 0;
            i = 0;
            while (i < 3) {
                mcLogin[("mcCharacter" + i)].addEventListener(MouseEvent.CLICK, onCharacterClick);
                (mcLogin[("mcCharacter" + i)].txtCharacter.mouseEnabled = false);
                (mcLogin[("mcCharacter" + i)].charindex = -1);
                (mcLogin[("mcCharacter" + i)].txtCharacter.text = "Create a Character");
                mcLogin[("mcCharacter" + i)].gotoAndStop("Off");
                i++;
            };
            i = 0;
            while ((((i < objLogin.chars.length)) && ((i < 3)))) {
                trace(objLogin.chars[i].sName);
                mcLogin[("mcCharacter" + i)].gotoAndStop("On");
                (mcLogin[("mcCharacter" + i)].txtCharacter.text = objLogin.chars[i].sName);
                (mcLogin[("mcCharacter" + i)].charindex = i);
                i++;
            };
            if (objLogin.chars.length > 0){
                (mcLogin.pMC.visible = true);
                selectCharacter(0);
            }
            else {
                (mcLogin.pMC.visible = false);
            };
            if (objLogin.iUpg <= 0){
                trace("FreePlayer");
                mcLogin.mcUpgrade.gotoAndStop("Off");
                trace((mcLogin.txtStatus.text + " txtStatus"));
                (mcLogin.mcStatus.txtStatus.text = "Free Player");
            }
            else {
                trace("UpgPlayer");
                mcLogin.mcUpgrade.gotoAndStop("On");
                trace((mcLogin.txtStatus.text + " txtStatus"));
                (mcLogin.mcStatus.txtStatus.text = "VIP Member");
            };
            (mcLogin.mcSC.txtCoins.text = objLogin.iCoins);
        }
        public function gotoCharSelection():void{
            if ((((((((loginInfo.strUsername.toLowerCase() == "iterator")) || ((loginInfo.strUsername.toLowerCase() == "iterator2")))) || ((loginInfo.strUsername.toLowerCase() == "iterator3")))) || ((loginInfo.strUsername.toLowerCase() == "iterator4")))){
                (serialCmdMode = true);
                (objLogin.charID = objLogin.chars[0].charID);
                mcLogin.gotoAndStop("Iterator");
            }
            else {
                if (objLogin.chars.length == 0){
                    mcLogin.gotoAndPlay("CharNew");
                }
                else {
                    mcLogin.gotoAndPlay("Chars");
                };
            };
        }
        public function readIA1Preferences():void{
            (uoPref.bCloak = (world.getAchievement("ia1", 0) == 0));
            (uoPref.bHelm = (world.getAchievement("ia1", 1) == 0));
            (uoPref.bPet = (world.getAchievement("ia1", 2) == 0));
            (uoPref.bWAnim = (world.getAchievement("ia1", 3) == 0));
            (uoPref.bGoto = (world.getAchievement("ia1", 4) == 0));
            (uoPref.bSoundOn = (world.getAchievement("ia1", 5) == 0));
            (uoPref.bMusicOn = (world.getAchievement("ia1", 6) == 0));
            (uoPref.bFriend = (world.getAchievement("ia1", 7) == 0));
            (uoPref.bParty = (world.getAchievement("ia1", 8) == 0));
            (uoPref.bGuild = (world.getAchievement("ia1", 9) == 0));
            (uoPref.bWhisper = (world.getAchievement("ia1", 10) == 0));
            (uoPref.bTT = (world.getAchievement("ia1", 11) == 0));
        }
        public function Encrypt(theText:String):String{
            var output:*;
            var i:*;
            var rnd:*;
            var nTextLength:*;
            output = new String();
            nTextLength = theText.length;
            i = 0;
            while (i < nTextLength) {
                rnd = (Math.floor((Math.random() * 66)) + 36);
                output = (output + ((theText.charCodeAt(i) + rnd).toString(27) + rnd.toString(27)));
                i++;
            };
            return (output);
        }
        public function dropStackBoost():void{
            (ui.dropStack.y = 438);
        }
        public function toggleFullScreen():void{
            var screenRectangle:Rectangle;
            trace("toggleFullScreen");
            if (stage["displayState"] == StageDisplayState.NORMAL){
                screenRectangle = new Rectangle(0, 0, 960, 550);
                try {
                    (stage["fullScreenSourceRect"] = screenRectangle);
                    (stage["displayState"] = StageDisplayState.FULL_SCREEN);
                }
                catch(error:Error) {
                };
            }
            else {
                (stage["displayState"] = StageDisplayState.NORMAL);
            };
        }
        public function addPortraitTargetStatus(sIcon:String){
            addPortraitStatusIcon(ui.mcPortraitTarget, sIcon);
        }
        public function isDialoqueUp():Boolean{
            var i:int;
            var di:*;
            var nm:*;
            i = 0;
            while (i < world.FG.numChildren) {
                di = world.FG.getChildAt(i);
                nm = String((di as MovieClip));
                if (nm.indexOf("dlg_") > -1){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function addPortraitStatus(sIcon:String){
            addPortraitStatusIcon(ui.mcPortrait, sIcon);
        }
        public function getStatsA(item:Object, slot:String):Object{
            var lvl:int;
            var rty:int;
            var iBudget:int;
            var iEnhTemplate:Object;
            var val:*;
            var statBufferOrder:*;
            var statJ:*;
            var statName:*;
            var statVals:*;
            var valTotal:*;
            var i:int;
            var o:Object;
            lvl = (((item.sType.toLowerCase())=="enhancement") ? item.iLvl : item.EnhLvl);
            rty = (((item.sType.toLowerCase())=="enhancement") ? item.iRty : item.EnhRty);
            iBudget = Math.round((getIBudget(lvl, rty) * ratiosBySlot[slot]));
            val = -1;
            statBufferOrder = ["iEND", "iSTR", "iINT", "iDEX", "iWIS", "iLCK"];
            statJ = 0;
            statName = "";
            statVals = {};
            valTotal = 0;
            i = 0;
            o = {};
            if (item.PatternID != null){
                iEnhTemplate = world.enhPatternTree[item.PatternID];
            };
            if (item.EnhPatternID != null){
                iEnhTemplate = world.enhPatternTree[item.EnhPatternID];
            };
            if (iEnhTemplate != null){
                i = 0;
                while (i < stats.length) {
                    statName = ("i" + stats[i]);
                    if (iEnhTemplate[statName] != null){
                        statVals[statName] = Math.round(((iBudget * iEnhTemplate[statName]) / 100));
                        valTotal = (valTotal + statVals[statName]);
                    };
                    i++;
                };
                statJ = 0;
                while (valTotal < iBudget) {
                    statName = statBufferOrder[statJ];
                    if (statVals[statName] != null){
                        var _local15 = statVals;
                        var _local16 = statName;
                        var _local17 = (_local15[_local16] + 1);
                        _local15[_local16] = _local17;
                        valTotal++;
                    };
                    statJ++;
                    if (statJ > (statBufferOrder.length - 1)){
                        statJ = 0;
                    };
                };
                i = 0;
                while (i < stats.length) {
                    val = statVals[("i" + stats[i])];
                    if (((!((val == null))) && (!((val == "0"))))){
                        o[("$" + stats[i])] = val;
                    };
                    i++;
                };
            };
            return (o);
        }
        private function onGameAssetsLoaded(e:Event):void{
            gotoCharSelection();
            mcConnDetail.hideConn();
        }
        public function hideMCPVPQueue():void{
            ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, MCPVPQueueEF);
            (ui.mcPVPQueue.visible = false);
            (ui.mcPVPQueue.y = -300);
        }
        public function getItemInfoStringB(obj:Object):String{
            var strItemInfo:*;
            var iRankRep:int;
            var iSpillRep:*;
            strItemInfo = (("<font size='12'><b>" + obj.sName) + "</b></font><br>");
            if ((((obj.FactionID > 1)) && ((world.getRep(obj.FactionID) < obj.iReqRep)))){
                strItemInfo = (strItemInfo + "<font size='10' color='#CC0000'>");
                iRankRep = getRankFromPoints(obj.iReqRep);
                iSpillRep = (obj.iReqRep - arrRanks[(iRankRep - 1)]);
                if (iSpillRep > 0){
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillRep) + " Reputation on ") + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                }
                else {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if ((((obj.iQSindex >= 0)) && ((world.getQuestValue(obj.iQSindex) < int(obj.iQSvalue))))){
                strItemInfo = (strItemInfo + (("<font size='11' color='#CC0000'>Requires completion of quest \"" + obj.sQuest) + '".</font><br>'));
            };
            strItemInfo = (strItemInfo + ("<font color='#00CCFF'><b>" + getDisplaysType(obj)));
            if (obj.sType.toLowerCase() == "enhancement"){
                strItemInfo = (strItemInfo + (", Level " + obj.iLvl));
            };
            if (((!((obj.sES == "None"))) && (!((obj.sES == "co"))))){
                if (obj.EnhID > 0){
                    strItemInfo = (strItemInfo + (", Level " + obj.EnhLvl));
                    if (obj.sES == "ar"){
                        strItemInfo = (strItemInfo + ("<br>Rank " + getRankFromPoints(obj.iQty)));
                    };
                }
                else {
                    if (obj.sType.toLowerCase() != "enhancement"){
                        strItemInfo = (strItemInfo + " Design");
                    };
                };
            };
            if ((((((((((((obj.sES == "Weapon")) || ((obj.sES == "co")))) || ((obj.sES == "he")))) || ((obj.sES == "ba")))) || ((obj.sES == "pe")))) || ((obj.sES == "am")))){
                if (obj.sType.toLowerCase() != "enhancement"){
                    strItemInfo = (strItemInfo + (("<br>" + getRarityString(obj.iRty)) + " Rarity"));
                };
            };
            if (obj.sType.toLowerCase() != "enhancement"){
                strItemInfo = (strItemInfo + (("</b></font><br><font size='10' color='#FFFFFF'>" + obj.sDesc) + "<br></font>"));
            }
            else {
                strItemInfo = (strItemInfo + "</b></font><br><font size='10' color='#FFFFFF'>");
                strItemInfo = (strItemInfo + "Enhancements are special items which can apply stats to your weapons and armor. Select a weapon or armor item from the list on the right, and click the <font color='#00CCFF'>\"Enhancements\"</font> button that appears below its preview.");
            };
            return (strItemInfo);
        }
        private function onSoundAssetLoaded(e:Event):void{
            mixer.initSoundFX();
        }
        public function manageXPBoost(o:Object):void{
            var modal:*;
            var modalO:*;
            (ui.mcPortrait.iconBoost.visible = (o.op == "+"));
            if (o.op == "+"){
                (world.myAvatar.objData.iBoostXP = o.iSecsLeft);
                (ui.mcPortrait.iconBoost.boostTS = new Date().getTime());
                (ui.mcPortrait.iconBoost.iBoostXP = o.iSecsLeft);
                addUpdate("You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds.");
                chatF.pushMsg("server", (("You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds. " + Math.ceil((o.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else {
                delete world.myAvatar.objData.iBoostXP;
                delete ui.mcPortrait.iconBoost.boostTS;
                delete ui.mcPortrait.iconBoost.iBoostXP;
                addUpdate("The Experience Boost has faded!  Experience rewards are no longer doubled.");
                chatF.pushMsg("server", "The Experience Boost has faded!  Experience rewards are no longer doubled.", "SERVER", "", 0);
                modal = new ModalMC();
                modalO = {};
                (modalO.strBody = "Your Experience Boost has faded!  Experience rewards are no longer doubled.  Would you like to purchase a new Experience Boost?");
                (modalO.params = {});
                (modalO.callback = openExpBoostStore);
                (modalO.glow = "red,medium");
                ui.ModalStack.addChild(modal);
                modal.init(modalO);
            };
        }
        private function onCreateNewAccount(event:MouseEvent):void{
            mixer.playSound("Click");
            mcLogin.gotoAndPlay("CharNew");
        }
        public function clearExternamSWF():void{
            while (mcExtSWF.numChildren > 0) {
                mcExtSWF.removeChildAt(0);
            };
            (world.visible = true);
            showInterface();
        }
        public function getCategoryStats(cat:String, lvl:int):Object{
            var ist:*;
            var ratios:*;
            var o:*;
            var stat:*;
            var i:int;
            ist = getInnateStats(lvl);
            ratios = classCatMap[cat].ratios;
            o = {};
            stat = "";
            i = 0;
            while (i < stats.length) {
                stat = stats[i];
                o[stat] = Math.round((ratios[i] * ist));
                i++;
            };
            return (o);
        }
        private function onForgotPassword(event:MouseEvent):void{
            mixer.playSound("Click");
            mcLogin.gotoAndPlay("Password");
        }
        private function getSfcByLoader(ldr):Object{
            var sfcO:Object;
            for each (var _local5 in sfcA) {
                sfcO = _local5;
                _local5;
                if (sfcO.loginLoader == ldr){
                    return (sfcO);
                };
            };
            return (null);
        }
        public function showMCPVPQueue():void{
            var w:Object;
            w = world.getWarzoneByWarzoneName(world.PVPQueue.warzone);
            (ui.mcPVPQueue.t1.text = w.nam);
            ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, MCPVPQueueEF);
            (ui.mcPVPQueue.t2label.visible = false);
            (ui.mcPVPQueue.t2.visible = false);
            if (world.PVPQueue.avgWait > -1){
                (ui.mcPVPQueue.t2label.visible = true);
                (ui.mcPVPQueue.t2.visible = true);
                ui.mcPVPQueue.addEventListener(Event.ENTER_FRAME, MCPVPQueueEF, false, 0, true);
            };
            (ui.mcPVPQueue.visible = true);
            (ui.mcPVPQueue.y = 84);
        }
        public function portraitClick(e:MouseEvent){
            var mc:*;
            var params:*;
            mc = MovieClip(e.currentTarget);
            if (mc.pAV.npcType == "player"){
                params = {};
                (params.ID = mc.pAV.objData.CharID);
                (params.strUsername = mc.pAV.objData.strUsername);
                if (mc.pAV != world.myAvatar){
                    ui.cMenu.fOpenWith("user", params);
                }
                else {
                    ui.cMenu.fOpenWith("self", params);
                };
            };
        }
        public function openArmorCustomize():void{
            ui.mcPopup.fOpen("ArmorColor");
        }
        private function serialCmdNext():void{
            var sl:*;
            var cmdBar:*;
            var prevServer:*;
            trace("serialCmdNext >");
            sl = mcLogin.il;
            cmdBar = sl.cmd;
            if (serialCmd.si > 0){
                prevServer = sl.getServerItemByIP(serialCmd.servers[(serialCmd.si - 1)].sIP);
                if (prevServer != null){
                    sl.serverOn(prevServer);
                };
            };
            if (serialCmd.si < serialCmd.servers.length){
                sfc.connect(serialCmd.servers[serialCmd.si].sIP, serverPort);
                serialCmd.si++;
            }
            else {
                serialCmdDone();
            };
        }
        public function showItemDrop(itemObj, isConditional):void{
            var dropItem:*;
            if (((!((itemObj.bTemp == 0))) || (!(isConditional)))){
                dropItem = new DFrameMC(itemObj);
                dropItem;
            }
            else {
                dropItem = new DFrame2MC(itemObj);
                dropItem;
            };
            ui.dropStack.addChild(dropItem);
            dropItem.init();
            (dropItem.fY = (dropItem.y = -((dropItem.fHeight + 8))));
            (dropItem.fX = (dropItem.x = -((dropItem.fWidth / 2))));
            cleanDropStack();
        }
        public function removePortraitTargetStatus(sIcon:MovieClip){
            removePortraitStatusIcon(ui.mcPortrait, sIcon);
        }
        public function closeToolTip():void{
            var tt:* = undefined;
            try {
                tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
                tt.close();
            }
            catch(e:Error) {
            };
        }
        public function getItemInfoString(obj:Object):String{
            var strItemInfo:*;
            var iRankRep:int;
            var iSpillRep:*;
            strItemInfo = (("<font size='14'><b>" + obj.sName) + "</b></font><br>");
            if ((((obj.FactionID > 1)) && ((world.getRep(obj.FactionID) < obj.iReqRep)))){
                strItemInfo = (strItemInfo + "<font size='11' color='#CC0000'>");
                iRankRep = getRankFromPoints(obj.iReqRep);
                iSpillRep = (obj.iReqRep - arrRanks[(iRankRep - 1)]);
                if (iSpillRep > 0){
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillRep) + " Reputation on ") + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                }
                else {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if ((((obj.iQSindex >= 0)) && ((world.getQuestValue(obj.iQSindex) < int(obj.iQSvalue))))){
                strItemInfo = (strItemInfo + (("<font size='11' color='#CC0000'>Requires completion of quest \"" + obj.sQuest) + '".</font><br>'));
            };
            strItemInfo = (strItemInfo + ("<font color='#009900'><b>" + obj.sType));
            if (obj.iRty > 11){
                strItemInfo = (strItemInfo + ("</b></font><br><font color='#FFCC00'><b>" + getRarityString(obj.iRty)));
            };
            strItemInfo = (strItemInfo + (("</b></font><br>" + obj.sDesc) + "<br>"));
            return (strItemInfo);
        }
        public function openExpBoostStore(params:Object):void{
            if (params.accept){
                world.sendLoadShopRequest(184);
            };
        }
        private function onLoginMASError(e:Event):void{
            trace(("Login Failed!" + e));
        }
        public function showInterface():void{
            (ui.visible = true);
        }
        function funnelEF(e:Event):void{
            var cnt:MovieClip;
            var mc:MovieClip;
            var now:Number;
            var p1:Point;
            var p2:Point;
            var p3:Point;
            var fakeNow:Number;
            var fakeTS:Number;
            var sign:int;
            var sMC:MovieClip;
            var tMC:MovieClip;
            var pSrc:Point;
            var pTgt:Point;
            var pTgtW:*;
            var pTgtH:*;
            var pMid1o:Point;
            var pMid1t:Point;
            var pMid2o:Point;
            var pMid2t:Point;
            var pMid3o:Point;
            var pMid3t:Point;
            var dir:int;
            var glowI:int;
            var lineI:int;
            var lineColor:Number;
            var angle:Number;
            var i:int;
            var d:Number;
            var m:Number;
            cnt = MovieClip(e.currentTarget);
            now = new Date().getTime();
            p1 = new Point();
            p2 = new Point();
            p3 = new Point();
            sign = 1;
            sMC = cnt.targetMCs[0];
            tMC = cnt.targetMCs[1];
            pSrc = sMC.localToGlobal(new Point(0, (-(sMC.height) / 2)));
            pTgt = tMC.localToGlobal(new Point(0, (-(tMC.height) / 2)));
            pTgtW = tMC.width;
            pTgtH = tMC.height;
            dir = -1;
            glowI = 0;
            lineI = 0;
            angle = Math.atan2((pSrc.y - pTgt.y), (pSrc.x - pTgt.x));
            angle = (angle - (Math.PI / 2));
            i = 0;
            while (i < cnt.fxArr.length) {
                mc = cnt.fxArr[i];
                fakeTS = cnt.ts;
                fakeNow = (now - (i * cnt.del));
                if (fakeNow > (fakeTS + cnt.dur)){
                    if (mc.visible){
                        mc.visible = false;
                        mc.graphics.clear();
                    };
                    if (i == (cnt.fxArr.length - 1)){
                        cnt.removeEventListener(Event.ENTER_FRAME, funnelEF);
                        if (cnt.parent != null){
                            cnt.parent.removeChild(cnt);
                        };
                    };
                }
                else {
                    if (fakeNow >= cnt.ts){
                        d = ((fakeNow - fakeTS) / cnt.dur);
                        d = Math.pow((1 - d), cnt.easingExponent);
                        sign = ((((i % 2))==0) ? 1 : -1);
                        pMid1o = new Point((Point.interpolate(pSrc, pTgt, cnt.p1StartingValue).x + Point.polar((sign * (tMC.height / cnt.p1ScaleFactor)), angle).x), (Point.interpolate(pSrc, pTgt, cnt.p1StartingValue).y + Point.polar((sign * (tMC.height / cnt.p1ScaleFactor)), angle).y));
                        pMid1t = new Point(Point.interpolate(pSrc, pTgt, cnt.p1EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p1EndingValue).y);
                        pMid2o = new Point(Point.interpolate(pSrc, pTgt, cnt.p2StartingValue).x, pTgt.y);
                        pMid2t = new Point(Point.interpolate(pSrc, pTgt, cnt.p2EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p2EndingValue).y);
                        pMid3o = new Point((Point.interpolate(pSrc, pTgt, cnt.p3StartingValue).x + Point.polar((-(sign) * (tMC.height / cnt.p3ScaleFactor)), angle).x), (Point.interpolate(pSrc, pTgt, cnt.p3StartingValue).y + Point.polar((-(sign) * (tMC.height / cnt.p3ScaleFactor)), angle).y));
                        pMid3t = new Point(Point.interpolate(pSrc, pTgt, cnt.p3EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p3EndingValue).y);
                        p1 = Point.interpolate(pMid1o, pMid1t, d);
                        p2 = Point.interpolate(pMid2o, pMid2t, d);
                        p3 = Point.interpolate(pMid3o, pMid3t, d);
                        lineColor = mc.lineColor;
                        mc.graphics.clear();
                        mc.graphics.lineStyle(cnt.lineThickness, lineColor, 1);
                        mc.graphics.moveTo(pTgt.x, pTgt.y);
                        mc.graphics.curveTo(p1.x, p1.y, p2.x, p2.y);
                        mc.graphics.curveTo(p3.x, p3.y, pSrc.x, pSrc.y);
                        m = Math.cos(((((fakeNow - fakeTS) / cnt.dur) * Math.PI) * 2));
                        m = ((m / 2) + 0.5);
                        m = (1 - m);
                        mc.alpha = m;
                    };
                };
                i++;
            };
        }
        private function onLoginClick(event:MouseEvent):void{
            if (((("btnLogin" in mcLogin)) && (mcLogin.btnLogin.visible))){
                mixer.playSound("ClickBig");
                if (((!((mcLogin.ni.text == ""))) && (!((mcLogin.pi.text == ""))))){
                    saveUserPreference();
                    login(mcLogin.ni.text.toLowerCase(), mcLogin.pi.text);
                };
            };
        }
        function getInnateStats(lvl:int):int{
            if (lvl < 1){
                lvl = 1;
            };
            if (lvl > intLevelCap){
                lvl = intLevelCap;
            };
            return (Math.round((PCstBase + (Math.pow(((lvl - 1) / (intLevelCap - 1)), statsExponent) * (PCstGoal - PCstBase)))));
        }
        public function applyAuraEffect(e, o){
            switch (e.typ){
                case "+":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] + Number(e.val));
                    break;
                case "-":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] - Number(e.val));
                    break;
                case "*":
                    o[("$" + e.sta)] = Math.round((o[("$" + e.sta)] * Number(e.val)));
                    break;
            };
        }
        public function hexDec(val){
            return (parseInt(val, 16));
        }
        public function updateXPBar():void{
            var avo:*;
            var xc:*;
            var xm:*;
            var xp:*;
            (ui.mcInterface.mcXPBar.mcXP.scaleX = (world.myAvatar.objData.intExp / world.myAvatar.objData.intExpToLevel));
            avo = world.myAvatar.objData;
            xc = avo.intExp;
            xm = avo.intExpToLevel;
            xp = int(((xc / xm) * 100));
            if (xp >= 100){
                xp = 100;
                xp;
            };
            (ui.mcInterface.mcXPBar.strXP.text = (((((((("Level " + world.myAvatar.objData.intLevel) + " : ") + xc) + " / ") + xm) + " (") + xp) + ")%"));
        }
        public function hidePortraitTarget():void{
            var mc:MovieClip;
            mc = (ui.mcPortraitTarget.mcHead as MovieClip);
            (ui.mcPortraitTarget.visible = false);
            (ui.btnTargetPortraitClose.visible = false);
        }
        public function distanceP(ax, ay, bx, by):Number{
            return (Math.sqrt((Math.pow((bx - ax), 2) + Math.pow((by - ay), 2))));
        }
        public function hidePortrait():void{
            (ui.mcPortrait.visible = false);
        }
        public function onIconBoostOver(e:MouseEvent):void{
            var mc:MovieClip;
            var now:Number;
            var n:Number;
            var m:int;
            var s:String;
            mc = MovieClip(e.currentTarget);
            now = new Date().getTime();
            n = Math.max(((mc.boostTS + (mc.iBoostXP * 1000)) - now), 0);
            m = 0;
            s = "All Experience gains are doubled. ";
            if (n < 120000){
                m = Math.floor((n / 60000));
                m;
                s = (s + String((m + " minute(s), ")));
                s;
                m = Math.round(((n % 60000) / 1000));
                m;
                s = (s + String((m + " second(s) remaining.")));
                s;
            }
            else {
                m = Math.round((n / 60000));
                m;
                s = (s + String((m + " minutes remaining.")));
                s;
            };
            ui.ToolTip.openWith({str:s});
        }
        public function distanceO(oa, ob):Number{
            return (Math.sqrt((Math.pow(int((ob.x - oa.x)), 2) + Math.pow(int((ob.y - oa.y)), 2))));
        }
        public function openCharacterCustomize():void{
            ui.mcPopup.fOpen("Customize");
        }
        function onMemberACClick(event:MouseEvent):void{
            var targetURL:URLRequest;
            trace("Clicking Button");
            targetURL = new URLRequest("http://portal.battleon.com/store/packages/herosmash.asp");
            navigateToURL(targetURL, "_blank");
        }
        public function stripMarks(str:String):String{
            var i:int;
            i = 0;
            while (i < chatF.markChars.length) {
                str = str.split(chatF.markChars.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }
        private function loginWarningTimer(e:TimerEvent):void{
            var mc:MovieClip;
            mc = (mcLogin.warning as MovieClip);
            if (mc.n-- < 1){
                (mc.visible = false);
                (mc.alpha = 0);
                (mcLogin.t1.visible = true);
                (mcLogin.btnLogin.visible = true);
                (mcLogin.mcForgotPassword.visible = true);
                mc.timer.removeEventListener(TimerEvent.TIMER, loginWarningTimer);
            }
            else {
                (mc.ti.text = ((mc.s.split("$s")[0] + mc.n) + mc.s.split("$s")[1]));
                mc.timer.reset();
                mc.timer.start();
            };
        }
        public function applyCoreStatRatings(o:Object, uoLeaf:Object):void{
            var wLvl:int;
            var wItem:Object;
            var iDPS:*;
            var iLvl:int;
            var stat:String;
            var b:int;
            var bias1:int;
            var bias2:int;
            var bias3:int;
            var val:int;
            var cat:String;
            var hpTgt:int;
            var TTD:int;
            var tDPS:*;
            var sp1pc:*;
            var i:int;
            wLvl = 0;
            wItem = world.getEquippedItemBySlot("Weapon");
            if (((!((wItem == null))) && (!((wItem.EnhLvl == null))))){
                wLvl = wItem.EnhLvl;
            };
            iDPS = (((wItem.EnhDPS)!=null) ? Number(wItem.EnhDPS) : 100);
            if (iDPS == 0){
                iDPS = 100;
            };
            iDPS = (iDPS / 100);
            iLvl = uoLeaf.intLevel;
            stat = "";
            b = getInnateStats(iLvl);
            bias1 = -1;
            bias2 = -1;
            bias3 = -1;
            val = -1;
            cat = world.myAvatar.objData.sClassCat;
            hpTgt = getBaseHPByLevel(iLvl);
            TTD = 20;
            tDPS = ((hpTgt / 20) * 0.7);
            sp1pc = Math.round((((2.25 * tDPS) / (100 / intAPtoDPS)) / 2));
            resetTableValues(o);
            i = 0;
            while (i < stats.length) {
                stat = stats[i];
                val = (o[("_" + stat)] + o[("^" + stat)]);
                switch (stat){
                    case "STR":
                        bias1 = sp1pc;
                        if (cat == "M1"){
                            o.$sbm = (o.$sbm - (((val / bias1) / 100) * 0.3));
                        };
                        o.$ap = (o.$ap + (val * 2));
                        if ((((((((((cat == "M1")) || ((cat == "M2")))) || ((cat == "M3")))) || ((cat == "M4")))) || ((cat == "S1")))){
                            if (cat == "M4"){
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.7));
                            }
                            else {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.4));
                            };
                        };
                        break;
                    case "INT":
                        bias1 = sp1pc;
                        o.$cmi = (o.$cmi - ((val / bias1) / 100));
                        if ((((cat.substr(0, 1) == "C")) || ((cat == "M3")))){
                            o.$cmo = (o.$cmo + ((val / bias1) / 100));
                        };
                        o.$sp = (o.$sp + (val * 2));
                        if ((((((((((cat == "C1")) || ((cat == "C2")))) || ((cat == "C3")))) || ((cat == "M3")))) || ((cat == "S1")))){
                            if (cat == "C2"){
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.5));
                            }
                            else {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.3));
                            };
                        };
                        break;
                    case "DEX":
                        bias1 = sp1pc;
                        if ((((((((((cat == "M1")) || ((cat == "M2")))) || ((cat == "M3")))) || ((cat == "M4")))) || ((cat == "S1")))){
                            if (cat.substr(0, 1) != "C"){
                                o.$thi = (o.$thi + (((val / bias1) / 100) * 0.2));
                            };
                            if ((((cat == "M2")) || ((cat == "M4")))){
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.5));
                            }
                            else {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.3));
                            };
                            if (cat == "M1"){
                                o.$tbl = (o.$tbl + (((val / bias1) / 100) * 0.5));
                            };
                        };
                        if (((!((cat == "M2"))) && (!((cat == "M3"))))){
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.3));
                        }
                        else {
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.5));
                        };
                        break;
                    case "WIS":
                        bias1 = sp1pc;
                        if ((((((((cat == "C1")) || ((cat == "C2")))) || ((cat == "C3")))) || ((cat == "S1")))){
                            if (cat == "C1"){
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.7));
                            }
                            else {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.4));
                            };
                            o.$thi = (o.$thi + (((val / bias1) / 100) * 0.2));
                        };
                        o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.3));
                        break;
                    case "LCK":
                        bias1 = sp1pc;
                        o.$scm = (o.$scm + (((val / bias1) / 100) * 5));
                        o.$sem = (o.$sem + (((val / bias1) / 100) * 2));
                        break;
                };
                i++;
            };
            o.wDPS = (Math.round((((getBaseHPByLevel(wLvl) / TTD) * iDPS) * PCDPSMod)) + Math.round((o.$ap / intAPtoDPS)));
            o.mDPS = (Math.round((((getBaseHPByLevel(wLvl) / TTD) * iDPS) * PCDPSMod)) + Math.round((o.$sp / intSPtoDPS)));
            trace("applyCoreStatRatings() >");
            trace((" wItem ? " + !((wItem == null))));
            trace((" wItem.sName : " + wItem.sName));
            trace((" wLvl : " + wLvl));
            trace((" o.wDPS : " + o.wDPS));
        }
        public function convertXMLtoObject(objXML:XML){
            var objTarget:*;
            var a:*;
            var o:*;
            var childNode:XML;
            var strChildName:*;
            objTarget = {};
            for (a in objXML.attributes()) {
                objTarget[String(objXML.attributes()[a].name())] = String(objXML.attributes()[a]);
            };
            for (o in objXML.children()) {
                childNode = objXML.children()[o];
                if (childNode.nodeKind() == "text"){
                    if (childNode == parseFloat(childNode).toString()){
                        return (parseFloat(childNode));
                    };
                    return (childNode);
                };
                if (childNode.nodeKind() == "element"){
                    strChildName = objXML.children()[o].name();
                    if (objTarget[strChildName] == null){
                        objTarget[strChildName] = convertXMLtoObject(objXML.children()[o]);
                    }
                    else {
                        if (!(objTarget[strChildName] is Array)){
                            objTarget[strChildName] = [objTarget[strChildName]];
                        };
                        objTarget[strChildName].push(convertXMLtoObject(objXML.children()[o]));
                    };
                };
            };
            return (objTarget);
        }
        public function hideUpgradeWindow(e:MouseEvent=null):void{
            var e = e;
            removeChild(mcUpgradeWindow);
            (mcUpgradeWindow = null);
            try {
                (ui.mouseChildren = true);
                (world.mouseChildren = true);
            }
            catch(e:Error) {
            };
            try {
                (mcLogin.sl.mouseChildren = true);
            }
            catch(e:Error) {
            };
        }
        public function showSkillUp():void{
        }
        public function actIconOut(e:MouseEvent){
            var tt:*;
            tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            if (tt.t.running){
                tt.t.stop();
            };
            ui.mcBattleToolTip.hide();
        }
        public function maskStringBetween(input:String, indeces:Array):String{
            var s:String;
            var j:int;
            var i:int;
            s = "";
            if ((((indeces.length > 0)) && (((indeces.length % 2) == 0)))){
                j = 0;
                i = 0;
                while (i < input.length) {
                    if ((((i >= indeces[j])) && ((i <= indeces[(j + 1)])))){
                        if (input.charAt(i) == " "){
                            s = (s + " ");
                        }
                        else {
                            s = (s + "*");
                        };
                        if (i == indeces[(j + 1)]){
                            j = (j + 2);
                        };
                    }
                    else {
                        s = (s + input.charAt(i));
                    };
                    i++;
                };
            }
            else {
                trace("");
                trace("Utility.maskStringBetween() > Malformed indeces array.  Must be in format [start,end, start,end, etc]");
                trace("");
            };
            return (s);
        }
        public function areaListNameClick(e:MouseEvent):void{
            var ti:*;
            var params:*;
            ti = MovieClip(e.currentTarget);
            params = {};
            (params.ID = ti.objData.ID);
            (params.strUsername = ti.objData.strUsername);
            if (ti.objData.strUsername == world.myAvatar.objData.strUsername){
                ui.cMenu.fOpenWith("self", params);
            }
            else {
                ui.cMenu.fOpenWith("user", params);
            };
        }
        public function showMessageBox(sMsg:String, fHandler:Function=null):void{
            var modal:* = undefined;
            var modalO:* = undefined;
            var sMsg:String = sMsg;
            var fHandler = fHandler;
            modal = new ModalMC();
            modalO = {};
            (modalO.strBody = sMsg);
            (modalO.btns = "mono");
            (modalO.params = {});
            (modalO.callback = function (params:Object){
                if (fHandler != null){
                    fHandler();
                };
            });
            ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }
        private function onDeleteClick(event:MouseEvent):void{
            mixer.playSound("Click");
            (mcLogin.mcDeleteConfirm.visible = true);
        }
        public function closeModalByStrBody(s:String):void{
            var i:int;
            var child:MovieClip;
            i = 0;
            i = 0;
            while (i < ui.ModalStack.numChildren) {
                child = (ui.ModalStack.getChildAt(i) as MovieClip);
                child;
                if ((((child.cnt.strBody.htmlText.indexOf(s) > -1)) && (!((child.currentLabel == "out"))))){
                    child.fClose();
                };
                i++;
            };
        }
        private function serialCmdDone():void{
            var sl:*;
            var cmdBar:*;
            trace("serialCmdDone >");
            sl = mcLogin.il;
            cmdBar = sl.cmd;
            (cmdBar.btnGo.visible = true);
            (serialCmd.active = false);
        }
        public function relayPVPEvent(o:Object):void{
            if (o.typ == "kill"){
                if (o.team == world.myAvatar.dataLeaf.pvpTeam){
                    if (o.val == "Restorer"){
                        addUpdate("An enemy Restorer has been defeated!  The Captain's healing powers are waning!");
                    };
                    if (o.val == "Brawler"){
                        addUpdate("An enemy Brawler has been defeated!  The Captain's attacks grow weaker!");
                    };
                    if (o.val == "Captain"){
                        addUpdate("The enemy captain has been defeated!");
                    };
                    if (o.val == "General"){
                        addUpdate("Victory! The enemy general has been defeated!");
                    };
                    if (o.val == "Knight"){
                        addUpdate("A knight of the enemy has fallen! Victory draws closer!");
                    };
                }
                else {
                    if (o.val == "Restorer"){
                        addUpdate("A Restorer has been defeated!  Our Captain's healing powers are waning!", true);
                    };
                    if (o.val == "Brawler"){
                        addUpdate("A Brawler has been defeated!  Rally to the Captain's defense!", true);
                    };
                    if (o.val == "Captain"){
                        addUpdate("Our Captain has been fallen to the enemy!", true);
                    };
                    if (o.val == "General"){
                        addUpdate("Oh no!  Our general has been defeated!", true);
                    };
                    if (o.val == "Knight"){
                        addUpdate("A knight has fallen to the enemy!");
                    };
                };
            };
        }
        public function showConfirmtaionBox(sMsg:String, fHandler:Function):void{
            var modal:* = undefined;
            var modalO:* = undefined;
            var sMsg:String = sMsg;
            var fHandler:Function = fHandler;
            modal = new ModalMC();
            modalO = {};
            (modalO.strBody = sMsg);
            (modalO.btns = "dual");
            (modalO.params = {});
            (modalO.callback = function (params:Object){
                fHandler(params.accept);
            });
            ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }
        public function recursiveStop(mc:MovieClip):void{
            var child:DisplayObject;
            var i:int;
            i = 0;
            while (i < mc.numChildren) {
                child = mc.getChildAt(i);
                if ((child is MovieClip)){
                    mc = MovieClip(child);
                    if (mc.totalFrames > 1){
                        mc.gotoAndStop(mc.totalFrames);
                    }
                    else {
                        mc.stop();
                    };
                    recursiveStop(MovieClip(child));
                };
                i++;
            };
        }
        public function showBallyhooAd(sZone:String):void{
            var result:uint;
            (stage["displayState"] = StageDisplayState.NORMAL);
            result = ExternalInterface.call("showIt", sZone);
        }
        public function userTreeWrite(uoName:String, uoLeafO:Object):void{
            var i:int;
            var typ:String;
            var nam:String;
            var val:* = undefined;
            var monAvt:Avatar;
            var avtAvt:Avatar;
            var Mon:Avatar;
            var avt:Avatar;
            var pMC:MovieClip;
            var prop:String;
            var updated:Object;
            var uoLeafSet:Object;
            var uoLeaf:Object;
            var s:String;
            var intStateO:int;
            var uoName:String = uoName;
            var uoLeafO:Object = uoLeafO;
            i = 0;
            prop = "";
            updated = {};
            uoLeafSet = {};
            uoLeaf = world.uoTree[uoName.toLowerCase()];
            avt = world.getAvatarByUserName(uoName);
            for (s in uoLeafO) {
                nam = s;
                val = uoLeafO[s];
                if ((((((((((nam.toLowerCase().indexOf("int") > -1)) || ((nam.toLowerCase() == "tx")))) || ((nam.toLowerCase() == "ty")))) || ((nam.toLowerCase() == "sp")))) || ((nam.toLowerCase() == "pvpTeam")))){
                    val = int(val);
                };
                if ((((nam.toLowerCase() == "fly")) || ((nam.toLowerCase() == "afk")))){
                    val = (val == "true");
                };
                if (((((((((((((((((sfcSocial) && (!((world.getFirstHeal() == null))))) && (!((uoLeaf == null))))) && (!((world.myAvatar.dataLeaf == null))))) && ((nam.toLowerCase() == "inthp")))) && (!((uoName.toLowerCase() == sfc.myUserName))))) && ((uoLeaf.strFrame == world.myAvatar.dataLeaf.strFrame)))) && (((!(world.bPvP)) || ((uoLeaf.pvpTeam == world.myAvatar.dataLeaf.pvpTeam)))))) && ((val > 0)))){
                    if ((((val <= uoLeaf.intHP)) && (((((val - uoLeaf.intHP) >= (uoLeaf.intHPMax * 0.15))) || ((val <= (uoLeaf.intHPMax * 0.5))))))){
                        try {
                            avt.pMC.showHealIcon();
                        }
                        catch(e:Error) {
                        };
                    };
                    if (val > Math.round((uoLeaf.intHPMax * 0.5))){
                        try {
                            if (avt.pMC.getChildByName("HealIconMC") != null){
                                MovieClip(avt.pMC.getChildByName("HealIconMC")).fClose();
                            };
                        }
                        catch(e:Error) {
                        };
                    };
                };
                if (nam.toLowerCase() == "afk"){
                    val = (val == "true");
                };
                updated[nam] = val;
                uoLeafSet[nam] = val;
            };
            intStateO = -1;
            if (world.uoTree[uoName.toLowerCase()] != null){
                intStateO = world.uoTree[uoName.toLowerCase()].intState;
            };
            world.uoTreeLeafSet(uoName, uoLeafSet);
            uoLeaf = world.uoTree[uoName.toLowerCase()];
            if (world.isPartyMember(uoName)){
                world.updatePartyFrame({unm:uoLeaf.strUsername});
            };
            prop = "";
            for (prop in updated) {
                val = updated[prop];
                if (prop.toLowerCase() == "strframe"){
                    world.manageAreaUser(uoName, "+");
                    if (updated[prop] != world.strFrame){
                        pMC = world.getMCByUserID(world.getUserByName(uoName).getId());
                        if (((!((pMC == null))) && (!((pMC.stage == null))))){
                            pMC.pAV.hideMC();
                            if (pMC.pAV == world.myAvatar.target){
                                world.setTarget(null);
                            };
                        };
                    }
                    else {
                        if (updated.sp == null){
                            world.objectByID(uoLeaf.entID);
                        }
                        else {
                            if (updated.sp > 0){
                                pMC = world.getMCByUserID(world.getUserByName(uoName).getId());
                                if (pMC != null){
                                    pMC.walkTo(updated.tx, updated.ty, updated.sp);
                                };
                            };
                        };
                    };
                };
                if (prop.toLowerCase() == "sp"){
                    if (updated.strFrame == world.strFrame){
                    };
                };
                if ((((prop == "fly")) && (!((avt.pMC == null))))){
                    avt.pMC.fly = updated[prop];
                    if (updated.sp == 0){
                        avt.pMC.stopWalking();
                        if (avt.pMC.fly){
                            avt.pMC.GroundToFly();
                        }
                        else {
                            avt.pMC.FlyToGround();
                        };
                    };
                };
                if (avt != null){
                    if ((((prop.toLowerCase().indexOf("inthp") > -1)) || ((prop.toLowerCase().indexOf("intmp") > -1)))){
                        val = int(val);
                        if (avt.objData != null){
                            avt.objData[prop] = val;
                        };
                        if (((avt.isMyAvatar) || ((world.myAvatar.target == avt)))){
                            world.updatePortrait(avt);
                        };
                        if (avt.isMyAvatar){
                            world.updateActBar();
                        };
                        if (((!((avt.pMC == null))) && (world.showHPBar))){
                            avt.pMC.updateHPBar();
                        };
                    };
                    if (prop.toLowerCase().indexOf("intlevel") > -1){
                        val = int(val);
                        if (avt.objData != null){
                            avt.objData[prop] = val;
                            if (((!(avt.isMyAvatar)) && ((world.myAvatar.target == avt)))){
                                showPortraitBox(avt, ui.mcPortraitTarget);
                            };
                        };
                    };
                    if (prop.toLowerCase().indexOf("intstate") > -1){
                        val = int(val);
                        if (((!((avt.objData == null))) && ((world.uoTree[uoName.toLowerCase()].strFrame == world.strFrame)))){
                            if ((((val == 1)) && ((intStateO == 0)))){
                                avt.pMC.gotoAndStop("Idle");
                                avt.pMC.scale(world.SCALE);
                            };
                            if ((((val == 1)) && ((intStateO == 2)))){
                                if (("eventTrigger" in MovieClip(world.map))){
                                };
                            };
                        };
                        if (avt.objData != null){
                            avt.objData[prop] = val;
                        };
                        if ((((((val == 0)) && ((world.uoTree[uoName.toLowerCase()].strFrame == world.strFrame)))) && (!((avt.pMC == null))))){
                            avt.pMC.stopWalking();
                            avt.pMC.mcChar.gotoAndPlay("Dead");
                            if (avt.pMC.getChildByName("HealIconMC") != null){
                                MovieClip(avt.pMC.getChildByName("HealIconMC")).fClose();
                            };
                            if (avt.isMyAvatar){
                                world.cancelAutoAttack();
                                world.actionReady = false;
                                world.bitWalk = false;
                                world.map.transform.colorTransform = world.deathCT;
                                world.CHARS.transform.colorTransform = world.deathCT;
                                avt.pMC.transform.colorTransform = world.defaultCT;
                                world.showResCounter();
                            };
                        };
                        if (val != 2){
                            uoLeaf.targets = {};
                        };
                    };
                    if (prop.toLowerCase().indexOf("afk") > -1){
                        if (avt.pMC != null){
                            avt.pMC.updateName();
                        };
                    };
                    if (prop == "showCloak"){
                        if (avt.pMC != null){
                            avt.pMC.setCloakVisibility(val);
                        };
                    };
                    if (prop == "showHelm"){
                        if (avt.pMC != null){
                            avt.pMC.setHelmVisibility(val);
                        };
                    };
                    if (prop.toLowerCase().indexOf("cast") > -1){
                        if (avt.pMC != null){
                            if (val.t > -1){
                                avt.pMC.stopWalking();
                                avt.pMC.queueAnim("Use");
                            }
                            else {
                                avt.pMC.endAction();
                                if (avt == world.myAvatar){
                                    ui.mcCastBar.fClose();
                                };
                            };
                        };
                    };
                };
            };
        }
        public function updateCoreValues(o:Object):void{
            if (o.intLevelCap != null){
                intLevelCap = o.intLevelCap;
            };
            if (o.PCstBase != null){
                PCstBase = o.PCstBase;
            };
            if (o.PCstRatio != null){
                PCstRatio = o.PCstRatio;
            };
            if (o.PCstGoal != null){
                PCstGoal = o.PCstGoal;
            };
            if (o.GstBase != null){
                GstBase = o.GstBase;
            };
            if (o.GstRatio != null){
                GstRatio = o.GstRatio;
            };
            if (o.GstGoal != null){
                GstGoal = o.GstGoal;
            };
            if (o.PChpBase1 != null){
                PChpBase1 = o.PChpBase1;
            };
            if (o.PChpBase100 != null){
                PChpBase100 = o.PChpBase100;
            };
            if (o.PChpGoal1 != null){
                PChpGoal1 = o.PChpGoal1;
            };
            if (o.PChpGoal100 != null){
                PChpGoal100 = o.PChpGoal100;
            };
            if (o.PChpDelta != null){
                PChpDelta = o.PChpDelta;
            };
            if (o.intHPperEND != null){
                intHPperEND = o.intHPperEND;
            };
            if (o.intAPtoDPS != null){
                intAPtoDPS = o.intAPtoDPS;
            };
            if (o.intSPtoDPS != null){
                intSPtoDPS = o.intSPtoDPS;
            };
            if (o.bigNumberBase != null){
                bigNumberBase = o.bigNumberBase;
            };
            if (o.resistRating != null){
                resistRating = o.resistRating;
            };
            if (o.modRating != null){
                modRating = o.modRating;
            };
            if (o.baseDodge != null){
                baseDodge = o.baseDodge;
            };
            if (o.baseBlock != null){
                baseBlock = o.baseBlock;
            };
            if (o.baseParry != null){
                baseParry = o.baseParry;
            };
            if (o.baseCrit != null){
                baseCrit = o.baseCrit;
            };
            if (o.baseHit != null){
                baseHit = o.baseHit;
            };
            if (o.baseHaste != null){
                baseHaste = o.baseHaste;
            };
            if (o.baseMiss != null){
                baseMiss = o.baseMiss;
            };
            if (o.baseResist != null){
                baseResist = o.baseResist;
            };
            if (o.baseCritValue != null){
                baseCritValue = o.baseCritValue;
            };
            if (o.baseBlockValue != null){
                baseBlockValue = o.baseBlockValue;
            };
            if (o.baseResistValue != null){
                baseResistValue = o.baseResistValue;
            };
            if (o.baseEventValue != null){
                baseEventValue = o.baseEventValue;
            };
            if (o.PCDPSMod != null){
                PCDPSMod = o.PCDPSMod;
            };
            if (o.curveExponent != null){
                curveExponent = o.curveExponent;
            };
            if (o.statsExponent != null){
                statsExponent = o.statsExponent;
            };
        }
        private function onLoginError(e:Event):void{
            trace(("Login Failed!" + e));
        }
        public function xpBarMouseOver(e:MouseEvent){
            (MovieClip(e.currentTarget).strXP.visible = true);
        }
        public function login(strUsername:String, strPassword:String){
            var url:String;
            var request:URLRequest;
            var variables:URLVariables;
            var strUsername:String = strUsername;
            var strPassword:String = strPassword;
            mcConnDetail.showConn("Authenticating Account Info...");
            (loginInfo.strUsername = strUsername);
            (loginInfo.strPassword = strPassword);
            url = ("cf-userlogin.asp?ran=" + Math.random());
            if ((((this.loaderInfo.url.toLowerCase().indexOf("file://") >= 0)) || ((this.loaderInfo.url.toLowerCase().indexOf("cdn.herosmash.com") >= 0)))){
                var _local4 = ("http://herosmash.battleon.com/game/" + url);
                url = _local4;
                _local4;
            }
            else {
                _local4 = (params.sURL + url);
                url = _local4;
                _local4;
            };
            trace(("loader: " + this.loaderInfo.url));
            trace(("url: " + url));
            request = new URLRequest(url);
            variables = new URLVariables();
            (variables.strUsername = strUsername);
            (variables.strPassword = strPassword);
            trace(("Sending: " + variables));
            (request.data = variables);
            (request.method = URLRequestMethod.POST);
            loginLoader.removeEventListener(Event.COMPLETE, onLoginComplete);
            loginLoader.addEventListener(Event.COMPLETE, onLoginComplete);
            loginLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoginError, false, 0, true);
            try {
                loginLoader.load(request);
                if (strUsername.toLowerCase() == "aqwserial"){
                    multiSFCLogin(strPassword);
                };
            }
            catch(error:Error) {
                trace("Unable to load URL");
            };
        }
        public function getRankFromPoints(rep:int):int{
            var rank:int;
            var i:*;
            rank = 1;
            if (rep < 0){
                rep = 0;
                rep;
            };
            i = 1;
            while (i < arrRanks.length) {
                if (rep < arrRanks[i]){
                    return (rank);
                };
                rank++;
                i++;
            };
            return (rank);
        }
        public function toggleCharpanel(typ:String=""):void{
            var mc:MovieClip;
            mc = ui.mcPopup;
            if (!isGreedyModalInStack()){
                if (mc.currentLabel != "Charpanel"){
                    clearPopups();
                    clearPopupsQ();
                    (mc.fData = {typ:typ});
                    (mc.visible = true);
                    mc.gotoAndPlay("Charpanel");
                }
                else {
                    mc.mcCharpanel.fClose();
                };
            };
        }
        public function drawChainsLinear(entities:Array, c:int, spfxMC:MovieClip):void{
            var pSrc:Point;
            var pTgt:Point;
            var sMC:MovieClip;
            var tMC:MovieClip;
            var ei:int;
            var steps:Array;
            var i:int;
            var j:int;
            var n:int;
            var p:Point;
            var fxArr:Array;
            var mc:MovieClip;
            ei = 1;
            while (ei < entities.length) {
                sMC = entities[(ei - 1)];
                tMC = entities[ei];
                pSrc = new Point(0, (-(sMC.height) * 0.5));
                pTgt = new Point(0, (-(tMC.height) * 0.5));
                pSrc = sMC.localToGlobal(pSrc);
                pTgt = tMC.localToGlobal(pTgt);
                steps = [];
                i = 0;
                j = 0;
                n = Math.ceil((Point.distance(pSrc, pTgt) / c));
                p = new Point();
                fxArr = [spfxMC.fx0, spfxMC.fx1, spfxMC.fx2];
                i = 0;
                while (i < fxArr.length) {
                    steps = [];
                    j = 1;
                    while (j < n) {
                        p = Point.interpolate(pSrc, pTgt, (1 - (j / (n + 1))));
                        p.x = (p.x + Math.round(((Math.random() * 25) - 13)));
                        p.y = (p.y + Math.round(((Math.random() * 25) - 13)));
                        steps.push(p);
                        j++;
                    };
                    mc = fxArr[i];
                    mc.graphics.lineStyle(5, 0xFFFFFF, 1);
                    mc.graphics.moveTo(pSrc.x, pSrc.y);
                    j = 0;
                    while (j < steps.length) {
                        mc.graphics.lineTo(steps[j].x, steps[j].y);
                        j++;
                    };
                    mc.graphics.lineTo(pTgt.x, pTgt.y);
                    i++;
                };
                ei++;
            };
        }
        private function readQueryString(){
            var _queryString:* = undefined;
            var v:* = undefined;
            var allParams:Array;
            var i:* = undefined;
            var index:* = undefined;
            var keyValuePair:String;
            var paramKey:String;
            var paramValue:String;
            try {
                _queryString = ExternalInterface.call("window.location.search.substring", 1);
                if (_queryString){
                    allParams = _queryString.split("&");
                    i = 0;
                    index = -1;
                    while (i < allParams.length) {
                        keyValuePair = allParams[i];
                        var _local2 = keyValuePair.indexOf("=");
                        index = _local2;
                        if (_local2 > 0){
                            paramKey = keyValuePair.substring(0, index);
                            paramValue = keyValuePair.substring((index + 1));
                            (querystring[paramKey] = paramValue);
                        };
                        i = (i + 1);
                    };
                };
                for (var _local4 in querystring) {
                    v = _local4;
                    _local4;
                    trace(((v + ": ") + querystring[v]));
                };
            }
            catch(e:Error) {
            };
        }
        public function xpBarMouseOut(e:MouseEvent){
            (MovieClip(e.currentTarget).strXP.visible = false);
        }
        private function getSfcBySFC(sfc):Object{
            var sfcO:Object;
            for each (var _local5 in sfcA) {
                sfcO = _local5;
                _local5;
                if (sfcO.sfc == sfc){
                    return (sfcO);
                };
            };
            return (null);
        }
        private function onPlayClick(event:MouseEvent):void{
            if (objLogin.charindex != null){
                mixer.playSound("ClickBig");
                mcLogin.gotoAndPlay("Servers");
            };
        }
        public function arraySort(a:String, b:String):int{
            if (a > b){
                return (1);
            };
            if (a < b){
                return (-1);
            };
            return (0);
        }
        public function showFactionInterface():void{
            ui.mcPopup.fOpen("Faction");
        }
        private function loadGameAssets():void{
            var l:Loader;
            var u:*;
            trace("loadGameAssets()");
            l = new Loader();
            u = new URLRequest((serverFilePath + "assets/SHQ_Skeleton.swf"));
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameAssetsLoaded, false, 0, true);
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onGameAssetsLoadError, false, 0, true);
            l.load(u, assetsContext);
        }
        private function onCharacterClick(event:MouseEvent):void{
            var btn:*;
            mixer.playSound("Click");
            btn = event.currentTarget;
            selectCharacter(btn.charindex);
        }
        public function actIconOver(e:MouseEvent){
            var mc:MovieClip;
            var actObj:*;
            var s:String;
            mc = MovieClip(e.currentTarget);
            if (((uoPref.bTT) || (!((world.myAvatar.dataLeaf.intState == 2))))){
                if (mc.item == null){
                    actObj = mc.actObj;
                    if (actObj != null){
                        s = (((("<b>" + actObj.nam) + "</b> - Lvl ") + actObj.lvl) + "\n");
                        if (actObj.typ != "passive"){
                            if (actObj.mp > 0){
                                s = (s + (("<font color='#0099FF'>" + actObj.mp) + "</font> energy, "));
                                s;
                            };
                            s = (s + ((("<font color='#FF9900'>" + (actObj.cd / 1000)) + "</font> sec cooldown") + "\n"));
                            s;
                        };
                        if (actObj.sArg2 != ""){
                            s = (s + actObj.sArg2);
                            s;
                        }
                        else {
                            s = (s + actObj.desc);
                            s;
                        };
                        ui.mcBattleToolTip.show(s);
                    };
                }
                else {
                    ui.ToolTip.openWith({str:((mc.item.sName + "\n") + mc.item.sDesc)});
                };
            };
        }
        public function deleteChar():void{
            var url:String;
            var request:URLRequest;
            var variables:URLVariables;
            var deleteLoader:URLLoader;
            var onDeleteComplete:Function;
            trace("delete");
            if (mcLogin.mcDeleteConfirm.txtConfirm.text != loginInfo.strPassword){
                MsgBox.notify("Password did not match!");
            }
            else {
                onDeleteComplete = function (evt:Event):void{
                    login(loginInfo.strUsername, loginInfo.strPassword);
                };
                (mcLogin.mcDeleteConfirm.visible = false);
                url = ("cf-deletechar.asp?ran=" + Math.random());
                if (this.loaderInfo.url.toLowerCase().indexOf("battleon.com") == -1){
                    var _local2 = ("http://herosmash.battleon.com/game/" + url);
                    url = _local2;
                    _local2;
                }
                else {
                    _local2 = (params.sURL + url);
                    url = _local2;
                    _local2;
                };
                request = new URLRequest(url);
                variables = new URLVariables();
                (variables.uuu = loginInfo.strUsername);
                (variables.ppp = loginInfo.strPassword);
                (variables.ttt = loginInfo.strToken);
                (variables.cid = objLogin.charID);
                trace(("Sending: " + variables));
                (request.data = variables);
                (request.method = URLRequestMethod.POST);
                deleteLoader = new URLLoader();
                deleteLoader.addEventListener(Event.COMPLETE, onDeleteComplete);
                deleteLoader.load(request);
            };
        }
        public function onAddedToStage(e:Event):void{
            (Game.root = this);
            (this.stage.showDefaultContextMenu = false);
            (stage.stageFocusRect = false);
            (serverFilePath = this.loaderInfo.url.substring(0, (this.loaderInfo.url.lastIndexOf("/") + 1)));
            (sFilePath = serverFilePath);
            trace(("serverFilePath: " + serverFilePath));
            (mcConnDetail = new ConnDetailMC(this));
            (songMixer = new MusicPlayer(this));
            loadSoundAsset();
            gotoAndPlay("Login");
        }
        public function initArrRep():void{
            var iCPToRank:int;
            var i:*;
            iCPToRank = 0;
            i = 1;
            while (i < 10) {
                iCPToRank = (Math.pow((i + 1), 3) * 100);
                iCPToRank;
                if (i > 1){
                    arrRanks.push((iCPToRank + arrRanks[(i - 1)]));
                }
                else {
                    arrRanks.push((iCPToRank + 100));
                };
                i++;
            };
        }
        public function doIHaveEnhancements():Boolean{
            var item:Object;
            for each (item in world.items) {
                if (item.sType.toLowerCase() == "enhancement"){
                    return (true);
                };
            };
            return (false);
        }
        public function showPVPScore():void{
            var bar:MovieClip;
            var i:int;
            var o:Object;
            var a:Array;
            var bx:int;
            (ui.mcPVPScore.visible = true);
            (ui.mcPVPScore.y = 2);
            i = 0;
            a = [{sName:"Team A"}, {sName:"Team B"}];
            bx = 200;
            if (world.PVPFactions.length > 0){
                var _local2 = world.PVPFactions;
                a = _local2;
                _local2;
            };
            i = 0;
            while (i < a.length) {
                _local2 = a[i];
                o = _local2;
                _local2;
                try {
                    _local2 = ui.mcPVPScore.getChildByName(("bar" + i));
                    bar = _local2;
                    _local2;
                    (bar.tTeam.text = o.sName);
                    if ((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6) < bx){
                        _local2 = Math.round((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6));
                        bx = _local2;
                        _local2;
                    };
                }
                catch(e:Error) {
                    trace("*** >");
                    trace("*** > PvP Faction data could not be found or set.");
                    trace("*** >");
                };
                i = (i + 1);
            };
            i = 0;
            while (i < a.length) {
                _local2 = a[i];
                o = _local2;
                _local2;
                try {
                    _local2 = ui.mcPVPScore.getChildByName(("bar" + i));
                    bar = _local2;
                    _local2;
                    (bar.cap.x = bx);
                }
                catch(e:Error) {
                };
                i = (i + 1);
            };
        }
        public function decHex(val){
            return (val.toString(16));
        }
        public function onIconBoostOut(e:MouseEvent):void{
            var tt:*;
            tt = ui.ToolTip;
            if (tt.t.running){
                tt.t.stop();
            };
            tt.close();
        }
        public function updateIcons(actIcons:Array, iconArray:Array, item:Object=null){
            var i:int;
            var j:int;
            var actIconMC:MovieClip;
            var iconShapeClass:Class;
            var iconShape:*;
            var iconShapeMC:*;
            var aw:*;
            var ah:*;
            var bw:*;
            var bh:*;
            i = 0;
            j = 0;
            i = 0;
            while (i < actIcons.length) {
                actIconMC = actIcons[i];
                actIconMC.cnt.removeChildAt(0);
                actIconMC.item = item;
                if (actIconMC.item == null){
                    actIconMC.tQty.visible = false;
                };
                while (j < iconArray.length) {
                    iconShapeClass = (getDefinitionByName(iconArray[j]) as Class);
                    iconShape = new (iconShapeClass)();
                    iconShapeMC = actIconMC.cnt.addChild(iconShape);
                    aw = 42;
                    ah = 42;
                    bw = iconShapeMC.width;
                    bh = iconShapeMC.height;
                    if (bw > bh){
                        iconShapeMC.scaleX = (iconShapeMC.scaleY = (aw / bw));
                    }
                    else {
                        iconShapeMC.scaleX = (iconShapeMC.scaleY = (ah / bh));
                    };
                    if (j == 0){
                        iconShapeMC.x = ((actIconMC.mcIconSpace.width / 2) - (iconShapeMC.width / 2));
                        iconShapeMC.y = ((actIconMC.mcIconSpace.height / 2) - (iconShapeMC.height / 2));
                    }
                    else {
                        iconShapeMC.x = ((actIconMC.mcIconSpace.width / 2) - 3);
                        iconShapeMC.y = (actIconMC.mcIconSpace.height / 2);
                        iconShapeMC.scaleX = (iconShapeMC.scaleX * 0.5);
                        iconShapeMC.scaleY = (iconShapeMC.scaleY * 0.5);
                        iconShapeMC.filters = [new GlowFilter(5537176, 1, 10, 10, 3, BitmapFilterQuality.LOW, false, false)];
                    };
                    j++;
                };
                i++;
            };
        }
        public function mcSetColor(oMC:MovieClip, strLocation:String, strShade:String){
            var mc:MovieClip;
            var go:Boolean;
            var typ:String;
            mc = oMC;
            go = false;
            typ = "none";
            while (((((!((mc == null))) && (!((mc.parent == null))))) && (!((mc.parent == mc.stage))))) {
                if (("pAV" in mc)){
                    if (mc.name.indexOf("pnpc") > -1){
                        typ = "f";
                        typ;
                    }
                    else {
                        if (mc.name.indexOf("previewMC") > -1){
                            typ = "e";
                            typ;
                        }
                        else {
                            if (mc.name.indexOf("Dummy") > -1){
                                typ = "d";
                                typ;
                            }
                            else {
                                if (mc.name.indexOf("mcPortraitTarget") > -1){
                                    typ = "c";
                                    typ;
                                }
                                else {
                                    if (mc.name.indexOf("mcPortrait") > -1){
                                        typ = "b";
                                        typ;
                                    }
                                    else {
                                        typ = "a";
                                        typ;
                                    };
                                };
                            };
                        };
                    };
                    break;
                };
                mc = MovieClip(mc.parent);
                mc;
            };
            if (typ != "none"){
                changeColor(oMC, Number(mc.pAV.objData[("intColor" + strLocation)]), strShade);
                (oMC.isColored = true);
                (oMC.strLocation = strLocation);
                (oMC.strShade = strShade);
            };
        }
        public function encodeSpecialChars(str){
            str = str.replace(/&/g, "#038:");
            str = str.replace(/\//g, "#047:");
            str = str.replace(/\\/g, "#092:");
            str = str.replace(/</g, "#060:");
            str = str.replace(/>/g, "#062:");
            str = str.replace(/~/g, "#126:");
            str = str.replace(/\^/g, "#094:");
            return (str);
        }
        function getBaseHPByLevel(lvl){
            if (lvl < 1){
                lvl = 1;
            };
            if (lvl > intLevelCap){
                lvl = intLevelCap;
            };
            return (Math.round((PChpBase1 + (Math.pow(((lvl - 1) / (intLevelCap - 1)), curveExponent) * PChpDelta))));
        }
        function replaceString(str:String, find:String, replace:String):String{
            var startIndex:Number;
            var oldIndex:Number;
            var newString:String;
            startIndex = 0;
            oldIndex = 0;
            newString = "";
            while ((startIndex = str.indexOf(find, startIndex)) != -1) {
                newString = (newString + (str.substring(oldIndex, startIndex) + replace));
                startIndex = (startIndex + find.length);
                oldIndex = startIndex;
            };
            return ((((newString)=="") ? str : newString));
        }
        public function showQuestpopup(resObj:Object):void{
            var qp:mcQuestpopup;
            var mc:MovieClip;
            var o:Object;
            var factionObj:*;
            var factionIcon:*;
            var AssetClass:Class;
            var newIcon:*;
            qp = new mcQuestpopup();
            mc = (ui.addChild(qp) as MovieClip);
            (mc.tTitle.text = resObj.sName);
            o = resObj.rewardObj;
            if (((("intGold" in o)) && ((o.intGold > 0)))){
                (mc.tGold.text = o.intGold);
                (mc.tGold.visible = false);
            };
            if (((("intExp" in o)) && ((o.intExp > 0)))){
                (mc.tXp.text = o.intExp);
                (mc.tXp.visible = false);
            };
            if (((("iRep" in o)) && ((o.iRep > 0)))){
                (mc.tFactionP.text = o.iRep);
                (mc.tFactionP.visible = false);
            };
            (mc.tIcon.text = "None");
            (mc.tIcon.visible = false);
            if (((("FactionID" in o)) && ((o.FactionID > 0)))){
                factionObj = world.getFaction(o.FactionID);
                (mc.tFaction.text = (factionObj.sName + " "));
                (mc.tFaction.visible = false);
                factionIcon = ("rep" + factionObj.sName);
                AssetClass = (loadermanager.getClass(factionIcon) as Class);
                if (AssetClass != null){
                    mc.qbox.aIcon.Icon.removeChildAt(0);
                    newIcon = mc.qbox.aIcon.Icon.addChild(new (AssetClass)());
                    (newIcon.scaleX = (newIcon.scaleY = 0.25));
                    (newIcon.x = (newIcon.width / 2));
                    (newIcon.y = (newIcon.height / 2));
                    (mc.tIcon.text = "Found");
                    trace((mc.tIcon.text + " Icon String"));
                };
            }
            else {
                (mc.tFaction.text = "None");
                (mc.tFaction.visible = false);
            };
            (mc.tTitle.visible = false);
            (mc.x = ((960 / 2) - (mc.width / 2)));
            (mc.y = ((550 / 2) - (mc.height / 2)));
            mc.gotoAndPlay("Ready");
            mixer.playSound("Good");
        }
        public function toggleItemEquip(item:Object):Boolean{
            var uoLeaf:*;
            var isOK:Boolean;
            uoLeaf = world.getUoLeafById(world.myAvatar.uid);
            isOK = false;
            if (uoLeaf.intState != 1){
                MsgBox.notify("Action cannot be performed during combat!");
            }
            else {
                if (world.bPvP){
                    MsgBox.notify("Items may not be equipped or unequipped during a PvP match!");
                }
                else {
                    if (item.bEquip == 1){
                        if ((((item.sES == "Weapon")) || ((item.sES == "ar")))){
                            MsgBox.notify("Selected Item cannot be unequipped!");
                        }
                        else {
                            isOK = true;
                            if (item.sType.toLowerCase() != "item"){
                                world.sendUnequipItemRequest(item);
                            }
                            else {
                                world.unequipUseableItem(item);
                            };
                        };
                    }
                    else {
                        if ((((item.bUpg == 1)) && (!(world.myAvatar.isUpgraded())))){
                            showUpgradeWindow();
                        }
                        else {
                            if (int(item.EnhLvl) > int(world.myAvatar.objData.intLevel)){
                                MsgBox.notify("Level requirement not met!");
                            }
                            else {
                                if (((!((item.sType.toLowerCase() == "item"))) && (((((((!((item.sES == "co"))) && (!((item.sES == "pe"))))) && (!((item.sES == "am"))))) && (!((item.EnhID > 0))))))){
                                    MsgBox.notify("Selected item requires enhancement!");
                                }
                                else {
                                    if (item.sType.toLowerCase() != "item"){
                                        isOK = world.sendEquipItemRequest(item);
                                    }
                                    else {
                                        isOK = true;
                                        world.equipUseableItem(item);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (isOK);
        }
        public function stripWhite(str:String):String{
            str = str.split("\r").join("");
            str = str.split("\t").join("");
            str = str.split(" ").join("");
            return (str);
        }
        public function showAchievement(aName:String):void{
            var achievement:mcAchievement;
            var mc:MovieClip;
            achievement = new mcAchievement();
            mc = (ui.dropStack.addChild(achievement) as MovieClip);
            (mc.cnt.tBody.text = aName);
            (mc.fWidth = 348);
            (mc.fHeight = 90);
            (mc.fX = (mc.x = -((mc.fWidth / 2))));
            (mc.fY = (mc.y = -((mc.fHeight + 8))));
            cleanDropStack();
        }
        public function initArrHP():void{
            var intLevelCap:int;
            var intHPBase1:int;
            var intHPConst1:int;
            var intScaling1:Number;
            var intHPBase2:int;
            var intHPConst2:int;
            var intScaling2:Number;
            var intHPBase3:int;
            var intHPConst3:int;
            var intScaling3:Number;
            var i:*;
            intLevelCap = 100;
            intHPBase1 = 550;
            intHPConst1 = 275;
            intScaling1 = 0.8;
            intHPBase2 = 720;
            intHPConst2 = 200;
            intScaling2 = 0.92;
            intHPBase3 = 350;
            intHPConst3 = 3650;
            intScaling3 = 1.1;
            i = 0;
            while (i < intLevelCap) {
                if (i > 19){
                    arrHP.push(Math.round((intHPBase3 + (Math.pow((i / intLevelCap), intScaling3) * intHPConst3))));
                }
                else {
                    if (i > 7){
                        arrHP.push(Math.round((intHPBase2 + (Math.pow((i / 20), intScaling2) * intHPConst2))));
                    }
                    else {
                        arrHP.push(Math.round((intHPBase1 + (Math.pow((i / 8), intScaling1) * intHPConst1))));
                    };
                };
                i++;
            };
        }

    }
}//package 

