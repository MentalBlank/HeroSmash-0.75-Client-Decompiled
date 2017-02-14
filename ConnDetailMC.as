// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ConnDetailMC

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;

    public class ConnDetailMC extends MovieClip {

        public var btnBack:MovieClip;
        public var txtBack:TextField;
        public var rootClass:MovieClip;
        private var timerConnDetail:Timer;
        public var txtDetail:TextField;

        public function ConnDetailMC(mcRootClass:MovieClip){
            timerConnDetail = new Timer(10000, 1);
            super();
            rootClass = mcRootClass;
            txtBack.mouseEnabled = false;
            btnBack.addEventListener(MouseEvent.CLICK, onBackClick, false, 0, true);
            timerConnDetail.removeEventListener(TimerEvent.TIMER, showBackButton);
            timerConnDetail.addEventListener(TimerEvent.TIMER, showBackButton, false, 0, true);
        }
        public function showError(strDetail:String):void{
            if (stage == null){
                rootClass.addChild(this);
            };
            txtDetail.htmlText = strDetail;
            showBackButton();
        }
        public function hideConn():void{
            if (stage != null){
                rootClass.removeChild(this);
            };
        }
        public function showConn(strDetail:String):void{
            btnBack.visible = false;
            txtBack.visible = false;
            if (stage == null){
                txtDetail.text = strDetail;
                rootClass.addChild(this);
            };
            txtDetail.text = strDetail;
            if (!timerConnDetail.running){
                timerConnDetail.reset();
                timerConnDetail.start();
            };
        }
        function onBackClick(e:MouseEvent=null):void{
            rootClass.logout();
            hideConn();
        }
        public function showBackButton(e:TimerEvent=null):void{
            btnBack.visible = true;
            txtBack.visible = true;
        }

    }
}//package 

