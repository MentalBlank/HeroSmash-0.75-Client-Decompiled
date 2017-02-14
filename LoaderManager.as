// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//LoaderManager

package {
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.utils.Timer;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;
    import flash.utils.getDefinitionByName;
    import flash.net.URLRequest;

    public class LoaderManager {

        public var playerDomains:Object;
        public var loaderC:LoaderContext;
        public var loaderD:ApplicationDomain;
        public var loaderManager:Object;
        public var loaderQueue:Array;

        public function LoaderManager():void{
            loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            loaderC = new LoaderContext(false, loaderD);
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
            super();
            initLoaders();
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
        public function getLoaderHostByLoaderInfo(_loaderInfo):Object{
            var i:*;
            for (i in loaderManager) {
                if (loaderManager[i].ldr.contentLoaderInfo == _loaderInfo){
                    return (loaderManager[i]);
                };
            };
            return (null);
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
        private function loaderTimerComplete(e:TimerEvent):void{
            var l:*;
            trace("loaderTimerComplete >");
            l = getLoaderHostByTimer(Timer(e.currentTarget));
            if (l != null){
                trace(((("  " + l.n) + " timer cycle, isOpen: ") + l.isOpen));
                l.timer.reset();
                if (!l.isOpen){
                    if (l.loaderData.retries-- > 0){
                        loaderQueue.push(l.loaderData);
                    };
                    closeLoader(l, false, true);
                };
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
        public function getFreeLoader():Object{
            var i:*;
            if (loaderQueue.length > 0){
                for (i in loaderManager) {
                    if (loaderManager[i].free){
                        trace((">> returning loader " + i));
                        loaderManager[i].free = false;
                        return (loaderManager[i]);
                    };
                };
                return (null);
            };
            return (null);
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
        public function queueLoad(loaderData){
            var l:*;
            loaderData.retries = 1;
            loaderQueue.push(loaderData);
            l = getFreeLoader();
            if (l != null){
                loadNext(l);
            };
        }
        public function loaderErrorHandler(e:IOErrorEvent){
            var s:String;
            var u:String;
            var l:*;
            trace("loaderErrorHandler >");
            s = e.toString();
            u = s.substr((s.indexOf("URL: ") + 5));
            u = u.substr(0, (u.length - 1));
            l = getLoaderHostByURL(u);
            trace(("   error callback for  " + l.url));
            if (l != null){
                if (l.callBackB != null){
                    l.callBackB(e);
                };
            };
            closeLoader(l, false, false);
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
        public function getClass(assetLinkageID:String):Class{
            var o:Object;
            var c:Class;
            var rootClass:MovieClip;
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
            rootClass = Game.root;
            try {
                c = (rootClass.assetsDomain.getDefinition(assetLinkageID) as Class);
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
        private function mapPlayerAssetClass(sES:String):LoaderContext{
            trace(("mapPlayerAssetClass > " + sES));
            if (playerDomains[sES] == null){
                playerDomains[sES] = {};
                playerDomains[sES].loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
                playerDomains[sES].loaderC = new LoaderContext(false, playerDomains[sES].loaderD);
            };
            return (playerDomains[sES].loaderC);
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
                if (((((!((loaderData.avt == null))) && ((loaderData.avt.isMyAvatar == true)))) && (!((loaderData.sES == null))))){
                    c = mapPlayerAssetClass(loaderData.sES);
                };
                u = new URLRequest(loaderData.strFile);
                l.ldr.load(u, c);
                l.url = u.url;
                l.isOpen = false;
                l.loaderData = loaderData;
                l.timer.reset();
                l.timer.start();
                trace(("loadNext > Loader assigned for " + u.url));
            }
            else {
                trace("** No available loader found, event flow may terminate");
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
        public function loaderCallback(e:Event){
            var ldr:*;
            var l:*;
            trace("loaderCallback >");
            ldr = e.target.loader;
            l = getLoaderHost(ldr);
            if (l != null){
                trace(("   load callback for  " + l.url));
                if (l.callBackA != null){
                    l.callBackA(e);
                };
            };
            closeLoader(l, true);
        }
        public function loadNext(l:Object){
            if (loaderQueue.length > 0){
                loadNextWith(l, loaderQueue.shift());
            };
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

    }
}//package 

