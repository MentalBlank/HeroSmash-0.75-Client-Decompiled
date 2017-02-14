// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//LoaderMC

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.*;

    public class LoaderMC extends MovieClip {

        var mcDest:MovieClip;
        var isEvent:Boolean = false;
        public var history:Object;
        public var strLoad:TextField;
        private var rootClass:MovieClip;
        public var btnCancel:MovieClip;

        public function LoaderMC(rootClassMC:MovieClip){
            isEvent = false;
            history = {};
            super();
            btnCancel.addEventListener(MouseEvent.CLICK, onCancelClick);
            rootClass = rootClassMC;
        }
        public function closeHistory():void{
            var s:String;
            for each (s in history) {
                try {
                    history[s].ldr.close();
                }
                catch(e:Error) {
                };
                delete history[s];
            };
            history = {};
        }
        public function loadFile(mcDestination:MovieClip, strFilename:String, strDescription:String, isEvt:Boolean=false):void{
            var now:Number;
            var ldr:*;
            now = new Date().getTime();
            if ((((strFilename.indexOf("http://") == -1)) && ((strFilename.indexOf("file://") == -1)))){
                strFilename = (Game.serverFilePath + strFilename);
            };
            isEvent = isEvt;
            if (strDescription != "Inline Asset"){
                MovieClip(Game.root).addChild(this);
            };
            mcDest = mcDestination;
            ldr = new Loader();
            ldr.load(new URLRequest(strFilename), new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onFileLoadComplete, false, 0, true);
            ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onFileLoadProgress, false, 0, true);
            history[strFilename] = {
                ts:now,
                ldr:ldr
            };
        }
        private function onFileLoadProgress(evt:ProgressEvent):void{
            var procentLoaded:int;
            procentLoaded = Math.floor(((evt.bytesLoaded / evt.bytesTotal) * 100));
            strLoad.text = (("Loading " + procentLoaded) + "%");
        }
        private function onCancelClick(evt:MouseEvent):void{
            MovieClip(Game.root).logout();
            MovieClip(parent).removeChild(this);
        }
        private function onFileLoadComplete(evt:Event):void{
            var world:* = undefined;
            var ldr:Loader;
            var swf:* = undefined;
            var s:String;
            var o:Object;
            var evt:Event = evt;
            world = rootClass.world;
            ldr = Loader(evt.target.loader);
            try {
                for each (s in history) {
                    if (history[s].ldr == ldr){
                        delete history[s];
                    };
                };
            }
            catch(e:Error) {
            };
            ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, onFileLoadComplete);
            ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onFileLoadProgress);
            swf = MovieClip(ldr.content);
            mcDest.addChild(swf);
            if (((isEvent) && (("eventTrigger" in world.map)))){
                o = {
                    cmd:"fileLoaded",
                    args:{loc:"default"}
                };
                world.map.eventTrigger(o);
            };
            mcDest = null;
            try {
                MovieClip(parent).removeChild(this);
            }
            catch(e:Error) {
            };
        }

    }
}//package 

