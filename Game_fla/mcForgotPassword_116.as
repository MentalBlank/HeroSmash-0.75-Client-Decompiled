// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcForgotPassword_116

package Game_fla{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLRequestMethod;
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

    public dynamic class mcForgotPassword_116 extends MovieClip {

        public var txtEmail:TextField;
        public var btnContinue:SimpleButton;
        public var btnBack:SimpleButton;
        public var strResponse;
        public var btnSubmit:SimpleButton;
        public var rootClass;
        public var txtResponse:TextField;
        public var btnCancel:SimpleButton;

        public function mcForgotPassword_116(){
            addFrameScript(0, frame1, 10, frame11);
        }
        public function submitEmail():void{
            var variables:URLVariables;
            var request:URLRequest;
            var loader:URLLoader;
            variables = new URLVariables();
            variables.strEmail = txtEmail.text;
            trace(("Sending: " + variables));
            request = new URLRequest((rootClass.params.sURL + "cf-forgotpassword.asp"));
            request.data = variables;
            request.method = URLRequestMethod.POST;
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onSubmitEmailComplete, false, 0, true);
            loader.load(request);
        }
        public function onSubmitEmailComplete(e:Event):void{
            var vars:URLVariables;
            trace(("onDataComplete:" + e.target.data));
            vars = new URLVariables(e.target.data);
            if (vars.status != "success"){
                strResponse = vars.reason;
            };
            gotoAndPlay("Done");
        }
        public function onContinueClick(e:MouseEvent):void{
            MovieClip(parent).gotoAndPlay("Login");
        }
        function frame1(){
            txtEmail.tabIndex = 1;
            rootClass = MovieClip(parent.parent);
            strResponse = "";
            btnSubmit.addEventListener(MouseEvent.CLICK, onSubmitClick);
            btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);
            stop();
        }
        function frame11(){
            if (strResponse != ""){
                txtResponse.text = strResponse;
            };
            btnContinue.addEventListener(MouseEvent.CLICK, onContinueClick);
            btnBack.addEventListener(MouseEvent.CLICK, onBackClick);
            stop();
        }
        public function onBackClick(e:MouseEvent):void{
            gotoAndPlay("Init");
        }
        public function onCancelClick(e:MouseEvent):void{
            MovieClip(parent).gotoAndPlay("Login");
        }
        public function onSubmitClick(e:MouseEvent):void{
            if (!rootClass.isValidEmail(txtEmail.text)){
                strResponse = "Invalid Email";
                gotoAndPlay("Done");
            }
            else {
                submitEmail();
            };
        }

    }
}//package Game_fla

