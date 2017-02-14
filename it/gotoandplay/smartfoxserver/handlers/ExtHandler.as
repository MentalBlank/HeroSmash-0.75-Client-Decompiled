// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//it.gotoandplay.smartfoxserver.handlers.ExtHandler

package it.gotoandplay.smartfoxserver.handlers{
    import it.gotoandplay.smartfoxserver.SmartFoxClient;
    import it.gotoandplay.smartfoxserver.SFSEvent;
    import it.gotoandplay.smartfoxserver.util.ObjectSerializer;

    public class ExtHandler implements IMessageHandler {

        private var sfs:SmartFoxClient;

        public function ExtHandler(sfs:SmartFoxClient){
            this.sfs = sfs;
        }
        public function handleMessage(msgObj:Object, type:String):void{
            var params:Object;
            var evt:SFSEvent;
            var xmlData:XML;
            var action:String;
            var roomId:int;
            var xmlStr:String;
            var asObj:Object;
            if (type == SmartFoxClient.XTMSG_TYPE_XML){
                xmlData = (msgObj as XML);
                action = xmlData.body.@action;
                roomId = int(xmlData.body.@id);
                if (action == "xtRes"){
                    xmlStr = xmlData.body.toString();
                    asObj = ObjectSerializer.getInstance().deserialize(xmlStr);
                    params = {};
                    params.dataObj = asObj;
                    params.type = type;
                    evt = new SFSEvent(SFSEvent.onExtensionResponse, params);
                    sfs.dispatchEvent(evt);
                };
            }
            else {
                if (type == SmartFoxClient.XTMSG_TYPE_JSON){
                    params = {};
                    params.dataObj = msgObj.o;
                    params.type = type;
                    evt = new SFSEvent(SFSEvent.onExtensionResponse, params);
                    sfs.dispatchEvent(evt);
                }
                else {
                    if (type == SmartFoxClient.XTMSG_TYPE_STR){
                        params = {};
                        params.dataObj = msgObj;
                        params.type = type;
                        evt = new SFSEvent(SFSEvent.onExtensionResponse, params);
                        sfs.dispatchEvent(evt);
                    };
                };
            };
        }

    }
}//package it.gotoandplay.smartfoxserver.handlers

