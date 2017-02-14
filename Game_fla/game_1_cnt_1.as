// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.game_1_cnt_1

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
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

    public dynamic class game_1_cnt_1 extends MovieClip {

        public var pMC:AvatarMC;
        public var btnMember:SimpleButton;
        public var mcForgotPassword:MovieClip;
        public var mcTabUsername:MovieClip;
        public var btnUpgrade:MovieClip;
        public var panelLeft:MovieClip;
        public var btnAccount:SimpleButton;
        public var t1:MovieClip;
        public var bg:MovieClip;
        public var hintPassword:MovieClip;
        public var sl:ServerList;
        public var btnCharacterPage:MovieClip;
        public var mcCharacter0:MovieClip;
        public var mcCharacter2:MovieClip;
        public var mcCharacter1:MovieClip;
        public var mcSC:MovieClip;
        public var btnLogin:SimpleButton;
        public var btnCreate:SimpleButton;
        public var panelRight:MovieClip;
        public var hintUsername:MovieClip;
        public var txtStatus:TextField;
        public var mcDeleteConfirm:MovieClip;
        public var btnCoins:SimpleButton;
        public var il:IteratorMC;
        public var btnDelete:MovieClip;
        public var mcStatus:MovieClip;
        public var mcCoin:MovieClip;
        public var txtNews:TextField;
        public var chkPassword:MovieClip;
        public var warning:MovieClip;
        public var txtAccount:TextField;
        public var mcUpgrade:MovieClip;
        public var btnPlay:MovieClip;
        public var mcAccount:MovieClip;
        public var ni:TextField;
        public var chkUserName:MovieClip;
        public var mcTabPassword:MovieClip;
        public var pi:TextField;
        public var ModalStack:MovieClip;

        public function game_1_cnt_1(){
            addFrameScript(0, frame1, 7, frame8, 17, frame18, 19, frame20, 27, frame28, 38, frame39, 47, frame48);
        }
        public function showHintUsername(e:Event):void{
            hintUsername.visible = true;
        }
        function frame18(){
            MovieClip(parent).initSelect();
        }
        function frame1(){
            ni.tabIndex = 1;
            pi.tabIndex = 2;
            btnCreate.addEventListener(MouseEvent.CLICK, onCreateClick, false, 0, true);
            btnAccount.addEventListener(MouseEvent.CLICK, onAccountClick, false, 0, true);
            hintUsername.visible = false;
            hintPassword.visible = false;
            mcTabUsername.addEventListener(MouseEvent.MOUSE_OVER, showHintUsername, false, 0, true);
            mcTabUsername.addEventListener(MouseEvent.MOUSE_OUT, hideHintUsername, false, 0, true);
            mcTabPassword.addEventListener(MouseEvent.MOUSE_OVER, showHintPasswrod, false, 0, true);
            mcTabPassword.addEventListener(MouseEvent.MOUSE_OUT, hideHintPassword, false, 0, true);
            MovieClip(parent).initLogin();
            stop();
        }
        function frame28(){
            stop();
        }
        function frame8(){
            loadCharacterCreation("flash/newchar_20110613a.swf");
            stop();
        }
        public function onCreateClick(e:MouseEvent):void{
            btnCreate.removeEventListener(MouseEvent.CLICK, onCreateClick);
            gotoAndPlay("CharNew");
        }
        function frame20(){
            stop();
        }
        function frame39(){
            stop();
        }
        public function hideHintPassword(e:Event):void{
            hintPassword.visible = false;
        }
        function frame48(){
            stop();
        }
        public function showHintPasswrod(e:Event):void{
            hintPassword.visible = true;
        }
        public function onAccountClick(event:MouseEvent):void{
            navigateToURL(new URLRequest("http://www.artix.com"), "_blank");
        }
        public function hideHintUsername(e:Event):void{
            hintUsername.visible = false;
        }
        public function loadCharacterCreation(strFilename:String){
            var ldr:Loader;
            mcAccount.removeChildAt(0);
            ldr = new Loader();
            trace((("newchar " + Game.serverFilePath) + strFilename));
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, new ApplicationDomain(null)));
            mcAccount.addChild(ldr);
        }

    }
}//package Game_fla

