// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//it.gotoandplay.smartfoxserver.handlers.SysHandler

package it.gotoandplay.smartfoxserver.handlers{
    import it.gotoandplay.smartfoxserver.SmartFoxClient;
    import it.gotoandplay.smartfoxserver.SFSEvent;
    import it.gotoandplay.smartfoxserver.data.Room;
    import it.gotoandplay.smartfoxserver.data.User;
    import it.gotoandplay.smartfoxserver.util.Entities;
    import flash.utils.getTimer;
    import it.gotoandplay.smartfoxserver.util.ObjectSerializer;

    public class SysHandler implements IMessageHandler {

        private var sfs:SmartFoxClient;
        private var handlersTable:Array;

        public function SysHandler(sfs:SmartFoxClient){
            this.sfs = sfs;
            handlersTable = [];
            handlersTable["apiOK"] = this.handleApiOK;
            handlersTable["apiKO"] = this.handleApiKO;
            handlersTable["logOK"] = this.handleLoginOk;
            handlersTable["logKO"] = this.handleLoginKo;
            handlersTable["logout"] = this.handleLogout;
            handlersTable["rmList"] = this.handleRoomList;
            handlersTable["uCount"] = this.handleUserCountChange;
            handlersTable["joinOK"] = this.handleJoinOk;
            handlersTable["joinKO"] = this.handleJoinKo;
            handlersTable["uER"] = this.handleUserEnterRoom;
            handlersTable["userGone"] = this.handleUserLeaveRoom;
            handlersTable["pubMsg"] = this.handlePublicMessage;
            handlersTable["prvMsg"] = this.handlePrivateMessage;
            handlersTable["dmnMsg"] = this.handleAdminMessage;
            handlersTable["modMsg"] = this.handleModMessage;
            handlersTable["dataObj"] = this.handleASObject;
            handlersTable["rVarsUpdate"] = this.handleRoomVarsUpdate;
            handlersTable["roomAdd"] = this.handleRoomAdded;
            handlersTable["roomDel"] = this.handleRoomDeleted;
            handlersTable["rndK"] = this.handleRandomKey;
            handlersTable["roundTripRes"] = this.handleRoundTripBench;
            handlersTable["uVarsUpdate"] = this.handleUserVarsUpdate;
            handlersTable["createRmKO"] = this.handleCreateRoomError;
            handlersTable["bList"] = this.handleBuddyList;
            handlersTable["bUpd"] = this.handleBuddyListUpdate;
            handlersTable["bAdd"] = this.handleBuddyAdded;
            handlersTable["roomB"] = this.handleBuddyRoom;
            handlersTable["leaveRoom"] = this.handleLeaveRoom;
            handlersTable["swSpec"] = this.handleSpectatorSwitched;
            handlersTable["bPrm"] = this.handleAddBuddyPermission;
            handlersTable["remB"] = this.handleRemoveBuddy;
        }
        private function handleRoomDeleted(o:Object):void{
            var roomId:int;
            var roomList:Array;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.rm.@id);
            roomList = sfs.getAllRooms();
            if (roomList[roomId] != null){
                params = {};
                params.room = roomList[roomId];
                delete roomList[roomId];
                evt = new SFSEvent(SFSEvent.onRoomDeleted, params);
                sfs.dispatchEvent(evt);
            };
        }
        public function handleMessage(msgObj:Object, type:String):void{
            var xmlData:XML;
            var action:String;
            var fn:Function;
            xmlData = (msgObj as XML);
            action = xmlData.body.@action;
            fn = handlersTable[action];
            if (fn != null){
                fn.apply(this, [msgObj]);
            }
            else {
                trace(("Unknown sys command: " + action));
            };
        }
        public function handleUserEnterRoom(o:Object):void{
            var roomId:int;
            var usrId:int;
            var usrName:String;
            var isMod:Boolean;
            var isSpec:Boolean;
            var pid:int;
            var varList:XMLList;
            var currRoom:Room;
            var newUser:User;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            usrId = int(o.body.u.@i);
            usrName = o.body.u.n;
            isMod = (o.body.u.@m == "1");
            isSpec = (o.body.u.@s == "1");
            pid = (((o.body.u.@p)!=null) ? int(o.body.u.@p) : -1);
            varList = o.body.u.vars["var"];
            currRoom = sfs.getRoom(roomId);
            newUser = new User(usrId, usrName);
            newUser.setModerator(isMod);
            newUser.setIsSpectator(isSpec);
            newUser.setPlayerId(pid);
            currRoom.addUser(newUser, usrId);
            if (o.body.u.vars.toString().length > 0){
                populateVariables(newUser.getVariables(), o.body.u);
            };
            params = {};
            params.roomId = roomId;
            params.user = newUser;
            evt = new SFSEvent(SFSEvent.onUserEnterRoom, params);
            sfs.dispatchEvent(evt);
        }
        public function handleUserVarsUpdate(o:Object):void{
            var userId:int;
            var changedVars:Array;
            var varOwner:User;
            var returnUser:User;
            var room:Room;
            var params:Object;
            var evt:SFSEvent;
            userId = int(o.body.user.@id);
            varOwner = null;
            returnUser = null;
            if (o.body.vars.toString().length > 0){
                for each (room in sfs.getAllRooms()) {
                    varOwner = room.getUser(userId);
                    if (varOwner != null){
                        if (returnUser == null){
                            returnUser = varOwner;
                        };
                        changedVars = [];
                        populateVariables(varOwner.getVariables(), o.body, changedVars);
                    };
                };
                params = {};
                params.user = returnUser;
                params.changedVars = changedVars;
                evt = new SFSEvent(SFSEvent.onUserVariablesUpdate, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleCreateRoomError(o:Object):void{
            var errMsg:String;
            var params:Object;
            var evt:SFSEvent;
            errMsg = o.body.room.@e;
            params = {};
            params.error = errMsg;
            evt = new SFSEvent(SFSEvent.onCreateRoomError, params);
            sfs.dispatchEvent(evt);
        }
        public function handlePrivateMessage(o:Object):void{
            var roomId:int;
            var userId:int;
            var message:String;
            var theRoom:*;
            var sender:User;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            message = o.body.txt;
            theRoom = sfs.getRoom(roomId);
            sender = null;
            if (theRoom != null){
                sender = theRoom.getUser(userId);
            };
            params = {};
            params.message = Entities.decodeEntities(message);
            params.sender = sender;
            params.roomId = roomId;
            params.userId = userId;
            evt = new SFSEvent(SFSEvent.onPrivateMessage, params);
            sfs.dispatchEvent(evt);
        }
        private function handleBuddyRoom(o:Object):void{
            var roomIds:String;
            var ids:Array;
            var i:int;
            var params:Object;
            var evt:SFSEvent;
            roomIds = o.body.br.@r;
            ids = roomIds.split(",");
            i = 0;
            while (i < ids.length) {
                ids[i] = int(ids[i]);
                i++;
            };
            params = {};
            params.idList = ids;
            evt = new SFSEvent(SFSEvent.onBuddyRoom, params);
            sfs.dispatchEvent(evt);
        }
        public function handleLogout(o:Object):void{
            var evt:SFSEvent;
            sfs.__logout();
            evt = new SFSEvent(SFSEvent.onLogout, {});
            sfs.dispatchEvent(evt);
        }
        public function handleUserCountChange(o:Object):void{
            var uCount:int;
            var sCount:int;
            var roomId:int;
            var room:Room;
            var params:Object;
            var evt:SFSEvent;
            uCount = int(o.body.@u);
            sCount = int(o.body.@s);
            roomId = int(o.body.@r);
            room = sfs.getAllRooms()[roomId];
            if (room != null){
                room.setUserCount(uCount);
                room.setSpectatorCount(sCount);
                params = {};
                params.room = room;
                evt = new SFSEvent(SFSEvent.onUserCountChange, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleRandomKey(o:Object):void{
            var key:String;
            var params:Object;
            var evt:SFSEvent;
            key = o.body.k.toString();
            params = {};
            params.key = key;
            evt = new SFSEvent(SFSEvent.onRandomKey, params);
            sfs.dispatchEvent(evt);
        }
        public function handlePublicMessage(o:Object):void{
            var roomId:int;
            var userId:int;
            var message:String;
            var sender:User;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            message = o.body.txt;
            sender = sfs.getRoom(roomId).getUser(userId);
            params = {};
            params.message = Entities.decodeEntities(message);
            params.sender = sender;
            params.roomId = roomId;
            evt = new SFSEvent(SFSEvent.onPublicMessage, params);
            sfs.dispatchEvent(evt);
        }
        public function handleAdminMessage(o:Object):void{
            var roomId:int;
            var userId:int;
            var message:String;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            message = o.body.txt;
            params = {};
            params.message = Entities.decodeEntities(message);
            evt = new SFSEvent(SFSEvent.onAdminMessage, params);
            sfs.dispatchEvent(evt);
        }
        public function dispatchDisconnection():void{
            var evt:SFSEvent;
            evt = new SFSEvent(SFSEvent.onConnectionLost, null);
            sfs.dispatchEvent(evt);
        }
        private function handleRemoveBuddy(o:Object):void{
            var buddyName:String;
            var buddy:Object;
            var it:String;
            var params:Object;
            var evt:SFSEvent;
            buddyName = o.body.n.toString();
            buddy = null;
            for (it in sfs.buddyList) {
                buddy = sfs.buddyList[it];
                if (buddy.name == buddyName){
                    delete sfs.buddyList[it];
                    params = {};
                    params.list = sfs.buddyList;
                    evt = new SFSEvent(SFSEvent.onBuddyList, params);
                    sfs.dispatchEvent(evt);
                    break;
                };
            };
        }
        private function handleAddBuddyPermission(o:Object):void{
            var params:Object;
            var evt:SFSEvent;
            params = {};
            params.sender = o.body.n.toString();
            params.message = "";
            if (o.body.txt != undefined){
                params.message = Entities.decodeEntities(o.body.txt);
            };
            evt = new SFSEvent(SFSEvent.onBuddyPermissionRequest, params);
            sfs.dispatchEvent(evt);
        }
        public function handleLoginOk(o:Object):void{
            var uid:int;
            var mod:int;
            var name:String;
            var params:Object;
            var evt:SFSEvent;
            uid = int(o.body.login.@id);
            mod = int(o.body.login.@mod);
            name = o.body.login.@n;
            sfs.amIModerator = (mod == 1);
            sfs.myUserId = uid;
            sfs.myUserName = name;
            sfs.playerId = -1;
            params = {};
            params.success = true;
            params.name = name;
            params.error = "";
            evt = new SFSEvent(SFSEvent.onLogin, params);
            sfs.dispatchEvent(evt);
            sfs.getRoomList();
        }
        public function handleUserLeaveRoom(o:Object):void{
            var userId:int;
            var roomId:int;
            var theRoom:Room;
            var uName:String;
            var params:Object;
            var evt:SFSEvent;
            userId = int(o.body.user.@id);
            roomId = int(o.body.@r);
            theRoom = sfs.getRoom(roomId);
            if (theRoom == null){
                trace(("WARN - Leave Room not found, id: " + roomId));
                return;
            };
            uName = theRoom.getUser(userId).getName();
            theRoom.removeUser(userId);
            params = {};
            params.roomId = roomId;
            params.userId = userId;
            params.userName = uName;
            evt = new SFSEvent(SFSEvent.onUserLeaveRoom, params);
            sfs.dispatchEvent(evt);
        }
        public function handleRoomList(o:Object):void{
            var roomList:Array;
            var tempList:Array;
            var roomXml:XML;
            var params:Object;
            var evt:SFSEvent;
            var roomId:int;
            var room:Room;
            var oldRoom:Room;
            roomList = sfs.getAllRooms();
            tempList = [];
            for each (roomXml in o.body.rmList.rm) {
                roomId = int(roomXml.@id);
                room = new Room(roomId, roomXml.n, int(roomXml.@maxu), int(roomXml.@maxs), (roomXml.@temp == "1"), (roomXml.@game == "1"), (roomXml.@priv == "1"), (roomXml.@lmb == "1"), int(roomXml.@ucnt), int(roomXml.@scnt));
                if (roomXml.vars.toString().length > 0){
                    populateVariables(room.getVariables(), roomXml);
                };
                oldRoom = roomList[roomId];
                if (oldRoom != null){
                    room.setVariables(oldRoom.getVariables());
                    room.setUserList(oldRoom.getUserList());
                };
                tempList[roomId] = room;
            };
            sfs.setRoomList(tempList);
            params = {};
            params.roomList = tempList;
            evt = new SFSEvent(SFSEvent.onRoomListUpdate, params);
            sfs.dispatchEvent(evt);
        }
        private function handleBuddyAdded(o:Object):void{
            var buddy:Object;
            var bVars:XMLList;
            var params:Object;
            var evt:SFSEvent;
            var bVar:XML;
            buddy = {};
            buddy.isOnline = (((o.body.b.@s == "1")) ? true : false);
            buddy.name = o.body.b.n.toString();
            buddy.id = o.body.b.@i;
            buddy.isBlocked = (((o.body.b.@x == "1")) ? true : false);
            buddy.variables = {};
            bVars = o.body.b.vs;
            if (bVars.toString().length > 0){
                for each (bVar in bVars.v) {
                    buddy.variables[bVar.@n.toString()] = bVar.toString();
                };
            };
            sfs.buddyList.push(buddy);
            params = {};
            params.list = sfs.buddyList;
            evt = new SFSEvent(SFSEvent.onBuddyList, params);
            sfs.dispatchEvent(evt);
        }
        private function handlePlayerSwitched(o:Object):void{
            var roomId:int;
            var playerId:int;
            var isItMe:Boolean;
            var theRoom:Room;
            var userId:int;
            var user:User;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            playerId = int(o.body.pid.@id);
            isItMe = (o.body.pid.@u == undefined);
            theRoom = sfs.getRoom(roomId);
            if (playerId == -1){
                theRoom.setUserCount((theRoom.getUserCount() - 1));
                theRoom.setSpectatorCount((theRoom.getSpectatorCount() + 1));
                if (!isItMe){
                    userId = int(o.body.pid.@u);
                    user = theRoom.getUser(userId);
                    if (user != null){
                        user.setIsSpectator(true);
                        user.setPlayerId(playerId);
                    };
                };
            };
            if (isItMe){
                sfs.playerId = playerId;
                params = {};
                params.success = (playerId == -1);
                params.newId = playerId;
                params.room = theRoom;
                evt = new SFSEvent(SFSEvent.onPlayerSwitched, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleRoomAdded(o:Object):void{
            var rId:int;
            var rName:String;
            var rMax:int;
            var rSpec:int;
            var isTemp:Boolean;
            var isGame:Boolean;
            var isPriv:Boolean;
            var isLimbo:Boolean;
            var newRoom:Room;
            var rList:Array;
            var params:Object;
            var evt:SFSEvent;
            rId = int(o.body.rm.@id);
            rName = o.body.rm.name;
            rMax = int(o.body.rm.@max);
            rSpec = int(o.body.rm.@spec);
            isTemp = (((o.body.rm.@temp == "1")) ? true : false);
            isGame = (((o.body.rm.@game == "1")) ? true : false);
            isPriv = (((o.body.rm.@priv == "1")) ? true : false);
            isLimbo = (((o.body.rm.@limbo == "1")) ? true : false);
            newRoom = new Room(rId, rName, rMax, rSpec, isTemp, isGame, isPriv, isLimbo);
            rList = sfs.getAllRooms();
            rList[rId] = newRoom;
            if (o.body.rm.vars.toString().length > 0){
                populateVariables(newRoom.getVariables(), o.body.rm);
            };
            params = {};
            params.room = newRoom;
            evt = new SFSEvent(SFSEvent.onRoomAdded, params);
            sfs.dispatchEvent(evt);
        }
        private function populateVariables(variables:Array, xmlData:Object, changedVars:Array=null):void{
            var v:XML;
            var vName:String;
            var vType:String;
            var vValue:String;
            for each (v in xmlData.vars["var"]) {
                vName = v.@n;
                vType = v.@t;
                vValue = v;
                if (changedVars != null){
                    changedVars.push(vName);
                    changedVars[vName] = true;
                };
                if (vType == "b"){
                    variables[vName] = (((vValue == "1")) ? true : false);
                }
                else {
                    if (vType == "n"){
                        variables[vName] = Number(vValue);
                    }
                    else {
                        if (vType == "s"){
                            variables[vName] = vValue;
                        }
                        else {
                            if (vType == "x"){
                                delete variables[vName];
                            };
                        };
                    };
                };
            };
        }
        public function handleRoomVarsUpdate(o:Object):void{
            var roomId:int;
            var userId:int;
            var theRoom:Room;
            var changedVars:Array;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            theRoom = sfs.getRoom(roomId);
            changedVars = [];
            if (theRoom != null){
                if (o.body.vars.toString().length > 0){
                    populateVariables(theRoom.getVariables(), o.body, changedVars);
                };
                params = {};
                params.room = theRoom;
                params.changedVars = changedVars;
                evt = new SFSEvent(SFSEvent.onRoomVariablesUpdate, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleSpectatorSwitched(o:Object):void{
            var roomId:int;
            var playerId:int;
            var theRoom:Room;
            var userId:int;
            var user:User;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            playerId = int(o.body.pid.@id);
            theRoom = sfs.getRoom(roomId);
            if (playerId > 0){
                theRoom.setUserCount((theRoom.getUserCount() + 1));
                theRoom.setSpectatorCount((theRoom.getSpectatorCount() - 1));
            };
            if (o.body.pid.@u != undefined){
                userId = int(o.body.pid.@u);
                user = theRoom.getUser(userId);
                if (user != null){
                    user.setIsSpectator(false);
                    user.setPlayerId(playerId);
                };
            }
            else {
                sfs.playerId = playerId;
                params = {};
                params.success = (sfs.playerId > 0);
                params.newId = sfs.playerId;
                params.room = theRoom;
                evt = new SFSEvent(SFSEvent.onSpectatorSwitched, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleLeaveRoom(o:Object):void{
            var roomLeft:int;
            var roomList:Array;
            var params:Object;
            var evt:SFSEvent;
            roomLeft = int(o.body.rm.@id);
            roomList = sfs.getAllRooms();
            if (roomList[roomLeft]){
                params = {};
                params.roomId = roomLeft;
                evt = new SFSEvent(SFSEvent.onRoomLeft, params);
                sfs.dispatchEvent(evt);
            };
        }
        private function handleBuddyListUpdate(o:Object):void{
            var params:Object;
            var evt:SFSEvent;
            var buddy:Object;
            var bVars:XMLList;
            var tempB:Object;
            var found:Boolean;
            var it:String;
            var bVar:XML;
            params = {};
            evt = null;
            if (o.body.err.toString().length > 0){
                params.error = o.body.err.toString();
                evt = new SFSEvent(SFSEvent.onBuddyListError, params);
                sfs.dispatchEvent(evt);
                return;
            };
            if (o.body.b != null){
                buddy = {};
                buddy.isOnline = (((o.body.b.@s == "1")) ? true : false);
                buddy.name = o.body.b.n.toString();
                buddy.id = o.body.b.@i;
                buddy.isBlocked = (((o.body.b.@x == "1")) ? true : false);
                bVars = o.body.b.vs;
                tempB = null;
                found = false;
                for (it in sfs.buddyList) {
                    tempB = sfs.buddyList[it];
                    if (tempB.name == buddy.name){
                        sfs.buddyList[it] = buddy;
                        buddy.isBlocked = tempB.isBlocked;
                        buddy.variables = tempB.variables;
                        if (bVars.toString().length > 0){
                            for each (bVar in bVars.v) {
                                buddy.variables[bVar.@n.toString()] = bVar.toString();
                            };
                        };
                        found = true;
                        break;
                    };
                };
                if (found){
                    params.buddy = buddy;
                    evt = new SFSEvent(SFSEvent.onBuddyListUpdate, params);
                    sfs.dispatchEvent(evt);
                };
            };
        }
        public function handleLoginKo(o:Object):void{
            var params:Object;
            var evt:SFSEvent;
            params = {};
            params.success = false;
            params.error = o.body.login.@e;
            evt = new SFSEvent(SFSEvent.onLogin, params);
            sfs.dispatchEvent(evt);
        }
        public function handleModMessage(o:Object):void{
            var roomId:int;
            var userId:int;
            var message:String;
            var sender:User;
            var room:Room;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            message = o.body.txt;
            sender = null;
            room = sfs.getRoom(roomId);
            if (room != null){
                sender = room.getUser(userId);
            };
            params = {};
            params.message = Entities.decodeEntities(message);
            params.sender = sender;
            evt = new SFSEvent(SFSEvent.onModeratorMessage, params);
            sfs.dispatchEvent(evt);
        }
        public function handleApiOK(o:Object):void{
            var evt:SFSEvent;
            sfs.isConnected = true;
            evt = new SFSEvent(SFSEvent.onConnection, {success:true});
            sfs.dispatchEvent(evt);
        }
        private function fakeRoomAdd(roomID:int):void{
            var rId:int;
            var rName:String;
            var rMax:int;
            var rSpec:int;
            var isTemp:Boolean;
            var isGame:Boolean;
            var isPriv:Boolean;
            var isLimbo:Boolean;
            var newRoom:Room;
            var rList:Array;
            rId = int(roomID);
            rName = String(roomID);
            rMax = 20;
            rSpec = 0;
            isTemp = false;
            isGame = true;
            isPriv = false;
            isLimbo = false;
            newRoom = new Room(rId, rName, rMax, rSpec, isTemp, isGame, isPriv, isLimbo);
            rList = sfs.getAllRooms();
            rList[rId] = newRoom;
        }
        private function handleRoundTripBench(o:Object):void{
            var now:int;
            var res:int;
            var params:Object;
            var evt:SFSEvent;
            now = getTimer();
            res = (now - sfs.getBenchStartTime());
            params = {};
            params.elapsed = res;
            evt = new SFSEvent(SFSEvent.onRoundTripResponse, params);
            sfs.dispatchEvent(evt);
        }
        public function handleJoinOk(o:Object):void{
            var roomId:int;
            var roomVarsXml:XMLList;
            var userListXml:XMLList;
            var playerId:int;
            var currRoom:Room;
            var usr:XML;
            var params:Object;
            var evt:SFSEvent;
            var name:String;
            var id:int;
            var isMod:Boolean;
            var isSpec:Boolean;
            var pId:int;
            var user:User;
            roomId = int(o.body.@r);
            roomVarsXml = o.body;
            userListXml = o.body.uLs.u;
            playerId = int(o.body.pid.@id);
            if (roomId != 1){
                fakeRoomAdd(roomId);
            };
            sfs.activeRoomId = roomId;
            currRoom = sfs.getRoom(roomId);
            currRoom.clearUserList();
            sfs.playerId = playerId;
            currRoom.setMyPlayerIndex(playerId);
            if (roomVarsXml.vars.toString().length > 0){
                currRoom.clearVariables();
                populateVariables(currRoom.getVariables(), roomVarsXml);
            };
            for each (usr in userListXml) {
                name = usr.n;
                id = int(usr.@i);
                isMod = (((usr.@m == "1")) ? true : false);
                isSpec = (((usr.@s == "1")) ? true : false);
                pId = (((usr.@p == null)) ? -1 : int(usr.@p));
                user = new User(id, name);
                user.setModerator(isMod);
                user.setIsSpectator(isSpec);
                user.setPlayerId(pId);
                if (usr.vars.toString().length > 0){
                    populateVariables(user.getVariables(), usr);
                };
                currRoom.addUser(user, id);
            };
            sfs.changingRoom = false;
            params = {};
            params.room = currRoom;
            evt = new SFSEvent(SFSEvent.onJoinRoom, params);
            sfs.dispatchEvent(evt);
        }
        public function handleJoinKo(o:Object):void{
            var params:Object;
            var evt:SFSEvent;
            sfs.changingRoom = false;
            params = {};
            params.error = o.body.error.@msg;
            evt = new SFSEvent(SFSEvent.onJoinRoomError, params);
            sfs.dispatchEvent(evt);
        }
        public function handleASObject(o:Object):void{
            var roomId:int;
            var userId:int;
            var xmlStr:String;
            var sender:User;
            var asObj:Object;
            var params:Object;
            var evt:SFSEvent;
            roomId = int(o.body.@r);
            userId = int(o.body.user.@id);
            xmlStr = o.body.dataObj;
            sender = sfs.getRoom(roomId).getUser(userId);
            asObj = ObjectSerializer.getInstance().deserialize(new XML(xmlStr));
            params = {};
            params.obj = asObj;
            params.sender = sender;
            evt = new SFSEvent(SFSEvent.onObjectReceived, params);
            sfs.dispatchEvent(evt);
        }
        private function handleBuddyList(o:Object):void{
            var bList:XMLList;
            var myVars:XMLList;
            var buddy:Object;
            var params:Object;
            var evt:SFSEvent;
            var myVar:XML;
            var b:XML;
            var bVars:XMLList;
            var bVar:XML;
            bList = o.body.bList;
            myVars = o.body.mv;
            params = {};
            evt = null;
            if (((!((myVars == null))) && ((myVars.toString().length > 0)))){
                for each (myVar in myVars.v) {
                    sfs.myBuddyVars[myVar.@n.toString()] = myVar.toString();
                };
            };
            if (((!((bList == null))) && (!((bList.b.length == null))))){
                if (bList.toString().length > 0){
                    for each (b in bList.b) {
                        buddy = {};
                        buddy.isOnline = (((b.@s == "1")) ? true : false);
                        buddy.name = b.n.toString();
                        buddy.id = b.@i;
                        buddy.isBlocked = (((b.@x == "1")) ? true : false);
                        buddy.variables = {};
                        bVars = b.vs;
                        if (bVars.toString().length > 0){
                            for each (bVar in bVars.v) {
                                buddy.variables[bVar.@n.toString()] = bVar.toString();
                            };
                        };
                        sfs.buddyList.push(buddy);
                    };
                };
                params.list = sfs.buddyList;
                evt = new SFSEvent(SFSEvent.onBuddyList, params);
                sfs.dispatchEvent(evt);
            }
            else {
                params.error = o.body.err.toString();
                evt = new SFSEvent(SFSEvent.onBuddyListError, params);
                sfs.dispatchEvent(evt);
            };
        }
        public function handleApiKO(o:Object):void{
            var params:Object;
            var evt:SFSEvent;
            params = {};
            params.success = false;
            params.error = "API are obsolete, please upgrade";
            evt = new SFSEvent(SFSEvent.onConnection, params);
            sfs.dispatchEvent(evt);
        }

    }
}//package it.gotoandplay.smartfoxserver.handlers

