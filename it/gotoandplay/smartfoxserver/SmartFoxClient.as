// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//it.gotoandplay.smartfoxserver.SmartFoxClient

package it.gotoandplay.smartfoxserver{
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import it.gotoandplay.smartfoxserver.http.HttpConnection;
    import flash.net.Socket;
    import it.gotoandplay.smartfoxserver.handlers.SysHandler;
    import it.gotoandplay.smartfoxserver.handlers.ExtHandler;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import it.gotoandplay.smartfoxserver.http.HttpEvent;
    import it.gotoandplay.smartfoxserver.handlers.IMessageHandler;
    import com.adobe.serialization.json.JSON;
    import it.gotoandplay.smartfoxserver.data.Room;
    import flash.utils.getTimer;
    import flash.net.URLRequest;
    import flash.net.FileReference;
    import flash.events.ErrorEvent;
    import flash.net.URLLoader;
    import it.gotoandplay.smartfoxserver.data.User;
    import it.gotoandplay.smartfoxserver.util.Entities;
    import flash.utils.setTimeout;
    import it.gotoandplay.smartfoxserver.util.ObjectSerializer;

    public class SmartFoxClient extends EventDispatcher {

        public static const CONNECTION_MODE_HTTP:String = "http";
        private static const MSG_JSON:String = "{";
        public static const MODMSG_TO_USER:String = "u";
        public static const XTMSG_TYPE_XML:String = "xml";
        private static const MSG_XML:String = "<";
        public static const MODMSG_TO_ROOM:String = "r";
        private static const EOM:int = 0;
        public static const XTMSG_TYPE_STR:String = "str";
        public static const CONNECTION_MODE_SOCKET:String = "socket";
        public static const MODMSG_TO_ZONE:String = "z";
        public static const CONNECTION_MODE_DISCONNECTED:String = "disconnected";
        public static const XTMSG_TYPE_JSON:String = "json";

        private static var MAX_POLL_SPEED:Number = 10000;
        private static var DEFAULT_POLL_SPEED:Number = 750;
        private static var MIN_POLL_SPEED:Number = 0;
        private static var HTTP_POLL_REQUEST:String = "poll";
        private static var MSG_STR:String = "%";

        private var connected:Boolean;
        private var autoConnectOnConfigSuccess:Boolean = false;
        private var benchStartTime:int;
        private var roomList:Array;
        private var _httpPollSpeed:int;
        private var minVersion:Number;
        public var httpPort:int = 8080;
        public var properties:Object = null;
        public var myUserId:int;
        public var blueBoxPort:Number = 0;
        public var debug:Boolean;
        private var byteBuffer:ByteArray;
        private var subVersion:Number;
        public var buddyList:Array;
        public var port:int = 9339;
        private var messageHandlers:Array;
        public var defaultZone:String;
        private var isHttpMode:Boolean = false;
        private var httpConnection:HttpConnection;
        private var majVersion:Number;
        private var socketConnection:Socket;
        public var blueBoxIpAddress:String;
        private var sysHandler:SysHandler;
        public var myBuddyVars:Array;
        public var myUserName:String;
        public var ipAddress:String;
        public var playerId:int;
        public var smartConnect:Boolean = true;
        public var amIModerator:Boolean;
        private var extHandler:ExtHandler;
        public var changingRoom:Boolean;
        public var activeRoomId:int;

        public function SmartFoxClient(debug:Boolean=false){
            byteBuffer = new ByteArray();
            autoConnectOnConfigSuccess = false;
            port = 9339;
            isHttpMode = false;
            _httpPollSpeed = DEFAULT_POLL_SPEED;
            blueBoxPort = 0;
            smartConnect = true;
            httpPort = 8080;
            properties = null;
            super();
            this.majVersion = 1;
            this.minVersion = 6;
            this.subVersion = 5;
            this.activeRoomId = -1;
            this.debug = debug;
            this.messageHandlers = [];
            setupMessageHandlers();
            socketConnection = new Socket();
            socketConnection.addEventListener(Event.CONNECT, handleSocketConnection);
            socketConnection.addEventListener(Event.CLOSE, handleSocketDisconnection);
            socketConnection.addEventListener(ProgressEvent.SOCKET_DATA, handleSocketData);
            socketConnection.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
            socketConnection.addEventListener(IOErrorEvent.NETWORK_ERROR, handleIOError);
            socketConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError);
            httpConnection = new HttpConnection();
            httpConnection.addEventListener(HttpEvent.onHttpConnect, handleHttpConnect);
            httpConnection.addEventListener(HttpEvent.onHttpClose, handleHttpClose);
            httpConnection.addEventListener(HttpEvent.onHttpData, handleHttpData);
            httpConnection.addEventListener(HttpEvent.onHttpError, handleHttpError);
        }
        private function getXmlUserVariable(uVars:Object):String{
            var xmlStr:String;
            var val:*;
            var t:String;
            var type:String;
            var key:String;
            xmlStr = "<vars>";
            for (key in uVars) {
                val = uVars[key];
                type = typeof(val);
                t = null;
                if (type == "boolean"){
                    t = "b";
                    val = ((val) ? "1" : "0");
                }
                else {
                    if (type == "number"){
                        t = "n";
                    }
                    else {
                        if (type == "string"){
                            t = "s";
                        }
                        else {
                            if ((((((val == null)) && ((type == "object")))) || ((type == "undefined")))){
                                t = "x";
                                val = "";
                            };
                        };
                    };
                };
                if (t != null){
                    xmlStr = (xmlStr + (((((("<var n='" + key) + "' t='") + t) + "'><![CDATA[") + val) + "]]></var>"));
                };
            };
            xmlStr = (xmlStr + "</vars>");
            return (xmlStr);
        }
        private function jsonReceived(msg:String):void{
            var jso:Object;
            var handlerId:String;
            var handler:IMessageHandler;
            jso = JSON.decode(msg);
            handlerId = jso["t"];
            handler = messageHandlers[handlerId];
            if (handler != null){
                handler.handleMessage(jso["b"], XTMSG_TYPE_JSON);
            };
        }
        private function onConfigLoadFailure(evt:IOErrorEvent):void{
            var params:Object;
            var sfsEvt:SFSEvent;
            params = {message:evt.text};
            sfsEvt = new SFSEvent(SFSEvent.onConfigLoadFailure, params);
            dispatchEvent(sfsEvt);
        }
        public function getActiveRoom():Room{
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return (null);
            };
            return (roomList[activeRoomId]);
        }
        public function getBuddyRoom(buddy:Object):void{
            if (buddy.id != -1){
                send({t:"sys"}, "roomB", -1, (("<b id='" + buddy.id) + "' />"));
            };
        }
        private function checkBuddyDuplicates(buddyName:String):Boolean{
            var res:Boolean;
            var buddy:Object;
            res = false;
            for each (buddy in buddyList) {
                if (buddy.name == buddyName){
                    res = true;
                    break;
                };
            };
            return (res);
        }
        private function getXmlRoomVariable(rVar:Object):String{
            var vName:String;
            var vValue:*;
            var vPrivate:String;
            var vPersistent:String;
            var t:String;
            var type:String;
            vName = rVar.name.toString();
            vValue = rVar.val;
            vPrivate = ((rVar.priv) ? "1" : "0");
            vPersistent = ((rVar.persistent) ? "1" : "0");
            t = null;
            type = typeof(vValue);
            if (type == "boolean"){
                t = "b";
                vValue = ((vValue) ? "1" : "0");
            }
            else {
                if (type == "number"){
                    t = "n";
                }
                else {
                    if (type == "string"){
                        t = "s";
                    }
                    else {
                        if ((((((vValue == null)) && ((type == "object")))) || ((type == "undefined")))){
                            t = "x";
                            vValue = "";
                        };
                    };
                };
            };
            if (t != null){
                return ((((((((((("<var n='" + vName) + "' t='") + t) + "' pr='") + vPrivate) + "' pe='") + vPersistent) + "'><![CDATA[") + vValue) + "]]></var>"));
            };
            return ("");
        }
        public function getBuddyById(id:int):Object{
            var buddy:Object;
            for each (buddy in buddyList) {
                if (buddy.id == id){
                    return (buddy);
                };
            };
            return (null);
        }
        private function handleSocketDisconnection(evt:Event):void{
            var sfse:SFSEvent;
            initialize();
            sfse = new SFSEvent(SFSEvent.onConnectionLost, {});
            dispatchEvent(sfse);
        }
        private function handleSocketError(evt:SecurityErrorEvent):void{
            debugMessage(("Socket Error: " + evt.text));
        }
        private function xmlReceived(msg:String):void{
            var xmlData:XML;
            var handlerId:String;
            var action:String;
            var roomId:int;
            var handler:IMessageHandler;
            xmlData = new XML(msg);
            handlerId = xmlData.@t;
            action = xmlData.body.@action;
            roomId = xmlData.body.@r;
            handler = messageHandlers[handlerId];
            if (handler != null){
                handler.handleMessage(xmlData, XTMSG_TYPE_XML);
            };
        }
        public function switchSpectator(roomId:int=-1):void{
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            send({t:"sys"}, "swSpec", roomId, "");
        }
        public function roundTripBench():void{
            this.benchStartTime = getTimer();
            send({t:"sys"}, "roundTrip", activeRoomId, "");
        }
        private function handleHttpError(evt:HttpEvent):void{
            trace("HttpError");
            if (!connected){
                dispatchConnectionError();
            };
        }
        public function joinRoom(newRoom, pword:String="", isSpectator:Boolean=false, dontLeave:Boolean=false, oldRoom:int=-1):void{
            var newRoomId:int;
            var isSpec:int;
            var r:Room;
            var header:Object;
            var leaveCurrRoom:String;
            var roomToLeave:int;
            var message:String;
            if (!checkRoomList()){
                return;
            };
            newRoomId = -1;
            isSpec = ((isSpectator) ? 1 : 0);
            if (!this.changingRoom){
                if (typeof(newRoom) == "number"){
                    newRoomId = int(newRoom);
                }
                else {
                    if (typeof(newRoom) == "string"){
                        for each (r in roomList) {
                            if (r.getName() == newRoom){
                                newRoomId = r.getId();
                                break;
                            };
                        };
                    };
                };
                if (newRoomId != -1){
                    header = {t:"sys"};
                    leaveCurrRoom = ((dontLeave) ? "0" : "1");
                    roomToLeave = (((oldRoom > -1)) ? oldRoom : activeRoomId);
                    if (activeRoomId == -1){
                        leaveCurrRoom = "0";
                        roomToLeave = -1;
                    };
                    message = (((((((((("<room id='" + newRoomId) + "' pwd='") + pword) + "' spec='") + isSpec) + "' leave='") + leaveCurrRoom) + "' old='") + roomToLeave) + "' />");
                    send(header, "joinRoom", activeRoomId, message);
                    changingRoom = true;
                }
                else {
                    debugMessage("SmartFoxError: requested room to join does not exist!");
                };
            };
        }
        public function get httpPollSpeed():int{
            return (this._httpPollSpeed);
        }
        public function uploadFile(fileRef:FileReference, id:int=-1, nick:String="", port:int=-1):void{
            if (id == -1){
                id = this.myUserId;
            };
            if (nick == ""){
                nick = this.myUserName;
            };
            if (port == -1){
                port = this.httpPort;
            };
            fileRef.upload(new URLRequest(((((((("http://" + this.ipAddress) + ":") + port) + "/default/Upload.py?id=") + id) + "&nick=") + nick)));
            debugMessage(((((((("[UPLOAD]: http://" + this.ipAddress) + ":") + port) + "/default/Upload.py?id=") + id) + "&nick=") + nick));
        }
        public function switchPlayer(roomId:int=-1):void{
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            send({t:"sys"}, "swPl", roomId, "");
        }
        private function makeXmlHeader(headerObj:Object):String{
            var xmlData:String;
            var item:String;
            xmlData = "<msg";
            for (item in headerObj) {
                xmlData = (xmlData + ((((" " + item) + "='") + headerObj[item]) + "'"));
            };
            xmlData = (xmlData + ">");
            return (xmlData);
        }
        private function debugMessage(message:String):void{
            var evt:SFSEvent;
            if (this.debug){
                trace(message);
                evt = new SFSEvent(SFSEvent.onDebugMessage, {message:message});
                dispatchEvent(evt);
            };
        }
        public function loadBuddyList():void{
            send({t:"sys"}, "loadB", -1, "");
        }
        private function errorTrace(msg:String):void{
            trace("\n****************************************************************");
            trace("Warning:");
            trace(msg);
            trace("****************************************************************");
        }
        public function leaveRoom(roomId:int):void{
            var header:Object;
            var xmlMsg:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            header = {t:"sys"};
            xmlMsg = (("<rm id='" + roomId) + "' />");
            send(header, "leaveRoom", roomId, xmlMsg);
        }
        private function checkRoomList():Boolean{
            var success:Boolean;
            success = true;
            return (success);
        }
        public function getRoomByName(roomName:String):Room{
            var room:Room;
            var r:Room;
            if (!checkRoomList()){
                return (null);
            };
            room = null;
            for each (r in roomList) {
                if (r.getName() == roomName){
                    room = r;
                    break;
                };
            };
            return (room);
        }
        private function handleHttpClose(evt:HttpEvent):void{
            var sfse:SFSEvent;
            initialize();
            sfse = new SFSEvent(SFSEvent.onConnectionLost, {});
            dispatchEvent(sfse);
        }
        public function set httpPollSpeed(sp:int):void{
            if ((((sp >= 0)) && ((sp <= 10000)))){
                this._httpPollSpeed = sp;
            };
        }
        public function getRoom(roomId:int):Room{
            if (!checkRoomList()){
                return (null);
            };
            return (roomList[roomId]);
        }
        private function checkJoin():Boolean{
            var success:Boolean;
            success = true;
            if (activeRoomId < 0){
                success = false;
                errorTrace("You haven't joined any rooms!\nIn order to interact with the server you should join at least one room.\nPlease consult the documentation for more infos.");
            };
            return (success);
        }
        public function setBuddyVariables(varList:Array):void{
            var header:Object;
            var xmlMsg:String;
            var vName:String;
            var vValue:String;
            header = {t:"sys"};
            xmlMsg = "<vars>";
            for (vName in varList) {
                vValue = varList[vName];
                if (myBuddyVars[vName] != vValue){
                    myBuddyVars[vName] = vValue;
                    xmlMsg = (xmlMsg + (((("<var n='" + vName) + "'><![CDATA[") + vValue) + "]]></var>"));
                };
            };
            xmlMsg = (xmlMsg + "</vars>");
            this.send(header, "setBvars", -1, xmlMsg);
        }
        private function tryBlueBoxConnection(evt:ErrorEvent):void{
            var __ip:String;
            var __port:int;
            if (!connected){
                if (smartConnect){
                    debugMessage("Socket connection failed. Trying BlueBox");
                    isHttpMode = true;
                    __ip = (((blueBoxIpAddress)!=null) ? blueBoxIpAddress : ipAddress);
                    __port = (((blueBoxPort)!=0) ? blueBoxPort : httpPort);
                    httpConnection.connect(__ip, __port);
                }
                else {
                    dispatchConnectionError();
                };
            }
            else {
                debugMessage(("[WARN] Connection error: " + evt.text));
            };
        }
        public function getAllRooms():Array{
            return (roomList);
        }
        private function strReceived(msg:String):void{
            var params:Array;
            var handlerId:String;
            var handler:IMessageHandler;
            params = msg.substr(1, (msg.length - 2)).split(MSG_STR);
            handlerId = params[0];
            handler = messageHandlers[handlerId];
            if (handler != null){
                handler.handleMessage(params.splice(1, (params.length - 1)), XTMSG_TYPE_STR);
            };
        }
        private function handleSecurityError(evt:SecurityErrorEvent):void{
            tryBlueBoxConnection(evt);
        }
        private function handleIOError(evt:IOErrorEvent):void{
            tryBlueBoxConnection(evt);
        }
        private function dispatchConnectionError():void{
            var params:Object;
            var sfse:SFSEvent;
            params = {};
            params.success = false;
            params.error = "I/O Error";
            sfse = new SFSEvent(SFSEvent.onConnection, params);
            dispatchEvent(sfse);
        }
        public function login(zone:String, name:String, pass:String):void{
            var header:Object;
            var message:String;
            header = {t:"sys"};
            message = (((((("<login z='" + zone) + "'><nick><![CDATA[") + name) + "]]></nick><pword><![CDATA[") + pass) + "]]></pword></login>");
            send(header, "login", 0, message);
        }
        public function __logout():void{
            initialize(true);
        }
        private function setupMessageHandlers():void{
            sysHandler = new SysHandler(this);
            extHandler = new ExtHandler(this);
            addMessageHandler("sys", sysHandler);
            addMessageHandler("xt", extHandler);
        }
        private function addMessageHandler(key:String, handler:IMessageHandler):void{
            if (this.messageHandlers[key] == null){
                this.messageHandlers[key] = handler;
            }
            else {
                debugMessage((("Warning, message handler called: " + key) + " already exist!"));
            };
        }
        public function autoJoin():void{
            var header:Object;
            if (!checkRoomList()){
                return;
            };
            header = {t:"sys"};
            this.send(header, "autoJoin", ((this.activeRoomId) ? this.activeRoomId : -1), "");
        }
        private function onConfigLoadSuccess(evt:Event):void{
            var loader:URLLoader;
            var xmlDoc:XML;
            var sfsEvt:SFSEvent;
            loader = (evt.target as URLLoader);
            xmlDoc = new XML(loader.data);
            this.ipAddress = (this.blueBoxIpAddress = xmlDoc.ip);
            this.port = int(xmlDoc.port);
            this.defaultZone = xmlDoc.zone;
            if (xmlDoc.blueBoxIpAddress != undefined){
                this.blueBoxIpAddress = xmlDoc.blueBoxIpAddress;
            };
            if (xmlDoc.blueBoxPort != undefined){
                this.blueBoxPort = xmlDoc.blueBoxPort;
            };
            if (xmlDoc.debug != undefined){
                this.debug = (((xmlDoc.debug.toLowerCase() == "true")) ? true : false);
            };
            if (xmlDoc.smartConnect != undefined){
                this.smartConnect = (((xmlDoc.smartConnect.toLowerCase() == "true")) ? true : false);
            };
            if (xmlDoc.httpPort != undefined){
                this.httpPort = int(xmlDoc.httpPort);
            };
            if (xmlDoc.httpPollSpeed != undefined){
                this.httpPollSpeed = int(xmlDoc.httpPollSpeed);
            };
            if (xmlDoc.rawProtocolSeparator != undefined){
                rawProtocolSeparator = xmlDoc.rawProtocolSeparator;
            };
            if (autoConnectOnConfigSuccess){
                this.connect(ipAddress, port);
            }
            else {
                sfsEvt = new SFSEvent(SFSEvent.onConfigLoadSuccess, {});
                dispatchEvent(sfsEvt);
            };
        }
        private function handleSocketConnection(e:Event):void{
            var header:Object;
            var xmlMsg:String;
            header = {t:"sys"};
            xmlMsg = (((("<ver v='" + this.majVersion.toString()) + this.minVersion.toString()) + this.subVersion.toString()) + "' />");
            send(header, "verChk", 0, xmlMsg);
        }
        private function handleSocketData(evt:Event):void{
            var bytes:int;
            var b:int;
            var evt:Event = evt;
            bytes = socketConnection.bytesAvailable;
            while ((bytes = (bytes - 1)), bytes >= 0) {
                b = socketConnection.readByte();
                if (b != 0){
                    byteBuffer.writeByte(b);
                }
                else {
                    try {
                        handleMessage(byteBuffer.toString());
                    }
                    catch(err:Error) {
                        debugMessage(("[WARN] Unexpected exception during handleMessage: " + err));
                        if (err.getStackTrace() != null){
                            debugMessage(err.getStackTrace());
                        };
                    };
                    byteBuffer = new ByteArray();
                };
            };
        }
        public function logout():void{
            var header:Object;
            header = {t:"sys"};
            send(header, "logout", -1, "");
        }
        public function getRoomList():void{
            var header:Object;
            header = {t:"sys"};
            send(header, "getRmList", activeRoomId, "");
        }
        public function getConnectionMode():String{
            var mode:String;
            mode = CONNECTION_MODE_DISCONNECTED;
            if (this.isConnected){
                if (this.isHttpMode){
                    mode = CONNECTION_MODE_HTTP;
                }
                else {
                    mode = CONNECTION_MODE_SOCKET;
                };
            };
            return (mode);
        }
        public function setRoomList(roomList:Array):void{
            this.roomList = roomList;
        }
        public function disconnect():void{
            connected = false;
            if (!isHttpMode){
                socketConnection.close();
            }
            else {
                httpConnection.close();
            };
            sysHandler.dispatchDisconnection();
        }
        public function sendJson(jsMessage:String):void{
            debugMessage((("[Sending - JSON]: " + jsMessage) + "\n"));
            if (isHttpMode){
                httpConnection.send(jsMessage);
            }
            else {
                writeToSocket(jsMessage);
            };
        }
        private function send(header:Object, action:String, fromRoom:Number, message:String):void{
            var xmlMsg:String;
            xmlMsg = makeXmlHeader(header);
            xmlMsg = (xmlMsg + ((((((("<body action='" + action) + "' r='") + fromRoom) + "'>") + message) + "</body>") + closeHeader()));
            debugMessage((("[Sending]: " + xmlMsg) + "\n"));
            if (isHttpMode){
                httpConnection.send(xmlMsg);
            }
            else {
                writeToSocket(xmlMsg);
            };
        }
        public function setRoomVariables(varList:Array, roomId:int=-1, setOwnership:Boolean=true):void{
            var header:Object;
            var xmlMsg:String;
            var rv:Object;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            header = {t:"sys"};
            if (setOwnership){
                xmlMsg = "<vars>";
            }
            else {
                xmlMsg = "<vars so='0'>";
            };
            for each (rv in varList) {
                xmlMsg = (xmlMsg + getXmlRoomVariable(rv));
            };
            xmlMsg = (xmlMsg + "</vars>");
            send(header, "setRvars", roomId, xmlMsg);
        }
        public function addBuddy(buddyName:String):void{
            var xmlMsg:String;
            if (((!((buddyName == myUserName))) && (!(checkBuddyDuplicates(buddyName))))){
                xmlMsg = (("<n>" + buddyName) + "</n>");
                send({t:"sys"}, "addB", -1, xmlMsg);
            };
        }
        public function clearRoomList():void{
            this.roomList = [];
        }
        public function getVersion():String{
            return (((((this.majVersion + ".") + this.minVersion) + ".") + this.subVersion));
        }
        public function setUserVariables(varObj:Object, roomId:int=-1):void{
            var header:Object;
            var currRoom:Room;
            var user:User;
            var userId:int;
            var room:Room;
            var xmlMsg:String;
            var varOwner:User;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            header = {t:"sys"};
            currRoom = getActiveRoom();
            user = currRoom.getUser(myUserId);
            user.setVariables(varObj);
            userId = user.getId();
            for each (room in getAllRooms()) {
                varOwner = room.getUser(userId);
                if (((!((varOwner == null))) && (!((varOwner == user))))){
                    varOwner.setVariables(varObj);
                };
            };
            xmlMsg = getXmlUserVariable(varObj);
            send(header, "setUvars", roomId, xmlMsg);
        }
        public function sendPrivateMessage(message:String, recipientId:int, roomId:int=-1):void{
            var header:Object;
            var xmlMsg:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            header = {t:"sys"};
            xmlMsg = (((("<txt rcp='" + recipientId) + "'><![CDATA[") + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "prvMsg", roomId, xmlMsg);
        }
        public function getBuddyByName(buddyName:String):Object{
            var buddy:Object;
            for each (buddy in buddyList) {
                if (buddy.name == buddyName){
                    return (buddy);
                };
            };
            return (null);
        }
        private function closeHeader():String{
            return ("</msg>");
        }
        public function sendPublicMessage(message:String, roomId:int=-1):void{
            var header:Object;
            var xmlMsg:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            header = {t:"sys"};
            xmlMsg = (("<txt><![CDATA[" + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "pubMsg", roomId, xmlMsg);
        }
        public function clearBuddyList():void{
            var params:Object;
            var evt:SFSEvent;
            buddyList = [];
            send({t:"sys"}, "clearB", -1, "");
            params = {};
            params.list = buddyList;
            evt = new SFSEvent(SFSEvent.onBuddyList, params);
            dispatchEvent(evt);
        }
        public function sendString(strMessage:String):void{
            debugMessage((("[Sending - STR]: " + strMessage) + "\n"));
            if (isHttpMode){
                httpConnection.send(strMessage);
            }
            else {
                writeToSocket(strMessage);
            };
        }
        public function removeBuddy(buddyName:String):void{
            var found:Boolean;
            var buddy:Object;
            var it:String;
            var header:Object;
            var xmlMsg:String;
            var params:Object;
            var evt:SFSEvent;
            found = false;
            for (it in buddyList) {
                buddy = buddyList[it];
                if (buddy.name == buddyName){
                    delete buddyList[it];
                    found = true;
                    break;
                };
            };
            if (found){
                header = {t:"sys"};
                xmlMsg = (("<n>" + buddyName) + "</n>");
                send(header, "remB", -1, xmlMsg);
                params = {};
                params.list = buddyList;
                evt = new SFSEvent(SFSEvent.onBuddyList, params);
                dispatchEvent(evt);
            };
        }
        public function setBuddyBlockStatus(buddyName:String, status:Boolean):void{
            var b:Object;
            var xmlMsg:String;
            var params:Object;
            var evt:SFSEvent;
            b = getBuddyByName(buddyName);
            if (b != null){
                if (b.isBlocked != status){
                    b.isBlocked = status;
                    xmlMsg = (((("<n x='" + ((status) ? "1" : "0")) + "'>") + buddyName) + "</n>");
                    send({t:"sys"}, "setB", -1, xmlMsg);
                    params = {};
                    params.buddy = b;
                    evt = new SFSEvent(SFSEvent.onBuddyListUpdate, params);
                    dispatchEvent(evt);
                };
            };
        }
        private function handleMessage(msg:String):void{
            var type:String;
            if (msg != "ok"){
                debugMessage((((("[ RECEIVED ]: " + msg) + ", (len: ") + msg.length) + ")"));
            };
            type = msg.charAt(0);
            if (type == MSG_XML){
                xmlReceived(msg);
            }
            else {
                if (type == MSG_STR){
                    strReceived(msg);
                }
                else {
                    if (type == MSG_JSON){
                        jsonReceived(msg);
                    };
                };
            };
        }
        public function getUploadPath():String{
            return ((((("http://" + this.ipAddress) + ":") + this.httpPort) + "/default/uploads/"));
        }
        private function handleHttpData(evt:HttpEvent):void{
            var data:String;
            var messages:Array;
            var message:String;
            var i:int;
            data = (evt.params.data as String);
            messages = data.split("\n");
            if (messages[0] != ""){
                i = 0;
                while (i < (messages.length - 1)) {
                    message = messages[i];
                    if (message.length > 0){
                        handleMessage(message);
                    };
                    i++;
                };
                if (this._httpPollSpeed > 0){
                    setTimeout(this.handleDelayedPoll, this._httpPollSpeed);
                }
                else {
                    handleDelayedPoll();
                };
            };
        }
        public function loadConfig(configFile:String="config.xml", autoConnect:Boolean=true):void{
            var loader:URLLoader;
            this.autoConnectOnConfigSuccess = autoConnect;
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onConfigLoadSuccess);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onConfigLoadFailure);
            loader.load(new URLRequest(configFile));
        }
        public function set rawProtocolSeparator(value:String):void{
            if (((!((value == "<"))) && (!((value == "{"))))){
                MSG_STR = value;
            };
        }
        private function writeToSocket(msg:String):void{
            var byteBuff:ByteArray;
            byteBuff = new ByteArray();
            byteBuff.writeUTFBytes(msg);
            byteBuff.writeByte(0);
            socketConnection.writeBytes(byteBuff);
            socketConnection.flush();
        }
        private function initialize(isLogOut:Boolean=false):void{
            this.changingRoom = false;
            this.amIModerator = false;
            this.playerId = -1;
            this.activeRoomId = -1;
            this.myUserId = -1;
            this.myUserName = "";
            this.roomList = [];
            this.buddyList = [];
            this.myBuddyVars = [];
            if (!isLogOut){
                this.connected = false;
                this.isHttpMode = false;
            };
        }
        public function sendXtMessage(xtName:String, cmd:String, paramObj, type:String="xml", roomId:int=-1):void{
            var header:Object;
            var xtReq:Object;
            var xmlmsg:String;
            var hdr:String;
            var i:Number;
            var body:Object;
            var obj:Object;
            var msg:String;
            if (!checkRoomList()){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            if (type == XTMSG_TYPE_XML){
                header = {t:"xt"};
                xtReq = {
                    name:xtName,
                    cmd:cmd,
                    param:paramObj
                };
                xmlmsg = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(xtReq)) + "]]>");
                send(header, "xtReq", roomId, xmlmsg);
            }
            else {
                if (type == XTMSG_TYPE_STR){
                    hdr = ((((((((MSG_STR + "xt") + MSG_STR) + xtName) + MSG_STR) + cmd) + MSG_STR) + roomId) + MSG_STR);
                    i = 0;
                    while (i < paramObj.length) {
                        hdr = (hdr + (paramObj[i].toString() + MSG_STR));
                        i++;
                    };
                    sendString(hdr);
                }
                else {
                    if (type == XTMSG_TYPE_JSON){
                        body = {};
                        body.x = xtName;
                        body.c = cmd;
                        body.r = roomId;
                        body.p = paramObj;
                        obj = {};
                        obj.t = "xt";
                        obj.b = body;
                        msg = JSON.encode(obj);
                        sendJson(msg);
                    };
                };
            };
        }
        public function sendObjectToGroup(obj:Object, userList:Array, roomId:int=-1):void{
            var strList:String;
            var i:String;
            var header:Object;
            var xmlMsg:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            strList = "";
            for (i in userList) {
                if (!isNaN(userList[i])){
                    strList = (strList + (userList[i] + ","));
                };
            };
            strList = strList.substr(0, (strList.length - 1));
            obj._$$_ = strList;
            header = {t:"sys"};
            xmlMsg = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(obj)) + "]]>");
            send(header, "asObjG", roomId, xmlMsg);
        }
        public function get rawProtocolSeparator():String{
            return (MSG_STR);
        }
        public function getRandomKey():void{
            send({t:"sys"}, "rndK", -1, "");
        }
        public function sendObject(obj:Object, roomId:int=-1):void{
            var xmlData:String;
            var header:Object;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            xmlData = (("<![CDATA[" + ObjectSerializer.getInstance().serialize(obj)) + "]]>");
            header = {t:"sys"};
            send(header, "asObj", roomId, xmlData);
        }
        public function connect(ipAdr:String, port:int=9339):void{
            if (!connected){
                initialize();
                this.ipAddress = ipAdr;
                this.port = port;
                socketConnection.connect(ipAdr, port);
            }
            else {
                debugMessage("*** ALREADY CONNECTED ***");
            };
        }
        public function sendBuddyPermissionResponse(allowBuddy:Boolean, targetBuddy:String):void{
            var header:Object;
            var xmlMsg:String;
            header = {t:"sys"};
            xmlMsg = (((("<n res='" + ((allowBuddy) ? "g" : "r")) + "'>") + targetBuddy) + "</n>");
            send(header, "bPrm", -1, xmlMsg);
        }
        public function sendModeratorMessage(message:String, type:String, id:int=-1):void{
            var header:Object;
            var xmlMsg:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            header = {t:"sys"};
            xmlMsg = (((((("<txt t='" + type) + "' id='") + id) + "'><![CDATA[") + Entities.encodeEntities(message)) + "]]></txt>");
            send(header, "modMsg", activeRoomId, xmlMsg);
        }
        public function getBenchStartTime():int{
            return (this.benchStartTime);
        }
        public function createRoom(roomObj:Object, roomId:int=-1):void{
            var header:Object;
            var isGame:String;
            var exitCurrentRoom:String;
            var maxUsers:String;
            var maxSpectators:String;
            var joinAsSpectator:String;
            var xmlMsg:String;
            var i:String;
            if (((!(checkRoomList())) || (!(checkJoin())))){
                return;
            };
            if (roomId == -1){
                roomId = activeRoomId;
            };
            header = {t:"sys"};
            isGame = ((roomObj.isGame) ? "1" : "0");
            exitCurrentRoom = "1";
            maxUsers = (((roomObj.maxUsers == null)) ? "0" : String(roomObj.maxUsers));
            maxSpectators = (((roomObj.maxSpectators == null)) ? "0" : String(roomObj.maxSpectators));
            joinAsSpectator = ((roomObj.joinAsSpectator) ? "1" : "0");
            if (((roomObj.isGame) && (!((roomObj.exitCurrentRoom == null))))){
                exitCurrentRoom = ((roomObj.exitCurrentRoom) ? "1" : "0");
            };
            xmlMsg = (((((((("<room tmp='1' gam='" + isGame) + "' spec='") + maxSpectators) + "' exit='") + exitCurrentRoom) + "' jas='") + joinAsSpectator) + "'>");
            xmlMsg = (xmlMsg + (("<name><![CDATA[" + (((roomObj.name == null)) ? "" : roomObj.name)) + "]]></name>"));
            xmlMsg = (xmlMsg + (("<pwd><![CDATA[" + (((roomObj.password == null)) ? "" : roomObj.password)) + "]]></pwd>"));
            xmlMsg = (xmlMsg + (("<max>" + maxUsers) + "</max>"));
            if (roomObj.uCount != null){
                xmlMsg = (xmlMsg + (("<uCnt>" + ((roomObj.uCount) ? "1" : "0")) + "</uCnt>"));
            };
            if (roomObj.extension != null){
                xmlMsg = (xmlMsg + ("<xt n='" + roomObj.extension.name));
                xmlMsg = (xmlMsg + (("' s='" + roomObj.extension.script) + "' />"));
            };
            if (roomObj.vars == null){
                xmlMsg = (xmlMsg + "<vars></vars>");
            }
            else {
                xmlMsg = (xmlMsg + "<vars>");
                for (i in roomObj.vars) {
                    xmlMsg = (xmlMsg + getXmlRoomVariable(roomObj.vars[i]));
                };
                xmlMsg = (xmlMsg + "</vars>");
            };
            xmlMsg = (xmlMsg + "</room>");
            send(header, "createRoom", roomId, xmlMsg);
        }
        private function handleDelayedPoll():void{
            httpConnection.send(HTTP_POLL_REQUEST);
        }
        private function handleHttpConnect(evt:HttpEvent):void{
            this.handleSocketConnection(null);
            connected = true;
            httpConnection.send(HTTP_POLL_REQUEST);
        }
        public function set isConnected(b:Boolean):void{
            this.connected = b;
        }
        public function get isConnected():Boolean{
            return (this.connected);
        }

    }
}//package it.gotoandplay.smartfoxserver

