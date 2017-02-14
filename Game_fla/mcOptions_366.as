// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcOptions_366

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.system.*;
    import flash.text.*;
    import flash.net.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.filters.*;
    import flash.ui.*;
    import flash.external.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.xml.*;

    public dynamic class mcOptions_366 extends MovieClip {

        public var chkHelm:MovieClip;
        public var btnLogout:SimpleButton;
        public var chkSound:MovieClip;
        public var chkWhisper:MovieClip;
        public var btnClose:SimpleButton;
        public var btnHigh:SimpleButton;
        public var chkGoto:MovieClip;
        public var btnFS:SimpleButton;
        public var chkFriend:MovieClip;
        public var btnIgnore:SimpleButton;
        public var btnLow:SimpleButton;
        public var arrQuality:Array;
        public var btnNews:SimpleButton;
        public var txtQuality:TextField;
        public var btnFriends:SimpleButton;
        public var chkTT:MovieClip;
        public var chkPet:MovieClip;
        public var btnCloseold:SimpleButton;
        public var rootClass;
        public var chkCloak:MovieClip;
        public var btnServer:SimpleButton;
        public var txtServer:TextField;
        public var chkParty:MovieClip;
        public var intCurQuality;

        public function mcOptions_366(){
            addFrameScript(0, frame1);
        }
        public function onSoundClick(evt:Event):void{
            if (!chkSound.bitChecked){
                chkSound.bitChecked = (rootClass.mixer.bSoundOn = false);
                rootClass.songMixer.removeSong();
            }
            else {
                chkSound.bitChecked = (rootClass.mixer.bSoundOn = true);
                rootClass.mixer.playSound("Click");
                rootClass.songMixer.hasSongThenPlay();
            };
            rootClass.uoPref.bSoundOn = rootClass.mixer.bSoundOn;
            chkSound.bitChecked = rootClass.uoPref.bSoundOn;
            rootClass.userPreference.data.bSoundOn = rootClass.mixer.bSoundOn;
            rootClass.userPreference.flush();
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bSoundOn", String(rootClass.uoPref.bSoundOn)], "str", 1);
        }
        public function onFriendClick(evt:Event):void{
            if (!chkFriend.bitChecked){
                chkFriend.bitChecked = (rootClass.uoPref.bFriend = false);
            }
            else {
                chkFriend.bitChecked = (rootClass.uoPref.bFriend = true);
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bFriend", String(rootClass.uoPref.bFriend)], "str", 1);
        }
        public function onHighClick(evt:Event):void{
            if (intCurQuality < 2){
                rootClass.mixer.playSound("Click");
                intCurQuality++;
                stage.quality = (txtQuality.text = arrQuality[intCurQuality]);
            };
        }
        public function onLogout(evt:Event):void{
            rootClass.mixer.playSound("Click");
            rootClass.logout();
        }
        public function onToggleFullScreen(e:Event):void{
            rootClass.toggleFullScreen();
        }
        function frame1(){
            rootClass = MovieClip(stage.getChildAt(0));
            arrQuality = new Array("LOW", "MEDIUM", "HIGH");
            intCurQuality = arrQuality.indexOf(stage.quality);
            txtQuality.text = stage.quality;
            txtServer.text = rootClass.objServerInfo.sName;
            chkSound.chkBtn.addEventListener(MouseEvent.CLICK, onSoundClick, false, 0, true);
            chkPet.chkBtn.addEventListener(MouseEvent.CLICK, onPetClick, false, 0, true);
            chkParty.chkBtn.addEventListener(MouseEvent.CLICK, onPartyClick, false, 0, true);
            chkFriend.chkBtn.addEventListener(MouseEvent.CLICK, onFriendClick, false, 0, true);
            chkWhisper.chkBtn.addEventListener(MouseEvent.CLICK, onWhisperClick, false, 0, true);
            chkGoto.chkBtn.addEventListener(MouseEvent.CLICK, onGotoClick, false, 0, true);
            chkCloak.chkBtn.addEventListener(MouseEvent.CLICK, onCloakClick, false, 0, true);
            chkHelm.chkBtn.addEventListener(MouseEvent.CLICK, onHelmClick, false, 0, true);
            chkTT.chkBtn.addEventListener(MouseEvent.CLICK, onTTClick, false, 0, true);
            chkSound.checkmark.visible = (chkSound.bitChecked = rootClass.mixer.bSoundOn);
            chkPet.checkmark.visible = (chkPet.bitChecked = rootClass.uoPref.bPet);
            chkParty.checkmark.visible = (chkParty.bitChecked = rootClass.uoPref.bParty);
            chkFriend.checkmark.visible = (chkFriend.bitChecked = rootClass.uoPref.bFriend);
            chkWhisper.checkmark.visible = (chkWhisper.bitChecked = rootClass.uoPref.bWhisper);
            chkGoto.checkmark.visible = (chkGoto.bitChecked = rootClass.uoPref.bGoto);
            chkCloak.checkmark.visible = (chkCloak.bitChecked = rootClass.uoPref.bCloak);
            chkHelm.checkmark.visible = (chkHelm.bitChecked = rootClass.uoPref.bHelm);
            chkTT.checkmark.visible = (chkTT.bitChecked = rootClass.uoPref.bTT);
            btnLow.addEventListener(MouseEvent.CLICK, onLowClick, false, 0, true);
            btnHigh.addEventListener(MouseEvent.CLICK, onHighClick, false, 0, true);
            btnFriends.addEventListener(MouseEvent.CLICK, onFriends, false, 0, true);
            btnIgnore.addEventListener(MouseEvent.CLICK, onIgnore, false, 0, true);
            btnServer.addEventListener(MouseEvent.CLICK, onServerList, false, 0, true);
            btnNews.addEventListener(MouseEvent.CLICK, onNews, false, 0, true);
            btnLogout.addEventListener(MouseEvent.CLICK, onLogout, false, 0, true);
            btnFS.addEventListener(MouseEvent.CLICK, onToggleFullScreen, false, 0, true);
            btnClose.addEventListener(MouseEvent.CLICK, onClose, false, 0, true);
            stop();
        }
        public function onPartyClick(evt:Event):void{
            if (!chkParty.bitChecked){
                chkParty.bitChecked = (rootClass.uoPref.bParty = false);
            }
            else {
                chkParty.bitChecked = (rootClass.uoPref.bParty = true);
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bParty", String(rootClass.uoPref.bParty)], "str", 1);
        }
        public function onIgnore(evt:Event):void{
            rootClass.mixer.playSound("Click");
            rootClass.world.showIgnoreList();
        }
        public function onNews(evt:Event):void{
        }
        public function onLowClick(evt:Event):void{
            if (intCurQuality > 0){
                rootClass.mixer.playSound("Click");
                intCurQuality--;
                stage.quality = (txtQuality.text = arrQuality[intCurQuality]);
            };
        }
        public function onClose(e:Event=null):void{
            if (MovieClip(parent).currentLabel != "Init"){
                rootClass.mixer.playSound("Click");
                MovieClip(parent).gotoAndPlay("Init");
            };
        }
        public function onPetClick(evt:Event):void{
            if (!chkPet.bitChecked){
                chkPet.bitChecked = (rootClass.uoPref.bPet = false);
                rootClass.world.hideAllPets();
            }
            else {
                chkPet.bitChecked = (rootClass.uoPref.bPet = true);
                rootClass.world.showAllPets();
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bPet", String(rootClass.uoPref.bPet)], "str", 1);
        }
        public function onFriends(evt:Event):void{
            rootClass.mixer.playSound("Click");
            rootClass.world.showFriendsList();
            MovieClip(parent).gotoAndPlay("Init");
        }
        public function onGotoClick(evt:Event):void{
            if (!chkGoto.bitChecked){
                chkGoto.bitChecked = (rootClass.uoPref.bGoto = false);
            }
            else {
                chkGoto.bitChecked = (rootClass.uoPref.bGoto = true);
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bGoto", String(rootClass.uoPref.bGoto)], "str", 1);
        }
        public function onWhisperClick(evt:Event):void{
            if (!chkWhisper.bitChecked){
                chkWhisper.bitChecked = (rootClass.uoPref.bWhisper = false);
            }
            else {
                chkWhisper.bitChecked = (rootClass.uoPref.bWhisper = true);
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bWhisper", String(rootClass.uoPref.bWhisper)], "str", 1);
        }
        public function onHelmClick(evt:Event):void{
            if (!chkHelm.bitChecked){
                chkHelm.bitChecked = (rootClass.uoPref.bHelm = false);
            }
            else {
                chkHelm.bitChecked = (rootClass.uoPref.bHelm = true);
            };
            rootClass.world.myAvatar.dataLeaf.showHelm = rootClass.uoPref.bHelm;
            rootClass.world.myAvatar.pMC.setHelmVisibility(rootClass.uoPref.bHelm);
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bHelm", String(rootClass.uoPref.bHelm)], "str", 1);
        }
        public function onTTClick(evt:Event):void{
            if (!chkTT.bitChecked){
                chkTT.bitChecked = (rootClass.uoPref.bTT = false);
            }
            else {
                chkTT.bitChecked = (rootClass.uoPref.bTT = true);
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bTT", String(rootClass.uoPref.bTT)], "str", 1);
        }
        public function onCloakClick(evt:Event):void{
            if (!chkCloak.bitChecked){
                chkCloak.bitChecked = (rootClass.uoPref.bCloak = false);
            }
            else {
                chkCloak.bitChecked = (rootClass.uoPref.bCloak = true);
            };
            rootClass.world.myAvatar.dataLeaf.showCloak = rootClass.uoPref.bCloak;
            rootClass.world.myAvatar.pMC.setCloakVisibility(rootClass.uoPref.bCloak);
            rootClass.sfc.sendXtMessage("zm", "cmd", ["uopref", "bCloak", String(rootClass.uoPref.bCloak)], "str", 1);
        }
        public function onServerList(evt:Event):void{
            rootClass.mixer.playSound("Click");
            rootClass.showServerList();
        }

    }
}//package Game_fla

