// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//it.gotoandplay.smartfoxserver.http.LoaderFactory

package it.gotoandplay.smartfoxserver.http{
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class LoaderFactory {

        private static const DEFAULT_POOL_SIZE:int = 2;

        private var currentLoaderIndex:int;
        private var responseHandler:Function;
        private var errorHandler:Function;

        public function LoaderFactory(responseHandler:Function, errorHandler:Function, poolSize:int=2){
            this.responseHandler = responseHandler;
            this.errorHandler = errorHandler;
        }
        public function getLoader():URLLoader{
            var urlLoader:URLLoader;
            urlLoader = new URLLoader();
            urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
            urlLoader.addEventListener(Event.COMPLETE, this.responseHandler);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            urlLoader.addEventListener(IOErrorEvent.NETWORK_ERROR, this.errorHandler);
            return (urlLoader);
        }

    }
}//package it.gotoandplay.smartfoxserver.http

