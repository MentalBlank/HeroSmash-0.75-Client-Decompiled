// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcPopup_310

package Game_fla{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.display.Loader;
    import flash.net.URLRequest;
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

    public dynamic class mcPopup_310 extends MovieClip {

        public var mcCustomizeArmor:Customization;
        public var mcHouseOptions:MovieClip;
        public var fData:Object;
        public var mcInventory:Inventory;
        public var cnt:FactionsMC;
        public var mcHouseShop:HouseShop;
        public var mcOptions:MovieClip;
        public var mcCharpanel:CharpanelMC;
        public var mcNews:MovieClip;
        public var mcBook:MovieClip;
        public var world:MovieClip;
        public var mcHouseMenu:HouseMenu;
        public var mcShop:Shop;
        public var mcPVPPanel:PVPPanelMC;
        public var rootClass:MovieClip;
        public var reportMC:MovieClip;
        public var mcHouseItemHandle:HouseItemHandleMC;
        public var mcMap:MovieClip;
        public var mcBank:Bank;

        public function mcPopup_310(){
            addFrameScript(0, frame1, 1, frame2, 6, frame7, 16, frame17, 22, frame23, 31, frame32, 38, frame39, 45, frame46, 51, frame52, 59, frame60, 67, frame68, 75, frame76, 83, frame84, 92, frame93, 100, frame101, 110, frame111, 120, frame121);
        }
        function frame52(){
            loadPointsAPI(rootClass.world.objInfo.sPoints);
            stop();
        }
        function frame68(){
            stop();
        }
        function frame84(){
            stop();
        }
        function frame76(){
            stop();
        }
        public function fClose(){
            var mc:MovieClip;
            mc = MovieClip(this);
            if (mc.mcHouseMenu != null){
                mc.mcHouseMenu.fClose();
            };
            if (getChildByName("mcCharpanel") != null){
                MovieClip(getChildByName("mcCharpanel")).fClose();
            };
        }
        function frame1(){
            rootClass = MovieClip(stage.getChildAt(0));
            world = (rootClass.world as MovieClip);
            fData = {};
            visible = false;
            stop();
        }
        public function onClose(evt:Event=null):void{
            trace("mcPopup.onClose >");
            if (((!((currentLabel == "Init"))) && (!((currentFrame == 1))))){
                fClose();
                MovieClip(Game.root).mixer.playSound("Click");
                if (((((world.isMyHouse()) && (!(world.mapLoadInProgress)))) && (!((currentLabel == "House"))))){
                    gotoAndPlay("House");
                }
                else {
                    trace(" > init");
                    gotoAndPlay("Init");
                };
            };
        }
        function frame17(){
            stop();
        }
        function frame111(){
            stop();
        }
        function frame7(){
            stop();
        }
        function frame39(){
            loadNews(rootClass.world.objInfo.sNews);
            stop();
        }
        public function loadMap(strFilename:String){
            var ldr:Loader;
            mcMap.removeChildAt(0);
            ldr = new Loader();
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, ApplicationDomain.currentDomain));
            mcMap.addChild(ldr);
        }
        function frame23(){
            stop();
        }
        function frame46(){
            loadBook(rootClass.world.objInfo.sBook);
            stop();
        }
        function frame2(){
            fData = {};
            visible = false;
            stop();
        }
        function frame93(){
            mcHouseMenu.visible = false;
            mcHouseItemHandle.visible = false;
            mcHouseMenu.fOpen("default");
            stop();
        }
        function frame121(){
            stop();
        }
        function frame32(){
            loadMap(rootClass.world.objInfo.sMap);
            stop();
        }
        public function fOpen(l:String, o:Object=null):void{
            if (currentLabel != l){
                fClose();
                if (o != null){
                    fData = o;
                };
                gotoAndStop(l);
                visible = true;
            };
        }
        public function loadNews(strFilename:String){
            var ldr:Loader;
            mcNews.removeChildAt(0);
            ldr = new Loader();
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, ApplicationDomain.currentDomain));
            mcNews.addChild(ldr);
        }
        function frame101(){
            stop();
        }
        function frame60(){
            stop();
        }
        public function loadBook(strFilename:String){
            var ldr:Loader;
            mcBook.removeChildAt(0);
            ldr = new Loader();
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, ApplicationDomain.currentDomain));
            mcBook.addChild(ldr);
        }
        public function loadPointsAPI(strFilename:String){
            var ldr:Loader;
            mcBook.removeChildAt(0);
            ldr = new Loader();
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, ApplicationDomain.currentDomain));
            mcBook.addChild(ldr);
        }

    }
}//package Game_fla

